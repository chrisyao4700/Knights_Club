//
//  SignInViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

@interface SignInViewController : UIViewController
@property KCCustomer * loginCustomer;
@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end
