from cmemcached import *
import time
import cmemcached
print cmemcached

mc = Client([
#	'192.163.1.222:11211',
#	'192.163.1.2:11211',
#	'192.163.1.5:11211',
#    'localhost:7902'
    'theoden:11400',
	], do_split=0)
print mc.set_behavior(BEHAVIOR_NO_BLOCK, 0)
#print mc.set_behavior(BEHAVIOR_TCP_NODELAY, 1)
mc.set_behavior(BEHAVIOR_CONNECT_TIMEOUT, 50)
mc.set_behavior(BEHAVIOR_SND_TIMEOUT, 500*1000)
mc.set_behavior(BEHAVIOR_RCV_TIMEOUT, 500*1000)
mc.set_behavior(BEHAVIOR_POLL_TIMEOUT, 5000)
mc.set_behavior(BEHAVIOR_SERVER_FAILURE_LIMIT, 2)
mc.set_behavior(BEHAVIOR_RETRY_TIMEOUT, 10)

print mc.get_behavior(BEHAVIOR_NO_BLOCK)
print mc.get_behavior(BEHAVIOR_TCP_NODELAY)

for i in xrange(1):
    print time.time(), mc.set('test', 'test'*1024*1024)
#    print time.time(), len(mc.get('test') or '')
