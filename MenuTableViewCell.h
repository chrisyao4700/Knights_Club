//
//  MenuTableViewCell.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView * m_imageView;
@property (strong, nonatomic) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic) IBOutlet UILabel * priceLabel;

@end
