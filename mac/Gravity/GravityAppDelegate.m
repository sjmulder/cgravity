#import "GravityAppDelegate.h"
#import "gravity.h"

@implementation GravityAppDelegate

@synthesize fps;

- (void)freeSimulation {
	gravityView.simulation = NULL;
	
	free(simulation->world);
	free(simulation->bodies);
	free(simulation);	
}

- (void)setupSimulation {
	[self willChangeValueForKey:@"numBodies"];
	
	World *world = malloc(sizeof(World));
	world->numBodies = 500;
	world->worldSize.x = 800;
	world->worldSize.y = 500;
	world->spawnAreaSize.x = 800;
	world->spawnAreaSize.y = 500;
	world->gravity = 3.0f;
	world->bodyMass = 3.0f;
	world->wrap = false;
	
	Body *bodies = malloc(sizeof(Body) * world->numBodies);
	seed_bodies(world, bodies);
	
	simulation = malloc(sizeof(Simulation));
	simulation->world = world;
	simulation->bodies = bodies;
	
	gravityView.simulation = simulation;
	[gravityView setNeedsDisplay:YES];

	[self didChangeValueForKey:@"numBodies"];
}

- (void)resetFrameCount {
	[self willChangeValueForKey:@"fps"];

	frameCount = 0;
	fps = 0;
	timeSinceLastFrame = 0;
	
	[frameCountStart release];
	[lastFrameTime release];
	
	[self didChangeValueForKey:@"fps"];
}

- (void)countFrame {
	frameCount++;
	
	NSDate *time = [NSDate date];
	
	if (frameCountStart) {
		NSTimeInterval timeSinceStart = [time timeIntervalSinceDate:frameCountStart];
		if (timeSinceStart >= 1.0f) {
			[self willChangeValueForKey:@"fps"];
			fps = frameCount;
			[self didChangeValueForKey:@"fps"];
			
			frameCount = 0;
			[frameCountStart release];
			frameCountStart = [time retain];
		}
	} else {
		frameCountStart = [time retain];
	}
	
	if (lastFrameTime) {
		timeSinceLastFrame = [time timeIntervalSinceDate:lastFrameTime];
	} else {
		timeSinceLastFrame = 0;
	}
	
	[lastFrameTime release];
	lastFrameTime = [time retain];
}

- (void)stepThrough:(NSTimeInterval)time {
	step_simulation(simulation, time);
	[gravityView setNeedsDisplay:YES];
}

- (void)doTimedStep:(id)sender {
	[self countFrame];
	[self stepThrough:timeSinceLastFrame];
}

- (void)dealloc {
	[self freeSimulation];
	[self pause:self];
	[self resetFrameCount];
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

- (int)numBodies {
	if (simulation) {
		return simulation->world->numBodies;
	} else {
		return 0;
	}
}

- (IBAction)play:(id)sender {
	if (self.isPlaying) {
		return;
	}
	
	[self resetFrameCount];
	
	timer = [[NSTimer timerWithTimeInterval:0 target:self selector:@selector(doTimedStep:) userInfo:nil repeats:YES] retain];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
}

- (IBAction)pause:(id)sender {
	[timer invalidate];
	[timer release];
	timer = NULL;
	
	[self resetFrameCount];
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
	[self resetFrameCount];
}

- (IBAction)doStep:(id)sender {
	[self stepThrough:STEP_SIZE];
}

@end
