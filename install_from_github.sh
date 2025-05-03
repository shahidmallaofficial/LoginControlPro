#!/bin/bash

PLUGIN_NAME="logincontrolpro"
PLUGIN_REPO="https://github.com/shahidmallaofficial/LoginControlPro.git"
INSTALL_DIR="/usr/local/cpanel/$PLUGIN_NAME"
HOOK_PATH="$INSTALL_DIR/hooks/block_direct_login.pl"
WHM_INDEX_PATH="$INSTALL_DIR/whm/index.php"
LOG_DIR="$INSTALL_DIR/logs"

echo ""
echo "=============================================="
echo "Installing LoginControlPro Plugin by Shahid Malla"
echo "Repo: $PLUGIN_REPO"
echo "=============================================="
echo ""

# Step 1: Remove any previous version
if [ -d "$INSTALL_DIR" ]; then
  echo "[+] Removing existing directory: $INSTALL_DIR"
  rm -rf "$INSTALL_DIR"
fi

# Step 2: Clone from GitHub
echo "[+] Cloning from GitHub..."
git clone "$PLUGIN_REPO" "$INSTALL_DIR"

if [ $? -ne 0 ]; then
  echo "[X] Error cloning the plugin. Check internet or repo access."
  exit 1
fi

# Step 3: Ensure log directory exists
mkdir -p "$LOG_DIR"

# Step 4: Register the login hook with cPanel
echo "[+] Registering login block hook..."
/usr/local/cpanel/bin/manage_hooks add \
  --category Cpanel \
  --event login \
  --stage authn \
  --hook "$HOOK_PATH" \
  --exectype script

# Step 5: Set file permissions
echo "[+] Setting permissions..."
chmod +x "$HOOK_PATH"
chmod 755 "$WHM_INDEX_PATH"
chown -R root:wheel "$INSTALL_DIR"

# Final Message
echo ""
echo "✅ Plugin installed successfully!"
echo "Go to WHM → Plugins → LoginControlPro to configure settings."
echo ""
echo "Developed by Shahid Malla | https://shahidmalla.dev | life@shahidmalla.dev"
echo ""
