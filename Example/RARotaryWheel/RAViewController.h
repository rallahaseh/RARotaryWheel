//
//  RAViewController.h
//  RARotaryWheel
//
//  Created by rashed on 01/28/2017.
//  Copyright (c) 2017 rashed. All rights reserved.
//

@import UIKit;

#import "RAWheel.h"
#import "RAWheelOverlayView.h"

@interface RAViewController : UIViewController <RAWheelDelegate, RAWheelDataSource> {
    NSMutableArray *wheelSectorsData;
}

@property (nonatomic ,retain) RAWheel *wheel;
@property (nonatomic ,retain) RAWheelOverlayView *wheelOverlay;
    
@property (strong, nonatomic) IBOutlet UIView *contentView;
    
@property (strong, nonatomic) IBOutlet UIButton *spinningWheelButton;

@end
