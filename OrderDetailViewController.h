//
//  OrderDetailViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCConnectOrder.h"
#import "CartViewController.h"
#import "KCQRCodeHandler.h"
#import "KCMenuHandler.h"
#import "KCItemListHandler.h"
#import "KCImageHandler.h"

@interface OrderDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *state_image;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UITextView *orderContentView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

@property KCOrder * currentOrder;

@property (strong, nonatomic) IBOutlet UIButton *qrButton;

@end
