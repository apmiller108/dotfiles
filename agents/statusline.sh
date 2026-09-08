#!/usr/bin/env bash
# Status line styled after the miloshadzic zsh prompt (~/dotfiles/shell/zsh/prompt.zsh):
# cyan(last 2 path segments) red(|) green(git branch)yellow(dirty) cyan(⇒), then
# Model | context tokens (% remaining) | effort

input=$(cat)

RESET=$'\033[0m'
CYAN=$'\033[36m'
RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'

cwd=$(jq -r '.workspace.current_dir // .cwd // empty' <<<"$input")
[ -z "$cwd" ] && cwd="$PWD"

# emulate zsh's %2~: collapse $HOME to ~, keep last 2 path segments
display_path() {
  local path="$1"
  case "$path" in
    "$HOME") echo "~"; return ;;
    "$HOME"/*) path="~${path#"$HOME"}" ;;
  esac
  IFS='/' read -ra parts <<<"$path"
  local nonempty=()
  for p in "${parts[@]}"; do [ -n "$p" ] && nonempty+=("$p"); done
  local n=${#nonempty[@]}
  if [ "$n" -le 2 ]; then
    printf '%s' "$path"
  else
    printf '%s/%s' "${nonempty[$((n - 2))]}" "${nonempty[$((n - 1))]}"
  fi
}
pathdisp=$(display_path "$cwd")

git_segment=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ] && dirty="${YELLOW}⚡${RESET}"
    git_segment="${GREEN}${branch}${RESET}${dirty} "
  fi
fi

model=$(jq -r '.model.display_name // "unknown"' <<<"$input")
used=$(jq -r '.context_window.total_input_tokens // empty' <<<"$input")
remaining_pct=$(jq -r '.context_window.remaining_percentage // empty' <<<"$input")
effort=$(jq -r 'if .effort == null then empty elif (.effort|type)=="object" then (.effort.level // empty) else .effort end' <<<"$input")

fmt_k() { awk -v n="$1" 'BEGIN{printf "%.1fk", n/1000}'; }

info=""
[ -n "$used" ] && info="$(fmt_k "$used") tokens"
if [ -n "$remaining_pct" ]; then
  pct=$(awk -v p="$remaining_pct" 'BEGIN{printf "%.0f", p}')
  info="${info}${info:+ }(${pct}% remaining)"
fi

right="$model"
[ -n "$info" ] && right="${right} | ${info}"
[ -n "$effort" ] && right="${right} | effort: ${effort}"

printf '%s%s%s%s|%s%s%s⇒%s %s\n' \
  "$CYAN" "$pathdisp" "$RESET" "$RED" "$RESET" "$git_segment" "$CYAN" "$RESET" "$right"
