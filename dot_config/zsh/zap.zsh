ZAP_FILE="$HOME/.local/share/zap/zap.zsh"

if [ -f "$ZAP_FILE" ]; then
  source "$ZAP_FILE"
else
  echo "Installing zap..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 -k
  source "$ZAP_FILE"
fi
