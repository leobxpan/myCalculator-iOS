//
//  Calculator.h
//  Calculator
//
//  Created by caesar on 15/2/9.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property double firstOperator,secondOperator;
@property char op;
@property BOOL hasError;

-(void)plus;
-(void)minus;
-(void)multiply;
-(void)divide;
-(void)decimals;
-(void)equal;
-(void)sqrt;
-(void)pow;
-(void)leftBracket;
-(void)rightBracket;
@end
