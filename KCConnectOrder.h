//
//  KCConnectOrder.h
//  The Knights Club
//
//  Created by 姚远 on 8/2/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCOrder.h"

@interface KCConnectOrder : NSObject
+(NSURLConnection *) sendOrderToEmailService: (KCOrder *) order
                                 andDelegate:(id) delegate;
+(NSURLConnection *) insertOrderToDatabase:(KCOrder *) order
                               andDelegate:(id) delegate;

@end
