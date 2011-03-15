__author__    = "davies <davies.liu@gmail.com> hongqn <hongqn@gmail.com> subdragon <subdragon@gmail.com>"
__version__   = "0.40"
__copyright__ = "Copyright (C) 2010 douban.com"
__license__   = "Apache License 2.0"

cdef extern from "Python.h":
    ctypedef int Py_ssize_t
    int PyString_AsStringAndSize(object obj, char **s, Py_ssize_t *len) except -1
    object PyString_FromStringAndSize(char * v, Py_ssize_t len)
    object PyInt_FromLong(long v)
    char *PyString_AsString(object obj) except NULL

    ctypedef struct PyThreadState:
            pass
    PyThreadState *PyEval_SaveThread()
    void PyEval_RestoreThread(PyThreadState *_save)

cdef extern from "stdlib.h":
    ctypedef unsigned int size_t
    ctypedef unsigned int time_t
    void *malloc(size_t size)
    void free(void *ptr)
    int atoi (char *STRING)

cdef extern from "stdint.h":
    ctypedef unsigned short int uint16_t
    ctypedef unsigned int uint32_t
    ctypedef unsigned long long int uint64_t

cdef extern from "libmemcached/memcached.h":
    ctypedef enum memcached_return: 
        MEMCACHED_SUCCESS
        MEMCACHED_FAILURE
        MEMCACHED_HOST_LOOKUP_FAILURE
        MEMCACHED_CONNECTION_FAILURE
        MEMCACHED_CONNECTION_BIND_FAILURE
        MEMCACHED_WRITE_FAILURE
        MEMCACHED_READ_FAILURE
        MEMCACHED_UNKNOWN_READ_FAILURE
        MEMCACHED_PROTOCOL_ERROR
        MEMCACHED_CLIENT_ERROR
        MEMCACHED_SERVER_ERROR
        MEMCACHED_CONNECTION_SOCKET_CREATE_FAILURE
        MEMCACHED_DATA_EXISTS
        MEMCACHED_DATA_DOES_NOT_EXIST
        MEMCACHED_NOTSTORED
        MEMCACHED_STORED
        MEMCACHED_NOTFOUND
        MEMCACHED_MEMORY_ALLOCATION_FAILURE
        MEMCACHED_PARTIAL_READ
        MEMCACHED_SOME_ERRORS
        MEMCACHED_NO_SERVERS
        MEMCACHED_END
        MEMCACHED_DELETED
        MEMCACHED_VALUE
        MEMCACHED_STAT
        MEMCACHED_ERRNO
        MEMCACHED_FAIL_UNIX_SOCKET
        MEMCACHED_NOT_SUPPORTED
        MEMCACHED_NO_KEY_PROVIDED
        MEMCACHED_FETCH_NOTFINISHED
        MEMCACHED_TIMEOUT
        MEMCACHED_BUFFERED
        MEMCACHED_BAD_KEY_PROVIDED
        MEMCACHED_INVALID_HOST_PROTOCOL
        MEMCACHED_SERVER_MARKED_DEAD
        MEMCACHED_UNKNOWN_STAT_KEY
        MEMCACHED_E2BIG
        MEMCACHED_INVALID_ARGUMENTS
        MEMCACHED_KEY_TOO_BIG
        MEMCACHED_AUTH_PROBLEM
        MEMCACHED_AUTH_FAILURE
        MEMCACHED_AUTH_CONTINUE
        MEMCACHED_MAXIMUM_RETURN # Always add new error code before

    ctypedef enum memcached_behavior:
        MEMCACHED_BEHAVIOR_NO_BLOCK
        MEMCACHED_BEHAVIOR_TCP_NODELAY
        MEMCACHED_BEHAVIOR_HASH
        MEMCACHED_BEHAVIOR_KETAMA
        MEMCACHED_BEHAVIOR_SOCKET_SEND_SIZE
        MEMCACHED_BEHAVIOR_SOCKET_RECV_SIZE
        MEMCACHED_BEHAVIOR_CACHE_LOOKUPS
        MEMCACHED_BEHAVIOR_SUPPORT_CAS
        MEMCACHED_BEHAVIOR_POLL_TIMEOUT
        MEMCACHED_BEHAVIOR_DISTRIBUTION
        MEMCACHED_BEHAVIOR_BUFFER_REQUESTS
        MEMCACHED_BEHAVIOR_USER_DATA
        MEMCACHED_BEHAVIOR_SORT_HOSTS
        MEMCACHED_BEHAVIOR_VERIFY_KEY
        MEMCACHED_BEHAVIOR_CONNECT_TIMEOUT
        MEMCACHED_BEHAVIOR_RETRY_TIMEOUT
        MEMCACHED_BEHAVIOR_KETAMA_WEIGHTED
        MEMCACHED_BEHAVIOR_KETAMA_HASH
        MEMCACHED_BEHAVIOR_BINARY_PROTOCOL
        MEMCACHED_BEHAVIOR_SND_TIMEOUT
        MEMCACHED_BEHAVIOR_RCV_TIMEOUT
        MEMCACHED_BEHAVIOR_SERVER_FAILURE_LIMIT
        MEMCACHED_BEHAVIOR_IO_MSG_WATERMARK
        MEMCACHED_BEHAVIOR_IO_BYTES_WATERMARK
        MEMCACHED_BEHAVIOR_IO_KEY_PREFETCH
        MEMCACHED_BEHAVIOR_HASH_WITH_PREFIX_KEY
        MEMCACHED_BEHAVIOR_NOREPLY
        MEMCACHED_BEHAVIOR_USE_UDP
        MEMCACHED_BEHAVIOR_AUTO_EJECT_HOSTS
        MEMCACHED_BEHAVIOR_NUMBER_OF_REPLICAS
        MEMCACHED_BEHAVIOR_RANDOMIZE_REPLICA_READ
        MEMCACHED_BEHAVIOR_CORK
        MEMCACHED_BEHAVIOR_TCP_KEEPALIVE
        MEMCACHED_BEHAVIOR_TCP_KEEPIDLE
        MEMCACHED_BEHAVIOR_MAX

    ctypedef enum memcached_server_distribution:
        MEMCACHED_DISTRIBUTION_MODULA
        MEMCACHED_DISTRIBUTION_CONSISTENT
        MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA
        MEMCACHED_DISTRIBUTION_RANDOM
        MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA_SPY
        MEMCACHED_DISTRIBUTION_CONSISTENT_MAX

    ctypedef enum memcached_hash:
        MEMCACHED_HASH_DEFAULT= 0
        MEMCACHED_HASH_MD5
        MEMCACHED_HASH_CRC
        MEMCACHED_HASH_FNV1_64
        MEMCACHED_HASH_FNV1A_64
        MEMCACHED_HASH_FNV1_32
        MEMCACHED_HASH_FNV1A_32
        MEMCACHED_HASH_HSIEH
        MEMCACHED_HASH_MURMUR
        MEMCACHED_HASH_JENKINS
        MEMCACHED_HASH_CUSTOM
        MEMCACHED_HASH_MAX

    ctypedef enum memcached_connection:
        MEMCACHED_CONNECTION_UNKNOWN
        MEMCACHED_CONNECTION_TCP
        MEMCACHED_CONNECTION_UDP
        MEMCACHED_CONNECTION_UNIX_SOCKET
        MEMCACHED_CONNECTION_MAX

    cdef enum:
        MEMCACHED_MAX_KEY

    struct memcached_st:
        pass

    struct memcached_server_st:
        pass

    struct memcached_allocated:
        pass

    struct memcached_string_st:
        pass

    struct memcached_result_st:
        pass
    
    struct memcached_stat_st:
        pass

    size_t memcached_string_length(memcached_string_st* str)
    char* memcached_string_value(memcached_string_st* str)
    char* memcached_string_c_copy(memcached_string_st* str)

    uint32_t memcached_result_flags(memcached_result_st* result)
    uint64_t memcached_result_cas(memcached_result_st* result)
    uint32_t memcached_result_key_length(memcached_result_st* result)
    char *memcached_result_value(memcached_result_st *ptr)
    size_t memcached_result_length(memcached_result_st *ptr)

    char* memcached_result_key_value(memcached_result_st* result)
    memcached_string_st memcached_result_string_st(memcached_result_st* result)

    memcached_st *memcached_create(memcached_st *ptr)
    void memcached_free(memcached_st *ptr)
    char* memcached_get(memcached_st *ptr, char *key, size_t key_length, size_t *value_length, uint32_t *flags, memcached_return *error)
    memcached_return memcached_set(memcached_st *ptr, char *key, size_t key_length, 
                               char *value, size_t value_length, time_t expiration, uint32_t  flags)
    memcached_server_st *memcached_servers_parse(char *server_strings)
    memcached_return memcached_server_push(memcached_st *ptr, memcached_server_st *list)
    memcached_return memcached_increment(memcached_st *ptr, 
            char *key, size_t key_length,
            uint32_t offset,
            uint64_t *value)
    memcached_return memcached_decrement(memcached_st *ptr, 
            char *key, size_t key_length,
            uint32_t offset,
            uint64_t *value)
    memcached_return memcached_delete(memcached_st *ptr, char *key, size_t key_length,
            time_t expiration)
    memcached_return memcached_mget(memcached_st *ptr, 
                                char **keys, size_t *key_length, 
                                unsigned int number_of_keys)
    char *memcached_fetch(memcached_st *ptr, char *key, size_t *key_length, 
                      size_t *value_length, uint32_t *flags, 
                      memcached_return *error)
    memcached_return memcached_behavior_set(memcached_st *ptr, memcached_behavior flag, uint64_t data)
    uint64_t memcached_behavior_get(memcached_st *ptr, unsigned int flag)
    void memcached_server_list_free(memcached_server_st *ptr)
    memcached_return memcached_append(memcached_st *ptr, 
                                  char *key, size_t key_length,
                                  char *value, size_t value_length, 
                                  time_t expiration,
                                  uint32_t flags)
    memcached_return memcached_prepend(memcached_st *ptr, 
                                   char *key, size_t key_length,
                                   char *value, size_t value_length, 
                                   time_t expiration,
                                   uint32_t flags)
    memcached_result_st *memcached_result_create(memcached_st *memc,
            memcached_result_st *ptr)
    memcached_result_st *memcached_fetch_result(memcached_st *ptr,
            memcached_result_st *result, memcached_return *error)
    memcached_return memcached_cas(memcached_st *ptr,
            char *key, size_t key_length,
            char *value, size_t value_length,
            time_t expiration,
            uint32_t flags,
            uint64_t cas)
    memcached_return memcached_add(memcached_st *ptr,
            char *key, size_t key_length,
            char *value, size_t value_length,
            time_t expiration,
            uint32_t flags)
    memcached_return memcached_replace(memcached_st *ptr,
            char *key, size_t key_length,
            char *value, size_t value_length,
            time_t expiration,
            uint32_t flags)
    memcached_stat_st *memcached_stat(memcached_st *ptr, char *args, memcached_return *error)
    uint32_t memcached_generate_hash(memcached_st *ptr, char *key, size_t key_length)
    char *memcached_strerror(memcached_st *ptr, memcached_return rc)
    memcached_return memcached_flush_buffers(memcached_st *mem)

cdef extern from "split_mc.h":
    cdef enum:
        CHUNK_SIZE
        _FLAG_CHUNKED "FLAG_CHUNKED"

    int split_mc_set(memcached_st *mc, char *key, size_t key_len, void *val,
        size_t bytes, time_t expire, uint32_t flags)
    char* split_mc_get(memcached_st *mc, char *key, size_t key_len,
        int count, size_t *bytes)

#-----------------------------------------

from cPickle import dumps, loads
import marshal
from string import join 
from time import strftime
import sys

class Error(Exception):
    pass

cdef int _FLAG_PICKLE, _FLAG_INTEGER, _FLAG_LONG, _FLAG_BOOL, _FLAG_MARSHAL

_FLAG_PICKLE = 1<<0
_FLAG_INTEGER = 1<<1
_FLAG_LONG = 1<<2
_FLAG_BOOL = 1<<3
_FLAG_MARSHAL = 1<<5

cdef object _prepare(object val, uint32_t *flags):
    cdef uint32_t f
    f = 0

    if isinstance(val, basestring):
        pass
    elif isinstance(val, (bool)):
        f = _FLAG_BOOL
        val = str(int(val))
    elif isinstance(val, (int,long)):
        f = _FLAG_INTEGER
        val = str(val)
    else:
        try:
            val = marshal.dumps(val, 2)
            f = _FLAG_MARSHAL
        except ValueError, e:
            try:
                val = dumps(val, -1)
                f = _FLAG_PICKLE
            except Exception, e:
                val = None

    flags[0] = f
    return val

def prepare(val):
    cdef uint32_t flag
    val = _prepare(val, &flag)
    return val, flag

cdef object _restore(object val, uint32_t flags):
    
    if flags == 0:
        pass
    elif flags & _FLAG_BOOL:
        val = bool(int(val))
    elif flags & _FLAG_INTEGER:
        val = int(val)
    elif flags & _FLAG_LONG:
        val = long(val)
    elif flags & _FLAG_MARSHAL:
        try:
            val = marshal.loads(val)
        except Exception, e:
            val = None
    elif flags & _FLAG_PICKLE:
        try:
            val = loads(val)
        except Exception, e:
            val = None
    return val

def restore(val, flag):
    return _restore(val, flag)

# count is the size of the whole chunk
cdef object _restore_splitted(memcached_st *mc, object key, int count):
    cdef char *c_key
    cdef Py_ssize_t key_len
    cdef char *c_val
    cdef size_t bytes
    
    PyString_AsStringAndSize(key, &c_key, &key_len)
    c_val = split_mc_get(mc, c_key, key_len, count, &bytes)

    if c_val != NULL:
        val = PyString_FromStringAndSize(c_val, bytes)
        free(c_val)
    else:
        val = None
    return val
        
HASH_DEFAULT   = PyInt_FromLong(MEMCACHED_HASH_DEFAULT)
HASH_MD5       = PyInt_FromLong(MEMCACHED_HASH_MD5)
HASH_CRC       = PyInt_FromLong(MEMCACHED_HASH_CRC)
HASH_FNV1_64   = PyInt_FromLong(MEMCACHED_HASH_FNV1_64)
HASH_FNV1A_64  = PyInt_FromLong(MEMCACHED_HASH_FNV1A_64)
HASH_FNV1_32   = PyInt_FromLong(MEMCACHED_HASH_FNV1_32)
HASH_FNV1A_32  = PyInt_FromLong(MEMCACHED_HASH_FNV1A_32)
HASH_HSIEH     = PyInt_FromLong(MEMCACHED_HASH_HSIEH)
HASH_MURMUR    = PyInt_FromLong(MEMCACHED_HASH_MURMUR)
HASH_JENKINS   = PyInt_FromLong(MEMCACHED_HASH_JENKINS)

DIST_MODULA                 = PyInt_FromLong(MEMCACHED_DISTRIBUTION_MODULA)
DIST_CONSISTENT             = PyInt_FromLong(MEMCACHED_DISTRIBUTION_CONSISTENT)
DIST_CONSISTENT_KETAMA      = PyInt_FromLong(MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA)
DIST_RANDOM                 = PyInt_FromLong(MEMCACHED_DISTRIBUTION_RANDOM)
DIST_CONSISTENT_KETAMA_SPY  = PyInt_FromLong(MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA_SPY)

BEHAVIOR_NO_BLOCK = PyInt_FromLong(MEMCACHED_BEHAVIOR_NO_BLOCK)
BEHAVIOR_TCP_NODELAY = PyInt_FromLong(MEMCACHED_BEHAVIOR_TCP_NODELAY)
BEHAVIOR_HASH = PyInt_FromLong(MEMCACHED_BEHAVIOR_HASH)
BEHAVIOR_KETAMA = PyInt_FromLong(MEMCACHED_BEHAVIOR_KETAMA)
BEHAVIOR_SOCKET_SEND_SIZE = PyInt_FromLong(MEMCACHED_BEHAVIOR_SOCKET_SEND_SIZE)
BEHAVIOR_SOCKET_RECV_SIZE = PyInt_FromLong(MEMCACHED_BEHAVIOR_SOCKET_RECV_SIZE)
BEHAVIOR_CACHE_LOOKUPS = PyInt_FromLong(MEMCACHED_BEHAVIOR_CACHE_LOOKUPS)
BEHAVIOR_SUPPORT_CAS = PyInt_FromLong(MEMCACHED_BEHAVIOR_SUPPORT_CAS)
BEHAVIOR_POLL_TIMEOUT = PyInt_FromLong(MEMCACHED_BEHAVIOR_POLL_TIMEOUT)
BEHAVIOR_DISTRIBUTION = PyInt_FromLong(MEMCACHED_BEHAVIOR_DISTRIBUTION)
BEHAVIOR_BUFFER_REQUESTS = PyInt_FromLong(MEMCACHED_BEHAVIOR_BUFFER_REQUESTS)
BEHAVIOR_USER_DATA = PyInt_FromLong(MEMCACHED_BEHAVIOR_USER_DATA)
BEHAVIOR_SORT_HOSTS = PyInt_FromLong(MEMCACHED_BEHAVIOR_SORT_HOSTS)
BEHAVIOR_VERIFY_KEY = PyInt_FromLong(MEMCACHED_BEHAVIOR_VERIFY_KEY)
BEHAVIOR_CONNECT_TIMEOUT = PyInt_FromLong(MEMCACHED_BEHAVIOR_CONNECT_TIMEOUT)
BEHAVIOR_RETRY_TIMEOUT = PyInt_FromLong(MEMCACHED_BEHAVIOR_RETRY_TIMEOUT)
BEHAVIOR_KETAMA_WEIGHTED = PyInt_FromLong(MEMCACHED_BEHAVIOR_KETAMA_WEIGHTED)
BEHAVIOR_KETAMA_HASH = PyInt_FromLong(MEMCACHED_BEHAVIOR_KETAMA_HASH)
BEHAVIOR_BINARY_PROTOCOL = PyInt_FromLong(MEMCACHED_BEHAVIOR_BINARY_PROTOCOL)
BEHAVIOR_SND_TIMEOUT = PyInt_FromLong(MEMCACHED_BEHAVIOR_SND_TIMEOUT)
BEHAVIOR_RCV_TIMEOUT = PyInt_FromLong(MEMCACHED_BEHAVIOR_RCV_TIMEOUT)
BEHAVIOR_SERVER_FAILURE_LIMIT = PyInt_FromLong(MEMCACHED_BEHAVIOR_SERVER_FAILURE_LIMIT)
BEHAVIOR_IO_MSG_WATERMARK        = PyInt_FromLong(MEMCACHED_BEHAVIOR_IO_MSG_WATERMARK) 
BEHAVIOR_IO_BYTES_WATERMARK      = PyInt_FromLong(MEMCACHED_BEHAVIOR_IO_BYTES_WATERMARK)
BEHAVIOR_IO_KEY_PREFETCH         = PyInt_FromLong(MEMCACHED_BEHAVIOR_IO_KEY_PREFETCH)
BEHAVIOR_HASH_WITH_PREFIX_KEY    = PyInt_FromLong(MEMCACHED_BEHAVIOR_HASH_WITH_PREFIX_KEY)
BEHAVIOR_NOREPLY                 = PyInt_FromLong(MEMCACHED_BEHAVIOR_NOREPLY)
BEHAVIOR_USE_UDP                 = PyInt_FromLong(MEMCACHED_BEHAVIOR_USE_UDP)
BEHAVIOR_AUTO_EJECT_HOSTS        = PyInt_FromLong(MEMCACHED_BEHAVIOR_AUTO_EJECT_HOSTS)
BEHAVIOR_NUMBER_OF_REPLICAS      = PyInt_FromLong(MEMCACHED_BEHAVIOR_NUMBER_OF_REPLICAS)
BEHAVIOR_RANDOMIZE_REPLICA_READ  = PyInt_FromLong(MEMCACHED_BEHAVIOR_RANDOMIZE_REPLICA_READ)
BEHAVIOR_CORK                    = PyInt_FromLong(MEMCACHED_BEHAVIOR_CORK)
BEHAVIOR_TCP_KEEPALIVE           = PyInt_FromLong(MEMCACHED_BEHAVIOR_TCP_KEEPALIVE)
BEHAVIOR_TCP_KEEPIDLE            = PyInt_FromLong(MEMCACHED_BEHAVIOR_TCP_KEEPIDLE)


cdef class Client:
    cdef memcached_st *mc
    cdef object servers
    cdef int    last_error

    def __cinit__(self, *a, **kw):
        """
        Create a new Client object with the given list of servers.
        """
        self.mc = memcached_create(NULL)
        if not self.mc:
            raise MemoryError
        self.servers = []

    def add_server(self, servers):
        """
        Add new server list
        """
        cdef memcached_return retval
        cdef memcached_server_st *server_mc

        server_string = ','.join(servers)
        server_mc = memcached_servers_parse(server_string) 
        retval = memcached_server_push(self.mc, server_mc)
        memcached_server_list_free(server_mc)
        self.servers += servers

    def get_host_by_key(self, key):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef unsigned int hash
        PyString_AsStringAndSize(key, &c_key, &key_len)
        hash = memcached_generate_hash(self.mc, c_key, key_len)
        if 0 <= hash < len(self.servers):
            return self.servers[hash]

    def get_last_error(self):
        return self.last_error

    def __dealloc__(self):
        memcached_free(self.mc)

    def set_behavior(self, int flag, uint64_t behavior):
        return memcached_behavior_set(self.mc, <memcached_behavior>flag, behavior)

    def get_behavior(self, unsigned int behavior):
        return memcached_behavior_get(self.mc, behavior)

    def _store(self, cmd, key, val, time_t time=0, cas=0, expected=(MEMCACHED_SUCCESS,)):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef uint32_t flags
        cdef memcached_return retval
        cdef int retval_int
        cdef PyThreadState *_save

        PyString_AsStringAndSize(key, &c_key, &key_len)

        # memcached do not support the key whose length is bigger than MEMCACHED_MAX_KEY
        if key_len >= MEMCACHED_MAX_KEY:
            return 0

        #validate key
        for i from 0 <= i < key_len:
            if c_key[i] <= 32 and c_key[i] >=0:
                sys.stderr.write("[cmemcached]%s: invalid key(%s)(%d)\n" % (cmd, key, i,))
                return 0

        if cmd in ('append', 'prepend') and type(val) != type(''):
            sys.stderr.write("[cmemcached]%s only support string: %s" % (cmd, key))
            return 0 

        val = _prepare(val, &flags)
        PyString_AsStringAndSize(val, &c_val, &bytes)
        
        #_save = PyEval_SaveThread()
        if cmd == 'add':
            retval = memcached_add(self.mc, c_key, key_len, c_val, bytes, time, flags)
        elif cmd == 'replace':
            retval = memcached_replace(self.mc, c_key, key_len, c_val, bytes, time, flags)
        elif cmd == 'cas':
            retval = memcached_cas(self.mc, c_key, key_len, c_val, bytes, time, flags, cas)
        elif cmd == 'append':
            retval = memcached_append(self.mc, c_key, key_len, c_val, bytes, time, flags)
        elif cmd == 'prepend': 
            retval = memcached_prepend(self.mc, c_key, key_len, c_val, bytes, time, flags)
        else:
            #PyEval_RestoreThread(_save)
            raise Exception, "invalid cmd %s" % cmd
        #PyEval_RestoreThread(_save)

        return retval in expected

    def add(self, key, val, time_t time=0):
        return self._store('add', key, val, time)

    def replace(self, key, val, time_t time=0):
        return self._store('replace', key, val, time)
 
    def cas(self, key, val, time_t time=0, cas=0):
        return self._store('cas', key, val, time, cas)

    def append(self, key, val):
        return self._store('append', key, val)

    def prepend(self, key, val):
        return self._store('prepend', key, val)

    def _store_multi(self, cmd, keys, val, time_t time=0):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef memcached_return retval

        if type(val) != type(''):
            sys.stderr.write("[cmemcached]%s only support string: %s" % (cmd, key))
            return 0 
        PyString_AsStringAndSize(val, &c_val, &bytes)
       
        self.set_behavior(BEHAVIOR_NOREPLY, 1)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 1)
        for key in keys:
            PyString_AsStringAndSize(key, &c_key, &key_len)
            if key_len >= MEMCACHED_MAX_KEY:
                continue
            if cmd == 'append':
                memcached_append(self.mc, c_key, key_len, c_val, bytes, 0, 0)
            elif cmd == 'prepend':
                memcached_prepend(self.mc, c_key, key_len, c_val, bytes, 0, 0)
        retval = memcached_flush_buffers(self.mc)
        self.set_behavior(BEHAVIOR_NOREPLY, 0)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 0)
        
        return retval == MEMCACHED_SUCCESS

    def append_multi(self, keys, val):
        return self._store_multi('append', keys, val)

    def prepend_multi(self, keys, val):
        return self._store_multi('prepend', keys, val)

    def check_key(self, key):
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef int i
        
        PyString_AsStringAndSize(key, &c_key, &key_len)
        
        if key_len >= MEMCACHED_MAX_KEY:
            return 0

        #validate key
        for i from 0 <= i < key_len:
            if c_key[i] <= 32 and c_key[i] >=0:
                sys.stderr.write("[cmemcached]set_raw: invalid key(%s)(%d)\n" % (key, i,))
                return 0
        return 1

    def set_raw(self, key, val, time_t time=0, flags_py=0):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef uint32_t flags
        cdef memcached_return retval
        cdef int retval_int
        cdef int i
        cdef PyThreadState *_save
       
        if self.check_key(key) == 0:
            return 0

        flags=flags_py
        PyString_AsStringAndSize(key, &c_key, &key_len)
        PyString_AsStringAndSize(val, &c_val, &bytes)

        if bytes > CHUNK_SIZE and self.do_split != 0:
            _save = PyEval_SaveThread();
            retval_int = split_mc_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
            PyEval_RestoreThread(_save)
            return (retval_int == 0)

        _save = PyEval_SaveThread();
        retval = memcached_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
        PyEval_RestoreThread(_save)
        return retval in (MEMCACHED_SUCCESS, MEMCACHED_NOTSTORED, MEMCACHED_STORED)
    
    def set_multi_raw(self, values, time_t time=0):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef uint32_t flags
        cdef memcached_return retval
        
        self.set_behavior(BEHAVIOR_NOREPLY, 1)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 1)
        for key, (val, flags_py) in values.iteritems():
            if not self.check_key(key):
                continue
            flags=flags_py
            PyString_AsStringAndSize(key, &c_key, &key_len)
            PyString_AsStringAndSize(val, &c_val, &bytes)
            if bytes > CHUNK_SIZE and self.do_split != 0:
                split_mc_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
            else:
                memcached_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
        retval = memcached_flush_buffers(self.mc)
        self.set_behavior(BEHAVIOR_NOREPLY, 0)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 0)
        return retval == MEMCACHED_SUCCESS

    def delete(self, key, time_t time=0):
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef memcached_return retval
        cdef PyThreadState *_save

        PyString_AsStringAndSize(key, &c_key, &key_len)
        if key_len >= MEMCACHED_MAX_KEY:
            return 0

        _save = PyEval_SaveThread();
        retval = memcached_delete(self.mc, c_key, key_len, time)
        PyEval_RestoreThread(_save)
        return retval in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND)

    def delete_multi(self, keys, time_t time=0):
        "delete multi key with noreply"
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef memcached_return retval

        self.set_behavior(BEHAVIOR_NOREPLY, 1)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 1)
        for key in keys:
            PyString_AsStringAndSize(key, &c_key, &key_len)
            if key_len >= MEMCACHED_MAX_KEY:
                continue
            memcached_delete(self.mc, c_key, key_len, time)
        retval = memcached_flush_buffers(self.mc)
        self.set_behavior(BEHAVIOR_NOREPLY, 0)
        self.set_behavior(BEHAVIOR_BUFFER_REQUESTS, 0)
        
        return retval == MEMCACHED_SUCCESS 

    def get_raw(self, key):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef uint32_t flags
        cdef size_t bytes
        cdef memcached_return rc
        cdef char * c_val
        cdef PyThreadState *_save
        
        self.last_error = 0

        PyString_AsStringAndSize(key, &c_key, &key_len)

        if key_len > MEMCACHED_MAX_KEY:
            return None, 0
        
        #validate key
        for i from 0 <= i < key_len:
            if c_key[i] <= 32 and c_key[i] >=0:
                sys.stderr.write("[cmemcached]get_raw: invalid key(%s)(%d)\n" % (key, i))
                
                return None, 0

        flags = 0
        _save = PyEval_SaveThread();
        c_val = memcached_get(self.mc, c_key, key_len, &bytes, &flags, &rc)
        PyEval_RestoreThread(_save)
        if NULL == c_val and rc not in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND, 
                MEMCACHED_SERVER_MARKED_DEAD, MEMCACHED_BUFFERED):
            sys.stderr.write('[cmemcached]memcached_get: server %s error: %s\n' 
                    % (self.get_host_by_key(key), memcached_strerror(self.mc, rc)))
        
        if NULL == c_val and rc not in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND): 
            self.last_error = rc

        if c_val:
            if flags & _FLAG_CHUNKED:
                val = _restore_splitted(self.mc, key, atoi(c_val))
                flags = flags & (~_FLAG_CHUNKED)
            else:
                val = PyString_FromStringAndSize(c_val, bytes)
            free(c_val)
        else:
            val = None

        return val, flags

    def get_multi_raw(self, keys):
        cdef char **ckeys
        cdef Py_ssize_t *ckey_lens

        cdef memcached_return rc
        cdef uint32_t flags

        cdef Py_ssize_t key_len
        cdef int i, nkeys, valid_nkeys, index
        cdef char return_key[MEMCACHED_MAX_KEY]
        cdef size_t return_key_length
        cdef char *return_value
        cdef size_t bytes
        cdef PyThreadState *_save


        nkeys = len(keys)
        ckeys = <char **>malloc(sizeof(char *) * nkeys)
        ckey_lens = <Py_ssize_t *>malloc(sizeof(Py_ssize_t) * nkeys)

        index = 0
        for i from 0 <= i < nkeys:
            PyString_AsStringAndSize(keys[i], &(ckeys[index]), &(ckey_lens[index]))
            if ckey_lens[index] > 0 and ckey_lens[index] < MEMCACHED_MAX_KEY:
                index = index + 1

        valid_nkeys = index


        _save = PyEval_SaveThread();
        rc = memcached_mget(self.mc, ckeys, <size_t *>ckey_lens, valid_nkeys)
        PyEval_RestoreThread(_save)

        result = {}
        chunks_record = []

        flags = 0
        while 1:
            flags = 0
            _save = PyEval_SaveThread();
            return_value= memcached_fetch(self.mc, return_key, &return_key_length,
                &bytes, &flags, &rc)
            PyEval_RestoreThread(_save)
            if return_value == NULL:
                break
            key = PyString_FromStringAndSize(return_key, return_key_length)
            if flags & _FLAG_CHUNKED:
                chunks_record.append((key, atoi(return_value), flags))
            else:
                val = PyString_FromStringAndSize(return_value, bytes)
                result[key] = (val, flags)
            free(return_value)
        for key, count, flags in chunks_record:
            val = _restore_splitted(self.mc, key, count)
            flags = flags & (~_FLAG_CHUNKED)
            if val is not None:
                result[key] = (val, flags)

        free(ckeys)
        free(ckey_lens)

        return result

    def incr(self, key, int val=1):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef uint64_t new_value
        cdef memcached_return rc
        cdef PyThreadState *_save

        PyString_AsStringAndSize(key, &c_key, &key_len)
        if key_len >= MEMCACHED_MAX_KEY:
            return
        
        _save = PyEval_SaveThread();
        if val > 0:
            rc=memcached_increment(self.mc, c_key, key_len, val, &new_value)
        else:
            rc=memcached_decrement(self.mc, c_key, key_len, -val, &new_value)
        PyEval_RestoreThread(_save)
        
        if rc != MEMCACHED_SUCCESS:
            return
        return new_value
        
    def decr(self, key, int val=1):
        return self.incr(key, -val)
