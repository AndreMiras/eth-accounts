.PHONY: clean clean-test clean-pyc clean-build docs help
.DEFAULT_GOAL := help
VIRTUAL_ENV ?= venv
PIP=$(VIRTUAL_ENV)/bin/pip
PYTHON_MAJOR_VERSION=3
PYTHON_MINOR_VERSION=7
PYTHON_VERSION=$(PYTHON_MAJOR_VERSION).$(PYTHON_MINOR_VERSION)
PYTHON_WITH_VERSION=python$(PYTHON_VERSION)
PYTHON=$(VIRTUAL_ENV)/bin/python
FLAKE8=$(VIRTUAL_ENV)/bin/flake8
PYTEST=$(VIRTUAL_ENV)/bin/pytest
COVERAGE=$(VIRTUAL_ENV)/bin/coverage
TWINE=$(VIRTUAL_ENV)/bin/twine
SPHINX_APIDOC=$(VIRTUAL_ENV)/bin/sphinx-apidoc

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := $(PYTHON) -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

$(VIRTUAL_ENV):
	virtualenv --python $(PYTHON_WITH_VERSION) $(VIRTUAL_ENV)
	$(PIP) install --requirement requirements_dev.txt

virtualenv: $(VIRTUAL_ENV) ## creates virtualenv for local development

lint: virtualenv ## check style with flake8
	$(FLAKE8) eth_accounts tests

test: virtualenv ## run tests quickly with the default Python
	$(PYTEST)

test-all: ## run tests on every Python version with tox
	tox

coverage: virtualenv ## check code coverage quickly with the default Python
	$(COVERAGE) run --source eth_accounts -m pytest
	$(COVERAGE) report -m
	$(COVERAGE) html
	$(BROWSER) htmlcov/index.html

docs: virtualenv ## generate Sphinx HTML documentation, including API docs
	rm -f docs/eth_accounts.rst
	rm -f docs/modules.rst
	$(SPHINX_APIDOC) -o docs/ eth_accounts
	$(MAKE) -C docs clean SPHINXBUILD="../$(PYTHON) -msphinx"
	$(MAKE) -C docs html SPHINXBUILD="../$(PYTHON) -msphinx"
	$(BROWSER) docs/_build/html/index.html

servedocs: docs ## compile the docs watching for changes
	watchmedo shell-command -p '*.rst' -c '$(MAKE) -C docs html' -R -D .

release: dist ## package and upload a release
	$(TWINE) upload dist/*

dist: virtualenv clean ## builds source and wheel package
	$(PYTHON) setup.py sdist
	$(PYTHON) setup.py bdist_wheel
	$(TWINE) check dist/*
	ls -l dist

install: clean ## install the package to the active Python's site-packages
	python setup.py install
