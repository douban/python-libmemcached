#!/usr/bin/env python

import os
from setuptools import setup, Extension
from Cython.Distutils import build_ext

base_dir = '/Users/CMGS/Documents/Workplace/sources/test/greenify-test/'

options = {}
if os.environ.get('LIBRARY_DIRS'):
    options['library_dirs'] = [os.environ['LIBRARY_DIRS']]
if os.environ.get('INCLUDE_DIRS'):
    options['include_dirs'] = [os.environ['INCLUDE_DIRS']]

setup(
        name = "python-libmemcached",
        version = "1.0",
        description="python memcached client wrapped on libmemcached",
        maintainer="davies",
        maintainer_email="davies.liu@gmail.com",
        install_requires = ['cython>=0.18'],
        cmdclass = {'build_ext': build_ext},
        ext_modules=[Extension('cmemcached_imp',
            ['cmemcached_imp.pyx', 'split_mc.c'],
            libraries=['memcached'],
            **options)],

        py_modules=['cmemcached'],
        test_suite="cmemcached_test",
)
