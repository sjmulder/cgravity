#import <Cocoa/Cocoa.h>
#import "GravityView.h"

@interface GravityAppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet NSWindow *window;
	IBOutlet GravityView *gravityView;
	
	NSTimer *timer;
	Simulation *simulation;
}

@property (readonly) BOOL isPlaying;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resetSimlation:(id)sender;
- (IBAction)togglePause:(id)sender;
- (IBAction)doStep:(id)sender;

@end
