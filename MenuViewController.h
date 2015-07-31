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
#import "SearchMenuViewController.h"
#import "MenuDetailViewController.h"
#import "CartViewController.h"
#import "KCConnectDish.h"
#import "KCItemList.h"
#import "DismissFatherViewController.h"

@interface MenuViewController : UIViewController

@property id <DismissFatherViewController> closeControllerDelegate;

@property (strong, nonatomic) IBOutlet UITableView *menuTable;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cartItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *eventItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *meItem;

@property NSString * lastCall;

@property NSMutableDictionary * imageDictionary;
@property KCItemList * selectedItemList;


@end
