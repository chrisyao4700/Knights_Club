//
//  EventViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DismissFatherViewController.h"
#import "MenuViewController.h"
#import "CartViewController.h"
#import "CustomerViewController.h"

@interface EventViewController : UIViewController<DismissFatherViewController>

@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;

@property id <DismissFatherViewController> dismissFatherViewDelegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cartItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *eventItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *meItem;



@end
