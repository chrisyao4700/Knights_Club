//
//  MenuViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"
#import "KCImageHandler.h"
#import "KCMenuHandler.h"
#import "SearchMenuViewController.h"
#import "MenuDetailViewController.h"
#import "CustomerViewController.h"
#import "CartViewController.h"
#import "KCConnectDish.h"
#import "KCItemListHandler.h"
#import "DismissFatherViewController.h"
#import "EventViewController.h"
#import "RefreshViewControllerProtocol.h"

@interface MenuViewController : UIViewController<DismissFatherViewController,RefreshViewControllerProtocol>

@property id <DismissFatherViewController> closeControllerDelegate;


@property (strong, nonatomic) IBOutlet UITableView *menuTable;


@property NSString * lastCall;

@property NSMutableDictionary * imageDictionary;
@property KCItemList * selectedItemList;

@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic) IBOutlet UIButton *eventButton;
@property (strong, nonatomic) IBOutlet UIButton *meButton;

@property (strong, nonatomic) IBOutlet UIView *toolBarView;

@end
