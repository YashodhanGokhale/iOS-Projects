//
//  CustomSineWaveIndicator.h
//  CustomDrawing
//
//  Created by Yashodhan Gokhale on 29/06/16.
//  Copyright © 2016 Yashodhan Gokhale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomSineWaveIndicator : UIView
{
    float iThickness;
    int iNumberOfCrusts;
    BOOL bToggle;
}

@property(nonatomic,retain)UIColor* strokeColor;

-(id)initWithFrame:(CGRect)rect thickness:(float)thickness numberOfCrusts:(int)numberOfCrusts andColor:(UIColor*)color;

@end
