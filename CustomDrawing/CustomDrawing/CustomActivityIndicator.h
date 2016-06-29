//
//  CircularActivityIndicator.h
//  ArubaVIA
//
//  Created by Yashodhan Gokhale on 03/09/15.
//  Copyright (c) 2015 Aruba Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KCircularSpinner @"CircularSpinner"
#define KActivityIndicatorSize 12
#define KBackroundViewSize 300

@interface CircularActivityIndicator : UIView
{
    BOOL iIsAnimating;
    double iThickness;
    double iRadius;
    double iSpeed;
}
- (CircularActivityIndicator*)initWithSpinnerType:(NSString *) spinnerType;
- (void)StartAnimating;
- (void)StopAnimating;

@property(nonatomic,assign) BOOL iIsAnimating;/*Indicates whether spinner is animating or not*/
@property(nonatomic,assign) double iRadius;
@property(nonatomic,assign) double iThickness;

@end

@interface CustomActivityIndicator : UIView
{
    CircularActivityIndicator* iCircularActivityIndicator;
}
- (id)initWithFrame:(CGRect)frame radius:(CGFloat)radius rotationAngle:(CGFloat)rotAngle thickness:(CGFloat)thickness andColor:(UIColor*)color;
@property(nonatomic,readonly)CircularActivityIndicator* iCircularActivityIndicator;
- (void)SetAddationalEffect;
@end
