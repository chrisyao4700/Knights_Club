//
//  KCConnectOrder.m
//  The Knights Club
//
//  Created by 姚远 on 8/2/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCConnectOrder.h"

@implementation KCConnectOrder
+(NSURLConnection *) readDishesFromDatabaseWithDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/order_read.php"];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * readConnection = [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return readConnection;
}


+(NSURLConnection *) sendOrderToEmailService: (KCOrder *) order
                                 andDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/knights_order_email.php%@",[order createLinkURL]];
    strURL = [KCConnectOrder urlHandler:strURL];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * emailConnection =  [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return emailConnection;

    
}
+(NSURLConnection *) insertOrderToDatabase:(KCOrder *) order
                               andDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/order_insert.php%@",[order createLinkURL]];
    strURL = [KCConnectOrder urlHandler:strURL];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * insertConnection =  [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return insertConnection;

    
}

+(NSString *) urlHandler: (NSString *) value{
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
   // value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    value = [value stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    value = [value stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
    
    
    return [[NSMutableString alloc] initWithString: value] ;
    
}


@end
