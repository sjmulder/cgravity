#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "gravity.h"

void print_bodies(Body *bodies, int count)
{
	for (int i = 0; i < count; i++) {
		Body *body = &bodies[i];
		printf(" %4.2f, %4.2f (%4.2f, %4.2f) ",
				body->position.x, body->position.y,
				body->velocity.x, body->velocity.y);
	}
	printf("\n");
}

int main(int argc, const char **argv)
{
	srandomdev();

	World world;
	world.numBodies = 2;
	world.spawnAreaSize.x = 100;
	world.spawnAreaSize.y = 100;
	world.worldSize.x = 800;
	world.worldSize.y = 500;
	world.gravity = 3.0f;
	world.bodyMass = 3.0f;
	world.step = 30;
	world.wrap = true;

	Simulation sim;
	sim.world = &world;
	sim.bodies = malloc(sizeof(Body) * world.numBodies);

	seed_bodies(&world, sim.bodies);

	for (int i = 0; i < 20; i++) {
		step(&sim);
		print_bodies(sim.bodies, world.numBodies);
	}

	return 0;
}
