//
//  KCCustomerHandler.h
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCCustomer.h"

@interface KCCustomerHandler : NSObject

+(void) saveCustomerToFileWithCustomer: (KCCustomer *) customer;
+(KCCustomer *) readCustomerFromFile;
+(void) deleteCustomerFile;
@end
