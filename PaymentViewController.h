//
//  PaymentViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCItemList.h"
#import "PaymentTableViewCell.h"
#import "KCOrder.h"
#import "DetailBackToCartRefresh.h"
#import "KCCustomerHandler.h"
#import "KCConnectOrder.h"
#import "KCItemListHandler.h"



@interface PaymentViewController : UIViewController<UIAlertViewDelegate>
@property KCItemList * itemList;
@property NSNumber * tips;
@property NSString * orderTotal;
@property NSString * finalRequirement;
@property NSString * tax;
@property NSString * total;
@property NSString * paymentType;

@property id<DetailBackToCartRefresh> refreshDelegate;

@property (strong, nonatomic) IBOutlet UILabel *itemLabel;

@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *tipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (strong, nonatomic) IBOutlet UIImageView *paymentTypeView;

@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) IBOutlet UIButton *comfirmButton;

@end
