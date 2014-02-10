#!/usr/bin/env python

import os
from setuptools import setup, Extension

# setuptools DWIM monkey-patch madness
# http://mail.python.org/pipermail/distutils-sig/2007-September/thread.html#8204
import sys
if 'setuptools.extension' in sys.modules:
    m = sys.modules['setuptools.extension']
    m.Extension.__dict__ = m._Extension.__dict__

base_dir = '/Users/CMGS/Documents/Workplace/sources/test/greenify-test/'

options = {}
if os.environ.get('LIBRARY_DIRS'):
    options['library_dirs'] = [os.environ['LIBRARY_DIRS']]
if os.environ.get('INCLUDE_DIRS'):
    options['include_dirs'] = [os.environ['INCLUDE_DIRS']]

setup(name="python-libmemcached",
      version="1.0",
      description="python memcached client wrapped on libmemcached",
      maintainer="davies",
      maintainer_email="davies.liu@gmail.com",
      setup_requires=['setuptools_cython'],
      install_requires=['cython>=0.18'],
      ext_modules=[Extension('cmemcached_imp',
                             ['cmemcached_imp.pyx', 'split_mc.c'],
                             libraries=['memcached'],
                             **options)],
      py_modules=['cmemcached'],
      tests_require=['nose', 'mock'],
      test_suite="nose.collector",)
