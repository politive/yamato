run() {
  if [ "${VERBOSE:-0}" = "1" ]; then
    "$@"
  else
    "$@" > /dev/null 2>&1
  fi
}
