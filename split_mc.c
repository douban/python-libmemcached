#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "split_mc.h"

int split_mc_set(struct memcached_st *mc, char *key, size_t key_len, void *val,
		size_t bytes, time_t expire, uint32_t flags)
{
	char chunk_key[250];
	int i, retval;
	size_t chunk_bytes;

	/* assert bytes > CHUNK_SIZE */
    if (key_len > 200 || bytes > CHUNK_SIZE * 10) return -1; 

	for (i=0; bytes>0; i++) {
		retval = snprintf(chunk_key, 250, "~%.*s/%d", (int)key_len, key, i);
		if (retval < 0 || retval >= 250) {
			return -1;
		}
		chunk_bytes = bytes > CHUNK_SIZE ? CHUNK_SIZE : bytes;
		retval = memcached_set(mc, chunk_key, retval, val, chunk_bytes,
				expire, flags);
		if (retval != 0 && retval != 31) {
			return retval;
		}
		val += CHUNK_SIZE;
		bytes -= chunk_bytes;
	}

	sprintf(chunk_key, "%d", i);  /* re-use chunk_key as value buffer */
	retval = memcached_set(mc, key, key_len, chunk_key, strlen(chunk_key)+1,
			expire, flags|FLAG_CHUNKED);

	return retval;
}

/* It's up to the caller to free returned *val !!! */
char* split_mc_get(struct memcached_st *mc, char *key, size_t key_len,
		int nchunks, size_t *bytes)
{
	int i;
	char *c_val, *r, *v;
	memcached_return rc;
	uint32_t flags;
	size_t length;
	char chunk_key[250];

	/* assert res && res.val && (res.flags & FLAG_CHUNKED) */
    if (nchunks > 10 || key_len > 200)
        return NULL;

	r = (char*)malloc(sizeof(char) * CHUNK_SIZE * nchunks);
	if (!r) return NULL;

	for (i=0, v=r; i<nchunks; i++) {
		snprintf(chunk_key, 250, "~%.*s/%d", (int)key_len, key, i);
		c_val = memcached_get(mc, chunk_key, strlen(chunk_key),
				&length, &flags, &rc);	
		if(rc != MEMCACHED_SUCCESS || !c_val || length > CHUNK_SIZE) {
            if (c_val) free(c_val);
			goto error;
		}

		memcpy(v, c_val, length);
        free(c_val);
		v += length;
	}

    *bytes = v - r;
	return r;

error:
	memcached_delete(mc, key, key_len, 0);
	free(r);
	return NULL;
}
