//
//  CustomerViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCCustomerHandler.h"
#import "CustomerViewTableViewCell.h"
#import "KCConnectCustomer.h"
#import "KCImageHandler.h"
#import "KCItemListHandler.h"
#import "DismissFatherViewController.h"
#import "SignInViewController.h"
#import "MenuViewController.h"
#import "CartViewController.h"
#import "QRCodeScanViewController.h"

@interface CustomerViewController : UIViewController <UITextFieldDelegate,DismissFatherViewController,ScanOrderProtocol>

@property id <DismissFatherViewController> dismisViewDelegate;

@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UITableView *customer_infoView;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImageView;

@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic) IBOutlet UIButton *eventButton;
@property (strong, nonatomic) IBOutlet UIButton *meButton;

@property (strong, nonatomic) IBOutlet UIView *toolBarView;

@property KCCustomer * defaultCustomer;


@end
