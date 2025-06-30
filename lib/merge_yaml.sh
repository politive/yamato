merge_yaml() {
  local base="$1"
  local override="$2"
  local merged="$3"
  if [ -f "$override" ]; then
    yq eval-all '
      select(fileIndex == 0) * select(fileIndex == 1)
      | .tools = (select(fileIndex == 0).tools + select(fileIndex == 1).tools)
    ' "$base" "$override" > "$merged"
  else
    cp "$base" "$merged"
  fi
}
