//
//  KCConnectCustomer.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCConnectCustomer.h"


@implementation KCConnectCustomer

+(NSURLConnection *) readCustomerFromDatabaseWithUsername: (NSString *) username
                                              andPassword: (NSString *) password
                                              andDelegate: (id) connectionDelegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Customer/knights_customer_login.php%@",[KCConnectCustomer configLoginURLWithUsername:username andPassword:password]];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * loginConnection = [NSURLConnection connectionWithRequest:request delegate:connectionDelegate];
    
    return loginConnection;
}

+(NSString *) configLoginURLWithUsername: (NSString *) username
                             andPassword: (NSString *) password{
    NSString * replacedUsername = [username stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    replacedUsername = [replacedUsername stringByReplacingOccurrencesOfString:@"@" withString:@"_"];
    NSString * url = [NSString stringWithFormat:@"?Username=%@&Keycode=%@",replacedUsername,password];
    return url;
}

+(NSURLConnection *) saveCustomerToDatabaseWithCustomer: (KCCustomer *) customer
                                            andDelegate: (id) connectionDelegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Customer/knights_customer_insert.php%@",[customer createURL]];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * insertConnection = [NSURLConnection connectionWithRequest:request delegate:connectionDelegate];
    
    return insertConnection;
}


@end
