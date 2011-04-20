#include <string.h>
#include <stdlib.h>
#include "gravity.h"

void seed_bodies(World *world, Body *bodies)
{
	Vector seedStartPos = vec_min(
			vec_div(world->worldSize, 2),
			vec_div(world->spawnAreaSize, 2)); 

	for (int i = 0; i < world->numBodies; i++) {
		Body *body = &bodies[i];
		body->index = i;
		body->position = vec_add(seedStartPos,
				vec_random(world->spawnAreaSize));
		body->velocity = vec_zero();
		body->mass = world->bodyMass;
	}
}

Vector gravitational_acceleration(float g, Body *body, Body *other)
{
	Vector r = vec_min(other->position, body->position);
	float r2 = vec_len_sq(r);
	
	return vec_mul(r, g * (body->mass + other->mass) / r2);
}

void step(Simulation *sim)
{
	float t = 1 / sim->world->step;
	float g = sim->world->gravity;
	int numBodies = sim->world->numBodies;

	Vector *accelerations = malloc(sizeof(Vector) * numBodies);
	memset(accelerations, 0, sizeof(Vector) * numBodies);

	for (int i = 0; i < numBodies; i++) {
		for (int j = i + 1; j < numBodies; j++) {
			Body *body1 = &sim->bodies[i];
			Body *body2 = &sim->bodies[j];
			Vector accel1 = gravitational_acceleration(g, body1, body2);
			Vector accel2 = gravitational_acceleration(g, body2, body1);
			accelerations[i] = vec_add(accelerations[i], accel1);
			accelerations[j] = vec_add(accelerations[j], accel2);
		}
	}

	for (int i = 0; i < numBodies; i++) {
		Body *body = &sim->bodies[i];
		Vector *accel = &accelerations[i];
		Vector newVelocity = vec_add(body->velocity, vec_mul(*accel, t));
		Vector displacement = vec_mul(vec_add(body->velocity, newVelocity), t / 2);
		body->position = vec_add(body->position, displacement);
		body->velocity = newVelocity;
	}
}


