#include "SHA2.h"

#define SHA256_BLOCK_SIZE    64

extern void SHA256_init(SHA256_t *SHA256);
extern void SHA256_update(SHA256_t *SHA256, uint8 *message, uint32 length);
extern void SHA256_final(SHA256_t *SHA256, uint8 *digest_256bits);


static uint32 __k[SHA256_BLOCK_SIZE] =
{
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
	0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
	0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
	0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
	0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
};

static uint32 __shift(uint32 x, uint32 n)
{
	return x >> n;
}

static uint32 __rotr(uint32 x, uint32 n)
{
	return (x >> n) | (x << (32 - n));
}

static uint32 __ch(uint32 x, uint32 y, uint32 z)
{
	return (x & y) ^ (~x & z);
}

static uint32 __maj(uint32 x, uint32 y, uint32 z)
{
	return (x & y) ^ (x & z) ^ (y & z);
}

static uint32 __sumh0(uint32 x)
{
	return __rotr(x, 2) ^ __rotr(x, 13) ^ __rotr(x, 22);
}

static uint32 __sumh1(uint32 x)
{
	return __rotr(x, 6) ^ __rotr(x, 11) ^ __rotr(x, 25);
}

static uint32 __suml0(uint32 x)
{
	return __rotr(x, 7) ^ __rotr(x, 18) ^ __shift(x, 3);
}

static uint32 __suml1(uint32 x)
{
	return __rotr(x, 17) ^ __rotr(x, 19) ^ __shift(x, 10);
}

#define __u8_u32(i, o) {\
	(o) = (((i)[0]) & 0xff) << 24 | (((i)[1]) & 0xff) << 16 | (((i)[2]) & 0xff) << 8 | (((i)[3]) & 0xff);\
}

#define __u32_u8(i, o) {\
	(o)[3] = (uint8)(((i) >>  0) & 0xff);\
	(o)[2] = (uint8)(((i) >>  8) & 0xff);\
	(o)[1] = (uint8)(((i) >> 16) & 0xff);\
	(o)[0] = (uint8)(((i) >> 24) & 0xff);\
}

void SHA256_init(SHA256_t *SHA256)
{
	uint32 i;

	SHA256->hash[0] = 0x6a09e667;
	SHA256->hash[1] = 0xbb67ae85;
	SHA256->hash[2] = 0x3c6ef372;
	SHA256->hash[3] = 0xa54ff53a;
	SHA256->hash[4] = 0x510e527f;
	SHA256->hash[5] = 0x9b05688c;
	SHA256->hash[6] = 0x1f83d9ab;
	SHA256->hash[7] = 0x5be0cd19;

	for (i = 0; i < SHA256_BLOCK_SIZE; i++)
	{
		SHA256->block[i] = 0;
	}
	SHA256->offset = 0;
	SHA256->length = 0;
}

#define SHA256_BLOCK_SIZE    64

static void __transform(SHA256_t *SHA256)
{
	uint32 w[SHA256_BLOCK_SIZE];
	uint32 a, b, c, d, e, f, g, h, t1, t2=0, t;

	for (t = 0; t < 16; t++)
	{
		__u8_u32(SHA256->block + (t * 4), w[t]);
//	printf("%02x, w=%08x\n", SHA256->block[t*4], w[t]);
	}
	for (t = 16; t < SHA256_BLOCK_SIZE; t++)
	{
		w[t] = __suml1(w[t - 2]);
		w[t] = w[t] + w[t - 7];
		w[t] = w[t] + __suml0(w[t - 15]);
		w[t] = w[t] + w[t - 16];
	}

	a = SHA256->hash[0];
	b = SHA256->hash[1];
	c = SHA256->hash[2];
	d = SHA256->hash[3];
	e = SHA256->hash[4];
	f = SHA256->hash[5];
	g = SHA256->hash[6];
	h = SHA256->hash[7];

	for (t = 0; t < SHA256_BLOCK_SIZE; t++)
	{
		t1 = h;
		t1 = t1 + __sumh1(e);
		t1 = t1 + __ch(e, f, g);
		t1 = t1 + __k[t];
		t1 = t1 + w[t];
		t2 = __sumh0(a);
		t2 = t2 + __maj(a, b, c);

		h = g;
		g = f;
		f = e;
		e = d + t1;
		d = c;
		c = b;
		b = a;
		a = t1 + t2;
	}

	SHA256->hash[0] += a;
	SHA256->hash[1] += b;
	SHA256->hash[2] += c;
	SHA256->hash[3] += d;
	SHA256->hash[4] += e;
	SHA256->hash[5] += f;
	SHA256->hash[6] += g;
	SHA256->hash[7] += h;
}

void SHA256_update(SHA256_t *SHA256, uint8 *message, uint32 length)
{
	uint32 i;

	for (i = 0; i < length; i++)
	{
		SHA256->length += 8;
		SHA256->block[SHA256->offset++] = message[i];
		if (SHA256->offset == SHA256_BLOCK_SIZE)
		{
			__transform(SHA256);
			SHA256->offset = 0;
		}
	}
}

void SHA256_final(SHA256_t *SHA256, uint8 *digest_256bits)
{
	uint32 offset = SHA256->offset;
	uint32 t;

	SHA256->block[SHA256->offset++] = 0x80;
	while (SHA256->offset < SHA256_BLOCK_SIZE)
	{
		SHA256->block[SHA256->offset++] = 0x00;
	}
	if (offset >= SHA256_BLOCK_SIZE - 8)
	{
		__transform(SHA256);
		SHA256->offset = 0;
	}
	while (SHA256->offset < SHA256_BLOCK_SIZE)
	{
		SHA256->block[SHA256->offset++] = 0x00;
	}

	__u32_u8(SHA256->length, SHA256->block + (SHA256_BLOCK_SIZE - 4));

	__transform(SHA256);

	for (t = 0; t < 8; t++)
	{
		__u32_u8(SHA256->hash[t], digest_256bits + (t * 4));
	}
}



