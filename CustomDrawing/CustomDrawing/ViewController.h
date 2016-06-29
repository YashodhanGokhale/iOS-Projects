//
//  ViewController.h
//  CustomDrawing
//
//  Created by Yashodhan Gokhale on 16/06/15.
//  Copyright (c) 2015 Yashodhan Gokhale. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyButton;
@class CustomSineWaveIndicator;
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MyButton *btnDrawing;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (strong, nonatomic) CustomSineWaveIndicator* sineWave;

@end

@interface MyButton : UIButton

@end

