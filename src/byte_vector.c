#include "byte_vector.h"
#include <stdlib.h>

#define INITIAL_CAPACITY 16
#define GROWTH_FACTOR 2

static void bv_grow(ByteVector *bv) {
  size_t new_capacity =
      bv->cap == 0 ? INITIAL_CAPACITY : bv->cap * GROWTH_FACTOR;
  uint8_t *new_data = realloc(bv->data, new_capacity);
  bv->data = new_data;
  bv->cap = new_capacity;
}

void bv_expand_length(ByteVector *bv, size_t expand) {
    size_t new_len = bv->len + expand;
    if (new_len >= bv->cap) {
        size_t new_cap = new_len + 2 / 2;
        if (new_cap > bv->cap) {
            bv->cap = new_cap;
        }
        bv_grow(bv);
    }
    bv->len = new_len;
}

ByteVector *bv_create(void) {
  return bv_create_with_capacity(INITIAL_CAPACITY);
}

ByteVector *bv_create_with_capacity(size_t capacity) {
  ByteVector *bv = malloc(sizeof(ByteVector));
  bv->data = capacity > 0 ? malloc(capacity) : NULL;
  bv->len = 0;
  bv->cap = capacity;
  return bv;
}

void bv_destroy(ByteVector *bv) {
  free(bv->data);
  free(bv);
}

void bv_push(ByteVector *bv, uint8_t byte) {
  if (bv->len >= bv->cap) {
    bv_grow(bv);
  }
  bv->data[bv->len] = byte;
  bv->len += 1;
}

uint8_t bv_pop(ByteVector *bv) {
  uint8_t result = bv->data[bv->len];
  bv->len -= 1;
  return result;
}

uint8_t bv_get(const ByteVector *bv, size_t index) { return bv->data[index]; }

void bv_set(ByteVector *bv, size_t index, uint8_t byte) {
  bv->data[index] = byte;
}

void bv_clear(ByteVector *bv) { bv->len = 0; }
