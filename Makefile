ENV_PATH=....

.PHONY: configure_environment

# replace <ENV_PATH> with $ENV_PATH in .cursorrules and .vscode/settings.json
configure_environment:
	@if [ "$(ENV_PATH)" = "...." ] || [ -z "$(ENV_PATH)" ]; then \
		echo "Error: ENV_PATH must be set to a valid environment name"; \
		echo "Usage: make configure_environment ENV_PATH=your_ENV_PATH"; \
		exit 1; \
	fi
	@if [ ! -f .cursorrules ]; then \
		echo "Error: .cursorrules not found"; \
		exit 1; \
	fi
	@if [ ! -f .vscode/settings.json ]; then \
		echo "Error: .vscode/settings.json not found"; \
		exit 1; \
	fi
	sed -i 's/<ENV_PATH>/$(ENV_PATH)/g' .cursorrules
	sed -i 's/<ENV_PATH>/$(ENV_PATH)/g' .vscode/settings.json
	@echo "Configuration updated: <ENV_PATH> replaced with $(ENV_PATH)"

configure_environment_on_MAC:
	export ENV_PATH="$HOME/<your_path>"
	sed -i '' 's|<ENV_PATH>|'"$ENV_PATH"'|g' .cursor/rules/python-environment.mdc
	sed -i '' 's|<ENV_PATH>|'"$ENV_PATH"'|g' .vscode/settings.json 
