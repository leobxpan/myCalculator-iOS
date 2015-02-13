//
//  Calculator.m
//  Calculator
//
//  Created by caesar on 15/2/9.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(void)plus{
    _op = '+';
}
-(void)minus{
    _op = '-';
}
-(void)multiply{
    _op = '*';
}
-(void)divide{
    _op = '/';
}
-(void)decimals{
    _op = '.';
}
-(void)sqrt{
    _op = 's';
}
-(void)pow{
    _op = 'p';
}
-(void)leftBracket{
    _op = '(';
}
-(void)rightBracket{
    _op = ')';
}
-(void)equal{
    switch(_op){
        case '+' :
        case '.' :
            _secondOperator += _firstOperator;
            _firstOperator = 0;
            break;
        case '-' :
            _secondOperator -=  _firstOperator ;
            _firstOperator = 0;
            break;
        case '*' :
            _secondOperator *= _firstOperator;
            _firstOperator = 0;
            break;
        case '/' :
            _secondOperator /= _firstOperator;
            _firstOperator = 0;
            break;            
        case 's':
            _secondOperator = sqrt(_secondOperator);
            break;
        case 'p':
            _secondOperator = pow(_secondOperator, _firstOperator);
            _firstOperator = 0;
            break;
    }
}

@end
