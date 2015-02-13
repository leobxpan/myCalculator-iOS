//
//  OrdinaryCalculatorViewController.m
//  Calculator
//
//  Created by caesar on 15/2/1.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "OrdinaryCalculatorViewController.h"
#import "Calculator.h"
@interface OrdinaryCalculatorViewController ()

@property Calculator *myCalculator;

@end

@implementation OrdinaryCalculatorViewController

static int count = 1;           //set to set decimals.
static int avoidBug = 0;        //set to avoid bugs in multiply and divide when double clicking them.
static int avoidPowBug = 0;     //set to avoid bugs in pow when double-clicking it.

- (void)setup
{
    _myCalculator = [[Calculator alloc] init];
}
- (instancetype)init
{
    self = [self init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
    _myCalculator.op = '+';
}
-(IBAction)clickFirstDigit : (UIButton *)sender{
    avoidBug = 0;
    avoidPowBug = 0;
    long int digit = sender.tag;
    [self processFirstop:(double)digit];
}
-(void)processFirstop : (double)digit{
    if(_myCalculator.op == '.'){
        _myCalculator.firstOperator = _myCalculator.firstOperator + pow(0.1,count)*digit;
        count++;
        _display.text = [NSString stringWithFormat:@"%g",_myCalculator.firstOperator];
    }else{
        _myCalculator.firstOperator = _myCalculator.firstOperator * 10 + digit;
        NSString *firstOperatorString = [NSString stringWithFormat:@"%g", _myCalculator.firstOperator];
        _display.text = firstOperatorString;
    }
}
-(IBAction)clickPlus{
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    [self judge];
    [_myCalculator plus];
}
-(IBAction)clickMinus{
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    [self judge];
    [_myCalculator minus];
}
-(IBAction)clickMultiply{
    count = 1;
    avoidPowBug = 0;
    avoidBug++;
    [self judge];
    [_myCalculator multiply];
}
-(IBAction)clickDivide{
    count = 1;
    avoidPowBug = 0;
    avoidBug++;
    [self judge];
    [_myCalculator divide];
}
-(IBAction)equal{
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    [self judge];
}
-(IBAction)dot{
    avoidBug = 0;
    avoidPowBug = 0;
    [_myCalculator decimals];
    NSString *integerPart = [NSString stringWithFormat:@"%g",_myCalculator.firstOperator];
    _display.text = [integerPart stringByAppendingString:@"."];
}

-(IBAction)clear{
    _myCalculator.firstOperator = _myCalculator.secondOperator = 0;
    avoidBug = 0;
    avoidPowBug = 0;
    _display.text = @"0";
    _myCalculator.op = '+';
}
- (IBAction)sqrt {
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    [self judge];
    [_myCalculator sqrt];
    [self judge];
    _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
}

- (IBAction)pow {
    count = 1;
    avoidBug = 0;
    avoidPowBug++;
    [self judge];
    [_myCalculator pow];
}
-(void)judge{
    if(_myCalculator.op == '/'){
        if(avoidBug > 1){
            _myCalculator.firstOperator = 1;
            [_myCalculator equal];
            _myCalculator.op = '+';
            _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
        }else if(_myCalculator.firstOperator == 0){
            _display.text = @"Error";
        }else{
            [_myCalculator equal];
            _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
            _myCalculator.op = '+';
        }
    }else if(_myCalculator.op == 's'){
        [_myCalculator equal];
        if(_myCalculator.secondOperator){
            [_myCalculator plus];
        }else{
            double temp;
            temp = _myCalculator.firstOperator;
            _myCalculator.firstOperator = _myCalculator.secondOperator;
            _myCalculator.secondOperator = temp;
            [_myCalculator equal];
            _myCalculator.op = '+';
        }
        _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
    }else if(_myCalculator.op == '*'){
        if(avoidBug > 1){
            _myCalculator.firstOperator = 1;
            [_myCalculator equal];
            _myCalculator.op = '+';
            _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
        }else{
            [_myCalculator equal];
            _myCalculator.op = '+';
            _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
        }
    }else if((_myCalculator.op == 'p') && (avoidPowBug > 1)){
        _myCalculator.firstOperator = 1;
        [_myCalculator equal];
        _myCalculator.op = '+';
        _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
    }else{
        [_myCalculator equal];
        _myCalculator.op = '+';
        _display.text = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
    }
}




@end
