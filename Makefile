# Start the lab with Keycloak default policies or Cedar policies, then run its
# use cases. Starting one stops the other first (they share ports).
#
#   make up               # Keycloak default policies
#   make up-cedar         # Cedar policies (Keycloak Cedar provider)
#   make test             # the use cases, against the running lab
#   make logs             # follow the lab's logs
#   make down             # stop the lab

KEYCLOAK       = docker compose -f mcp-authzen/docker-compose.yaml
KEYCLOAK_CEDAR = $(KEYCLOAK) -f mcp-authzen/docker-compose.cedar.yaml
CLI = shared/cli-tests.sh

.PHONY: help up up-cedar test logs down

help:
	@sed -n '1,9p' Makefile | sed 's/^# \{0,1\}//'

up: down
	$(KEYCLOAK) up -d --build --wait agentic-agentgateway payments-mcp

up-cedar: down
	$(KEYCLOAK_CEDAR) up -d --build --wait agentic-agentgateway payments-mcp

test:
	@set -e; \
	echo "== alice (payments_user): list and create allowed, approve denied"; \
	$(CLI) alice list_accounts; $(CLI) alice create_payment; $(CLI) alice approve_payment; \
	echo "== bob (payments_manager): approve allowed"; \
	$(CLI) bob approve_payment; \
	echo "== carol (payments_admin): cancel allowed"; \
	$(CLI) carol cancel_payment

logs:
	$(KEYCLOAK_CEDAR) logs -f

down:
	$(KEYCLOAK_CEDAR) down -v --remove-orphans
