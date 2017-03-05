//
//  RACommon.m
//  Pods
//
//  Created by Rashed Al Lahaseh on 1/28/17.
//
//

#import "RACommon.h"

@implementation RACommon
    
void drawLinearGradient(CGContextRef context, CGPathRef path, CFArrayRef colors, CGGradientPosition position, CGFloat locations[], CGRect rect)
{
        
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    CGPoint startPoint;
    CGPoint endPoint;
        
    switch (position) {
        case CGGradientPositionHorizontal:
        startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
        
        break;
        
        case CGGradientPositionVertical:
        startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
        endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
        break;
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
        
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
    
CGRect rectFor1PxStroke(CGRect rect)
{
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

@end
