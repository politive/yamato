run() {
  if [ "${DRYRUN:-0}" = "1" ]; then
    log_dryrun "$*"
    return 0
  fi
  if [ "${VERBOSE:-0}" = "1" ]; then
    "$@"
  else
    "$@" > /dev/null 2>&1
  fi
}
