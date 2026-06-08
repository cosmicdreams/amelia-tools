#!/usr/bin/env zsh
# check-integration.sh gws
#
# Preflight health check (a "circuit breaker") for the Google Workspace
# command-line tool, whose command name is `gws`. Run this before any `gws`
# call so the assistant fails fast with a clear message instead of part-way
# through an operation.
#
# Exit 0  — the integration is healthy (or a recent cached result says healthy).
# Exit 1  — the tool is missing, not authenticated, or a recent cached result
#           says it failed. A human-readable reason is printed to standard error.
#
# The result is cached for a short window so repeated calls in one session do
# not re-check every time. The cache holds only a healthy-or-failed flag, a
# short reason, and a timestamp — never any of the student's information.

set -euo pipefail

TOOL="${1:-}"
if [[ "$TOOL" != "gws" ]]; then
  print -u2 "Usage: check-integration.sh gws"
  exit 1
fi

CACHE_DIR="${HOME}/.claude/plugins/data/college"
CACHE_FILE="${CACHE_DIR}/integration-cache.json"
TIME_TO_LIVE_SECONDS=300  # five minutes

# Read a still-fresh cached result, if one exists.
_cache_read() {
  [[ -f "$CACHE_FILE" ]] || return 1
  python3 -c "
import json, sys, time
data = json.load(open('${CACHE_FILE}'))
entry = data.get('gws')
if not entry:
    sys.exit(1)
age = time.time() - entry.get('ts', 0)
if age > ${TIME_TO_LIVE_SECONDS}:
    sys.exit(2)
print(json.dumps(entry))
" 2>/dev/null
}

# Write a result to the cache.
_cache_write() {
  local health="$1" reason="$2"
  mkdir -p "$CACHE_DIR"
  python3 - "$health" "$reason" "$CACHE_FILE" <<'PYEOF'
import json, sys, time, os
health, reason, cache_file = sys.argv[1], sys.argv[2], sys.argv[3]
data = {}
if os.path.exists(cache_file):
    try:
        data = json.load(open(cache_file))
    except Exception:
        data = {}
data["gws"] = {"status": health, "reason": reason, "ts": time.time()}
json.dump(data, open(cache_file, "w"), indent=2)
PYEOF
}

# Actually exercise the tool with a tiny read-only call.
_check_gws() {
  if ! command -v gws &>/dev/null; then
    echo "The Google Workspace command-line tool (gws) was not found. Install it with: npm install -g @googleworkspace/cli"
    return 1
  fi
  local out
  if ! out=$(gws calendar events list --params '{"calendarId":"primary","maxResults":1}' 2>&1); then
    echo "gws authentication failed: ${out}"
    return 1
  fi
  return 0
}

# 1. Use a fresh cached result if there is one.
if cache_entry=$(_cache_read); then
  cached_status=$(python3 -c "import json,sys; print(json.loads(sys.argv[1])['status'])" "$cache_entry")
  cached_reason=$(python3 -c "import json,sys; print(json.loads(sys.argv[1]).get('reason',''))" "$cache_entry")
  if [[ "$cached_status" == "healthy" ]]; then
    exit 0
  fi
  print -u2 "integration gws unavailable: ${cached_reason}"
  exit 1
fi

# 2. No fresh cache — run the check and record the result.
if reason=$(_check_gws); then
  _cache_write "healthy" ""
  exit 0
else
  reason=${reason%%$'\n'*}   # keep only the first line; a failing gws call can print many lines
  _cache_write "failed" "$reason"
  print -u2 "integration gws unavailable: ${reason}"
  exit 1
fi
