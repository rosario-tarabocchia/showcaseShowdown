//
//  RPTPlayer.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTPlayer.h"

@implementation RPTPlayer

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
       
        _firstSpinScore = 0;
        _totalSpinScore = 0;
        _numberOfSpins = 0;
        _centsSign = [[UIImage alloc] init];
        _centsSign = [UIImage imageNamed:@"spin"];

    }
    
    return self;

}

-(void)numberCheck:(NSInteger)wheelNumber {
    
    if (self.numberOfSpins == 1) {
        
        self.firstSpinScore = wheelNumber;
        
        [self actionsAfterTheFirstSpin:self.firstSpinScore];
        
    }
    
    else {
        
        self.totalSpinScore = wheelNumber + self.firstSpinScore;
        
        [self actionsAfterSecondSpin:self.totalSpinScore];
        
    }
    
}


-(void)actionsAfterTheFirstSpin:(NSInteger)firstNumber {
    
    NSString *sign = [NSString stringWithFormat:@"%li", firstNumber];
    
    self.centsSign = [UIImage imageNamed:sign];
    
    self.totalSpinScore = firstNumber;

}


-(void)actionsAfterSecondSpin:(NSInteger)secondNumber {
    
    NSString *sign = [NSString stringWithFormat:@"%li", secondNumber];
    
    if (secondNumber > 100) {
        
        sign = @"over";
        
        self.centsSign = [UIImage imageNamed:sign];
        
        secondNumber = 0;
        
    }
    
    else {
        
        self.centsSign = [UIImage imageNamed:sign];
        
    }
    
    self.totalSpinScore = secondNumber;
    
}

@end
