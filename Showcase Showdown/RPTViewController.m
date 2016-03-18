//
//  RPTViewController.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTViewController.h"
#import "RPTGame.h"
#import <AVFoundation/AVFoundation.h>


@interface RPTViewController ()

//Game Properties
@property (nonatomic) RPTPlayer *player;
@property (nonatomic) RPTGame *game;

@property (weak, nonatomic) IBOutlet UILabel *p1Score;
@property (weak, nonatomic) IBOutlet UILabel *p2Score;
@property (weak, nonatomic) IBOutlet UILabel *p3Score;

//PickerView Properties
@property (weak, nonatomic) IBOutlet UIPickerView *pirWheelPicker;
@property (nonatomic) NSInteger pickerRowValue;
@property (nonatomic) NSInteger previousPickerRowValue;
@property (nonatomic) NSArray *numbersArray;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *pickerGestureUp;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *pickerGestureDown;

//Bools
@property (nonatomic) BOOL fullSpin;
@property (nonatomic) BOOL spinDownward;
@property (nonatomic) BOOL spinUpwards;


//Images Properties
@property (weak, nonatomic) IBOutlet UIImageView *digitalSignImage;
@property (weak, nonatomic) IBOutlet UIImageView *middleGraphic;
@property (weak, nonatomic) IBOutlet UIImageView *nextContestantImageView;
@property (nonatomic) UIImage *nextContestantImage;
@property (strong, nonatomic) IBOutlet UIImageView *hostDialogImageView;
@property (nonatomic ,strong) UIImage *hostDialog;
//@property (strong, nonatomic) IBOutlet UIImageView *hostImageView;

//Buttons Properties
@property (weak, nonatomic) IBOutlet UIButton *stayButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *spinAgainButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *doneButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *okButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *resetButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *dismissOKSpinHarderButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *dismissNextContestantImageButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *dismissTieButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *drewHeadOutlet;
@property (strong, nonatomic) IBOutlet UIButton *bobHeadOutlet;
@property (strong, nonatomic) IBOutlet UIButton *introDismissButtonOutlet;

//Audio
@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) AVAudioPlayer *audioPlayerWinner;
@property (nonatomic) NSURL *priceIsWrong;
@property (nonatomic) NSURL *dollarWinner;
@property (nonatomic) NSURL *loserURL;
@property (nonatomic) NSURL *winnerURL;



@end

@implementation RPTViewController

- (void)viewDidLoad {
    
    NSLog(@"%@", self.host.name);
    
    [super viewDidLoad];
    
    [self loadSettings];
    [self loadAudio];
    [self checkHostButton];
    UIImage *centsSign = [UIImage imageNamed:@"spin"];
    [self.digitalSignImage setImage:centsSign];
//    [self startNewGame];
    
    
    NSLog(@"GETTING HERE");
    
    
    
    
    
    

    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self hostDialogIntro];
}

-(void)loadAudio {
    
        self.priceIsWrong = [[NSBundle mainBundle] URLForResource:@"happy10" withExtension:@"wav"];
        self.dollarWinner = [[NSBundle mainBundle] URLForResource:@"dollarwinner" withExtension:@"mp3"];
        self.loserURL = [[NSBundle mainBundle] URLForResource:@"loser1" withExtension:@"mp3"];
        self.winnerURL = [[NSBundle mainBundle] URLForResource:@"winner" withExtension:@"mp3"];
    
}



-(void)startNewGame {
    
    NSLog(@"GETTING TO START NEW GAME");
    
    self.player = [[RPTPlayer alloc] init];
    self.game = [[RPTGame alloc] init];
    self.previousPickerRowValue = 3000;
    [self.pirWheelPicker selectRow:3000 inComponent:0 animated:YES];
    [self startTieGame];
    
}

-(void)startTieGame {
    
    [self.pirWheelPicker setUserInteractionEnabled:NO];
    
    [self upDatePlayer];
    [self updateDigitalSign];
    [self hideAllButtons];
    [self hideGraphics];
    [self getContestantImage];
    
    
    
    self.p1Score.text = 0;
    self.p2Score.text = 0;
    self.p3Score.text = 0;
    
    
}

-(void)loadSettings {
    
//    self.host = [[RPTHost alloc] init];
    
    NSLog(@"GETTING TO LOAD GAME");
    
    [self.pirWheelPicker selectRow:3000 inComponent:0 animated:YES];
    
    [self.hostImageView setImage:self.host.hostImage];
    
    
    self.numbersArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"wheel1"], [UIImage imageNamed:@"wheel2"],[UIImage imageNamed:@"wheel3"],[UIImage imageNamed:@"wheel4"],[UIImage imageNamed:@"wheel5"],[UIImage imageNamed:@"wheel6"],[UIImage imageNamed:@"wheel7"],[UIImage imageNamed:@"wheel8"],[UIImage imageNamed:@"wheel9"],[UIImage imageNamed:@"wheel10"],[UIImage imageNamed:@"wheel11"],[UIImage imageNamed:@"wheel12"],[UIImage imageNamed:@"wheel13"],[UIImage imageNamed:@"wheel14"],[UIImage imageNamed:@"wheel15"],[UIImage imageNamed:@"wheel16"],[UIImage imageNamed:@"wheel17"], [UIImage imageNamed:@"wheel18"], [UIImage imageNamed:@"wheel19"], [UIImage imageNamed:@"wheel20"], nil];
    
    //Gesture Settings
    self.pickerGestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    self.pickerGestureUp.delegate = self;
    self.pickerGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    self.pickerGestureUp.numberOfTouchesRequired = 1;
    self.pickerGestureDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    self.pickerGestureDown.delegate = self;
    self.pickerGestureDown.direction = UISwipeGestureRecognizerDirectionDown;
    self.pickerGestureDown.numberOfTouchesRequired = 1;
    [self.pirWheelPicker addGestureRecognizer:self.pickerGestureDown];
    [self.pirWheelPicker addGestureRecognizer:self.pickerGestureUp];
    [self hideAllButtons];
    
}

#pragma Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    
    return 10000;
    
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSInteger newRowNumber = row % 20;
    
    //20 is hardcoded because the wheel will never change
    
    UIImageView *pvView = [[UIImageView alloc] initWithImage:self.numbersArray[newRowNumber]];
    
    return pvView;
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 70;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger newRow = row % 20;
    
    //20 is hardcoded because the wheel will never change
    
    self.pickerRowValue = row;
    
    if ([self fullSpin]) {
        
        self.previousPickerRowValue = self.pickerRowValue;
        
        switch(newRow)
        
        {
            case 0:
                self.player.wheelNumber = 100;
                break;
                
            case 1:
                self.player.wheelNumber = 5;
                break;
                
            case 2:
                self.player.wheelNumber = 90;
                break;
                
            case 3:
                self.player.wheelNumber = 25;
                break;
                
            case 4:
                self.player.wheelNumber = 70;
                break;
                
            case 5:
                self.player.wheelNumber = 45;
                break;
                
            case 6:
                self.player.wheelNumber = 10;
                break;
                
            case 7:
                self.player.wheelNumber = 65;
                break;
                
            case 8:
                self.player.wheelNumber = 30;
                break;
                
            case 9:
                self.player.wheelNumber = 85;
                break;
                
            case 10:
                self.player.wheelNumber = 50;
                break;
                
            case 11:
                self.player.wheelNumber = 95;
                break;
                
            case 12:
                self.player.wheelNumber = 55;
                break;
                
            case 13:
                self.player.wheelNumber = 75;
                break;
                
            case 14:
                self.player.wheelNumber = 40;
                break;
                
            case 15:
                self.player.wheelNumber = 20;
                break;
                
            case 16:
                self.player.wheelNumber = 60;
                break;
                
            case 17:
                self.player.wheelNumber = 35;
                break;
                
            case 18:
                self.player.wheelNumber = 80;
                break;
                
            case 19:
                self.player.wheelNumber = 15;
                break;
                
        }
        
        [self.player numberCheck:self.player.wheelNumber];
        [self updateDigitalSign];
        [self showButtons];
        
    }
    
    else {
        
        self.previousPickerRowValue = self.pickerRowValue;
        
        [self.dismissOKSpinHarderButtonOutlet setHidden:NO];
        
        if (self.spinUpwards) {
            
            UIImage *spinHarderImage = [UIImage imageNamed:@"swipeDownImage"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
        }
        
        else {
            
            UIImage *spinHarderImage = [UIImage imageNamed:@"spinHarderImage"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
        }
        
    }
    
}

#pragma BOOL to determine if full spin happened

-(BOOL)fullSpin {
    
    NSInteger finalValue = 0;
    
    BOOL fullSpin = NO;
    
    finalValue = labs(self.pickerRowValue - self.previousPickerRowValue);
    
    if (finalValue > 19 && self.spinDownward) {
        
        self.player.numberOfSpins += 1;
        
        fullSpin = YES;
        
        [self.pirWheelPicker setUserInteractionEnabled:NO];
        
        if (self.player.numberOfSpins >= 2) {
            
            [self.pirWheelPicker setUserInteractionEnabled:NO];
            
        }
        
    }
    
    else {
        
        fullSpin = NO;
        
        [self.pirWheelPicker setUserInteractionEnabled:NO];
        
    }
    
    return fullSpin;
    
}


#pragma Gesture Code


- (void)swipeUp:(UIGestureRecognizer *)sender {
    
    self.spinDownward = NO;
    self.spinUpwards = YES;

}


- (IBAction)swipeDown:(id)sender {
    
    self.spinDownward = YES;
    self.spinUpwards = NO;
    
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}



-(void)updateDigitalSign {
    
    [self.digitalSignImage setImage:self.player.centsSign];
    
    
}


-(void)upDatePlayer {
    
    self.player = [self.game.playerArray objectAtIndex:self.game.playerCount];
    
    
}

-(void)showButtons {
    
    if (self.player.numberOfSpins == 1) {
        
        if (self.game.playerCount == 0) {
            
            if (self.player.totalSpinScore == 100) {
                
                [self.doneButtonOutlet setHidden:NO];
                
                [self dollarWinnerSound];
            }
            
            else {
            
            [self.spinAgainButtonOutlet setHidden:NO];
            
                [self.stayButtonOutlet setHidden:NO];
            
            }
        }
        
        if (self.game.playerCount == 1) {
            
            if (self.player.totalSpinScore == 100) {
                
                [self dollarWinnerSound];
                
                [self.doneButtonOutlet setHidden:NO];
            }
            
            else if (self.player.totalSpinScore >= self.game.highScore) {
                
                [self.stayButtonOutlet setHidden:NO];
                
                [self.spinAgainButtonOutlet setHidden:NO];
            
            }
            
            else {
                
                [self.spinAgainButtonOutlet setHidden:NO];
                
            }
            
        }
        
        if (self.game.playerCount == 2) {
            
            if (self.player.totalSpinScore == 100) {
                
                [self dollarWinnerSound];
                
                [self.doneButtonOutlet setHidden:NO];
            }
            
            else if (self.player.totalSpinScore == self.game.highScore) {
                
                [self.stayButtonOutlet setHidden:NO];
                [self.spinAgainButtonOutlet setHidden:NO];
                
            }
            
            else if (self.player.totalSpinScore > self.game.highScore) {
                
                [self.stayButtonOutlet setHidden:NO];
                
            }
            
            else {
                
                [self.spinAgainButtonOutlet setHidden:NO];
                
            }
        }
    }
    
    else {
        
        if (self.player.totalSpinScore == 100) {
            
            [self.doneButtonOutlet setHidden:NO];
            
            [self dollarWinnerSound];
        }
        
        else if (self.player.totalSpinScore == 0) {
            
            [self.okButtonOutlet setHidden:NO];
            
            [self overSound];
        }
        
        else {
            
            [self.doneButtonOutlet setHidden:NO];
            
        }
        
    }
    
}


-(void)hideAllButtons {
    
    [self.spinAgainButtonOutlet setHidden:YES];
    [self.stayButtonOutlet setHidden:YES];
    [self.doneButtonOutlet setHidden:YES];
    [self.okButtonOutlet setHidden:YES];
    [self.playAgainButtonOutlet setHidden:YES];
    [self.dismissOKSpinHarderButtonOutlet setHidden:YES];
    [self.dismissNextContestantImageButtonOutlet setHidden:YES];
    [self.dismissTieButtonOutlet setHidden:YES];
    [self.introDismissButtonOutlet setHidden:YES];
    
    
}


-(void)hideGraphics {
    
    [self.middleGraphic setHidden:YES];
    [self.nextContestantImageView setHidden:YES];
    
}




#pragma Button Actions

- (IBAction)resetButtonAction:(id)sender {
    
    [self.audioPlayer stop];
    [self.audioPlayerWinner stop];
    [self startNewGame];
    
}


- (IBAction)playAgainButtonAction:(id)sender {
    
    [self.audioPlayerWinner stop];
    [self startNewGame];

}


- (IBAction)stayButtonAction:(id)sender {
    
    [self stayDoneAndOkayButtonMethod];
    [self.stayButtonOutlet setHidden:YES];
    [self.spinAgainButtonOutlet setHidden:YES];
    
    
}


- (IBAction)spinAgainButtonAction:(id)sender {
    
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    [self.spinAgainButtonOutlet setHidden:YES];
    [self.stayButtonOutlet setHidden:YES];
    
}


- (IBAction)doneButtonAction:(id)sender {
    
    [self stayDoneAndOkayButtonMethod];
    [self.doneButtonOutlet setHidden:YES];
    [self.audioPlayer stop];
    
    
}


- (IBAction)okayButtonAction:(id)sender {
    
    [self stayDoneAndOkayButtonMethod];
    [self.okButtonOutlet setHidden:YES];
    [self.audioPlayer stop];
    
    
}


- (IBAction)dismissOKSpinHarderButtonAction:(id)sender {
    
    [self.middleGraphic setHidden:YES];
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    [self.dismissOKSpinHarderButtonOutlet setHidden:YES];
    
}


-(void)stayDoneAndOkayButtonMethod {
    
    self.p1Score.text = [NSString stringWithFormat:@"%li", self.game.player1.totalSpinScore];
    self.p2Score.text = [NSString stringWithFormat:@"%li", self.game.player2.totalSpinScore];
    self.p3Score.text = [NSString stringWithFormat:@"%li", self.game.player3.totalSpinScore];
    
    self.game.playerCount += 1;
    
    if (self.game.playerCount > self.game.playerArray.count - 1) {
        
        [self.game isThereATieGame];
        
        if (self.game.tieGame) {
            
            UIImage *tieGame = [UIImage imageNamed:@"tieGame"];
            [self.dismissTieButtonOutlet setHidden:NO];
            [self.middleGraphic setImage:tieGame];
            [self.middleGraphic setHidden:NO];
        
        }
        
        else {
            
            
            [self.game determiningTheWinner];
            [self.playAgainButtonOutlet setHidden:NO];
            [self.middleGraphic setImage:self.game.winnerGraphic];
            [self.middleGraphic setHidden:NO];
            [self winnerSound];
            
        }
    }
    
    else {
        
        [self.game settingTheHighScore];
        [self upDatePlayer];
        [self updateDigitalSign];
        [self getContestantImage];
        
    }
    
}


- (IBAction)dismissNextContestantImageButtonAction:(id)sender {
    
    [self.nextContestantImageView setHidden:YES];
    [self.dismissNextContestantImageButtonOutlet setHidden:YES];
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    
}


-(void)getContestantImage {
    
    NSString *imageString = [self.game nextContestantImageString:self.player.contestantNumber];
    
    self.nextContestantImage = [UIImage imageNamed:imageString];
    [self.nextContestantImageView setImage:self.nextContestantImage];
    [self.nextContestantImageView setHidden:NO];
    [self.dismissNextContestantImageButtonOutlet setHidden:NO];
    
}


- (IBAction)dismissTieButtonAction:(id)sender {
    
    [self startTieGame];
    [self.middleGraphic setHidden:YES];
    [self.dismissTieButtonOutlet setHidden:YES];
    self.game.tieGame = NO;
    [self updateDigitalSign];
    
}


- (IBAction)priceIsWrongGesture:(UITapGestureRecognizer *)sender {
    
    if ([self.host.name isEqualToString:@"Bob"]) {
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.priceIsWrong error:nil];
        [self.audioPlayer play];
        
    }
    
     NSLog(@"PLAY MUSIC");

}

#pragma Audio Methods


-(void)dollarWinnerSound {
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.dollarWinner error:nil];
    [self.audioPlayer play];
    
}

-(void)overSound {
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.loserURL error:nil];
    [self.audioPlayer play];
    
}


-(void)winnerSound {
    
    self.audioPlayerWinner = [[AVAudioPlayer alloc] initWithContentsOfURL:self.winnerURL error:nil];
    [self.audioPlayerWinner play];
    
}

- (IBAction)bobHeadAction:(id)sender {
    
    self.host.name = @"Bob";
    self.host.hostImage = [UIImage imageNamed:@"bobImage"];
    [self.hostImageView setImage:self.host.hostImage];
    [self.bobHeadOutlet setHidden:YES];
    [self.drewHeadOutlet setHidden:NO];
    
    
}

- (IBAction)drewHeadAction:(id)sender {
    
    self.host.name = @"Drew";
    self.host.hostImage = [UIImage imageNamed:@"drewImage"];
    [self.hostImageView setImage:self.host.hostImage];
    [self.bobHeadOutlet setHidden:NO];
    [self.drewHeadOutlet setHidden:YES];
    
    
    
    
}

-(void)checkHostButton {
    
    if ([self.host.name isEqualToString:@"Bob"]) {
        [self.bobHeadOutlet setHidden:YES];
        [self.drewHeadOutlet setHidden:NO];
    }
    if ([self.host.name isEqualToString:@"Drew"]) {
        [self.bobHeadOutlet setHidden:NO];
        [self.drewHeadOutlet setHidden:YES];
    }
    
    
    
}

-(void)hostDialogIntro {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro1"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro2"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 7.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro3"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro4"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                [self.introDismissButtonOutlet setHidden:NO];
            }
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 13.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro5"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 16.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.hostDialog = [UIImage imageNamed:@"gameIntro6"];
            [self.hostDialogImageView setImage:self.hostDialog];
            
        } completion:nil];
    });
    
}

- (IBAction)introDismissButtonAction:(id)sender {
    
    [self.hostDialogImageView setHidden:YES];
    [self.introDismissButtonOutlet setHidden:YES];
    [self startNewGame];
    
}


@end
