#!/usr/bin/env bash

# ==============================================================================
# Dotfiles Installation & Symlinking Script
# ==============================================================================
# This script inventories and creates symbolic links from your home directory (~)
# to the corresponding files and directories in your dotfiles repository.
# ==============================================================================

set -euo pipefail

# Color definitions
RESET='\033[0m'
BOLD='\033[1m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
RED='\033[31m'
BLUE='\033[34m'

# Fix formatting if term doesn't support colors
if [ ! -t 1 ]; then
  RESET=""
  BOLD=""
  GREEN=""
  YELLOW=""
  CYAN=""
  RED=""
  BLUE=""
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
BACKUP_DIR="$HOME_DIR/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

DRY_RUN=false
FORCE=false
INTERACTIVE=false
BACKUP_NEEDED=false

usage() {
  cat <<EOF
${BOLD}Dotfiles Symlink Helper${RESET}

Usage: $(basename "$0") [options]

Options:
  -i, --interactive Prompt for approval before symlinking each config file.
  -n, --dry-run     Show what actions would be taken without creating links or modifying files.
  -f, --force       Overwrite existing files by creating backups first before replacing with symlinks.
  -h, --help        Show this help message.

EOF
  exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--interactive)
      INTERACTIVE=true
      shift
      ;;
    -n|--dry-run)
      DRY_RUN=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo -e "${RED}Unknown option: $1${RESET}"
      usage
      ;;
  esac
done

# List of mappings: "source_relative_path:target_home_path"
# Sources are relative to DOTFILES_DIR ($HOME/dotfiles)
# Targets are relative to HOME_DIR ($HOME)
FILES_TO_LINK=(
  # Shell & Terminal
  "shell/zshrc:.zshrc"
  "shell/tmux.conf:.tmux.conf"
  "shell/alacritty.toml:.config/alacritty/alacritty.toml"
  "shell/ghostty.conf:.config/ghostty/config.ghostty"

  # AI Agents
  "agents/statusline.sh:.claude/statusline.sh"

  # Git Configuration
  "git/gitconfig:.gitconfig"
  "git/gitignore_global:.gitignore_global"
  "git/gitprompt:.gitprompt"
  "git/git-completion.sh:.git-completion.sh"

  # Editors & Environments
  "vim/vimrc:.vimrc"
  "emacs/private:spacemacs/private"

  # Language REPLs & Tools
  "irb/irbrc:.irbrc"
  "iex/iex.exs:.iex.exs"
  "psql/psqlrc:.psqlrc"
  "rgems/gemrc:.gemrc"

  # Code Quality & Style Guides
  "style_guides/eslintrc.json:.eslintrc.json"
  "style_guides/jsbeautifyrc:.jsbeautifyrc"
  "style_guides/pylintrc:.pylintrc"
  "style_guides/reek:.reek.yml"
  "style_guides/rubocop.yml:.rubocop.yml"
  "style_guides/sass-lint.yml:.sass-lint.yml"
)

log_info()  { echo -e "${CYAN}[INFO]${RESET} $1"; }
log_succ()  { echo -e "${GREEN}[LINKED]${RESET} $1"; }
log_skip()  { echo -e "${BLUE}[EXISTS]${RESET} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_back()  { echo -e "${YELLOW}[BACKUP]${RESET} $1"; }
log_dry()   { echo -e "${CYAN}[DRY-RUN]${RESET} $1"; }
log_err()   { echo -e "${RED}[ERROR]${RESET} $1"; }

echo -e "${BOLD}====================================================${RESET}"
echo -e "${BOLD}       Dotfiles Symlink Installation Helper        ${RESET}"
echo -e "${BOLD}====================================================${RESET}"
echo -e "Dotfiles Source Directory: ${CYAN}$DOTFILES_DIR${RESET}"
echo -e "Target Home Directory:    ${CYAN}$HOME_DIR${RESET}"

if [ "$DRY_RUN" = true ]; then
  echo -e "${YELLOW}*** DRY RUN MODE - No changes will be written to disk ***${RESET}\n"
fi

if [ "$INTERACTIVE" = true ]; then
  echo -e "${CYAN}*** INTERACTIVE MODE - You will be prompted for each file ***${RESET}\n"
fi

create_symlink() {
  local src_rel="$1"
  local target_rel="$2"

  local src="$DOTFILES_DIR/$src_rel"
  local target="$HOME_DIR/$target_rel"
  local target_dir
  target_dir="$(dirname "$target")"

  if [ ! -e "$src" ]; then
    log_err "Source file does not exist: $src"
    return 1
  fi

  # Check if target already points to the correct source
  if [ -L "$target" ]; then
    local current_link
    current_link="$(readlink "$target")"
    if [ "$current_link" = "$src" ]; then
      log_skip "$target_rel already correctly points to $src_rel"
      return 0
    fi
  fi

  # In interactive mode, prompt user for permission
  if [ "$INTERACTIVE" = true ]; then
    local prompt_msg="Symlink $src_rel -> ~/$target_rel? [y/N] "
    read -r -p "$(echo -e "${BOLD}$prompt_msg${RESET}")" response
    case "$response" in
      [yY][eE][sS]|[yY])
        ;;
      *)
        log_warn "Skipped $target_rel (declined by user)"
        return 0
        ;;
    esac
  fi

  # Ensure parent directory exists
  if [ ! -d "$target_dir" ]; then
    if [ "$DRY_RUN" = true ]; then
      log_dry "Would create directory: $target_dir"
    else
      mkdir -p "$target_dir"
    fi
  fi

  # Handle case where target is an existing symlink to a different location
  if [ -L "$target" ]; then
    local current_link
    current_link="$(readlink "$target")"
    log_warn "$target_rel points to $current_link (expected $src)"
    if [ "$FORCE" = true ]; then
      if [ "$DRY_RUN" = true ]; then
        log_dry "Would remove existing symlink at $target_rel and link to $src_rel"
      else
        rm "$target"
        ln -s "$src" "$target"
        log_succ "$target_rel -> $src_rel"
      fi
    else
      log_warn "Skipping $target_rel. Use --force to overwrite."
    fi
    return 0
  # Handle case where target is a regular file/directory
  elif [ -e "$target" ]; then
    log_warn "Target $target_rel exists and is a regular file/directory."
    if [ "$FORCE" = true ]; then
      if [ "$DRY_RUN" = true ]; then
        log_dry "Would backup $target_rel to $BACKUP_DIR and symlink to $src_rel"
      else
        if [ "$BACKUP_NEEDED" = false ]; then
          mkdir -p "$BACKUP_DIR"
          BACKUP_NEEDED=true
        fi
        local backup_target_dir="$BACKUP_DIR/$(dirname "$target_rel")"
        mkdir -p "$backup_target_dir"
        mv "$target" "$BACKUP_DIR/$target_rel"
        log_back "Moved existing $target_rel to $BACKUP_DIR/$target_rel"
        ln -s "$src" "$target"
        log_succ "$target_rel -> $src_rel"
      fi
    else
      log_warn "Skipping $target_rel to avoid overwriting. Use --force to backup and overwrite."
    fi
    return 0
  fi

  # Create symlink if target doesn't exist
  if [ "$DRY_RUN" = true ]; then
    log_dry "Would link $target_rel -> $src_rel"
  else
    ln -s "$src" "$target"
    log_succ "$target_rel -> $src_rel"
  fi
}

count=0
for entry in "${FILES_TO_LINK[@]}"; do
  src_rel="${entry%%:*}"
  target_rel="${entry#*:}"
  create_symlink "$src_rel" "$target_rel"
  ((count+=1))
done

echo -e "\n${BOLD}Processed $count item(s).${RESET}"
if [ "$BACKUP_NEEDED" = true ]; then
  echo -e "${YELLOW}Backups were saved to: $BACKUP_DIR${RESET}"
fi
echo -e "${GREEN}Done!${RESET}"
