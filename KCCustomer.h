//
//  KCCustomer.h
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCCustomer : NSObject
@property NSArray * elementKeys;

@property NSString * networkID;
@property NSString * networkPassword;
@property NSString * email;
@property NSString * guNumber;

@property NSArray * contentArray;
@property NSDictionary * contentDictionary;


-(id) initWithNetworkID: (NSString *) networkID
            andPassword: (NSString *) networkPassword
               andEmail: (NSString *) email
            andGUNumber: (NSString *) gunumber;

-(id) initWithContentArray:(NSArray *) contentArray;
-(id) initWithContentDictionary:(NSDictionary *) contentDictionary;

+(NSArray *) configElementsKey;
-(NSString *) createURL;

@end
