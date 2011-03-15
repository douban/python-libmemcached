import cmemcached
class BigObject(object):
    def __init__(self, letter='1', size=10000):
        self.object = letter * size

    def __eq__(self, other):
        return self.object == other.object

mc=cmemcached.Client(["127.0.0.1:11211","127.0.0.1:11212","127.0.0.1:11213", "127.0.0.1:11214"])

num=200
keyss = []
for i in xrange(4):
    k=i
    keyss.append(['key%d_%d' % (k,j) for j in xrange(num)])


valuess = []
for i in (1000, 10000, 100000, 200000):
    values = [BigObject(str(j%10), i) for j in xrange(num)]
    valuess.append(values)

def test_set_get(mc, pairs):
    counter = 0
    for key, value in pairs:
        mc.set(key, value)
        if(counter%4 == 0):
            #assert mc.get(key) == value
            pass
        counter+=1

from time import time
t=time()
for i in xrange(100):
    for k in xrange(4):
        pairs = zip(keyss[k],valuess[k])
        test_set_get(mc, pairs)
print time()-t
