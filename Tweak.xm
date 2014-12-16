#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define DEFAULT_RADIUS 10

@interface RNDWindow : UIWindow

@end

@implementation RNDWindow

-(instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    self.windowLevel = 1000000;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(BOOL)_shouldCreateContextAsSecure {
    return YES;
}

-(void) drawRect:(CGRect) rect {
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:DEFAULT_RADIUS];
    [path appendPath:path2];
    path.usesEvenOddFillRule = YES;
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
    [path fill];
}

@end

RNDWindow* window;

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
    %orig;
    window = [[RNDWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.hidden = NO;
}

%end

%ctor
{
    %init();
}