#!/bin/bash

set -e

echo "🚀 Installing LazyVim with your custom config..."

# Set up base paths
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_DATA="$HOME/.local/share/nvim"
BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%s)"

# Backup old config if needed
if [ -d "$NVIM_CONFIG" ]; then
  echo "📦 Backing up existing nvim config to $BACKUP_DIR"
  mv "$NVIM_CONFIG" "$BACKUP_DIR"
fi

# Might want to delete this step as it is sorta dangerous and unnecessary
# Clear out existing nvim configuration
echo "🗑 Deleting existing NeoVim configuration..."
rm -rf $NVIM_DATA/
rm -rf $NVIM_CONFIG/

# Install LazyVim starter template
echo "📥 Cloning LazyVim starter..."
git clone https://github.com/LazyVim/starter $NVIM_CONFIG
rm -rf "$NVIM_CONFIG/.git"

echo "📦  Injecting your custom NeoVim config..."
cp -r nvim/plugins/* $NVIM_CONFIG/lua/plugins/
cp -r nvim/config/* $NVIM_CONFIG/lua/config/

echo "🧹 Clearing mason cache..."
rm -rf "$NVIM_DATA/mason"

echo "Injecting tmux configuration"
cp tmux/tmux.conf ~/.tmux.conf

echo "✅ Done! Open Neovim with 'nvim' and LazyVim will sync your plugins."
