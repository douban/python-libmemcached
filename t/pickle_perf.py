from cPickle import dumps, loads
from timeit import Timer

num = 300
class BigObject(object):
    def __init__(self, letter='1', size=10000):
        self.object = letter * size

    def __eq__(self, other):
        return self.object == other.object

sillything = []

for i in (1000, 10000, 100000, 200000):
    value = [BigObject(str(j%10), i) for j in xrange(num)]
    sillything.append(value)


value_t = None

def test_pickle():
    for tset in sillything:
        for t in tset:
            value = dumps(t, -1)
            value_t = loads(value)
            #assert value_t == t

from time import time
t=time()
for i in xrange(10):
    test_pickle()
print time()-t
#t=Timer(setup='from __main__ import test_pickle', stmt='test_pickle()')
#print t.timeit()

