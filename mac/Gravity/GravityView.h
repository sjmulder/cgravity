#import <Cocoa/Cocoa.h>

#include "gravity.h"

@interface GravityView : NSView {
	float dotRadius;
	NSColor *backgroundColor;
	NSColor *foregroundColor;
	
	Simulation *simulation;
}

@property (assign) float dotRadius;
@property (retain) NSColor *backgroundColor;
@property (retain) NSColor *foregroundColor;
		   
@property (assign) Simulation *simulation;

@end
