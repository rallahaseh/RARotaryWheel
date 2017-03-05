//
//  RAWheel.h
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    RAWheelThumbsSeparatorNone,
    RAWheelThumbsSeparatorBasic
}RAWheelThumbsSeparator;

@class RAWheel, RAWheelThumb, RAWheelOverlayView;

@protocol RAWheelDelegate <NSObject>
    
    @required
    
-(void) wheel: (RAWheel *)rawheel didMoveToSegment:(NSInteger)segment thumb: (RAWheelThumb *)thumb;
    
@end

@protocol RAWheelDataSource <NSObject>
    
-(UIImage *)wheel: (RAWheel *)rawheel iconForThumbAtRow:(NSInteger) row;
    
-(NSString *)wheel: (RAWheel *)rawheel textForThumbAtRow:(NSInteger) row;
    
    @end

@class RAWheelGestureRecognizer;

@interface RAWheel : UIView
    
    @property (nonatomic, strong) NSMutableArray *thumbs;
    @property (nonatomic, strong) UIBezierPath *circle;
    @property (nonatomic, strong) UIBezierPath *path;
    @property (nonatomic, assign) BOOL inertiaeffect;
    @property (nonatomic, strong) RAWheelGestureRecognizer *recognizer;
    @property (assign) NSInteger numberOfSegments;
    @property (nonatomic, strong) UIColor *separatorColor;
    @property (nonatomic, assign) RAWheelThumbsSeparator separatorStyle;
    @property (nonatomic, strong) RAWheelOverlayView *overlayView;
    @property (nonatomic, assign) CGFloat ringWidth;
    @property (nonatomic, assign) BOOL overlay;
    
    @property (nonatomic, strong) id <RAWheelDelegate> delegate;
    @property (nonatomic, strong) id <RAWheelDataSource> dataSource;
    
    @property (nonatomic, strong) UIColor *rawheelColor;
    
-(id) initWithFrame:(CGRect)frame numberOfSegments:(NSInteger)nSegments ringWidth:(CGFloat)width;
    
@end
