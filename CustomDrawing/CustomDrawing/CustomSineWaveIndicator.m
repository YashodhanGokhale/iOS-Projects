//
//  CustomSineWaveIndicator.m
//  CustomDrawing
//
//  Created by Yashodhan Gokhale on 29/06/16.
//  Copyright © 2016 Yashodhan Gokhale. All rights reserved.
//

#import "CustomSineWaveIndicator.h"

@implementation CustomSineWaveIndicator

-(id)initWithFrame:(CGRect)rect thickness:(float)thickness numberOfCrusts:(int)numberOfCrusts andColor:(UIColor*)color
{
    if (self = [super initWithFrame:rect])
    {
        iThickness = thickness;
        iNumberOfCrusts = numberOfCrusts;
        _strokeColor = color;
        self.backgroundColor = [UIColor clearColor];
        bToggle = NO;
    }
    
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
        CGMutablePathRef pathRef = CGPathCreateMutable();
    CGContextSetLineWidth(context, iThickness);
    
    float currentStartCrust = 0;
    float height = rect.size.height;
    float crustWidth = rect.size.width/iNumberOfCrusts;
    
    bToggle = !bToggle;
    
    while (currentStartCrust <= rect.size.width)
    {
        if (bToggle)
        {
            CGPathMoveToPoint(pathRef, NULL, currentStartCrust, height/2);
            CGPathAddQuadCurveToPoint(pathRef, NULL, currentStartCrust+(crustWidth/2), 0, currentStartCrust+crustWidth, height/2);
            currentStartCrust += crustWidth;
            
            CGPathAddQuadCurveToPoint(pathRef, NULL, currentStartCrust+(crustWidth/2), height, currentStartCrust+crustWidth, height/2);
            currentStartCrust += crustWidth;
        }
        else
        {
            CGPathMoveToPoint(pathRef, NULL, currentStartCrust, height/2);
            CGPathAddQuadCurveToPoint(pathRef, NULL, currentStartCrust+(crustWidth/2), height, currentStartCrust+crustWidth, height/2);
            currentStartCrust += crustWidth;
            
            
            CGPathAddQuadCurveToPoint(pathRef, NULL, currentStartCrust+(crustWidth/2), 0, currentStartCrust+crustWidth, height/2);
            currentStartCrust += crustWidth;
            
        }
    }
    
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
