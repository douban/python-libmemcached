from mock import Mock, patch
import cmemcached

INVALID_SERVER_ADDR = '127.0.0.1:12345'


def test_set_multi_return_failure():
    client = cmemcached.Client([INVALID_SERVER_ADDR])
    v = dict([(str(i), "vv%s" % i) for i in range(10)])
    r, failures = client.set_multi(v, return_failure=True)
    assert r == False
    assert failures == v.keys()


def test_delete_multi_return_failure():
    client = cmemcached.Client([INVALID_SERVER_ADDR])
    keys = [str(i) for i in range(10)]
    r, failures = client.delete_multi(keys, return_failure=True)
    assert r == False
    assert failures == keys


