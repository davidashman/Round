#import <UIKit/UIKit.h>

#define DEFAULT_RADIUS 10

@interface RNDWindow : UIWindow

@property (nonatomic, retain) CAShapeLayer* cornerLayer;
@property (nonatomic, retain) UIView* cornerView;

@end

@implementation RNDWindow

-(instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    self.windowLevel = 1000000;
    self.userInteractionEnabled = NO;

    UIBezierPath* path1 = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:DEFAULT_RADIUS];
    [path1 appendPath:path2];

    CAShapeLayer* layer = [[[CAShapeLayer alloc] init] autorelease];
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.path = path1.CGPath;
    layer.fillColor = [UIColor blackColor].CGColor;
    self.cornerLayer = layer;

    UIView* v = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
    v.userInteractionEnabled = NO;
    [v.layer addSublayer:layer];
    self.cornerView = v;
    
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