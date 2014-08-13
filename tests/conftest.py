from subprocess import Popen
import time
import socket
import pytest
import cmemcached


@pytest.fixture(scope='session')
def memcached(request):
    # find a usable port in ephemeral ports
    for port in xrange(49152, 65536):
        sck = socket.socket()
        try:
            sck.bind(('127.0.0.1', port))
        except socket.error:
            continue
        sck.close()

        process = Popen(['memcached', '-l', '127.0.0.1', '-p', str(port)])
        time.sleep(1)
        if process.poll() is None:
            # we found a usable port!
            print "memcached listening on port %s" % port

            def fin():
                print "shutting down memcached"
                process.terminate()
                process.wait()
            request.addfinalizer(fin)
            return '127.0.0.1:%d' % port

    raise Exception("Cannot find usable port for memcached to listen on")


@pytest.fixture
def mc(memcached):
    return cmemcached.Client([memcached], comp_threshold=1024)
