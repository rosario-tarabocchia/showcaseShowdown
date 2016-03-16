//
//  RPTPlayer.h
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPTDigitalSign.h"


@interface RPTPlayer : NSObject

@property (nonatomic, assign) NSInteger wheelNumber;
@property (nonatomic ,assign) NSInteger firstSpinScore;
@property (nonatomic, assign) NSInteger totalSpinScore;
@property (nonatomic, assign) NSInteger numberOfSpins;
@property (nonatomic, assign) NSInteger contestantNumber;
@property (nonatomic) RPTDigitalSign *centsSign;

-(void)numberCheck:(NSInteger)wheelNumber;
-(void)actionsAfterTheFirstSpin:(NSInteger)firstNumber;
-(void)actionsAfterSecondSpin:(NSInteger)secondNumber;

@end
