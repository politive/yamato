# デフォルト
VERBOSE=0

# 引数パース
for arg in "$@"; do
  case "$arg" in
    --verbose)
      VERBOSE=1
      ;;
    --help|-h)
      echo "Usage: $0 [--verbose]"
      exit 0
      ;;
    *)
      echo "❌ Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done
