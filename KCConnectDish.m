//
//  KCConnectDish.m
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCConnectDish.h"

@implementation KCConnectDish
+(NSURLConnection *) readDishesFromDatabaseWithDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Menu/menu_read.php"];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * readConnection = [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return readConnection;
}

+(NSURLConnection *) readImageFromServerWithDish:(KCDish *) dish
                                     andDelegate: (id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Menu/menu_icon/GU_Full_Logo.png"];
    
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * readConnection = [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return readConnection;
}

@end
