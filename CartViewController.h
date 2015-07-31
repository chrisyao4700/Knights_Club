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
@interface CartViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>



@property KCItemList * selectedItemList;

@property (strong, nonatomic) IBOutlet UITableView *orderTable;

@property (strong, nonatomic) IBOutlet UITextView *finalRequirementView;
@property (strong, nonatomic) IBOutlet UITextField *tipsField;
@property (strong, nonatomic) IBOutlet UILabel *taxValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalChargeLabel;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cartItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *eventItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *meItem;
@property (strong, nonatomic) IBOutlet UIButton *checkoutButton;



@end
