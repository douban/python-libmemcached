import cmemcached
import unittest
import subprocess
import time

TEST_SERVER = "localhost"
memcached_process = None

def setup():
    global memcached_process
    memcached_process = subprocess.Popen(['memcached'])
    time.sleep(0.5)


def teardown():
    memcached_process.terminate()


class TestCmemcached_for_long(unittest.TestCase):

    def setUp(self):
        self.mc = cmemcached.Client([TEST_SERVER], comp_threshold=1024)

    def test_set_get_long(self):
        self.mc.set("key_long_short", long(1L))
        v = self.mc.get("key_long_short")
        self.assertEqual(v, 1L)
        self.assertEqual(type(v), long)

        big = 1233345435353543L
        self.mc.set("key_long_big", big)
        v = self.mc.get("key_long_big")
        self.assertEqual(v, big)
        self.assertEqual(type(v), long)

