import cmemcached
import optparse

class BigObject(object):
    def __init__(self, letter='1', size=10000):
        self.object = letter * size

    def __eq__(self, other):
        return self.object == other.object

parameters = ['set', 'add_server', 'remove_server']
parameters_string = '|'.join(parameters)
p = optparse.OptionParser(usage=("%prog " + parameters_string))

options, arguments = p.parse_args()
if len(arguments) != 1 or arguments[0] not in parameters:
    p.error('Only one parameter(in %s) are supported!' % parameters_string)
print arguments[0]

if arguments[0] == 'remove_server':
    mc =  cmemcached.Client(["127.0.0.1:11211","127.0.0.1:11212","127.0.0.1:11213"])
else:
    mc =  cmemcached.Client(["127.0.0.1:11211","127.0.0.1:11212","127.0.0.1:11213", "127.0.0.1:11214"])

num_tests = 10000
count = 0
keys = ['helloworld%d' % i for i in xrange(num_tests)]
if arguments[0] == 'set':
    for key in keys:
        mc.set(key , 'aa')
    for key in keys:
        assert mc.get(key) == 'aa'

if arguments[0] == 'add_server':
    mc.add_server(["127.0.0.1:11215"])
    for key in keys:
        if mc.get(key) == 'aa':
            count += 1
    print "hit rate:", float(count)/num_tests

if arguments[0] == 'remove_server':
    for key in keys:
        if mc.get(key) == 'aa':
            count += 1
    print "hit rate:", float(count)/num_tests
