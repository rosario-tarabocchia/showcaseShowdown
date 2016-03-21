//
//  RPTGame.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTGame.h"

@implementation RPTGame

-(instancetype)init {
    
    self = [super init];
    
    if (self){
        
        _playerArray = [NSMutableArray new];
        _player1 = [RPTPlayer new];
        _player1.contestantNumber = 1;
        _player2 = [RPTPlayer new];
        _player2.contestantNumber = 2;
        _player3 = [RPTPlayer new];
        _player3.contestantNumber = 3;
        _playerArray = [@[self.player1, self.player2, self.player3] mutableCopy];
        _playerCount = 0;
        _winnerGraphic = [[UIImage alloc] init];
        _highScore = 0;
    
    }
    
    return self;
    
}


-(void)isThereATieGame {
    
    if (self.player1.totalSpinScore == self.player2.totalSpinScore && self.player2.totalSpinScore == self.player3.totalSpinScore) {
        
        self.playerArray = [@[self.player1, self.player2, self.player3] mutableCopy];
        
        NSLog(@"TIE SETTINGS ALL TIED");
        
        [self tieSettings];
        
        
    }
    
    else if (self.player1.totalSpinScore == self.player2.totalSpinScore && self.player1.totalSpinScore > self.player3.totalSpinScore) {
        
        self.playerArray = [@[self.player1, self.player2] mutableCopy];
        
        NSLog(@"TIE SETTINGS 1 AND 2");
        
        [self tieSettings];
        
    }
    
    else if (self.player1.totalSpinScore == self.player3.totalSpinScore && self.player1.totalSpinScore > self.player2.totalSpinScore) {
        
        self.playerArray = [@[self.player1, self.player3] mutableCopy];
        
        NSLog(@"TIE SETTINGS 1 AND 3");
        
        [self tieSettings];

    }
    
    else if (self.player2.totalSpinScore == self.player3.totalSpinScore && self.player2.totalSpinScore > self.player1.totalSpinScore) {
        
        self.playerArray = [@[self.player2, self.player3] mutableCopy];
        
        NSLog(@"TIE SETTINGS 2 AND 3");
        
        [self tieSettings];
        
    }
    


}


-(void)determiningTheWinner {
    
        
        if (self.player1.totalSpinScore > self.player2.totalSpinScore && self.player1.totalSpinScore > self.player3.totalSpinScore) {
            
            self.winnerGraphic = [UIImage imageNamed:@"winner1Image"];
            
        }
        
        if (self.player2.totalSpinScore > self.player1.totalSpinScore && self.player2.totalSpinScore > self.player3.totalSpinScore) {
            
            self.winnerGraphic = [UIImage imageNamed:@"winner2Image"];
            
        }
        
        
        if (self.player3.totalSpinScore > self.player1.totalSpinScore && self.player3.totalSpinScore > self.player2.totalSpinScore) {
            
            self.winnerGraphic = [UIImage imageNamed:@"winner3Image"];
            
        }

    
}


-(void)tieSettings {
    
    NSLog(@"WE GETTING TO TIE SETTINGS?");
    
    self.player1.firstSpinScore = 0;
    self.player2.firstSpinScore = 0;
    self.player3.firstSpinScore = 0;
    self.player1.totalSpinScore = 0;
    self.player2.totalSpinScore = 0;
    self.player3.totalSpinScore = 0;
    self.player1.numberOfSpins = 1;
    self.player2.numberOfSpins = 1;
    self.player3.numberOfSpins = 1;
    self.player1.centsSign = [UIImage imageNamed:@"spin"];
    self.player2.centsSign = [UIImage imageNamed:@"spin"];
    self.player3.centsSign = [UIImage imageNamed:@"spin"];
    self.tieGame = YES;
    self.playerCount = 0;
    self.winnerGraphic = [UIImage imageNamed:@"tiedImage"];
    self.highScore = 0;

}

-(void)settingTheHighScore {
    
    if (self.player1.totalSpinScore > self.highScore) {
        
        self.highScore = self.player1.totalSpinScore;
    }
    
    if (self.player2.totalSpinScore > self.highScore) {
        
        self.highScore = self.player2.totalSpinScore;
    }
    
    
}


-(NSString *)nextContestantImageString:(NSInteger)contestantNumber{
    
    NSString *newString = [NSString stringWithFormat:@"contestant%liReadyImage", contestantNumber];
    
    
    return newString;

}



@end
