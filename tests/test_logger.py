from mock import Mock, patch
import cmemcached

INVALID_SERVER_ADDR = '127.0.0.1:1'


def test_sys_stderr_should_have_no_output_when_no_logger_is_set(memcached):
    mc = cmemcached.Client([memcached])
    with patch('sys.stderr') as mock_stderr:
        mc.get('test_key_with_no_logger')
        mc.set('test_key_with_no_logger', 'test_value_with_no_logger')
        assert not mock_stderr.write.called


def test_logger_should_be_called_when_set():
    logger = Mock()
    client = cmemcached.Client([INVALID_SERVER_ADDR], logger=logger)
    client.get('test_key_with_logger')
    client.set('test_key_with_logger', 'test_value_with_logger')
    logger.assert_called_with(
        "[cmemcached]memcached_get: server %s error: CONNECTION FAILURE\n" %
        INVALID_SERVER_ADDR)
