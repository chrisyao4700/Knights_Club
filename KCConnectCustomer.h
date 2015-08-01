//
//  KCConnectCustomer.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCCustomer.h"

@interface KCConnectCustomer : NSObject
+(NSURLConnection *) readCustomerFromDatabaseWithUsername: (NSString *) username
                                              andPassword: (NSString *) password
                                              andDelegate: (id) connectionDelegate;

+(NSURLConnection *) saveCustomerToDatabaseWithCustomer: (KCCustomer *) customer
                                            andDelegate: (id) connectionDelegate;

+(NSURLConnection *) editCustomerTodatabaseWithCustomer:(KCCustomer *) customer
                                            andDelegate:(id) connectionDelegate;
@end
