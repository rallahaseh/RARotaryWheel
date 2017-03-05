//
//  RAIconView.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import <UIKit/UIKit.h>

@interface RAIconView : UIView

@property (nonatomic, strong) UIImage *image;
    
@property (nonatomic, strong) UILabel *label;
    
@property (nonatomic, strong) NSString *string;
    
@property (nonatomic, assign, setter = setIsSelected:) BOOL selected;
    
@property (nonatomic, strong) UIColor *highlitedIconColor;
    
-(void) setIsSelected:(BOOL)isSelected;

@end
