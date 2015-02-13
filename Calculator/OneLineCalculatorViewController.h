//
//  OneLineCalculatorViewController.h
//  Calculator
//
//  Created by caesar on 15/2/11.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneLineCalculatorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

- (IBAction)clickDigit:(id)sender;
- (IBAction)clickDot;
- (IBAction)clickEqual;
- (IBAction)clickClear;
- (IBAction)clickPlus;
- (IBAction)clickMinus;
- (IBAction)clickMultiply;
- (IBAction)clickDivide;
- (IBAction)clickLeftBracket;
- (IBAction)clickRightBracket;

@end
