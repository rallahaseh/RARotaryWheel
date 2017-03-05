//
//  RAWheelOverlayView.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import <UIKit/UIKit.h>
#import "RAWheel.h"
#import "RAWheelThumb.h"

@interface RAWheelOverlayView : UIView {
    RAWheelThumb  *overlayThumb;
}
    
    @property (nonatomic, strong) RAWheelThumb *overlayThumb;
    @property (nonatomic, strong) RAWheel *circle;
    @property (nonatomic, assign) CGPoint controlPoint;
    @property (nonatomic, assign) CGPoint buttonCenter;
    
-(id)initWithCircle: (RAWheel *) wheel;
    
@end
