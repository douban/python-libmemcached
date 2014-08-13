#!/usr/local/bin/python2.7
# coding:utf-8

from cmemcached import Client
import pytest

PREFIX = 'dae|admin|'


@pytest.fixture
def prefixed_mc(memcached):
    return Client([memcached], prefix=PREFIX)


@pytest.fixture
def raw_mc(memcached):
    return Client([memcached])


def test_prefix(prefixed_mc, raw_mc):
    raw_mc.delete('a')
    prefixed_mc.set('a', 1)
    assert(prefixed_mc.get('a') == 1)
    assert(raw_mc.get(PREFIX + 'a') == 1)
    assert(raw_mc.get('a') is None)

    prefixed_mc.add('b', 2)
    assert(prefixed_mc.get('b') == 2)
    assert(raw_mc.get(PREFIX + 'b') == 2)
    assert(raw_mc.get('b') is None)

    prefixed_mc.incr('b')
    assert(prefixed_mc.get('b') == 3)
    assert(raw_mc.get(PREFIX + 'b') == 3)

    raw_mc.decr(PREFIX + 'b')
    assert(prefixed_mc.get('b') == 2)

    prefixed_mc.set_multi({'x': 'a', 'y': 'b'})
    ret = prefixed_mc.get_multi(['x', 'y'])
    assert(ret.get('x') == 'a' and ret.get('y') == 'b')
    assert(prefixed_mc.delete_multi(['a', 'b', 'x', 'y']))
