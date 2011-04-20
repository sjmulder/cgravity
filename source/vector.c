#include <math.h>
#include <stdlib.h>
#include "vector.h"

Vector vec_zero()
{
	static Vector zero = { 0.0f, 0.0f };
	return zero;
}

Vector vec_random(Vector limit)
{
	Vector out;
	out.x = random() % (long)limit.x;
	out.y = random() % (long)limit.y;
	return out;
}

float vec_len_sq(Vector vector)
{
	return vector.x * vector.x + vector.y * vector.y;
}

Vector vec_mul(Vector left, float factor)
{
	Vector out;
	out.x = left.x * factor;
	out.y = left.y * factor;
	return out;
}

Vector vec_div(Vector left, float divider)
{
	Vector out;
	out.x = left.x / divider;
	out.y = left.y / divider;
	return out;
}

Vector vec_add(Vector left, Vector right)
{
	Vector out;
	out.x = left.x + right.x;
	out.y = left.y + right.y;
	return out;
}

Vector vec_min(Vector left, Vector right)
{
	Vector out;
	out.x = left.x - right.x;
	out.y = left.y - right.y;
	return out;
}

Vector vec_wrap(Vector point, Vector area)
{
	Vector out;
	out.x = fmodf(point.x + area.x, area.x);
	out.y = fmodf(point.x + area.y, area.y);
	return out;
}

