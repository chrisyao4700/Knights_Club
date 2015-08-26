//
//  SignInViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignUpViewController.h"
#import "MenuViewController.h"
#import "KCCustomerHandler.h"


@interface SignInViewController : UIViewController<DismissFatherViewController>
@property KCCustomer * loginCustomer;
@property id <DismissFatherViewController> dismisViewDelegate;
@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end
