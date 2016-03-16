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
        _centsSign = [[RPTDigitalSign alloc] init];
        _centsSign.image = [RPTDigitalSign imageNamed:@"spin"];

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
    
    if (firstNumber == 100) {
        
        sign = [NSString stringWithFormat:@"%liwhite", firstNumber];
        
        self.centsSign.image = [RPTDigitalSign imageNamed:sign];
        
    } else {
        
        self.centsSign.image = [RPTDigitalSign imageNamed:sign];
        
    }
    
    self.firstSpinScore = firstNumber;
    
    self.totalSpinScore = firstNumber;

}


-(void)actionsAfterSecondSpin:(NSInteger)secondNumber {
    
    NSString *sign = [NSString stringWithFormat:@"%li", secondNumber];
    
    if (secondNumber > 100) {
        
        sign = @"over";
        
        self.centsSign.image = [RPTDigitalSign imageNamed:sign];
        
        secondNumber = 0;
        
    }
    
    else if (secondNumber == 100){
        
        sign = [NSString stringWithFormat:@"%lired", secondNumber];
        
        self.centsSign.image = [RPTDigitalSign imageNamed:sign];
        
    }
    
    else {
        
        self.centsSign.image = [RPTDigitalSign imageNamed:sign];
        
    }
    
    self.totalSpinScore = secondNumber;
    
}

@end
