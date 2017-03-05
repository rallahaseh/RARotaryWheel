//
//  RAWheelThumb.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import <UIKit/UIKit.h>
#import "RAWheel.h"
#import "RAIconView.h"

@interface RAWheelThumb : UIView {
    CGFloat numberOfSegments;
    CGFloat bigArcHeight;
    CGFloat smallArcWidth;
}
    
    
@property (assign, readonly) CGFloat sRadius;
@property (assign, readonly) CGFloat lRadius;
@property (assign, readonly) CGFloat yydifference;
    
@property (nonatomic, strong) UIBezierPath *arc;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CGPoint centerPoint;
    
@property (nonatomic, strong) NSMutableArray * colorsLocations;
    
@property (nonatomic, assign) RAWheelThumbsSeparator separatorStyle;
@property (nonatomic, strong) RAIconView *iconView;
    
@property (assign) BOOL gradientFill;
    
@property (nonatomic, strong) NSArray *gradientColors;
@property (nonatomic, strong) UIColor *arcColor;
    
-(id) initWithShortCircleRadius:(CGFloat)shortRadius longRadius:(CGFloat)longRadius numberOfSegments:(CGFloat)sNumber;
    
@end
