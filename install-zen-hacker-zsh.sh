#!/bin/bash

echo "🚀 Starting full setup: ZSH + powerlevel10k + Zen Hacker Mode..."

# === Install Oh My Zsh ===
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "➡️ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# === Install powerlevel10k theme ===
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "➡️ Installing powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "✅ powerlevel10k already installed."
fi

# === Install plugins ===
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "➡️ Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "✅ zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "➡️ Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "✅ zsh-syntax-highlighting already installed."
fi

# === Update plugins & theme in .zshrc ===
ZSHRC="$HOME/.zshrc"
echo "🛠 Updating .zshrc..."

# Set theme
sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"

# Add plugins (overwrite or append)
if grep -q "^plugins=" "$ZSHRC"; then
  sed -i '' 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

# Source p10k config
if ! grep -q "source ~/.p10k.zsh" "$ZSHRC"; then
  echo '[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh' >> "$ZSHRC"
fi

# === Write .p10k.zsh – Zen Hacker Mode ===
cat > ~/.p10k.zsh <<'EOF'
# ZEN HACKER MODE 🔥

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{magenta}┌─%f "
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{cyan}┗━➤%f "

POWERLEVEL9K_DIR_FOREGROUND=245
POWERLEVEL9K_DIR_BACKGROUND=
POWERLEVEL9K_DIR_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_DIR_MAX_LENGTH=35
POWERLEVEL9K_DIR_ANCHOR_BASENAME=true

POWERLEVEL9K_VCS_CLEAN_FOREGROUND=70
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=208
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=214
POWERLEVEL9K_VCS_BACKGROUND=
POWERLEVEL9K_VCS_GIT_GLYPH='⭢'

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_PROMPT_CHAR_OK_VIVIS_CONTENT=""
POWERLEVEL9K_PROMPT_CHAR_ERROR_VIVIS_CONTENT=""
POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=

POWERLEVEL9K_SHOW_TIME=false
POWERLEVEL9K_LOAD=false
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=0
EOF

# === Done ===
echo "✅ Zen Hacker Mode is ready!"
echo "👉 Run: source ~/.zshrc"
echo "👉 Open new terminal or VS Code terminal to enjoy ⚡"
