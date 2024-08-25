SHELL := /bin/bash
.ONESHELL:
.PHONY: help start_b stop_b fb dev_fb run_all

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start_b:
	docker compose up

stop_b:
	docker compose down

fb: ## Run app
	chmod +x ./scripts/start.sh
	chmod +x ./frontend/frontend.sh
	./scripts/start.sh fb

dev_fb:
	chmod +x ./scripts/start.sh
	chmod +x ./frontend/frontend.sh
	./scripts/start.sh dev_fb

run_all: ## Run backend and frontend in separate tabs of a new iTerm window
	@echo "Starting backend and frontend in separate tabs of a new iTerm window..."
	@osascript -e 'tell application "iTerm"' \
		-e 'set newWindow to (create window with default profile)' \
		-e 'tell current session of newWindow' \
		-e '    write text "cd $(shell pwd) && make start_b"' \
		-e '    split horizontally with default profile' \
		-e 'end tell' \
		-e 'tell second session of current tab of newWindow' \
		-e '    write text "cd $(shell pwd) && make dev_fb"' \
		-e 'end tell' \
		-e 'end tell'
	@echo "Backend and frontend started in separate panes of a new iTerm window."