#ifndef CGRAVITY_GRAVITY_H
#define CGRAVITY_GRAVITY_H

#include <stdbool.h>
#include "vector.h"

typedef struct {
	int numBodies;
	Vector worldSize;
	Vector spawnAreaSize;
	float gravity;
	float bodyMass;
	float step;
	bool wrap;	
} World;

typedef struct {
	int index;
	float mass;
	Vector position;
	Vector velocity;
} Body;

typedef struct {
	World *world;
	Body *bodies;
} Simulation;

void seed_bodies(World *world, Body *bodies);
Vector gravitational_acceleration(float g, Body *body, Body *other);
void step_simulation(Simulation *sim);

#endif
