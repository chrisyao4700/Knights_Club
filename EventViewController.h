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

@interface EventViewController : UIViewController<DismissFatherViewController,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;

@property id <DismissFatherViewController> dismissFatherViewDelegate;

@property (strong, nonatomic) IBOutlet UIView *toolBarView;

@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic) IBOutlet UIButton *eventButton;
@property (strong, nonatomic) IBOutlet UIButton *meButton;



@end
