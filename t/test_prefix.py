#!/usr/local/bin/python2.7
#coding:utf-8

from cmemcached import Client as m2

prefix = 'dae|admin|'

c1=m2(['localhost:11211'], prefix=prefix)
c2=m2(['localhost:11211'])

c1.set('a', 1)
assert(c1.get('a')==1)
assert(c2.get(prefix+'a')==1)
assert(c2.get('a')==None)

c1.add('b', 2)
assert(c1.get('b')==2)
assert(c2.get(prefix+'b')==2)
assert(c2.get('b')==None)

c1.incr('b')
assert(c1.get('b')==3)
assert(c2.get(prefix+'b')==3)

c2.decr(prefix+'b')
assert(c1.get('b')==2)

c1.set_multi({'x':'a', 'y':'b'})
ret = c1.get_multi(['x', 'y'])
assert(ret.get('x') == 'a' and ret.get('y') == 'b')
assert(c1.delete_multi(['a', 'b', 'x', 'y']))
