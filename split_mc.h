#ifndef SPLIT_MC_H
#define SPLIT_MC_H

#include "libmemcached/memcached.h"

#ifdef __cplusplus
extern "C" {
#endif

#define CHUNK_SIZE 1000000
#define FLAG_CHUNKED (1<<12)
	
int split_mc_set(struct memcached_st *mc, char *key, size_t key_len, void *val,
		size_t bytes, time_t expire, uint32_t flags);

char* split_mc_get(struct memcached_st *mc, char *key, size_t key_len,
		int count, size_t *bytes);

#ifdef __cplusplus
}
#endif

#endif
