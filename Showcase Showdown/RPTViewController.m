//
//  RPTViewController.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTViewController.h"
#import "RPTGame.h"
#import "RPTHost.h"
#import <AVFoundation/AVFoundation.h>


@interface RPTViewController ()

//Game Properties
@property (nonatomic) RPTPlayer *player;
@property (nonatomic) RPTGame *game;

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
@property (nonatomic) BOOL anotherTieGame;

//Images Properties
@property (weak, nonatomic) IBOutlet UIImageView *digitalSignImage;
@property (weak, nonatomic) IBOutlet UIImageView *middleGraphic;
@property (weak, nonatomic) IBOutlet UIImageView *nextContestantImageView;
@property (strong, nonatomic) IBOutlet UIImageView *hostDialogImageView;
@property (nonatomic) UIImage *nextContestantImage;
@property (nonatomic ,strong) UIImage *hostDialog;
@property (strong, nonatomic) IBOutlet UILabel *hostDialogLabel;

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
@property (strong, nonatomic) IBOutlet UIButton *dismissStayButtonDialogOutlet;

//Audio
@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) AVAudioPlayer *audioPlayerWinner;
@property (nonatomic) AVAudioPlayer *buttonPlayer;
@property (nonatomic) NSURL *priceIsWrong;
@property (nonatomic) NSURL *dollarWinner;
@property (nonatomic) NSURL *loserURL;
@property (nonatomic) NSURL *winnerURL;
@property (nonatomic) NSURL *buttonURL;

//Timer
@property (nonatomic) NSTimer *timer;
@property (nonatomic, assign) NSInteger seconds;



@end

@implementation RPTViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage *centsSign = [UIImage imageNamed:@"spin"];
    
    [self.digitalSignImage setImage:centsSign];
    [self.pirWheelPicker setUserInteractionEnabled:NO];
    [self loadSettings];
    [self loadAudio];
    [self checkHostButton];
    
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
        self.buttonURL = [[NSBundle mainBundle] URLForResource:@"buttonSound" withExtension:@"mp3"];
    
}


-(void)startNewGame {
    
    self.player = [[RPTPlayer alloc] init];
    self.game = [[RPTGame alloc] init];
    self.previousPickerRowValue = 8000;
    [self.pirWheelPicker selectRow:8000 inComponent:0 animated:YES];
    [self startTieGame];
    self.anotherTieGame = NO;
    
}

-(void)startTieGame {
    
    [self.pirWheelPicker setUserInteractionEnabled:NO];
    [self upDatePlayer];
    [self updateDigitalSign];
    [self hideAllButtons];
    [self hideGraphics];
    [self getContestantImage];

}

-(void)loadSettings {
    

    
    [self.pirWheelPicker selectRow:8000 inComponent:0 animated:YES];
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
        [self updateHostDialog];
        [self showButtons];
        
    }
    
    else {
        
        self.previousPickerRowValue = self.pickerRowValue;
        [self.dismissOKSpinHarderButtonOutlet setHidden:NO];
        [self notAValidSpin];
        
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
                
                [self doTheDollarStuff];
            }
            
            else {
            
            [self.spinAgainButtonOutlet setHidden:NO];
            [self.stayButtonOutlet setHidden:NO];
            
            }
        }
        
        if (self.game.playerCount == 1) {
            
            if (self.player.totalSpinScore == 100) {
                
                [self doTheDollarStuff];
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
                
                [self doTheDollarStuff];
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
            
            [self doTheDollarStuff];
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
    [self.dismissStayButtonDialogOutlet setHidden:YES];
    
    
}


-(void)hideGraphics {
    
    [self.middleGraphic setHidden:YES];
    [self.nextContestantImageView setHidden:YES];
    [self.hostDialogImageView setHidden:YES];
    [self.hostDialogLabel setHidden:YES];
    
}




#pragma Button Actions

- (IBAction)resetButtonAction:(id)sender {
    
    [self.audioPlayer stop];
    [self.audioPlayerWinner stop];
    [self startNewGame];
    [self buttonSound];
    
}


- (IBAction)playAgainButtonAction:(id)sender {
    
    [self.audioPlayerWinner stop];
    [self startNewGame];
    [self buttonSound];

}


- (IBAction)stayButtonAction:(id)sender {
    
    [self.stayButtonOutlet setHidden:YES];
    [self.spinAgainButtonOutlet setHidden:YES];
    [self.hostDialogImageView setHidden:YES];
    [self.hostDialogLabel setHidden:YES];
    
    if (self.game.playerCount == 0 || self.game.playerCount == 1 ) {
        
        [self.dismissStayButtonDialogOutlet setHidden:NO];
        self.host.hostDialog = [UIImage imageNamed:@"scoreHoldUp"];
        [self.hostDialogImageView setImage:self.host.hostDialog];
        [self.hostDialogImageView setHidden:NO];
    }
    
    if (self.game.playerCount == 2) {
    
    [self stayDoneAndOkayButtonMethod];
    [self.hostDialogImageView setHidden:NO];
        
    }

    [self buttonSound];
}


- (IBAction)spinAgainButtonAction:(id)sender {
    
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    [self.spinAgainButtonOutlet setHidden:YES];
    [self.stayButtonOutlet setHidden:YES];
    [self.hostDialogImageView setHidden:YES];
    [self.hostDialogLabel setHidden:YES];
    [self buttonSound];
    

}


- (IBAction)doneButtonAction:(id)sender {
    
    [self stayDoneAndOkayButtonMethod];
    [self.doneButtonOutlet setHidden:YES];
    [self.audioPlayer stop];
    [self buttonSound];

    
    
}


- (IBAction)okayButtonAction:(id)sender {
    
    [self stayDoneAndOkayButtonMethod];
    [self.okButtonOutlet setHidden:YES];
    [self.audioPlayer stop];
    [self buttonSound];

    
    
}


- (IBAction)dismissOKSpinHarderButtonAction:(id)sender {
    
    [self.middleGraphic setHidden:YES];
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    [self.dismissOKSpinHarderButtonOutlet setHidden:YES];
    [self.hostDialogImageView setHidden:YES];
    [self buttonSound];
    
}


-(void)stayDoneAndOkayButtonMethod {
    
    
    self.game.playerCount += 1;
    
    if (self.game.playerCount > self.game.playerArray.count - 1) {
        
        [self.game isThereATieGame];
        
        if (self.game.tieGame) {
            
            self.anotherTieGame = YES;
            
            UIImage *tieGame = [UIImage imageNamed:@"tieGame"];
            [self.dismissTieButtonOutlet setHidden:NO];
            self.hostDialogLabel.text = @"It's a TIE!!! SPIN-OFF!!!";
            self.host.hostDialog = [UIImage imageNamed:@"blankDialog"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            [self.hostDialogImageView setHidden:NO];
            [self.hostDialogLabel setHidden:NO];
            [self.middleGraphic setImage:tieGame];
            [self.middleGraphic setHidden:NO];
        
        }
        
        else {
            
            
            [self.game determiningTheWinner];
            [self.playAgainButtonOutlet setHidden:NO];
            self.hostDialogLabel.text = @"Congrats!!! You are going to the Showcase!!!";
            self.host.hostDialog = [UIImage imageNamed:@"blankDialog"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            [self.hostDialogImageView setHidden:NO];
            [self.hostDialogLabel setHidden:NO];
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
        [self.hostDialogImageView setHidden:YES];
        [self.hostDialogLabel setHidden:YES];
        [self.middleGraphic setHidden:YES];
        
        
    }
    
}


- (IBAction)dismissNextContestantImageButtonAction:(id)sender {
    
    [self.nextContestantImageView setHidden:YES];
    [self.dismissNextContestantImageButtonOutlet setHidden:YES];
    [self.pirWheelPicker setUserInteractionEnabled:YES];
    [self buttonSound];
    
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
    [self buttonSound];
    
}

- (IBAction)bobHeadAction:(id)sender {
    
    self.host.name = @"Bob";
    self.host.hostImage = [UIImage imageNamed:@"bobImage"];
    [self.hostImageView setImage:self.host.hostImage];
    [self.bobHeadOutlet setHidden:YES];
    [self.drewHeadOutlet setHidden:NO];
    [self buttonSound];
    
    
}

- (IBAction)drewHeadAction:(id)sender {
    
    self.host.name = @"Drew";
    self.host.hostImage = [UIImage imageNamed:@"drewImage"];
    [self.hostImageView setImage:self.host.hostImage];
    [self.bobHeadOutlet setHidden:NO];
    [self.drewHeadOutlet setHidden:YES];
    [self buttonSound];
    
    
    
    
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

- (IBAction)introDismissButtonAction:(id)sender {
    

    [self.hostDialogImageView setHidden:YES];
    [self.introDismissButtonOutlet setHidden:YES];
    [self startNewGame];
    [self buttonSound];
    
}


- (IBAction)dismissStayDialogAction:(id)sender {
    
    [self.dismissStayButtonDialogOutlet setHidden:YES];
    [self.hostDialogImageView setHidden:YES];
    [self stayDoneAndOkayButtonMethod];
    [self buttonSound];
    
}

-(void)updateHostDialog {
    
    NSString *dialog = [self.host getHostDialogWithPlayer:self.game.playerCount withSpin:self.player.numberOfSpins withHighScore:self.game.highScore withPlayerScore:self.player.totalSpinScore withTieBool:self.anotherTieGame andNumberOfPlayers:self.game.playerArray.count];
    
    self.hostDialogLabel.text = dialog;
    self.host.hostDialog = [UIImage imageNamed:@"blankDialog"];
    [self.hostDialogImageView setImage:self.host.hostDialog];
    [self.hostDialogImageView setHidden:NO];
    [self.hostDialogLabel setHidden:NO];
    
    
}

#pragma animations

-(void)hostDialogIntro {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro1"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro2"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 7.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro3"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro4"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.introDismissButtonOutlet setHidden:NO];
            }
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 13.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro5"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 16.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hostDialogImageView duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.host.hostDialog = [UIImage imageNamed:@"gameIntro6"];
            [self.hostDialogImageView setImage:self.host.hostDialog];
            
        } completion:nil];
    });
    
}


-(void)animateDollar {
    
    if (self.seconds == 0) {
        
        NSLog(@"This is getting called");
        [self.doneButtonOutlet setHidden:NO];
        [self.timer invalidate];
        self.timer = nil;
    }
    
    else {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.middleGraphic duration:0 options:0 animations:^{
            UIImage *spinHarderImage = [UIImage imageNamed:@"dollarGreen"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
            NSLog(@"1");
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.middleGraphic duration:0 options:0 animations:^{
            UIImage *spinHarderImage = [UIImage imageNamed:@"dollarOrange"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
            NSLog(@"2");
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.middleGraphic duration:0 options:0 animations:^{
            UIImage *spinHarderImage = [UIImage imageNamed:@"dollarYellow"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
            NSLog(@"3");
            
        } completion:nil];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .75 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.middleGraphic duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
            UIImage *spinHarderImage = [UIImage imageNamed:@"dollarRed"];
            [self.middleGraphic setImage:spinHarderImage];
            [self.middleGraphic setHidden:NO];
            
            NSLog(@"4");
            
        } completion:nil];
    });
    
    self.seconds -= 1;
    
    }
    
}

-(void)startTimer {
    
    self.seconds = 11;
    
    [self.doneButtonOutlet setHidden:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animateDollar) userInfo:nil repeats:YES];
    [self.timer fire];
    
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

-(void)buttonSound {
   
    self.buttonPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.buttonURL error:nil];
    [self.buttonPlayer play];
    
}


-(void)winnerSound {
    
    self.audioPlayerWinner = [[AVAudioPlayer alloc] initWithContentsOfURL:self.winnerURL error:nil];
    [self.audioPlayerWinner play];
    
}

-(void)doTheDollarStuff {
    
    [self startTimer];
    [self dollarWinnerSound];

    
    
}

-(void)notAValidSpin{
    
    UIImage *spinHarderImage;
    
    if (self.spinUpwards) {
        
        spinHarderImage = [UIImage imageNamed:@"swipeDownImage"];
        self.host.hostDialog = [UIImage imageNamed:@"spinDownDialog"];
    }
    
    else {
        
        spinHarderImage = [UIImage imageNamed:@"spinHarderImage"];
        self.host.hostDialog = [UIImage imageNamed:@"spinHarderDialog"];
        
    }
    
    
    [self.middleGraphic setHidden:NO];
    [self.middleGraphic setImage:spinHarderImage];
    [self.hostDialogImageView setImage:self.host.hostDialog];
    [self.hostDialogImageView setHidden:NO];
    
}

@end
