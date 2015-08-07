//
//  OrderPresentViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCConnectOrder.h"
#import "KCCustomerHandler.h"
#import "OrderPresentTableViewCell.h"
#import "KCImageHandler.h"
#import "OrderDetailViewController.h"

@interface OrderPresentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *orderContentView;

@end
