//
//  RAIconView.m
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import "RAIconView.h"

@implementation RAIconView

@synthesize image, string, label, selected, highlitedIconColor;
    
-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        selected = NO;
        [self setOpaque: NO];
        [self setBackgroundColor: [UIColor clearColor]];
        [self setHighlitedIconColor: [UIColor colorWithRed:0.75 green:0.00f blue:0.00f alpha:1.00f]];
        
        label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 80, 10)];
        [label setTextColor:[UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:40.0/255.0 alpha:1.0]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setNumberOfLines:0];
        [label setTextAlignment: NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:label];
    }
    return self;
}
    
-(void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (image != nil || string != nil)
    {
        if (selected == YES) {
#pragma mark - Image [Icons]
            //            CGContextRef context = UIGraphicsGetCurrentContext();
            //            CGContextTranslateCTM(context, 0, image.size.height);
            //            CGContextScaleCTM(context, 1.0, -1.0);
            //            CGContextSetBlendMode(context, kCGBlendModeColor);
            //            CGContextClipToMask(context, self.bounds, image.CGImage); // this restricts drawing to within alpha channel
            //            CGContextSetFillColorWithColor(context, self.highlitedIconColor.CGColor); // this is your color,  a light reddish tint
            //            CGContextFillRect(context, rect);
            //
#pragma mark - String [Text]
            
            //            NSMutableString* newText = [[NSMutableString alloc] init];
            //            for (NSInteger charIndex=0; charIndex<[string length]; charIndex++) {
            //                if (![[NSString stringWithFormat:@"%C", [string characterAtIndex:charIndex]] isEqualToString:@" "])
            //                    [newText appendString: [NSString stringWithFormat:@"%C\n", [string characterAtIndex:charIndex]]];
            //            }
            //            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            //            [style setLineBreakMode:NSLineBreakByCharWrapping];
            //            NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:40.0/255.0 alpha:1.0],
            //                                     NSFontAttributeName : [UIFont systemFontOfSize:9.0f],
            //                                     NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
            //                                     NSParagraphStyleAttributeName: style};
            //            [string drawInRect:rect withAttributes:attrs];
            
#pragma mark - String [UILabel]
            [label setText: string];
        }
        else
        {
            [image drawInRect:rect];
            
            //            NSMutableString* newText = [[NSMutableString alloc] init];
            //            for (NSInteger charIndex=0; charIndex<[string length]; charIndex++) {
            //                [newText appendString: [NSString stringWithFormat:@"%C\n", [string characterAtIndex:charIndex]]];
            //            }
            //            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            //            [style setLineBreakMode:NSLineBreakByCharWrapping];
            //            NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:40.0/255.0 alpha:1.0],
            //                                     NSFontAttributeName : [UIFont systemFontOfSize:9.0f],
            //                                     NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
            //                                     NSParagraphStyleAttributeName: style};
            //            [string drawInRect:rect withAttributes:attrs];
            [label setText: string];
        }
    }
}
    
#pragma mark - Show Selected Item
-(void) setIsSelected:(BOOL)isSelected {
    if (selected != isSelected) {
        selected = isSelected;
        [self setNeedsDisplay];
    }
    else return;
}

@end
