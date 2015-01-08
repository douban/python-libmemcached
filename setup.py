#!/usr/bin/env python

import os
import sys
from setuptools import setup, Extension
from setuptools.command.test import test as TestCommand

# setuptools DWIM monkey-patch madness
# http://mail.python.org/pipermail/distutils-sig/2007-September/thread.html#8204
if 'setuptools.extension' in sys.modules:
    m = sys.modules['setuptools.extension']
    m.Extension.__dict__ = m._Extension.__dict__

options = {}
if os.environ.get('LIBRARY_DIRS'):
    options['library_dirs'] = [os.environ['LIBRARY_DIRS']]
if os.environ.get('INCLUDE_DIRS'):
    options['include_dirs'] = [os.environ['INCLUDE_DIRS']]


# support python setup.py test
# http://pytest.org/latest/goodpractises.html#integration-with-setuptools-test-commands
class PyTest(TestCommand):
    user_options = [('pytest-args=', 'a', "Arguments to pass to py.test")]

    def initialize_options(self):
        TestCommand.initialize_options(self)
        self.pytest_args = None

    def finalize_options(self):
        TestCommand.finalize_options(self)
        self.test_args = []
        self.test_suite = True

    def run_tests(self):
        # import here, cause outside the eggs aren't loaded
        import pytest
        errno = pytest.main(self.pytest_args or [])
        sys.exit(errno)

setup(name="python-libmemcached",
      version="1.0",
      description="python memcached client wrapped on libmemcached",
      maintainer="Qiangning Hong",
      maintainer_email="hongqn@douban.com",
      setup_requires=['setuptools_cython'],
      install_requires=['Cython>=0.18'],
      ext_modules=[Extension('cmemcached_imp',
                             ['cmemcached_imp.pyx', 'split_mc.c'],
                             libraries=['memcached'],
                             **options)],
      py_modules=['cmemcached'],
      cmdclass={'test': PyTest},
      tests_require=['pytest', 'mock'],
      )
