//
//  RPTHostScreenViewController.m
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/16/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import "RPTHostScreenViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface RPTHostScreenViewController ()

@property (nonatomic, strong) RPTHost *host;


@property (strong, nonatomic) IBOutlet UIImageView *bobDialogImage;
@property (strong, nonatomic) IBOutlet UIImageView *drewDialogImage;
@property (strong) UIImage *dialog;
@property (strong) UIImage *dialog1;

@property (nonatomic) BOOL animationFinsihed;
@property (strong, nonatomic) IBOutlet UIButton *drewButton;
@property (strong, nonatomic) IBOutlet UIButton *bobButton;

@property (nonatomic, assign) NSInteger pictureImageNumber;
@property (strong, nonatomic) IBOutlet UIImageView *blankImage;

@property (strong, nonatomic) IBOutlet UIImageView *doorsClosed;
@property (strong, nonatomic) UIImage *doorsOpened;

@property (nonatomic) AVAudioPlayer *audioPlayerIntro;
@property (nonatomic) NSURL *introMusic;



@end

@implementation RPTHostScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.introMusic = [[NSBundle mainBundle] URLForResource:@"CMONDWN75" withExtension:@"mp3"];
    
    self.audioPlayerIntro = [[AVAudioPlayer alloc] initWithContentsOfURL:self.introMusic error:nil];
    [self.audioPlayerIntro play];
    

    
    
    
    UIImage *drewImage = [UIImage imageNamed:@"drewImage"];
    [self.drewButton.imageView setImage:drewImage];
    
    UIImage *bobImage = [UIImage imageNamed:@"bobImage"];
    [self.bobButton.imageView setImage:bobImage];
    
    self.host = [[RPTHost alloc] init];


    
//    self.dialog1 = [UIImage imageNamed:@"hostIntroScreen2"];
//    [self.drewDialogImage setImage:self.dialog1];
    [self.drewDialogImage setHidden:YES];
    
    self.dialog = [UIImage imageNamed:@"hostIntro1"];
    [self.bobDialogImage setImage:self.dialog];
    [self.bobDialogImage setHidden:YES];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self changePicture];


}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    
    
    RPTViewController *destVC = segue.destinationViewController;
    
    destVC.host = self.host;
                
    [self.audioPlayerIntro stop];

  

    
}


-(void)changePicture {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:0.0 options:0 animations:^{
            [self.bobDialogImage setHidden:NO];
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:2.0 options:UIViewAnimationOptionTransitionFlipFromTop  animations:^{
            self.dialog = [UIImage imageNamed:@"hostIntro2"];
            [self.bobDialogImage setImage:self.dialog];
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.dialog = [UIImage imageNamed:@"hostIntro3"];
            [self.bobDialogImage setImage:self.dialog];
        } completion:nil];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 9.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:2.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{

            self.dialog = [UIImage imageNamed:@"hostIntro4"];
            [self.bobDialogImage setImage:self.dialog];
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 12 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.drewDialogImage duration:1.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self.drewDialogImage setHidden:NO];
            self.dialog1 = [UIImage imageNamed:@"hostIntro5"];
            [self.drewDialogImage setImage:self.dialog1];
            
        } completion:^(BOOL finished) {
            
//            if (finished) {
//                self.animationFinsihed = YES;
//            }
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 13 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:2.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            [self.bobDialogImage setHidden:YES];
            
            
        } completion:nil];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.bobDialogImage duration:2.0 options:0 animations:^{
            [self.drewDialogImage setHidden:YES];
            
            
        } completion:nil];
    });
    

    

    



    
    
}

-(void)stageDoorsOpen:(void (^)(BOOL animationDone))completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen1"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen2"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen3"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen4"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:nil];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen5"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.doorsClosed duration:.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.doorsOpened = [UIImage imageNamed:@"doorsOpen6"];
            [self.doorsClosed setImage:self.doorsOpened];
            
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                completionHandler(YES);
            }
        }];
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (IBAction)drewButtonAction:(id)sender {
    
    [self stageDoorsOpen:^(BOOL animationDone) {
        if (animationDone) {
            
            NSLog(@"ARE WE GETING HERE");
            
            self.host.name = @"Drew";
            self.host.hostImage = [UIImage imageNamed:@"drewImage"];
            
            [self performSegueWithIdentifier:@"gameVC" sender:nil];
        }
    }];
    
}

- (IBAction)bobButtonAction:(id)sender {
    
    [self stageDoorsOpen:^(BOOL animationDone) {
        if (animationDone) {
            
            NSLog(@"ARE WE GETING HERE");
            
            self.host.name = @"Bob";
            self.host.hostImage = [UIImage imageNamed:@"bobImage"];
            
            [self performSegueWithIdentifier:@"gameVC" sender:nil];
        }
    }];
}


@end
