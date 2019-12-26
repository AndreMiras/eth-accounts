============
eth-accounts
============


.. image:: https://img.shields.io/pypi/v/eth_accounts.svg
        :target: https://pypi.python.org/pypi/eth_accounts

.. image:: https://img.shields.io/travis/AndreMiras/eth-accounts.svg
        :target: https://travis-ci.com/AndreMiras/eth-accounts

.. image:: https://readthedocs.org/projects/eth-accounts/badge/?version=latest
        :target: https://eth-accounts.readthedocs.io/en/latest/?badge=latest
        :alt: Documentation Status




Local Ethereum keystore management library


* Free software: MIT license
* Documentation: https://eth-accounts.readthedocs.io.


Features
--------

* Create and manage local Ethereum accounts


Example
-------

>>> from eth_accounts.account_utils import AccountUtils
>>>
>>> account_utils = AccountUtils(keystore_dir="/tmp/keystore")
>>> account_utils.new_account(password="strong_password")
<Account(address=0x7f92b97485c361ae50d5f30936fb52abac14fe08, id=None)>
>>> account_utils.get_account_list()
[<Account(address=0x7f92b97485c361ae50d5f30936fb52abac14fe08, id=None)>]
>>> account = account_utils.get_account_list()[0]
>>> account.privkey
b'wU\xb1\xd6\xf1,`\x05f\xf1\x93\x04B\x11\x88\xe4i\x9d \xb9z9B\xb4\x9a\x1f\xae\xc4{\xa5\x13\x1f'
>>> account_utils.delete_account(account)
>>> account_utils.get_account_list()
[]
