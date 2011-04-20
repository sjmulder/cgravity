#import "GravityView.h"

@implementation GravityView

@synthesize dotRadius;
@synthesize backgroundColor;
@synthesize foregroundColor;
@synthesize simulation;

#pragma mark Private methods

- (void)drawSimulationInRect:(NSRect)dirtyRect {
	NSRect dotRect;
	dotRect.size.width = dotRadius;
	dotRect.size.height = dotRadius;
	
	[foregroundColor set];
	
	int numBodies = simulation->world->numBodies;
	for (int i = 0; i < numBodies; i++) {
		Body *body = &simulation->bodies[i];
		Vector pos = body->position;
		
		dotRect.origin.x = pos.x - dotRadius / 2;
		dotRect.origin.y = pos.y - dotRadius / 2;
		
		if (!NSIntersectsRect(dirtyRect, dotRect)) {
			continue;
		}
		
		[[NSBezierPath bezierPathWithOvalInRect:dotRect] fill];
	}

}

#pragma mark Public methods

- (id)initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.dotRadius = 5.0f;
		self.backgroundColor = [NSColor whiteColor];
		self.foregroundColor = [NSColor blackColor];
	}
	
	return self;
}

- (void)dealloc {
	self.backgroundColor = nil;
	self.foregroundColor = nil;
}

- (void)drawRect:(NSRect)dirtyRect {
	[backgroundColor set];
	NSRectFill(dirtyRect);
	
	if (simulation) {
		[self drawSimulationInRect:dirtyRect];
	}
}

@end
