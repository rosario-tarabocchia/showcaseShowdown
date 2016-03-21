//
//  RPTHost.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTHost.h"

@implementation RPTHost

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _hostImage = [[UIImage alloc]init];
        _hostDialog = [[UIImage alloc]init];
        
        _name = @"BOB";
        
    }
    
    return self;
    
}

-(NSString *)getHostDialogWithPlayer:(NSInteger)playerCount withSpin:(NSInteger)spinCount withHighScore:(NSInteger)highScore withPlayerScore:(NSInteger)playerScore withTieBool:(BOOL)tie andNumberOfPlayers: (NSInteger) numberOfPlayers {
    
    if (playerCount == 0) {
        
        if (playerScore == 100) {
            self.hostDialogString = @"WOW!!! $1.00!!! Congratulations!!!";
            
        }
        
        else {
            
            if (spinCount == 1) {
                
                self.hostDialogString = [NSString stringWithFormat:@"You scored a %li. Spin again or stay?", playerScore];
                
            }
            
            if (spinCount == 2) {
                
                if (playerScore == 0) {
                    
                    self.hostDialogString = @"Awww... That's to bad. Thanks for playing.";
                }
                
                else {
                    
                    if (tie == YES && numberOfPlayers == 2) {
                        
                        self.hostDialogString = [NSString stringWithFormat:@"Let's see if your score of %li holds up!", playerScore];
                    }
                    
                    else {
                    
                    self.hostDialogString = [NSString stringWithFormat:@"You are the leader with a score of %li!", playerScore];
                    
                    }
                }
            }
        }
    }
    
    if (playerCount == 1) {
        
        if (playerScore == 100) {
            self.hostDialogString = @"WOW!!! $1.00!!! Congratulations!!!";
            
        }
        
        else {
            
            if (spinCount == 1) {
                
                if (playerScore > highScore) {
                    self.hostDialogString = [NSString stringWithFormat:@"You are in the lead with a %li. Spin again?", playerScore];
                }
                
                if (playerScore < highScore) {
                    
                    if (highScore == 100) {
                        
                        NSInteger x = highScore - playerScore;
                        
                        self.hostDialogString = [NSString stringWithFormat:@"Spin again. You need a %li to tie.", x];
                        
                    } else {
                        
                        self.hostDialogString = [NSString stringWithFormat:@"Spin again. You need to beat a %li.", highScore];
                        
                    }
                }
                
                if (playerScore == highScore) {
                    self.hostDialogString = [NSString stringWithFormat:@"You're tied with a score of %li. Spin again?", playerScore];
                }
                
            }
            
            if (spinCount == 2) {
                
                if (playerScore == 0) {
                    self.hostDialogString = @"Awww... That's to bad. Thanks for playing.";
                }
                
                else {
                    
                    if (playerScore > highScore) {
                        
                        if (tie == YES && numberOfPlayers == 2) {
                            
                            self.hostDialogString = @"NICE SPIN! You are the winner!";
                        }
                        
                        else {
                            
                            self.hostDialogString = [NSString stringWithFormat:@"You are the new leader with a %li.", playerScore];
                            
                        }
                        
                    }
                    
                    if (playerScore < highScore) {
                        self.hostDialogString = @"That is not enough. Thanks for playing!";
                    }
                    
                    if (playerScore == highScore) {
                        self.hostDialogString = [NSString stringWithFormat:@"You are tied with the leader with a %li.", highScore];
                    }
                }
            }
        }
    }
    
    if (playerCount == 2) {
    
    
        if (playerScore == 100) {
            
            self.hostDialogString = @"WOW!!! $1.00!!! Congratulations!!!";
        }
    
        else {
    
            if (spinCount == 1) {
                
                if (playerScore > highScore) {
                    self.hostDialogString = @"Congrats!!! You are the WINNER!";
                }
                
                if (playerScore < highScore) {
                    
                    if (highScore == 100) {
                        
                        NSInteger x = highScore - playerScore;
                        
                        self.hostDialogString = [NSString stringWithFormat:@"Spin again. You need a %li to tie.", x];
                        
                    } else {
                    
                        self.hostDialogString = [NSString stringWithFormat:@"Spin again. You need to beat a %li.", highScore];
                    
                    }
                }
                
                if (playerScore == highScore) {
                    self.hostDialogString = [NSString stringWithFormat:@"You are tied with a score of %li. Spin again?", playerScore];
                }
                
            }
    
            if (spinCount == 2) {
    
                if (playerScore == 0) {
                    self.hostDialogString = @"Awww... That's to bad. Thanks for playing.";
                }
                
                else {
                    
                    if (playerScore > highScore) {
                        
                        self.hostDialogString = @"You are the WINNER!";
                    }
                    
                    if (playerScore < highScore) {
                            self.hostDialogString = @"That is not enough. Thanks for playing!";
                        }
                    
                    if (playerScore == highScore) {
                        self.hostDialogString = [NSString stringWithFormat:@"You are tied with a score of %li.", playerScore];
                    }
                }
            }
        }
    }
    
    //newPlayer
    
    return self.hostDialogString;
    
}
@end
