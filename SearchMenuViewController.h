//
//  SearchMenuViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"
#import "MenuDetailViewController.h"
#import "KCConnectDish.h"
#import "KCItemList.h"

@interface SearchMenuViewController : UIViewController<UISearchBarDelegate>
@property NSArray * menuDataArray;
@property KCItemList * selectedItemList;
@property NSDictionary * imageDictionary;

@property (strong, nonatomic) IBOutlet UISearchBar *menuSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *menuTable;

@end
