//
//  SignUpViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCConnectCustomer.h"

@interface SignUpViewController : UIViewController
@property NSString * netWorkID;
@property NSString * netWorkPassword;

@property KCCustomer * customer;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *repasswordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *campusNumField;

@end
