#ifndef _SHA2_H
#define _SHA2_H

#include "TYPES.h"

#ifdef __cplusplus
extern "C" {
#endif

#define SHA256_BLOCK_SIZE	64

typedef struct st_SHA256
{
	uint32 hash[8];
	uint8 block[SHA256_BLOCK_SIZE];
	uint32 offset, length;
} SHA256_t;

extern void SHA256_init(SHA256_t *SHA256);
extern void SHA256_update(SHA256_t *SHA256, uint8 *message, uint32 length);
extern void SHA256_final(SHA256_t *SHA256, uint8 *digest_256bits);

#ifdef __cplusplus
}
#endif

#endif	/* _SHA2_H */

