//
//  RAWheel.m
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kRotationDegrees 90

#import <QuartzCore/QuartzCore.h>

#import "RAWheel.h"
#import "RAWheelGestureRecognizer.h"
#import "RAWheelThumb.h"
#import "RAWheelOverlayView.h"

@implementation RAWheel
    
@synthesize circle, recognizer, path, numberOfSegments, separatorStyle, overlayView;
@synthesize separatorColor, ringWidth, rawheelColor, thumbs, overlay;
@synthesize delegate, dataSource;
@synthesize inertiaeffect;
    
//Need to add property "NSInteger numberOfThumbs" and add this property to initializer definition, and property "CGFloat ringWidth equal to circle radius - path radius.
//Circle radius is equal to rect / 2 , path radius is equal to rect1/2.
    
-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.inertiaeffect = YES;
        self.recognizer = [[RAWheelGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.recognizer];
        self.opaque = NO;
        self.numberOfSegments = nSegments;
        self.separatorStyle = RAWheelThumbsSeparatorBasic;
        self.ringWidth = width;
        self.rawheelColor = [UIColor clearColor];
        self.recognizer = [[RAWheelGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        
        CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2*ringWidth), CGRectGetWidth(frame) - (2*ringWidth));
        self.thumbs = [NSMutableArray array];
        for (int i = 0; i < self.numberOfSegments; i++) {
            RAWheelThumb * thumb = [[RAWheelThumb alloc] initWithShortCircleRadius:rect1.size.height/2 longRadius:frame.size.height/2 numberOfSegments:self.numberOfSegments];
            [self.thumbs addObject:thumb];
        }
    }
    return self;
}
    
-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState (ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    
    [self.rawheelColor setFill];
    circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    [circle closePath];
    [circle fill];
    
    CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2*ringWidth), CGRectGetWidth(rect) - (2*ringWidth));
    rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
    rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;
    
    path = [UIBezierPath bezierPathWithOvalInRect:rect1];
    [self.rawheelColor setFill];
    [path fill];
    CGContextRestoreGState(ctx);
    
    //Drawing Thumbs
    CGFloat fNumberOfSegments = self.numberOfSegments;
    CGFloat perSectionDegrees = 360.f / fNumberOfSegments;
    CGFloat totalRotation = 360.f / fNumberOfSegments;
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    CGFloat deltaAngle = 0.0;
    for (int i = 0; i < self.numberOfSegments; i++) {
        RAWheelThumb * thumb = [self.thumbs objectAtIndex:i];
        thumb.tag = i;
        thumb.iconView.image = [self.dataSource wheel:self iconForThumbAtRow:thumb.tag];
        thumb.iconView.string = [self.dataSource wheel:self textForThumbAtRow:thumb.tag];
        
        CGFloat radius = rect1.size.height/2 + ((rect.size.height/2 - rect1.size.height/2)/2) - thumb.yydifference;
        CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
        CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));
        
        [thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians((perSectionDegrees + kRotationDegrees)))];
        if (i==0) {
            deltaAngle= degreesToRadians(360 - kRotationDegrees) + atan2(thumb.transform.a, thumb.transform.b);
            [thumb.iconView setIsSelected:YES];
            self.recognizer.currentThumb = thumb;
        }
        
        //set position of the thumb
        thumb.layer.position = CGPointMake(x, yi);
        
        perSectionDegrees += totalRotation;
        
        [self addSubview:thumb];
    }
    for (int i = 0; i < 4; i++) {
        [self setTransform:CGAffineTransformRotate(self.transform,deltaAngle)];
    }
}
    
-(void) tapped: (RAWheelGestureRecognizer *) arecognizer{
    if (arecognizer.ended == NO) {
        CGPoint point = [arecognizer locationInView:self];
        if ([path containsPoint:point] == NO) {
            //            [self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
        }
    }
}
    
@end
