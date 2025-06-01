VERBOSE=0
DRYRUN=0
MODE="interactive"
MODE_SET=""
PRESET_FILE=""

for arg in "$@"; do
  case "$arg" in
    --verbose)
      VERBOSE=1
      ;;
    --dryrun|--dry-run)
      DRYRUN=1
      ;;
    --omakase|--interactive)
      if [ -n "$MODE_SET" ]; then
        log_failure "--omakase, --interactive cannot be specified together."
        exit 1
      fi
      case "$arg" in
        --omakase) MODE="omakase" ;;
        --interactive) MODE="interactive" ;;
      esac
      MODE_SET=1
      ;;
    --help|-h)
      echo "Usage: $0 [--verbose] [--dryrun] [--omakase|--interactive]"
      exit 0
      ;;
    *)
      echo "❌ Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done


mkdir -p "$YAMATO_PATH/.cache"
PRESET_BASE="$YAMATO_PATH/yamato.yml"
PRESET_OVERRIDE="$YAMATO_PATH/yamato.overrides.yml"
PRESET_FILE="$YAMATO_PATH/.cache/yamato.merged.yml"

if [ -f "$PRESET_OVERRIDE" ]; then
  yq ea '. as $item ireduce ({}; . * $item )' "$PRESET_BASE" "$PRESET_OVERRIDE" > "$PRESET_FILE"
else
  cp "$PRESET_BASE" "$PRESET_FILE"
fi
