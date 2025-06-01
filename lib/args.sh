VERBOSE=0
DRYRUN=0
MODE="interactive"
MODE_SET=""
PRESET_FILE=""

while [ $# -gt 0 ]; do
  arg="$1"
  case "$arg" in
    --verbose)
      VERBOSE=1
      shift
      ;;
    --dryrun|--dry-run)
      DRYRUN=1
      shift
      ;;
    --omakase|--interactive|--preset)
      if [ -n "$MODE_SET" ]; then
        log_failure "--omakase, --interactive, --preset cannot be specified together."
        exit 1
      fi
      case "$arg" in
        --omakase) MODE="omakase" ;;
        --interactive) MODE="interactive" ;;
        --preset)
          MODE="preset"
          shift
          PRESET_FILE="$1"
          if [ ! -f "$PRESET_FILE" ]; then
            log_failure "Preset file not found: $PRESET_FILE"
            exit 1
          fi
          ;;
      esac
      MODE_SET=1
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--verbose] [--dryrun] [--omakase|--interactive|--preset <file>]"
      exit 0
      ;;
    *)
      echo "❌ Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

if [ -z "$PRESET_FILE" ]; then
  PRESET_FILE="$YAMATO_PATH/yamato.yml"
fi
