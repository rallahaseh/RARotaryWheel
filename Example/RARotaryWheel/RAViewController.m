//
//  RAViewController.m
//  RARotaryWheel
//
//  Created by rashed on 01/28/2017.
//  Copyright (c) 2017 rashed. All rights reserved.
//

#import "RAViewController.h"

@interface RAViewController ()

@end

@implementation RAViewController

#define ARC4RANDOM_MAX      0x100000000
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    wheelSectorsData = [[NSMutableArray alloc] init];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1", @"id",
                                  @"Free Spin", @"name",
                                  @"250", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"2", @"id",
                                  @"Win 100", @"name",
                                  @"100", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"3", @"id",
                                  @"Win 150", @"name",
                                  @"150", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"4", @"id",
                                  @"Lose", @"name",
                                  @"0", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"5", @"id",
                                  @"Win 5000", @"name",
                                  @"5000", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"6", @"id",
                                  @"Lose", @"name",
                                  @"0", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"7", @"id",
                                  @"Win 150", @"name",
                                  @"150", @"payout", nil]];
    [wheelSectorsData addObject: [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"8", @"id",
                                  @"x2", @"name",
                                  @"250", @"payout", nil]];
    
    [self.contentView setBackgroundColor: [UIColor clearColor]];
    
    CGRect size = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.wheel = [[RAWheel alloc] initWithFrame:size numberOfSegments:8 ringWidth:80.f];
    
    [self.wheel setDataSource:self];
    [self.wheel setDelegate:self];
    self.wheelOverlay = [[RAWheelOverlayView alloc] initWithCircle:self.wheel];
    
    // Starting Sector Color
    [self.wheel.overlayView.overlayThumb setArcColor: [UIColor clearColor]];
    //[UIColor colorWithRed:0.00f green:1.00f blue:0.25f alpha:0.3]
    
    [self.wheel setUserInteractionEnabled:NO];
    [self.wheelOverlay setUserInteractionEnabled:NO];
    [self.spinningWheelButton setUserInteractionEnabled:YES];
    
    
    UIColor* oddColor = [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:238.0/255.0 alpha:1.0];
    UIColor* evenColor = [UIColor colorWithRed:221.0/255.0 green:233.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    /****** Change Wheel Segments Colors *****/
    // Change 8 to nOfSegments
    for (int i = 2; i < 8; i++) {
        RAWheelThumb *thumb0 = [self.wheel.thumbs objectAtIndex:0];
        [thumb0 setGradientColors: [NSArray arrayWithObjects: (id) oddColor.CGColor, (id) oddColor.CGColor, (id) oddColor.CGColor, nil]];
        RAWheelThumb *thumb1 = [self.wheel.thumbs objectAtIndex:1];
        [thumb1 setGradientColors: [NSArray arrayWithObjects: (id) evenColor.CGColor, (id) evenColor.CGColor, (id) evenColor.CGColor, nil]];
        RAWheelThumb *evenThumb;   RAWheelThumb *oddThumb;
        if (i % 2) {
            evenThumb = [self.wheel.thumbs objectAtIndex:i];
            [evenThumb setGradientColors: [NSArray arrayWithObjects: (id) evenColor.CGColor, (id) evenColor.CGColor, (id) evenColor.CGColor, nil]];
        }
        else {
            oddThumb = [self.wheel.thumbs objectAtIndex:i];
            [oddThumb setGradientColors: [NSArray arrayWithObjects: (id) oddColor.CGColor, (id) oddColor.CGColor, (id) oddColor.CGColor, nil]];
        }
    }
    
    [self.contentView addSubview:self.wheel];
    [self.contentView addSubview:self.wheelOverlay];
}
    
#pragma mark - RAWheel delegate & data source
-(void) wheel:(RAWheel *)_rawheel didMoveToSegment:(NSInteger)_segment thumb:(RAWheelThumb *)_thumb {
    NSLog(@"%@", [NSString stringWithFormat:@"Segment's tag: %li %@", (long)_segment, [[wheelSectorsData valueForKey:@"id"] objectAtIndex: (long)_segment]]);
    [self.spinningWheelButton setEnabled:YES];
}
    
    
    // text
-(NSString *)wheel:(RAWheel *)_rawheel textForThumbAtRow:(NSInteger)_row {
    return [[wheelSectorsData valueForKey:@"name"] objectAtIndex:_row];
}
    // images
-(UIImage *)wheel:(RAWheel *)_rawheel iconForThumbAtRow:(NSInteger)_row {
    return nil;
}
    
#pragma mark - Spinning Button
- (IBAction)spinningWheelPressed:(id)sender {

    float duration = 5.0f;
    CAKeyframeAnimation *rotationAnimation;
    rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    int randomNumber = 200 + rand() % (300-200);
    float x = [(NSNumber *)[self.wheel valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (int i=0; i<randomNumber; i++) {
        x+=0.1;
        [array addObject:[NSNumber numberWithFloat:x]];
    }
    [rotationAnimation setValues: array];
    [rotationAnimation setCalculationMode: kCAAnimationPaced];
    [rotationAnimation setRemovedOnCompletion: NO];
    [rotationAnimation setFillMode: kCAFillModeForwards];
    [rotationAnimation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [rotationAnimation setDuration: duration];
    
    [self.wheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        CGAffineTransform rot = CGAffineTransformMakeRotation([[array objectAtIndex:[array count]-1] floatValue]);
        self.wheel.transform = rot;
        [self.wheel.layer removeAllAnimations];
        
        RAWheel *view = self.wheel;
        for (RAWheelThumb *thumb in view.thumbs)
        {
            CGPoint point = [thumb convertPoint:thumb.centerPoint toView:nil];
            RAWheelThumb *shadow = view.overlayView.overlayThumb;
            CGRect shadowRect = [shadow.superview convertRect:shadow.frame toView:nil];
            if (CGRectContainsPoint(shadowRect, point) == YES)
            {
                CGPoint pointInShadowRect = [thumb convertPoint:thumb.centerPoint toView:shadow];
                if (CGPathContainsPoint(shadow.arc.CGPath, NULL, pointInShadowRect, NULL))
                {
                    [thumb.iconView setIsSelected:YES];
                    [view.delegate wheel:view didMoveToSegment:thumb.tag thumb:thumb];
                    break;
                }
            }
        }
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
