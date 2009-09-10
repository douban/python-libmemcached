import cmemcached
import unittest
import pickle

MEMCACHED_HOSTS = ['localhost:9130']

class TestCmemcached(unittest.TestCase):

    def setUp(self, with_cas=0):
        self.mc = cmemcached.Client(MEMCACHED_HOSTS, behaviors={'support_cas': with_cas})

    def testSetAndGet(self):
        self.mc.set("num12345", 12345)
        self.assertEqual(self.mc.get("num12345"), 12345)
        self.mc.set("str12345", "12345")
        self.assertEqual(self.mc.get("str12345"), "12345")

    def testDelete(self):
        self.mc.set("str12345", "12345")
        #delete return True on success, otherwise False
        ret = self.mc.delete("str12345")
        self.assertEqual(self.mc.get("str12345"), None)
        self.assertEqual(ret, True)

        ret = self.mc.delete("hello world")
        self.assertEqual(ret, False)

    def testGetMulti(self):
        self.mc.set("a", "valueA")
        self.mc.set("b", "valueB")
        self.mc.set("c", "valueC")
        result = self.mc.get_multi(["a", "b", "c", "", "hello world"])
        self.assertEqual(result, {'a':'valueA', 'b':'valueB', 'c':'valueC'})

    def testBigGetMulti(self):
        count = 10
        keys = ['key%d' % i for i in xrange(count)]
        pairs = zip(keys, ['value%d' % i for i in xrange(count)])
        for key, value in pairs:
            self.mc.set(key, value)
        result = self.mc.get_multi(keys)
        assert result == dict(pairs)

    def testGetList(self):
        self.mc.delete("")
        self.mc.delete("hello world")
        self.mc.set("a", "valueA")
        self.mc.set("b", "valueB")
        self.mc.set("c", "valueC")
        result= self.mc.get_list(["a", "b", "c", "", "hello world"])
        self.assertEqual(result, ['valueA', 'valueB', 'valueC', None, None])

    def testAppend(self):
        self.mc.delete("a")
        self.mc.set("a", "I ")
        ret = self.mc.append("a", "Do")
        result = self.mc.get("a")
        self.assertEqual(result, "I Do")

    def testPrepend(self):
        self.mc.delete("a")
        self.mc.set("a", "Do")
        ret = self.mc.prepend("a", "I ")
        result = self.mc.get("a")
        self.assertEqual(result, "I Do")

    def testIncr(self):
        self.mc.set("incr", 1)
        ret = self.mc.incr("incr", 1)
        self.assertEqual(ret, 2)
        ret = self.mc.incr("incr", 2)
        self.assertEqual(ret, 4)

    def testDecr(self):
        self.mc.set("decr", 10)
        ret = self.mc.decr("decr", 1)
        self.assertEqual(ret, 9)
        ret = self.mc.decr("decr", 2)
        self.assertEqual(ret, 7)

    def testBool(self):
        self.mc.set("bool", True)
        value = self.mc.get("bool")
        self.assertEqual(value, True)
        self.mc.set("bool_", False)
        value = self.mc.get("bool_")
        self.assertEqual(value, False)

    def testFlush(self):
        self.mc.set("a", True)
        self.mc.set("b", "hello world")
        self.mc.flush_all()
        value = self.mc.get("a")
        self.assertEqual(value, None)
        value = self.mc.get("b")
        self.assertEqual(value, None)

    def testBehaviors(self):
        mc2 = cmemcached.Client(["127.0.0.1:11211"])
        self.assertEqual(mc2.behaviors['support_cas'], 0)
        mc2 = cmemcached.Client(["127.0.0.1:11211"],
                behaviors={'support_cas': 1})
        self.assertEqual(mc2.behaviors['support_cas'], 1)
        mc2 = cmemcached.Client(["127.0.0.1:11211"],
                behaviors={'support_cas': 0})
        self.assertEqual(mc2.behaviors['support_cas'], 0)


class TestCmemcachedCas(TestCmemcached):
    """
    Run the tests again, but with cas support on the default connection.
    """

    def setUp(self):
        super(TestCmemcachedCas, self).setUp(with_cas=1)
        self.mc_cas = self.mc

    def testCas(self):
        self.mc_cas.set('miredo', 'alamos')
        (res, cas), = self.mc_cas.get_list(['miredo'], with_cas=True)
        r2, c2 = self.mc_cas.gets('miredo')
        self.assertEqual((res, cas), (r2, c2))
        self.assertEqual(res, 'alamos')
        self.assertFalse(self.mc_cas.cas('miredo', 'monobot', 0))
        self.assertEqual(self.mc_cas.get('miredo'), 'alamos')
        self.assertTrue(self.mc_cas.cas('miredo', 'oulipo', cas))
        self.assertEqual(self.mc_cas.get('miredo'), 'oulipo')

if __name__ == '__main__':
    unittest.main()

