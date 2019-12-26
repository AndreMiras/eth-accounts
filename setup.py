#!/usr/bin/env python

"""The setup script."""

from setuptools import setup, find_packages

with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = (
    'eth-account<0.5.0',
    'eth-utils',
)

setup_requirements = (
    'pytest-runner',
)

test_requirements = (
    'pytest>=3',
)

setup(
    author="Andre Miras",
    author_email=' ',
    python_requires='>=3.6',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
    ],
    description="Local Ethereum keystore management library",
    install_requires=requirements,
    license="MIT license",
    long_description=readme + '\n\n' + history,
    long_description_content_type="text/x-rst",
    include_package_data=True,
    keywords='eth_accounts',
    name='eth_accounts',
    packages=find_packages(include=['eth_accounts', 'eth_accounts.*']),
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/AndreMiras/eth_accounts',
    version='20191226',
    zip_safe=False,
)
