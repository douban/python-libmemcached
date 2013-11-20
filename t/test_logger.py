import cmemcached

def test_no_logger():
    client = cmemcached.Client('127.0.0.1')
    client.get('test_key_with_no_logger')
    client.set('test_key_with_no_logger', 'test_value_with_no_logger')
    pass

def log_print(message):
    print message

def test_has_logger():
    client = cmemcached.Client('127.0.0.1', logger = log_print)
    client.get('test_key_with_logger')
    client.set('test_key_with_logger', 'test_value_with_logger')
    pass

print '----test_no_logger----'
#test_no_logger()
print '----test done----'

print '----test_has_logger----'
test_has_logger()
print '----test done----'
