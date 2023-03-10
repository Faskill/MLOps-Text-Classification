SHELL = /bin/bash

.PHONY: help
help:
	@echo "Commands:"
	@echo "venv    : Creates a venv virtual environment."
	@echo "style   : Formats files in PEP 8 format."
	@echo "clean   : Removes unnecessary files."

# Styling
.PHONY: style
style:
	black .
	flake8
	python3 -m isort .
# python3 -m mkdocs gh-deploy # Update documentation, done with github actions

.PHONY: clean
clean:
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	find . | grep -E ".trash" | xargs rm -rf
	rm -f .coverage

# Environment Setup
.ONESHELL:
venv:
	python3 -m venv venv
	source venv/bin/activate
	python3 -m pip install pip setuptools wheel
	python3 -m pip install pip --upgrade
	python3 -m pip install -e ".[dev]"
	pre-commit install
	pre-commit autoupdate

# Testing
.PHONY: test
.ONESHELL:
test:
# python3 -m pytest -m "not training" # Done with github actions
	cd tests
	great_expectations checkpoint run projects
	great_expectations checkpoint run tags
	great_expectations checkpoint run labeled_projects

.PHONY: dvc
dvc:
	dvc push
