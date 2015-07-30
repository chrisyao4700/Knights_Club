//
//  DishDetailScrllViewController.h
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCConnectDish.h"

@interface DishDetailScrllViewController : UIViewController

@property KCDish * selectedDish;
@property NSData * imageData;

@property (strong, nonatomic) IBOutlet UIImageView *dish_imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *catagoryLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionView;


@end
