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
+(NSURLConnection *) readOrderFromDatabaseWithColumn:(NSString *) column
                                            andValue:(NSString *) value
                                         andDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/order_choose.php?Column=%@&Value=%@",column,value];
    strURL = [KCConnectOrder urlHandler:strURL];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    [request setHTTPMethod:@"GET"];
    NSURLConnection * selectConnection =  [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return selectConnection;
}


+(NSString *) urlHandler: (NSString *) value{

    
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    //value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
   // 
    value = [value stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    value = [value stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
    
    
    return [[NSMutableString alloc] initWithString: value] ;
    
}


+(void) saveOrderToFileWithOrder: (KCOrder *) order{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_Order.plist"];
    if (order) {
        [[order contentDictionary] writeToFile:dataPath atomically:YES];
    }

}
+(KCOrder *) readOrderFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_Order.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        NSDictionary * contentDictionary = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        KCOrder * order = [[KCOrder alloc] initWithContentDictionary:contentDictionary];
        return order;
    }else{
        return nil;
    }

}
+(void) deleteOrderFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_Order.plist"];
    NSError * error;
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];
}

@end
