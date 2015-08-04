//
//  OrderDetailViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCConnectOrder.h"

@interface OrderDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *state_image;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UITextView *orderContentView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@end
