#!/usr/bin/env bash
#
# Setup a Python venv and Cursor/VSCode config for the current project.
# - Creates venv with chosen Python: <python> -m venv ~/venv/<PROJECT_NAME>
# - Copies .cursor and .vscode from the template dir into current directory
# - Replaces <ENV_PATH> in copied files with the venv path
#
# Usage:
#   cd /path/to/your/project
#   ./setup-cursor-project.sh [TEMPLATE_DIR]
#
# On your local Linux: set CURSOR_TEMPLATE_DIR below or export it.
# To run anywhere: pass TEMPLATE_DIR as first argument or set CURSOR_TEMPLATE_DIR.
#

set -e

# --- Configure on your local Linux: path to cursor-setup-template ---
CURSOR_TEMPLATE_DIR="${CURSOR_TEMPLATE_DIR:-/home/snow/Documents/Projects/cursor-setup-template}"

# Allow override via first argument (run anywhere)
if [ -n "$1" ]; then
  CURSOR_TEMPLATE_DIR="$1"
fi

PROJECT_NAME="$(basename "$(pwd)")"
VENV_PATH="${HOME}/venv/${PROJECT_NAME}"

echo "Project name: ${PROJECT_NAME}"
echo "Venv path:    ${VENV_PATH}"
echo "Template:     ${CURSOR_TEMPLATE_DIR}"
echo

if [ ! -d "$CURSOR_TEMPLATE_DIR" ]; then
  echo "Error: Template directory not found: ${CURSOR_TEMPLATE_DIR}"
  echo "Set CURSOR_TEMPLATE_DIR or pass it as first argument."
  exit 1
fi

# Create venv only if it does not exist
if [ -d "$VENV_PATH" ]; then
  echo "Using existing virtual environment: ${VENV_PATH}"
else
  echo "Creating virtual environment..."
  default_python="python3"
  read -r -p "Python executable for venv (e.g. python3.12) [default: ${default_python}]: " PYTHON_EXE
  PYTHON_EXE="${PYTHON_EXE:-$default_python}"
  if ! command -v "$PYTHON_EXE" &>/dev/null; then
    echo "Error: ${PYTHON_EXE} not found in PATH."
    exit 1
  fi
  "$PYTHON_EXE" -m venv "$VENV_PATH"
  echo "Created ${VENV_PATH} with ${PYTHON_EXE}"
fi
echo

# Copy .cursor and .vscode
echo "Copying .cursor and .vscode from template..."
cp -r "${CURSOR_TEMPLATE_DIR}/.cursor" .
cp -r "${CURSOR_TEMPLATE_DIR}/.vscode" .
echo "Copied .cursor and .vscode"
echo

# Replace <ENV_PATH> in rule files and settings (same as configure_environment)
echo "Replacing <ENV_PATH> with ${VENV_PATH}..."

for f in .cursor/rules/python-environment.mdc .vscode/settings.json; do
  if [ -f "$f" ]; then
    sed -i "s|<ENV_PATH>|${VENV_PATH}|g" "$f"
    echo "  Updated: $f"
  fi
done

echo
echo "Done. Virtual environment: ${VENV_PATH}"
echo "Activate with: source ${VENV_PATH}/bin/activate"
