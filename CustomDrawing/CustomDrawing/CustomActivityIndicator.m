//
//  CircularActivityIndicator.m
//  ArubaVIA
//
//  Created by Yashodhan Gokhale on 03/09/15.
//  Copyright (c) 2015 Aruba Networks. All rights reserved.
//

#import "CustomActivityIndicator.h"


#define KAnimationSpeed 0.001

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@interface CircularSpinner : CircularActivityIndicator
{
    CGFloat iAngle;
    CGFloat iRotationAngle;
    UIColor* iColor;
}

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)radius rotationAngle:(CGFloat)rotAngle thickness:(CGFloat)thickness andColor:(UIColor *)color;

@end

@implementation CircularSpinner

#pragma mark -

#pragma mark Timer Fire methods

- (void)UpdateTimer:(NSTimer*)aTimer
{
    iAngle = iAngle +iRotationAngle;
    if (iAngle > 360)
    {
        iAngle = 00.00;
    }
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark initWithFrame

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        iRotationAngle = 3.00; //Angle to rotate
        iAngle = 180.00;
        iRadius = 12.0f;
        iThickness = 6.00;
        iSpeed = 1.00/(360/iRotationAngle);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)radius rotationAngle:(CGFloat)rotAngle thickness:(CGFloat)thickness andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        iRotationAngle = rotAngle;
        iAngle = 180.00;
        iRadius = radius;
        iThickness = thickness;
        iSpeed = 1.00/(360/iRotationAngle);
        iColor = color;
    }
    return self;
}

#pragma mark -

#pragma mark init

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

#pragma mark  drawRect
-(void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw the arc only o0ce if it is not drawn
    CGPoint arcCenter = centerPoint;//CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGFloat arcRadius = iRadius + (iThickness/2.00);
    UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:arcRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];
    CGPathRef shape = CGPathCreateCopyByStrokingPath(arc.CGPath, NULL, iThickness, kCGLineCapRound, kCGLineJoinRound, 0.0f);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, shape);
    UIColor* pathColor = [UIColor clearColor];
    CGContextSetFillColorWithColor(context, pathColor.CGColor);
    CGContextFillPath(context);
    
    CGPathRelease(shape);
    
    CGFloat currentAngle = iAngle;
    CGFloat newAlphaValue = 0.0f;
    CGFloat numberOfSteps = 360.00/iRotationAngle;
    for(float i=0;i<numberOfSteps;i++)
    {
        newAlphaValue = (newAlphaValue+(1.0/numberOfSteps));
        if (newAlphaValue>1.0)
        {
            newAlphaValue = 0.0f;
        }
        
        CGFloat arcEndAngle = currentAngle+iRotationAngle;
        CGFloat arStartAngle = currentAngle;
        UIColor* fillColor = iColor;
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, iRadius + (iThickness/2.0), DEGREES_TO_RADIANS(arStartAngle), DEGREES_TO_RADIANS(arcEndAngle), 0);
        CGContextSetLineWidth(context, iThickness);
        UIColor *newColor = nil;
        CGColorRef colorRef = CGColorCreateCopyWithAlpha(fillColor.CGColor, newAlphaValue);
        newColor = [UIColor colorWithCGColor:colorRef];
        CGColorRelease(colorRef);
        CGContextSetStrokeColorWithColor(context,newColor.CGColor);
        if(i==numberOfSteps-1)
        {
            CGContextSetLineCap(context, kCGLineCapRound);
        }
        CGContextStrokePath(context);
        
        CGContextSetFillColorWithColor(context, newColor.CGColor);
        CGContextFillPath(context);
        
        currentAngle = currentAngle + iRotationAngle;
    }
    [self AddRotationAnimation];
}

- (void)AddRotationAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    rotationAnimation.removedOnCompletion = YES;
    rotationAnimation.duration = 0.50;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.cumulative = YES;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation1"];
}

-(void)addXAnimation:(CGContextRef)context from:(float)fromValue to:(float)toValue
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.duration = 5;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.cumulative = YES;
    [self.layer addAnimation:animation forKey:@"animation"];

}

-(void)addYAnimation:(CGContextRef)context from:(float)fromValue to:(float)toValue
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.duration = 1;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.cumulative = YES;
    [self.layer addAnimation:animation forKey:@"animation"];
}

-(void)addGroupAnimation
{
    CABasicAnimation* animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animationScale.fromValue = [NSNumber numberWithFloat:1];
    animationScale.toValue = [NSNumber numberWithFloat:2.5];
    animationScale.duration = 1;
    animationScale.repeatCount = 1;
    animationScale.removedOnCompletion = NO;
    animationScale.cumulative = YES;
    
    
    CABasicAnimation* animationTranslate = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animationTranslate.fromValue = [NSNumber numberWithFloat:0];
    animationTranslate.toValue = [NSNumber numberWithFloat:100];
    animationTranslate.duration = 1;
    animationTranslate.repeatCount = 1;
    animationTranslate.removedOnCompletion = NO;
    animationTranslate.cumulative = YES;
    
    NSArray* animationArray = [NSArray arrayWithObjects:animationScale,animationTranslate, nil];
    
    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    
    theGroup.duration = 2.5;
    theGroup.removedOnCompletion = NO;
    theGroup.fillMode = kCAFillModeForwards;
    theGroup.repeatCount = 0;
    theGroup.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    theGroup.animations = animationArray;
    theGroup.delegate = self;
    
    [theGroup setValue: @"translatescale" forKey: @"animationtype"];
    
    [self.layer addAnimation: theGroup forKey: @"translatescale"];
}

#pragma mark -

#pragma mark  StartAnimating

- (void)StartAnimating
{
    [super StartAnimating];
    iAngle = 180;
}

#pragma mark -

#pragma mark StopAnimating

- (void)StopAnimating
{
    [super StopAnimating];
    iAngle = 180;
}

#pragma mark -

#pragma mark setRadius


@end

@implementation CircularActivityIndicator

@synthesize iIsAnimating;
@synthesize iRadius;
@synthesize iThickness;

#pragma mark -
#pragma mark Initialization Methods

- (CircularActivityIndicator*)initWithSpinnerType:(NSString*)aType
{
    self = [super init];
    if (self)
    {
        self = [[NSClassFromString(aType) alloc]init];
    }
    return self;
}


#pragma mark -

#pragma mark StartAnimating

- (void)StartAnimating
{
    self.hidden = NO;
    iIsAnimating = YES;
}

#pragma mark -

#pragma mark StopAnimating

- (void)StopAnimating
{
    iIsAnimating = NO;
}

@end


@implementation CustomActivityIndicator

@synthesize iCircularActivityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        iCircularActivityIndicator = [[NSClassFromString(KCircularSpinner) alloc]init];
        [self addSubview:iCircularActivityIndicator];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)radius rotationAngle:(CGFloat)rotAngle thickness:(CGFloat)thickness andColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        iCircularActivityIndicator = [[NSClassFromString(KCircularSpinner) alloc]initWithFrame:frame radius:radius rotationAngle:rotAngle thickness:thickness andColor:color];
        [self addSubview:iCircularActivityIndicator];
    }
    return self;
}

#pragma mark -

#pragma mark SetAddationalEffect

- (void)SetAddationalEffect
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 8;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.80]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    iCircularActivityIndicator.frame = CGRectMake((self.frame.size.width - KBackroundViewSize)/2, (self.frame.size.height - KBackroundViewSize)/2,KBackroundViewSize ,KBackroundViewSize);
}
@end