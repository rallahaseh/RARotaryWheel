//
//  RAWheelGestureRecognizer.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import <UIKit/UIKit.h>

@class RAWheelThumb;

@interface RAWheelGestureRecognizer : UIGestureRecognizer
{
    NSDate *previousTouchDate;
    double currentTransformAngle;
}

@property (nonatomic, assign) BOOL ended;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, strong) RAWheelThumb *currentThumb;
    
@end
