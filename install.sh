#!/bin/bash

set -e

echo "🚀 Installing LazyVim with your custom config..."

# Set up base paths
NVIM_CONFIG="$HOME/.config/nvim"
NVIM_DATA="$HOME/.local/share/nvim"
NVIM_THEME_FILE="$HOME/.config/omarchy/current/theme/neovim.lua"
BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%s)"
OMARCHY_CONFIG_DIR=$HOME/.local/share/omarchy/config/nvim

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

if [ -d $OMARCHY_CONFIG_DIR ]; then
  echo "📦 Starting with OMARCHY configuration as basis..."
  cp -R $OMARCHY_CONFIG_DIR/* $NVIM_CONFIG/
fi

echo "📦  Injecting your custom NeoVim config..."
cp -r nvim/* $NVIM_CONFIG/lua
#cp -r nvim/config $NVIM_CONFIG/lua
#cp -r nvim/utils $NVIM_CONFIG/lua

echo "🧹 Clearing mason cache..."
rm -rf "$NVIM_DATA/mason"

echo "Injecting tmux configuration"
cp tmux/tmux.conf ~/.tmux.conf

echo "✅ Done! Open Neovim with 'nvim' and LazyVim will sync your plugins."
