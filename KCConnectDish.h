//
//  KCConnectDish.h
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KCDish.h"

@interface KCConnectDish : NSObject
+(NSURLConnection *) readDishesFromDatabaseWithDelegate:(id) delegate;
+(NSURLConnection *) readImageFromServerWithDish:(KCDish *) dish
                                     andDelegate: (id) delegate;
+(UIImage *) configImagesWithDish: (KCDish *) dish;


+(NSString *) urlHandler: (NSString *) value;
@end
