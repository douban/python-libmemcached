__author__    = "davies <davies.liu@gmail.com> hongqn <hongqn@gmail.com> subdragon <subdragon@gmail.com> hurricane1026@gmail.com"
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
    int PyObject_CheckReadBuffer(object o)

cdef extern from "stdlib.h":
    ctypedef unsigned int size_t
    ctypedef unsigned int time_t
    void *malloc(size_t size)
    void free(void *ptr)
    int atoi (char *STRING)
    int strlen(char *STRING)

cdef extern from "stdint.h":
    ctypedef unsigned short int uint16_t
    ctypedef unsigned int uint32_t
    ctypedef unsigned long long int uint64_t

cdef extern from "pthread.h":
    int pthread_atfork(void (*prepare)(), void (*parent)(),
                          void (*child)())

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
        MEMCACHED_PARSE_ERROR
        MEMCACHED_PARSE_USER_ERROR
        MEMCACHED_DEPRECATED
        MEMCACHED_IN_PROGRESS
        MEMCACHED_SERVER_TEMPORARILY_DISABLED
        MEMCACHED_SERVER_MEMORY_ALLOCATION_FAILURE
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
        MEMCACHED_BEHAVIOR_LOAD_FROM_FILE
        MEMCACHED_BEHAVIOR_REMOVE_FAILED_SERVERS
        MEMCACHED_BEHAVIOR_DEAD_TIMEOUT
        MEMCACHED_BEHAVIOR_MAX

    ctypedef enum memcached_server_distribution:
        MEMCACHED_DISTRIBUTION_MODULA
        MEMCACHED_DISTRIBUTION_CONSISTENT
        MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA
        MEMCACHED_DISTRIBUTION_RANDOM
        MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA_SPY
        MEMCACHED_DISTRIBUTION_CONSISTENT_WEIGHTED
        MEMCACHED_DISTRIBUTION_VIRTUAL_BUCKET
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
        uint32_t connection_structures
        uint32_t curr_connections
        uint32_t curr_items
        uint32_t pid
        uint32_t pointer_size
        uint32_t rusage_system_microseconds
        uint32_t rusage_system_seconds
        uint32_t rusage_user_microseconds
        uint32_t rusage_user_seconds
        uint32_t threads
        uint32_t time
        uint32_t total_connections
        uint32_t total_items
        uint32_t uptime
        uint64_t bytes
        uint64_t bytes_read
        uint64_t bytes_written
        uint64_t cmd_get
        uint64_t cmd_set
        uint64_t evictions
        uint64_t get_hits
        uint64_t get_misses
        uint64_t limit_maxbytes
        char version[24]

    size_t memcached_string_length(memcached_string_st* str)
    char* memcached_string_value(memcached_string_st* str)
    char* memcached_string_c_copy(memcached_string_st* str)

    uint32_t memcached_result_flags(memcached_result_st* result)
    uint64_t memcached_result_cas(memcached_result_st* result)
    uint32_t memcached_result_key_length(memcached_result_st* result)
    void memcached_result_free(memcached_result_st* result)
    const char *memcached_result_value(memcached_result_st *ptr)
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
    void memcached_server_list_free(memcached_server_st *ptr)
    memcached_return memcached_server_add_udp(memcached_st *ptr, char *hostname, int port)
    memcached_return memcached_server_add_unix_socket(memcached_st *ptr, char *filename)
    memcached_return memcached_server_add(memcached_st *ptr, char *hostname, int port)
    memcached_return memcached_server_add_udp_with_weight(memcached_st *ptr, char *hostname, int port, uint32_t weight)
    memcached_return memcached_server_add_unix_socket_with_weight(memcached_st *ptr, char *filename, uint32_t weight)
    memcached_return memcached_server_add_with_weight(memcached_st *ptr, char *hostname, int port, uint32_t weight)

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
                                const char * const *keys,
                                const size_t *key_length,
                                size_t number_of_keys)
    char *memcached_fetch(memcached_st *ptr, char *key, size_t *key_length,
                      size_t *value_length, uint32_t *flags,
                      memcached_return *error)
    memcached_return memcached_behavior_set(memcached_st *ptr, memcached_behavior flag, uint64_t data)
    uint64_t memcached_behavior_get(memcached_st *ptr, unsigned int flag)
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
    memcached_return memcached_touch(memcached_st *ptr, char *key,
            size_t key_length, int expiration)
    memcached_stat_st *memcached_stat(memcached_st *ptr, char *args, memcached_return *error)
    void memcached_stat_free(memcached_st *ptr, memcached_stat_st *stat)
    uint32_t memcached_generate_hash(memcached_st *ptr, char *key, size_t key_length)
    const char *memcached_strerror(memcached_st *ptr, memcached_return rc)
    memcached_return memcached_flush_buffers(memcached_st *mem)
    void memcached_quit(memcached_st *ptr)

cdef extern from "split_mc.h":
    cdef enum:
        CHUNK_SIZE
        _FLAG_CHUNKED "FLAG_CHUNKED"

    memcached_return split_mc_set(memcached_st *mc, char *key, size_t key_len, void *val,
        size_t bytes, time_t expire, uint32_t flags)
    char* split_mc_get(memcached_st *mc, char *key, size_t key_len,
        int count, size_t *bytes)

#-----------------------------------------

import sys
from cPickle import dumps, loads
import marshal
from string import join
from time import strftime
import weakref

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

    if isinstance(val, str):
        pass
    elif isinstance(val, (bool)):
        f = _FLAG_BOOL
        val = str(int(val))
    elif isinstance(val, (int,long)):
        f = _FLAG_INTEGER
        val = str(val)
    elif type(val) is unicode:
        val = marshal.dumps(val, 2)
        f = _FLAG_MARSHAL
    else:
        # marshal treats buffers as strings and cause objects e.g.
        # numpy.array unrestorable
        if not PyObject_CheckReadBuffer(val):
            try:
                val = marshal.dumps(val, 2)
                f = _FLAG_MARSHAL
            except ValueError, e:
                pass

        if f != _FLAG_MARSHAL:
            # val is buffer or marshal failed
            try:
                val = dumps(val, -1)
                f = _FLAG_PICKLE
            except Exception, e:
                sys.stderr.write('pickle failed: %s\n' % e)
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
DIST_CONSISTENT_WEIGHTED      = PyInt_FromLong(MEMCACHED_DISTRIBUTION_CONSISTENT_WEIGHTED)

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

__mc_instances = []

cdef void close_all_mc():
    for r in __mc_instances:
        mc = r()
        if mc is not None:
            mc.close()

cdef class Client:
    cdef memcached_st *mc
    cdef object servers
    cdef memcached_return    last_error
    cdef char* prefix

    def __cinit__(self, *a, logger = None,**kw):
        """
        Create a new Client object with the given list of servers.
        """
        self.mc = memcached_create(NULL)
        self.__prefix = kw.pop('prefix', '')
        self.prefix = self.__prefix
        if not self.mc:
            raise MemoryError
        self.servers = []
        self.log = logger if logger else lambda x : None

        #if not __mc_instances:
        #    pthread_atfork(close_all_mc, NULL, NULL)
        __mc_instances.append(weakref.ref(self))

    def add_server(self, addrs):
        """
        Add new server list
        """
        cdef int port
        for addr in addrs:
            ps = addr.split(':')
            if addr.startswith('/'):
                path = ps[0]
                if len(ps) > 1:
                    memcached_server_add_unix_socket_with_weight(self.mc, path, int(ps[1]))
                else:
                    memcached_server_add_unix_socket(self.mc, path)
            else:
                host = ps[0]
                port = 11211
                if len(ps) > 1:
                    port = int(ps[1])
                if len(ps) > 2:
                    memcached_server_add_with_weight(self.mc, host, port, int(ps[2]))
                else:
                    memcached_server_add(self.mc, host, port)
        self.servers += addrs

    def get_host_by_key(self, key):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef unsigned int hash
        PyString_AsStringAndSize(key, &c_key, &key_len)
        hash = memcached_generate_hash(self.mc, c_key, key_len)
        if hash < len(self.servers):
            return self.servers[hash]

    def get_last_error(self):
        return self.last_error

    def get_last_strerror(self):
        cdef const char *c_str = memcached_strerror(self.mc, self.last_error)
        return PyString_FromStringAndSize(c_str, strlen(c_str))

    def __dealloc__(self):
        self.close()
        memcached_free(self.mc)

    def set_behavior(self, int flag, uint64_t behavior):
        return memcached_behavior_set(self.mc, <memcached_behavior>flag, behavior)

    def get_behavior(self, unsigned int behavior):
        return memcached_behavior_get(self.mc, behavior)


    def _use_prefix(self, key):
        if self.prefix:
            ask_exists = key.startswith('?')
            key = self.prefix + (key[1:] if ask_exists else key)
            if ask_exists:
                key = '?' + key
        return key

    def _store(self, cmd, key, val, time_t time=0, cas=0, expected=(MEMCACHED_SUCCESS,)):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef uint32_t flags
        cdef memcached_return retval
        cdef int retval_int
        cdef PyThreadState *_save

        # set prefix
        key = self._use_prefix(key)
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
            sys.stderr.write("[cmemcached]%s only support string: %s" % (cmd, keys))
            return 0
        PyString_AsStringAndSize(val, &c_val, &bytes)

        self.set_behavior(BEHAVIOR_NOREPLY, 1)
        for key in keys:
            key = self._use_prefix(key)
            PyString_AsStringAndSize(key, &c_key, &key_len)
            if key_len >= MEMCACHED_MAX_KEY:
                continue
            if cmd == 'append':
                retval = memcached_append(self.mc, c_key, key_len, c_val, bytes, 0, 0)
            elif cmd == 'prepend':
                retval = memcached_prepend(self.mc, c_key, key_len, c_val, bytes, 0, 0)
        self.set_behavior(BEHAVIOR_NOREPLY, 0)

        return retval == MEMCACHED_SUCCESS

    def append_multi(self, keys, val):
        return self._store_multi('append', keys, val)

    def prepend_multi(self, keys, val):
        return self._store_multi('prepend', keys, val)

    def check_key(self, key, prefixed=0):
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef int i

        if self.prefix and not prefixed:
            key = self._use_prefix(key)
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
        cdef int i
        cdef PyThreadState *_save

        key = self._use_prefix(key)
        if self.check_key(key, prefixed=1) == 0:
            return False

        flags=flags_py
        PyString_AsStringAndSize(key, &c_key, &key_len)
        PyString_AsStringAndSize(val, &c_val, &bytes)

        if bytes > CHUNK_SIZE and self.do_split != 0:
            _save = PyEval_SaveThread()
            retval = split_mc_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
            PyEval_RestoreThread(_save)
            return (retval == MEMCACHED_SUCCESS)

        _save = PyEval_SaveThread()
        retval = memcached_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
        PyEval_RestoreThread(_save)

        if retval not in (MEMCACHED_SUCCESS, MEMCACHED_NOTSTORED, MEMCACHED_STORED,
                MEMCACHED_SERVER_TEMPORARILY_DISABLED,
                MEMCACHED_SERVER_MARKED_DEAD, MEMCACHED_BUFFERED):
            self.log('[cmemcached]memcached_set: server %s error: %s\n'
                    % (self.get_host_by_key(key), memcached_strerror(self.mc, retval)))

        return retval in (MEMCACHED_SUCCESS, MEMCACHED_NOTSTORED, MEMCACHED_STORED)

    def set_multi_raw(self, values, time_t time=0, return_failure = False):
        cdef Py_ssize_t key_len, bytes
        cdef char *c_key, *c_val
        cdef uint32_t flags
        cdef memcached_return retval
        failed_keys = []

        #self.set_behavior(BEHAVIOR_NOREPLY, 1)
        for key, (val, flags_py) in values.iteritems():
            key = self._use_prefix(key)
            if not self.check_key(key, prefixed=1):
                continue
            flags=flags_py
            PyString_AsStringAndSize(key, &c_key, &key_len)
            PyString_AsStringAndSize(val, &c_val, &bytes)
            if bytes > CHUNK_SIZE and self.do_split != 0:
                retval = split_mc_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
            else:
                retval = memcached_set(self.mc, c_key, key_len, c_val, bytes, time, flags)
                if retval != MEMCACHED_SUCCESS:
                        failed_keys.append(key)
        #self.set_behavior(BEHAVIOR_NOREPLY, 0)
        return (len(failed_keys) == 0, failed_keys) if return_failure else len(failed_keys) == 0

    def delete(self, key, time_t time=0):
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef memcached_return retval
        cdef PyThreadState *_save

        key = self._use_prefix(key)
        if not self.check_key(key, prefixed=1):
            return 0

        PyString_AsStringAndSize(key, &c_key, &key_len)
        _save = PyEval_SaveThread()
        retval = memcached_delete(self.mc, c_key, key_len, time)
        PyEval_RestoreThread(_save)

        return retval in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND)

    def delete_multi(self, keys, time_t time=0, return_failure = False):
        "delete multi key with noreply"
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef memcached_return retval
        failed_keys = []

        #self.set_behavior(BEHAVIOR_NOREPLY, 1)
        for key in keys:
            key = self._use_prefix(key)
            PyString_AsStringAndSize(key, &c_key, &key_len)
            if key_len >= MEMCACHED_MAX_KEY:
                continue
            retval = memcached_delete(self.mc, c_key, key_len, time)
            if retval != MEMCACHED_SUCCESS:
                failed_keys.append(key)
        #self.set_behavior(BEHAVIOR_NOREPLY, 0)

        return (len(failed_keys) == 0, failed_keys) if return_failure else len(failed_keys) == 0

    def touch(self, key, int exptime):
        cdef Py_ssize_t key_len
        cdef char *c_key
        cdef memcached_return retval
        cdef PyThreadState *_save

        key = self._use_prefix(key)
        if not self.check_key(key, prefixed=1):
            return False

        PyString_AsStringAndSize(key, &c_key, &key_len)
        _save = PyEval_SaveThread()
        retval = memcached_touch(self.mc, c_key, key_len, exptime)
        PyEval_RestoreThread(_save)

        return retval == MEMCACHED_SUCCESS

    def get_raw(self, key):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef uint32_t flags
        cdef size_t bytes
        cdef memcached_return rc
        cdef char * c_val
        cdef PyThreadState *_save

        self.last_error = MEMCACHED_SUCCESS

        key = self._use_prefix(key)
        if not self.check_key(key, prefixed=1):
            return None, 0

        flags = 0
        PyString_AsStringAndSize(key, &c_key, &key_len)

        _save = PyEval_SaveThread()
        c_val = memcached_get(self.mc, c_key, key_len, &bytes, &flags, &rc)
        PyEval_RestoreThread(_save)
        if NULL == c_val and rc not in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND,
                MEMCACHED_SERVER_MARKED_DEAD, MEMCACHED_BUFFERED,
                MEMCACHED_SERVER_TEMPORARILY_DISABLED):
            self.log('[cmemcached]memcached_get: server %s error: %s\n'
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

    def gets_raw(self, key):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef uint32_t flags
        cdef size_t bytes
        cdef memcached_return rc
        cdef long long cas

        cdef const char * c_val
        cdef PyThreadState *_save
        cdef memcached_result_st mc_result
        cdef memcached_result_st *mc_result_ptr

        self.last_error = MEMCACHED_SUCCESS
        key = self._use_prefix(key)
        if not self.check_key(key, prefixed=1):
            return None, 0, 0

        flags = 0
        PyString_AsStringAndSize(key, &c_key, &key_len)

        _save = PyEval_SaveThread()
        rc = memcached_mget(self.mc, <const char * const*>&c_key, <const size_t *>(&key_len), 1)
        PyEval_RestoreThread(_save)
        if rc != MEMCACHED_SUCCESS:
            self.last_error = rc
            return None, 0, 0

        self.last_error = MEMCACHED_SUCCESS
        mc_result_ptr = memcached_result_create(self.mc, &mc_result)
        mc_result_ptr = memcached_fetch_result(self.mc, mc_result_ptr, &rc)
        if mc_result_ptr == NULL:
            #can not create mc_result
            return None, 0, 0
        c_val = memcached_result_value(mc_result_ptr)
        flags = memcached_result_flags(mc_result_ptr)
        cas = memcached_result_cas(mc_result_ptr)
        val = PyString_FromStringAndSize(c_val,
                memcached_result_length(mc_result_ptr)
                )
        memcached_result_free(mc_result_ptr)
        mc_result_ptr = memcached_fetch_result(self.mc, mc_result_ptr, &rc)
        if mc_result_ptr== NULL:
            return val, flags, cas
        else:
            memcached_result_free(mc_result_ptr)
            memcached_quit(self.mc)
            return None, 0, 0


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

        # do not modify input parameter
        keys = keys[:]

        nkeys = len(keys)
        ckeys = <char **>malloc(sizeof(char *) * nkeys)
        ckey_lens = <Py_ssize_t *>malloc(sizeof(Py_ssize_t) * nkeys)

        index = 0
        for i from 0 <= i < nkeys:
            keys[i] = self._use_prefix(keys[i])
            PyString_AsStringAndSize(keys[i], &(ckeys[index]), &(ckey_lens[index]))
            if ckey_lens[index] > 0 and ckey_lens[index] < MEMCACHED_MAX_KEY:
                index = index + 1

        valid_nkeys = index


        _save = PyEval_SaveThread()
        rc = memcached_mget(self.mc, <const char * const*>ckeys, <const size_t *>ckey_lens, valid_nkeys)
        PyEval_RestoreThread(_save)
        if rc != MEMCACHED_SUCCESS:
            self.last_error = rc
            return {}

        self.last_error = MEMCACHED_SUCCESS
        result = {}
        chunks_record = []

        flags = 0
        while 1:
            flags = 0
            _save = PyEval_SaveThread()
            return_value= memcached_fetch(self.mc, return_key, &return_key_length,
                &bytes, &flags, &rc)
            PyEval_RestoreThread(_save)
            if return_value == NULL:
                if rc not in (MEMCACHED_SUCCESS, MEMCACHED_NOTFOUND, MEMCACHED_END):
                    self.last_error = rc
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

        if self.prefix:
            result = dict([(key.replace(self.prefix, ''), value)
                     for key, value in result.iteritems()])
        return result

    def incr(self, key, int val=1):
        cdef char *c_key
        cdef Py_ssize_t key_len
        cdef uint64_t new_value
        cdef memcached_return rc
        cdef PyThreadState *_save

        key = self._use_prefix(key)
        PyString_AsStringAndSize(key, &c_key, &key_len)
        if key_len >= MEMCACHED_MAX_KEY:
            return

        _save = PyEval_SaveThread()
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

    def stats(self):
        cdef memcached_stat_st *stat
        cdef memcached_return rc

        stat = memcached_stat(self.mc, NULL, &rc)
        if stat == NULL:
            return {}

        stats = {}
        for i in range(len(self.servers)):
            st = {}
            st['pid'] = stat[i].pid
            st['uptime'] = stat[i].uptime
            st['time'] = stat[i].time
            st['pointer_size'] = stat[i].pointer_size
            st['threads'] = stat[i].threads
            st['version'] = stat[i].version

            st['rusage_user'] = stat[i].rusage_system_seconds + stat[i].rusage_system_microseconds / 1e6
            st['rusage_system'] = stat[i].rusage_user_seconds + stat[i].rusage_user_microseconds / 1e6

            st['curr_items'] = stat[i].curr_items
            st['total_items'] = stat[i].total_items

            st['curr_connections'] = stat[i].pid
            st['total_connections'] = stat[i].pid
            st['connection_structures'] = stat[i].pid

            st['cmd_get'] = stat[i].cmd_get
            st['cmd_set'] = stat[i].cmd_set
            st['get_hits'] = stat[i].get_hits
            st['get_misses'] = stat[i].get_misses
            st['evictions'] = stat[i].evictions

            st['bytes'] = stat[i].bytes
            st['bytes_read'] = stat[i].bytes_read
            st['bytes_written'] = stat[i].bytes_written
            st['limit_maxbytes'] = stat[i].limit_maxbytes

            stats[self.servers[i]] = st

        memcached_stat_free(self.mc, stat)

        return stats

    def quit(self):
        memcached_quit(self.mc)

    def close(self):
        self.quit()
