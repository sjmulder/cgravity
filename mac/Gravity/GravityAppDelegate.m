#import "GravityAppDelegate.h"
#import "gravity.h"

@implementation GravityAppDelegate

- (void)freeSimulation {
	gravityView.simulation = NULL;
	
	free(simulation->world);
	free(simulation->bodies);
	free(simulation);	
}

- (void)setupSimulation {
	World *world = malloc(sizeof(World));
	world->numBodies = 1500;
	world->worldSize.x = 800;
	world->worldSize.y = 500;
	world->spawnAreaSize.x = 800;
	world->spawnAreaSize.y = 500;
	world->gravity = 3.0f;
	world->bodyMass = 3.0f;
	world->step = 30;
	world->wrap = false;
	
	Body *bodies = malloc(sizeof(Body) * world->numBodies);
	seed_bodies(world, bodies);
	
	simulation = malloc(sizeof(Simulation));
	simulation->world = world;
	simulation->bodies = bodies;
	
	gravityView.simulation = simulation;
	[gravityView setNeedsDisplay:YES];
}

- (void)dealloc {
	[self freeSimulation];
	[self pause:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	[self setupSimulation];
	[self play:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
	if ([menuItem action] == @selector(togglePause:)) {
		NSString *title = self.isPlaying ? @"Pause" : @"Play";
		[menuItem setTitle:title];
	}
	
	return YES;
}

- (BOOL)isPlaying {
	return timer != NULL;
}

- (IBAction)play:(id)sender {
	if (self.isPlaying) {
		return;
	}
	
	NSTimeInterval timerInterval = 1 / simulation->world->step;
	timer = [[NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(doStep:) userInfo:nil repeats:YES] retain];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
}

- (IBAction)pause:(id)sender {
	[timer invalidate];
	[timer release];
	timer = NULL;
}

- (IBAction)togglePause:(id)sender {
	if (self.isPlaying) {
		[self pause:self];
	} else {
		[self play:self];
	}
}

- (IBAction)resetSimlation:(id)sender {
	[self freeSimulation];
	[self setupSimulation];
}

- (IBAction)doStep:(id)sender {
	step_simulation(simulation);
	[gravityView setNeedsDisplay:YES];
}


@end
