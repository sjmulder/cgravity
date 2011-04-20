#ifndef CGRAVITY_VECTOR_H
#define CGRAVITY_VECTOR_H

typedef struct {
	float x;
	float y;
} Vector;

Vector vec_zero();
Vector vec_random(Vector limit);
float vec_len_sq(Vector vector);
Vector vec_mul(Vector left, float factor);
Vector vec_div(Vector left, float divider);
Vector vec_add(Vector left, Vector right);
Vector vec_min(Vector left, Vector right);
Vector vec_wrap(Vector point, Vector area);


#endif
