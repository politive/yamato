VERBOSE=0
DRYRUN=0
MODE=""
PRESET_FILE=""

for arg in "$@"; do
  case "$arg" in
    --verbose)
      VERBOSE=1
      ;;
    --dryrun|--dry-run)
      DRYRUN=1
      ;;
    --omakase|--interactive|--preset=*)
      if [ -n "$MODE" ]; then
        log_failure "--omakase, --interactive, --preset cannot be specified together."
        exit 1
      fi
      case "$arg" in
        --omakase) MODE="omakase" ;;
        --interactive) MODE="interactive" ;;
        --preset=*) MODE="preset"; PRESET_FILE="${arg#*=}" ;;
      esac
      ;;
    --help|-h)
      echo "Usage: $0 [--verbose] [--dryrun] [--omakase|--interactive|--preset=FILE]"
      exit 0
      ;;
    *)
      echo "❌ Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done
