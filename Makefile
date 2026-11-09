# Usage: make plan ENV=dev | make apply ENV=prod
ENV ?= dev
DIR := terraform/environments/$(ENV)

.PHONY: help init fmt validate plan apply destroy output

help:
	@echo "Targets: init fmt validate plan apply destroy output  (ENV=dev|prod, default dev)"

init:
	terraform -chdir=$(DIR) init

fmt:
	terraform fmt -recursive terraform

validate: init
	terraform -chdir=$(DIR) validate

plan: init
	terraform -chdir=$(DIR) plan -out=tfplan

apply:
	terraform -chdir=$(DIR) apply tfplan

destroy:
	terraform -chdir=$(DIR) destroy

output:
	terraform -chdir=$(DIR) output
