#!/bin/bash
set -e

SCRIPT_NAME=$(basename "$0")

# Which subfolders inside ~/Library/Developer/Xcode/UserData/ do we want to back up?
SUBFOLDERS=("CodeSnippets" "FontAndColorThemes" "KeyBindings")

# Which optional files do we want to back up?
#  - com.apple.dt.Xcode.plist   (global Xcode prefs)
#  - IDEFindNavigatorScopes.plist (custom search scopes)
OPTIONAL_FILES=(
  "$HOME/Library/Preferences/com.apple.dt.Xcode.plist"
  "$HOME/Library/Developer/Xcode/UserData/IDEFindNavigatorScopes.plist"
)

function usage {
  cat <<EOF
Usage:
  $SCRIPT_NAME export
      - Exports minimal Xcode user settings to a timestamped .tar.gz on the Desktop.

  $SCRIPT_NAME import /path/to/XcodeMinimalBackup-<timestamp>.tar.gz
      - Backs up current minimal Xcode settings, then imports from the specified .tar.gz archive.

Note: This script only handles:
  - CodeSnippets, FontAndColorThemes, KeyBindings
  - Optional: com.apple.dt.Xcode.plist, IDEFindNavigatorScopes.plist
EOF
}

function do_export {
  TIMESTAMP=$(date +"%Y%m%d%H%M%S")
  EXPORT_NAME="XcodeMinimalBackup-$TIMESTAMP"
  EXPORT_DIR="$HOME/Desktop/$EXPORT_NAME"

  echo "==> Exporting minimal Xcode settings to '$EXPORT_NAME.tar.gz' on your Desktop..."

  # Create a temporary export folder
  mkdir -p "$EXPORT_DIR"

  # Copy relevant subfolders
  for folder in "${SUBFOLDERS[@]}"; do
    SRC="$HOME/Library/Developer/Xcode/UserData/$folder"
    if [ -d "$SRC" ]; then
      echo "  - Copying $folder"
      cp -R "$SRC" "$EXPORT_DIR/"
    else
      echo "  - Skipping $folder (not found)"
    fi
  done

  # Copy optional files if they exist
  for file in "${OPTIONAL_FILES[@]}"; do
    if [ -f "$file" ]; then
      echo "  - Copying $(basename "$file")"
      cp "$file" "$EXPORT_DIR/"
    fi
  done

  # Create the tarball
  pushd "$(dirname "$EXPORT_DIR")" >/dev/null
  tar -czf "$EXPORT_NAME.tar.gz" "$(basename "$EXPORT_DIR")"
  popd >/dev/null

  # Remove the temporary uncompressed folder
  rm -rf "$EXPORT_DIR"

  echo "==> Export complete: $HOME/Desktop/$EXPORT_NAME.tar.gz"
}

function do_import {
  if [ -z "$1" ]; then
    echo "Error: No archive specified for import."
    usage
    exit 1
  fi

  ARCHIVE_PATH="$1"
  if [ ! -f "$ARCHIVE_PATH" ]; then
    echo "Error: Archive not found at: $ARCHIVE_PATH"
    exit 1
  fi

  # Close Xcode to avoid conflicts
  osascript -e 'tell application "Xcode" to quit' 2>/dev/null || true

  echo "==> Importing minimal Xcode settings from $ARCHIVE_PATH..."

  # Extract to a temporary directory
  TEMP_DIR=$(mktemp -d)
  tar -xzf "$ARCHIVE_PATH" -C "$TEMP_DIR"

  # The extracted folder might look like "XcodeMinimalBackup-<timestamp>/{folders/files}"
  # We want to refer to that top-level directory.
  BACKUP_PARENT_DIR=$(find "$TEMP_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit)
  if [ -z "$BACKUP_PARENT_DIR" ]; then
    echo "Error: Could not find extracted content in the archive."
    exit 1
  fi

  # For each subfolder we care about, rename existing (if any) and copy from backup.
  for folder in "${SUBFOLDERS[@]}"; do
    TARGET_DIR="$HOME/Library/Developer/Xcode/UserData/$folder"
    BACKUP_SOURCE="$BACKUP_PARENT_DIR/$folder"
    if [ -d "$BACKUP_SOURCE" ]; then
      # Backup existing
      if [ -d "$TARGET_DIR" ]; then
        BACKUP_SUFFIX=$(date +"%Y%m%d%H%M%S")
        mv "$TARGET_DIR" "${TARGET_DIR}.old.$BACKUP_SUFFIX"
        echo "  - Backed up existing '$folder' to '${TARGET_DIR}.old.$BACKUP_SUFFIX'"
      fi
      echo "  - Restoring $folder"
      cp -R "$BACKUP_SOURCE" "$(dirname "$TARGET_DIR")"
    fi
  done

  # For optional files, rename existing and copy if present
  for file in "${OPTIONAL_FILES[@]}"; do
    BASENAME=$(basename "$file")
    BACKUP_FILE="$BACKUP_PARENT_DIR/$BASENAME"
    if [ -f "$BACKUP_FILE" ]; then
      if [ -f "$file" ]; then
        BACKUP_SUFFIX=$(date +"%Y%m%d%H%M%S")
        mv "$file" "$file.old.$BACKUP_SUFFIX"
        echo "  - Backed up existing '$BASENAME' to '$file.old.$BACKUP_SUFFIX'"
      fi
      echo "  - Restoring $BASENAME"
      cp "$BACKUP_FILE" "$(dirname "$file")"
    fi
  done

  # Clean up
  rm -rf "$TEMP_DIR"

  echo "==> Import complete. Reopen Xcode to see your restored settings."
}

# Main entry point
case "$1" in
  export)
    do_export
    ;;
  import)
    shift
    do_import "$@"
    ;;
  *)
    usage
    exit 1
    ;;
esac
