//
//  OrderPresentTableViewCell.h
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPresentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *first_item;
@property (strong, nonatomic) IBOutlet UIImageView *second_item;

@property (strong, nonatomic) IBOutlet UIImageView *third_item;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *tittleLabel;

@end
