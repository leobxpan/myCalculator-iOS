//
//  OrdinaryCalculatorViewController.h
//  Calculator
//
//  Created by caesar on 15/2/1.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"
@interface OrdinaryCalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

-(IBAction) clickFirstDigit : (UIButton *) sender;
-(IBAction)clickPlus;
-(IBAction)clickMinus;
-(IBAction)clickMultiply;
-(IBAction)clickDivide;
-(IBAction)equal;
-(IBAction)clear;
-(IBAction)dot;
- (IBAction)sqrt;
- (IBAction)pow;

@end

