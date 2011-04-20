#import <Cocoa/Cocoa.h>
#import "GravityView.h"

static const int STEP_SIZE = 0.05f;

@interface GravityAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSWindow *window;
	IBOutlet GravityView *gravityView;
	
	NSTimer *timer;
	Simulation *simulation;

	int frameCount;
	NSDate *frameCountStart;
	NSDate *lastFrameTime;
	NSTimeInterval timeSinceLastFrame;
	float fps;
}

@property (readonly) BOOL isPlaying;
@property (readonly) float fps;
@property (readonly) int numBodies;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resetSimlation:(id)sender;
- (IBAction)togglePause:(id)sender;
- (IBAction)doStep:(id)sender;

@end
