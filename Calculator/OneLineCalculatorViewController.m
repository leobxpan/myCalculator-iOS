//
//  OneLineCalculatorViewController.m
//  Calculator
//
//  Created by caesar on 15/2/11.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "OneLineCalculatorViewController.h"
#import "Calculator.h"
@interface OneLineCalculatorViewController ()

@property Calculator *myCalculator;
@property Calculator *inBracketCalculator;
@property NSString *currentTitle;
@property double displayFirstOperator;
@property char bracketString;

@end



@implementation OneLineCalculatorViewController

static int count = 1;           //set to set decimals.
static int avoidBug = 0;        //set to avoid bugs in multiply and divide when double-clicking them.
static int avoidPowBug = 0;     //set to avoid bugs in pow when double-clicking it.
static char displayOp;          //op that is to be displayed on the screen.

- (void)setup{
    _myCalculator = [[Calculator alloc] init];
}
- (instancetype)init{
    self = [self init];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib{
    [self setup];
    _myCalculator.op = '+';
    self.currentTitle = [NSString stringWithFormat:@"%g",_myCalculator.firstOperator];
}
- (IBAction)clickDigit:(UIButton *)sender {
    avoidBug = 0;
    avoidPowBug = 0;
    long int digit = sender.tag;
    [self processFirstop:(double)digit];
}
-(void)processFirstop : (double)digit{
    if(_myCalculator.op == '.'){
        _myCalculator.firstOperator = _myCalculator.firstOperator + pow(0.1,count)*digit;
        self.displayFirstOperator = digit;
        count++;
        NSString *firstOperatorString = [NSString stringWithFormat:@"%g",self.displayFirstOperator];
        self.currentTitle = [self.currentTitle stringByAppendingString:firstOperatorString];
        _display.text = self.currentTitle;
    }else if(self.bracketString == '('){
        if(_inBracketCalculator.op == '.'){
            _inBracketCalculator.firstOperator = _inBracketCalculator.firstOperator + pow(0.1,count)*digit;
            self.displayFirstOperator = digit;
            count++;
            NSString *firstOperatorString = [NSString stringWithFormat:@"%g",self.displayFirstOperator];
            self.currentTitle = [self.currentTitle stringByAppendingString:firstOperatorString];
            _display.text = self.currentTitle;
        }else{
            _inBracketCalculator.firstOperator = _inBracketCalculator.firstOperator * 10 + digit;
            NSString *digitOperatorString = [NSString stringWithFormat:@"%g",digit];
            self.currentTitle = [self.currentTitle stringByAppendingString:digitOperatorString];
            _display.text = self.currentTitle;
        }
    }else{
        _myCalculator.firstOperator = _myCalculator.firstOperator * 10 + digit;
        NSString *digitOperatorString = [NSString stringWithFormat:@"%g", digit];
        NSRange range = [self.currentTitle rangeOfString:@"("];
        if(![self.currentTitle doubleValue] && !(range.length)){
            self.currentTitle = [NSString stringWithFormat:@"%g",_myCalculator.firstOperator];
        }else{
            self.currentTitle = [self.currentTitle stringByAppendingString:digitOperatorString];
        }
        _display.text = self.currentTitle;
    }
}
- (IBAction)clickDot {
    avoidBug = 0;
    avoidPowBug = 0;
    if(self.bracketString == '('){
        [_inBracketCalculator decimals];
    }else{
        [_myCalculator decimals];
    }
    self.currentTitle = [self.currentTitle stringByAppendingString:@"."];
    _display.text = self.currentTitle;
}

- (IBAction)clickEqual {
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    displayOp = '=';
    [self judge];
}

- (IBAction)clickClear {
    _myCalculator.firstOperator = _myCalculator.secondOperator = 0;
    _inBracketCalculator.firstOperator = _inBracketCalculator.secondOperator = 0;
    avoidBug = 0;
    avoidPowBug = 0;
    self.currentTitle = @"0";
    _display.text = self.currentTitle;
    _myCalculator.op = '+';
    self.bracketString = ' ';
}

- (IBAction)clickPlus {
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    displayOp = '+';
    if(self.bracketString == '('){
        [self bracketJudge];
        [_inBracketCalculator plus];
    }else if(self.bracketString == ')'){
        _myCalculator.firstOperator = _inBracketCalculator.secondOperator;
        self.bracketString = ' ';
        [self judge];
        [_myCalculator plus];
        self.bracketString = ' ';
    }else{
        [self judge];
        [_myCalculator plus];
    }
}

- (IBAction)clickMinus {
    count = 1;
    avoidBug = 0;
    avoidPowBug = 0;
    displayOp = '-';
    if(self.bracketString == '('){
        [self bracketJudge];
        [_inBracketCalculator minus];
    }else if(self.bracketString == ')'){
        _myCalculator.firstOperator = _inBracketCalculator.secondOperator;
        [self judge];
        [_myCalculator minus];
        self.bracketString = ' ';
    }else{
        [self judge];
        [_myCalculator minus];
    }
}

- (IBAction)clickMultiply {
    count = 1;
    avoidPowBug = 0;
    avoidBug++;
    displayOp = '*';
    if(self.bracketString == '('){
        [self bracketJudge];
        [_inBracketCalculator multiply];
    }else if(self.bracketString == ')'){
        _myCalculator.firstOperator = _inBracketCalculator.secondOperator;
        [self judge];
        [_myCalculator multiply];
        self.bracketString = ' ';
    }else{
        [self judge];
        [_myCalculator multiply];
    }
}

- (IBAction)clickDivide {
    count = 1;
    avoidPowBug = 0;
    avoidBug++;
    displayOp = '/';
    if(self.bracketString == '('){
        [self bracketJudge];
        [_inBracketCalculator divide];
    }else if(self.bracketString == ')'){
        _myCalculator.firstOperator = _inBracketCalculator.secondOperator;
        [self judge];
        [_myCalculator divide];
        self.bracketString = ' ';
    }else{
        [self judge];
        [_myCalculator divide];
    }
}

- (IBAction)clickLeftBracket {
    count = 1;
    avoidPowBug = 0;
    avoidBug = 0;
    displayOp = '(';
    _inBracketCalculator = [[Calculator alloc]init];
    _inBracketCalculator.op = '+';
    self.bracketString = '(';
    if(![self.currentTitle doubleValue]){
        self.currentTitle = @"(";
        _display.text = self.currentTitle;
    }else{
        NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
        self.currentTitle = [self.currentTitle stringByAppendingString:opString];
        _display.text = self.currentTitle;
    }
}

- (IBAction)clickRightBracket {
    count = 1;
    avoidPowBug = 0;
    avoidBug = 0;
    displayOp = ')';
    self.bracketString = ')';
    [self bracketJudge];
}
-(void)judge{
    if(displayOp == '='){
        if(self.bracketString == ')'){
            _myCalculator.firstOperator = _inBracketCalculator.secondOperator;
            self.bracketString = ' ';
            [self judge];
        }else{
            [_myCalculator equal];
            _myCalculator.op = '+';
            NSString *secondOperatorString = [NSString stringWithFormat:@"%g",_myCalculator.secondOperator];
            self.currentTitle = secondOperatorString;
            _display.text = self.currentTitle;
        }
    }else if(_myCalculator.op == '/'){
        if(avoidBug > 1){
            _myCalculator.firstOperator = 1;
            [_myCalculator equal];
            _myCalculator.op = '+';
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }else if(_myCalculator.firstOperator == 0){
            _display.text = @"Error";
        }else{
            [_myCalculator equal];
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;            _myCalculator.op = '+';
        }
    }else if(_myCalculator.op == '*'){
        if(avoidBug > 1){
            _myCalculator.firstOperator = 1;
            [_myCalculator equal];
            _myCalculator.op = '+';
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }else{
            [_myCalculator equal];
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }
    }else{
        [_myCalculator equal];
        _myCalculator.op = '+';
        NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
        self.currentTitle = [self.currentTitle stringByAppendingString:opString];
        _display.text = self.currentTitle;
        }
}
-(void)bracketJudge{
    if(_inBracketCalculator.op == '/'){
        if(avoidBug > 1){
            _inBracketCalculator.firstOperator = 1;
            [_inBracketCalculator equal];
            _inBracketCalculator.op = '+';
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }else if(_inBracketCalculator.firstOperator == 0){
            _display.text = @"Error";
        }else{
            [_inBracketCalculator equal];
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;            _inBracketCalculator.op = '+';
        }
    }else if(_inBracketCalculator.op == '*'){
        if(avoidBug > 1){
            _inBracketCalculator.firstOperator = 1;
            [_inBracketCalculator equal];
            _inBracketCalculator.op = '+';
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }else{
            [_inBracketCalculator equal];
            _inBracketCalculator.op = '+';
            NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
            self.currentTitle = [self.currentTitle stringByAppendingString:opString];
            _display.text = self.currentTitle;
        }
    }else{
        [_inBracketCalculator equal];
        NSString *opString = [NSString stringWithFormat:@"%c",displayOp];
        self.currentTitle = [self.currentTitle stringByAppendingString:opString];
        _display.text = self.currentTitle;
    }
}

@end
