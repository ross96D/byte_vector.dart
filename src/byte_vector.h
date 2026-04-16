#ifndef BYTE_VECTOR_H
#define BYTE_VECTOR_H

#include <stddef.h>
#include <stdint.h>

typedef struct {
    uint8_t *data;
    size_t len;
    size_t cap;
} ByteVector;

ByteVector *bv_create(void);
ByteVector *bv_create_with_capacity(size_t capacity);
void bv_destroy(ByteVector *bv);

void bv_expand_length(ByteVector *bv, size_t expand);

void bv_push(ByteVector *bv, uint8_t byte);
uint8_t bv_pop(ByteVector *bv);
uint8_t bv_get(const ByteVector *bv, size_t index);
void bv_set(ByteVector *bv, size_t index, uint8_t byte);

void bv_clear(ByteVector *bv);

#endif
