#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define DEFAULT_RADIUS 10

@interface RNDView : UIView

@end

@implementation RNDView

-(void) drawRect:(CGRect) rect {
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:DEFAULT_RADIUS];
    [path appendPath:path2];
    path.usesEvenOddFillRule = YES;
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
    [path fill];
}

@end

@interface RNDWindow : UIWindow

@end

@implementation RNDWindow

-(instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    self.windowLevel = 1000000;
    self.userInteractionEnabled = NO;
    self.autoresizesSubviews = YES;
    
    UIView* v = [[[RNDView alloc] initWithFrame:frame] autorelease];
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    v.backgroundColor = [UIColor clearColor];
    v.userInteractionEnabled = NO;
    [self addSubview:v];
    
    return self;
}

-(BOOL)_shouldCreateContextAsSecure {
    return YES;
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