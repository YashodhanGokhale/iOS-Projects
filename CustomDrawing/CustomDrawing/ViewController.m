//
//  ViewController.m
//  CustomDrawing
//
//  Created by Yashodhan Gokhale on 16/06/15.
//  Copyright (c) 2015 Yashodhan Gokhale. All rights reserved.
//

#import "ViewController.h"
#import "CustomActivityIndicator.h"
#import "CustomSineWaveIndicator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnDrawing addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnDrawing.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnDrawing.layer.borderWidth = 2.0f;
    self.btnDrawing.hidden = YES;
    
    CustomActivityIndicator* indicator = [[CustomActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 300, 80) radius:30.f rotationAngle:330.f thickness:5.f andColor:[UIColor redColor]];
    indicator.center =  self.view.center;
//    [self.view addSubview:indicator];
    
    self.sineWave = [[CustomSineWaveIndicator alloc] initWithFrame:CGRectMake(0, 0, 300, 200) thickness:1.f numberOfCrusts:10 andColor:[UIColor darkGrayColor]];
    self.sineWave.center = self.view.center;
    [self.view addSubview:self.sineWave];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClick:(id)sender
{
    self.btnDrawing.selected = !self.btnDrawing.selected;
}

-(void)viewDidAppear:(BOOL)animated
{
//    _gifImageView.alpha = 0.1f;
    _gifImageView.animationImages =  @[[UIImage imageNamed:@"poof1.png"], [UIImage imageNamed:@"poof2.png"],[UIImage imageNamed:@"poof3.png"], [UIImage imageNamed:@"poof4.png"],[UIImage imageNamed:@"poof5.png"]];
    
    //Set the duration of the entire animation
    _gifImageView.animationDuration = 1;
    
    //Set the repeat count. If you don't set that value, by default will be a loop (infinite)
    _gifImageView.animationRepeatCount = 100;
    
    //Start the animationrepeatcount
    [_gifImageView startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:0.175f target:self.sineWave selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];

    
    [super viewDidAppear:animated];
}

@end


@implementation MyButton

-(void)drawRect:(CGRect)rect
{
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
//    UIImage* image = [UIImage imageNamed:@"VPN_Off.png"];
    UIImage* image = [UIImage imageNamed:@"VPN_Off.png"];
    UIImage* imageCenter = [UIImage imageNamed:@"VPN_On.png"];
    
    CGRect rectu = CGRectMake(self.bounds.size.width/2.0f-100,self.bounds.size.height/2.0f-100, 200, 100);
//    rectu.origin = rect.origin;//CGPointMake(self.center.x, self.center.y);
    
    CGRect statusLableFrame = CGRectMake(self.bounds.size.width/2.0f-50, self.bounds.size.height-65, 100, 50);
    CGRect actionLableFrame = CGRectMake(self.bounds.size.width/2.0f-50, self.bounds.size.height-50, 100, 50);
    
    UIFont* textFont = [UIFont boldSystemFontOfSize:10.0f];
    UIColor* textColor = [UIColor blackColor];
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName,textColor,NSForegroundColorAttributeName, nil];
    
    if (self.isSelected)
    {
        [image drawInRect:self.bounds];
        [imageCenter drawInRect:rectu];
        NSAttributedString* strStatus = [[NSAttributedString alloc] initWithString:@"Connected" attributes:dict];
        NSAttributedString* strAction = [[NSAttributedString alloc] initWithString:@"Click to Disconnect" attributes:dict];
        
        [strStatus drawInRect:statusLableFrame];
        [strAction drawInRect:actionLableFrame];
    }
    else
    {
        [imageCenter drawInRect:self.bounds];
        [image drawInRect:rectu];
        NSAttributedString* strStatus = [[NSAttributedString alloc] initWithString:@"Dis-Connected" attributes:dict];
        NSAttributedString* strAction = [[NSAttributedString alloc] initWithString:@"Click to Connect" attributes:dict];
        
        [strStatus drawInRect:statusLableFrame];
        [strAction drawInRect:actionLableFrame];
    }
    
    
//    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
//    CGContextFillRect(ctx, rect);
}

@end