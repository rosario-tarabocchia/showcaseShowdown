//
//  RPTViewController.h
//  Showcase Showdown
//
//  Created by Rosario Tarabocchia on 3/14/16.
//  Copyright © 2016 RLDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPTHost.h"

@interface RPTViewController : UIViewController <UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) RPTHost *host;
@property (strong, nonatomic) IBOutlet UIImageView *hostImageView;
@end
