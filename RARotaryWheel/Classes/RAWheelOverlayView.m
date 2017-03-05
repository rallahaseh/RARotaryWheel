//
//  RAWheelOverlayView.m
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#define kBorderAroundButton 3
#define degreesToRadians(x) (M_PI * x / 180.0)

#import <QuartzCore/QuartzCore.h>

#import "RAWheelOverlayView.h"
#import "RAWheel.h"
#import "RAWheelThumb.h"

@implementation RAWheelOverlayView
    
@synthesize circle, controlPoint, buttonCenter, overlayThumb;
    
- (id)initWithCircle:(RAWheel *)wheel{
    CGRect frame = wheel.frame;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [self setOpaque: NO];
        [self setCircle: circle];
        [self.circle setOverlayView: self];
        
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(self.circle.frame) - (2*circle.ringWidth),
                                  CGRectGetWidth(self.circle.frame) - (2*circle.ringWidth));
        
        rect1.origin.x = self.circle.frame.size.width / 2  - rect1.size.width / 2;
        rect1.origin.y = 0;
        
        
        overlayThumb = [[RAWheelThumb alloc] initWithShortCircleRadius:rect1.size.height/2
                                                           longRadius:self.circle.frame.size.height/2
                                                     numberOfSegments:self.circle.numberOfSegments];
        [overlayThumb setGradientFill: NO];
        
        overlayThumb.layer.position = CGPointMake(CGRectGetWidth(frame)/2, circle.ringWidth/2);
        self.controlPoint = overlayThumb.layer.position;
        [self addSubview:overlayThumb];
        overlayThumb.arcColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.3f];
        self.buttonCenter = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(self.circle.frame));
    }
    
    return self;
}
    
    
    
-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
    
}
    
-(void) setCenter:(CGPoint)center {
    [super setCenter:center];
    [self.circle setCenter:buttonCenter];
}

@end
