//
//  MenuViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"
#import "SearchMenuViewController.h"
#import "MenuDetailViewController.h"
#import "KCConnectDish.h"

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *menuTable;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cartItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *eventItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *meItem;

@property NSMutableDictionary * imageDictionary;

@property NSMutableArray *selectedItems;


@end
