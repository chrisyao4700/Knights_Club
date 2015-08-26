//
//  CartViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCItemList.h"
#import "CartTableViewCell.h"
#import "MenuDetailViewController.h"
#import "MenuViewController.h"
#import "DismissFatherViewController.h"
#import "PaymentViewController.h"
#import "KCItemListHandler.h"


@interface CartViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,DetailBackToCartRefresh,DismissFatherViewController>



@property KCItemList * selectedItemList;

@property (strong, nonatomic) IBOutlet UITableView *orderTable;

@property id <DismissFatherViewController> dismisViewDelegate;

@property (strong, nonatomic) IBOutlet UITextView *finalRequirementView;
@property (strong, nonatomic) IBOutlet UITextField *tipsField;
@property (strong, nonatomic) IBOutlet UILabel *taxValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalChargeLabel;
@property (strong, nonatomic) IBOutlet UIView *toolBarView;

@property (strong, nonatomic) IBOutlet UIButton *checkoutButton;


@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic) IBOutlet UIButton *eventButton;
@property (strong, nonatomic) IBOutlet UIButton *meButton;

@end
