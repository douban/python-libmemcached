#!/usr/bin/env python

import time
import random
import sys


options = None
total_time = None

def run_test(func, name):
    sys.stdout.write(name + ': ')
    sys.stdout.flush()
    start_time = time.time()
    try:
        func()
    except:
        print "failed or not supported"
        global options
        if options.verbose:
            import traceback; traceback.print_exc()
    else:
        end_time = time.time()
        global total_time
        total_time += end_time - start_time
        print "%f seconds" % (end_time - start_time)


class BigObject(object):
    def __init__(self, letter='1', size=10000):
        self.object = letter * size

    def __eq__(self, other):
        return self.object == other.object


class Benchmark(object):
    def __init__(self, module, options):
        self.module = module
        self.options = options
        self.init_server()
        self.test_set()
        self.test_set_get()
        self.test_random_get()
        self.test_set_same()
        self.test_set_big_object()
        self.test_set_get_big_object()
        self.test_set_big_string()
        self.test_set_get_big_string()
        self.test_get()
        self.test_get_big_object()
        self.test_get_multi()
        self.test_get_list()

    def init_server(self):
        #self.mc = self.module.Client([self.options.server_address])
        self.mc = self.module.Client(["faramir:11217"])
        self.mc.set_behavior(self.module.BEHAVIOR_BINARY_PROTOCOL, 1)
        self.mc.set('bench_key', "E" * 50)

        num_tests = self.options.num_tests
        self.keys = ['key%d' % i for i in xrange(num_tests)]
        self.values = ['value%d' % i for i in xrange(num_tests)]
        self.random_keys = ['key%d' % random.randint(0, num_tests) for i in xrange(num_tests * 3)]

    def test_set(self):
        set_ = self.mc.set
        pairs = zip(self.keys, self.values)

        def test():
            for key, value in pairs:
                set_(key, value)
        def test_loop():
            for i in range(10):
                for key, value in pairs:
                    set_(key, value)
        run_test(test, 'test_set')

        for key, value in pairs:
            self.mc.delete(key)

    def test_set_get(self):
        set_ = self.mc.set
        get_ = self.mc.get
        pairs = zip(self.keys, self.values)

        def test():
            for key, value in pairs:
                set_(key, value)
                result = get_(key)
                assert result == value
        run_test(test, 'test_set_get')

        #for key, value in pairs:
        #    self.mc.delete(key)

    def test_random_get(self):
        get_ = self.mc.get
        set_ = self.mc.set

        value = "chenyin"

        def test():
            index = 0
            for key in self.random_keys:
                result = get_(key)
                index += 1
                if(index % 5 == 0):
                    set_(key, value)
        run_test(test, 'test_random_get')

    def test_set_same(self):
        set_ = self.mc.set

        def test():
            for i in xrange(self.options.num_tests):
                set_('key', 'value')
        def test_loop():
            for i in range(10):
                for i in xrange(self.options.num_tests):
                    set_('key', 'value')
        run_test(test, 'test_set_same')

        self.mc.delete('key')

    def test_set_big_object(self):
        set_ = self.mc.set
        # libmemcached is slow to store large object, so limit the
        # number of objects here to make tests not stall.
        pairs = [('key%d' % i, BigObject()) for i in xrange(100)]

        def test():
            for key, value in pairs:
                set_(key, value)

        run_test(test, 'test_set_big_object (100 objects)')

        for key, value in pairs:
            self.mc.delete(key)

    def test_set_get_big_object(self):
        set_ = self.mc.set
        get_ = self.mc.get
        # libmemcached is slow to store large object, so limit the
        # number of objects here to make tests not stall.
        pairs = [('key%d' % i, BigObject()) for i in xrange(100)]

        def test():
            for key, value in pairs:
                set_(key, value)
                result = get_(key)
                assert result == value

        run_test(test, 'test_set_get_big_object (100 objects)')

        #for key, value in pairs:
        #    self.mc.delete(key)

    def test_set_get_big_string(self):
        set_ = self.mc.set
        get_ = self.mc.get

        # libmemcached is slow to store large object, so limit the
        # number of objects here to make tests not stall.
        pairs = [('key%d' % i, 'x' * 10000) for i in xrange(100)]

        def test():
            for key, value in pairs:
                set_(key, value)
                result = get_(key)
                assert result == value
        run_test(test, 'test_set_get_big_string (100 objects)')


    def test_set_big_string(self):
        set_ = self.mc.set

        # libmemcached is slow to store large object, so limit the
        # number of objects here to make tests not stall.
        pairs = [('key%d' % i, 'x' * 10000) for i in xrange(100)]

        def test():
            for key, value in pairs:
                set_(key, value)
        run_test(test, 'test_set_big_string (100 objects)')

        for key, value in pairs:
            self.mc.delete(key)


    def test_get(self):
        pairs = zip(self.keys, self.values)
        for key, value in pairs:
            self.mc.set(key, value)

        get = self.mc.get

        def test():
            for key, value in pairs:
                result = get(key)
                assert result == value
        run_test(test, 'test_get')

        for key, value in pairs:
            self.mc.delete(key)

    def test_get_big_object(self):
        pairs = [('bkey%d' % i, BigObject('x')) for i in xrange(100)]
        for key, value in pairs:
            self.mc.set(key, value)

        get = self.mc.get
        expected_values = [BigObject('x') for i in xrange(100)]

        def test():
            for i in xrange(100):
                result = get('bkey%d' % i)
                assert result == expected_values[i]
        run_test(test, 'test_get_big_object (100 objects)')

        for key, value in pairs:
            self.mc.delete(key)

    def test_get_multi(self):
        pairs = zip(self.keys, self.values)
        for key, value in pairs:
            self.mc.set(key, value)

        keys = self.keys
        expected_result = dict(pairs)

        def test():
            result = self.mc.get_multi(keys)
            assert result == expected_result
        run_test(test, 'test_get_multi')

        for key, value in pairs:
            self.mc.delete(key)

    def test_get_list(self):
        pairs = zip(self.keys, self.values)
        for key, value in pairs:
            self.mc.set(key, value)

        keys = self.keys
        expected_result = self.values

        def test():
            result = self.mc.get_list(keys)
            assert result == expected_result
        run_test(test, 'test_get_list')

        for key in self.keys:
            self.mc.delete(key)


def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option('-a', '--server-address', dest='server_address',
            default='127.0.0.1:11211',
            help="address:port of memcached [default: 127.0.0.1:11211]")
    parser.add_option('-n', '--num-tests', dest='num_tests', type='int',
            default=1000,
            help="repeat counts of each test [default: 1000]")
    parser.add_option('-v', '--verbose', dest='verbose',
            action='store_true', default=False,
            help="show traceback infomation if a test fails")
    global options
    options, args = parser.parse_args()

    global total_time
    total_time = 0

    print "Benchmarking cmemcached..."
    import cmemcached
    Benchmark(cmemcached, options)


if __name__ == '__main__':
    main()
    global total_time
    print "total_time is %f" % total_time
