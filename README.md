# Cursor venv setup template

Sets up Python virtual-environment loading in Cursor so the agent and project use your venv.

**Why:** Easy, minimal setup for new projects. VS Code remembers your sourced venv; Cursor uses that same venv every time in the agent (no guessing which interpreter).

**Main scripts:** `setup-cursor-project.sh` (Linux) and `setup-cursor-project-mac.sh` (macOS).  
They use Python’s built-in **venv** to create a virtual environment, copy `.cursor` and `.vscode` from this template into your project, and replace `<ENV_PATH>` with the venv path. You are prompted to choose which Python version to use for the venv.

**Run from anywhere:** Put the script(s) on your PATH.

- **Linux:** e.g. `~/bin` — create it, add `export PATH="$HOME/bin:$PATH"` to `~/.bashrc` or `~/.zshrc`, copy the script(s) there, `chmod +x`.
- **macOS:** e.g. `~/bin` or `/usr/local/bin` — ensure the directory is on your PATH, copy the script(s), `chmod +x`.

Then from any project: `cd /path/to/project` and run `setup-cursor-project.sh` (or `-mac.sh`) with this repo as first argument if needed:  
`setup-cursor-project.sh /path/to/cursor-setup-template`

Use the Makefile here to replace `<ENV_PATH>` in the template files with your actual venv path if you edit them locally.
