//
//  RPTHost.h
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RPTHost : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *hostImage;
@property (nonatomic, strong) UIImage *hostDialog;
@property (nonatomic, strong) NSString *hostDialogString;
-(NSString *)getHostDialogWithPlayer:(NSInteger)playerCount
                           withSpin:(NSInteger)spinCount
                    withHighScore:(NSInteger)highScore
                    withPlayerScore:(NSInteger)playerScore
                         withTieBool:(BOOL)tie
                  andNumberOfPlayers:(NSInteger)numberOfPlayers;

@end
