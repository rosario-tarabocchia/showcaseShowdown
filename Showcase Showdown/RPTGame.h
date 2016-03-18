//
//  RPTGame.h
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPTPlayer.h"



@interface RPTGame : NSObject

@property (nonatomic, strong) RPTPlayer *player1;
@property (nonatomic, strong) RPTPlayer *player2;
@property (nonatomic, strong) RPTPlayer *player3;
@property (nonatomic, strong) UIImage *winnerGraphic;
@property (nonatomic, assign) BOOL tieGame;
@property (nonatomic, assign) NSInteger playerCount;
@property (nonatomic, strong) NSMutableArray *playerArray;
@property (nonatomic, assign) NSInteger highScore;

-(instancetype)init;
-(void)determiningTheWinner;
-(void)isThereATieGame;
-(void)settingTheHighScore;
-(NSString *)nextContestantImageString:(NSInteger)contestantNumber;

@end
