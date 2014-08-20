import cmemcached_imp

INVALID_SERVER_ADDR = '127.0.0.1:1'


def test_client_instantiation():
    cmemcached_imp.Client([INVALID_SERVER_ADDR])
