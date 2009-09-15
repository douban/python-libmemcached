#!/usr/bin/env python

from setuptools import setup, Extension

setup(
        name = "python-libmemcached",
		version = "0.17.0",
		description="python memcached client wrapped on libmemcached",
		maintainer="subdragon",
		maintainer_email="subdragon@gmail.com",

        requires = ['pyrex'],
		# This assumes that libmemcache is installed with base /usr/local
        ext_modules=[Extension('cmemcached', ['cmemcached.pyx'],
            libraries=['memcached'],
        )],
        test_suite="cmemcached_test",
)
