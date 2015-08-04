//
//  MenuDetailViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishDetailScrllViewController.h"
#import "KCConnectDish.h"
#import "KCItemList.h"
#import "DetailBackToCartRefresh.h"
#import "KCItemListHandler.h"

@interface MenuDetailViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *addCartButton;

@property NSData * imageData;
@property KCDish * currentDish;
@property KCItemList * selectedItemList;
@property id<DetailBackToCartRefresh> updateItemListDelegate;
@property NSNumber * si_quantity;
@property NSString * si_requirement;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;

@property (strong, nonatomic) IBOutlet UISlider *quantitySlider;
@property (strong, nonatomic) IBOutlet UITextView *requirementView;

@end
