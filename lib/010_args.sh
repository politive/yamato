VERBOSE=0
DRYRUN=0
SKIP_PULL=0
DEV_MODE=0

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
    --skip-pull)
      SKIP_PULL=1
      shift
      ;;
    --dev)
      DEV_MODE=1
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--verbose] [--dryrun] [--skip-pull] [--dev]"
      exit 0
      ;;
    *)
      echo "❌ Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done
