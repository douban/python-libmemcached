#!/usr/bin/env python
import cmemcached

def main():
    mc=cmemcached.Client(["127.0.0.1:11211","127.0.0.1:11212","127.0.0.1:11213", "127.0.0.1:11214"])

    num = 10000
    keys = ["key%d" % k for k in xrange(num)]

    success_counter = 0
    failure_counter = 0

    def print_counter():
        print "success_counter is ", success_counter
        print "failure_counter is ", failure_counter
        assert failure_counter+success_counter == num
        print "mis rate is ", float(failure_counter)/num


    while True:
        for key in keys:
            mc.set(key, "aa")
        for key in keys:
            if mc.get(key) == "aa":
                    success_counter += 1
            else:
                    failure_counter += 1
        print_counter()
        success_counter = 0
        failure_counter = 0


if __name__ == '__main__':
    main()
