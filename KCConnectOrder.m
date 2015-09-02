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
+(KCOrder *) fetchOrderFromList:(NSArray *) list andKey:(NSString *) key{
    for (NSDictionary* dict in list) {
        if ([[dict objectForKey:@"Title"] isEqualToString:key]) {
            return [[KCOrder alloc] initWithLocalDictionary:dict];
        }
    }
    return nil;
}

+(NSArray *) readOrdersFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Order_List.plist"];
    NSArray * list = [NSArray arrayWithContentsOfFile:dataPath];
    if (list) {
        return list;
    }else{
    return nil;
    }

    
}
+(void)saveOrdersToFile:(NSArray *)orderList{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Order_List.plist"];
    
    if (orderList) {
        [orderList writeToFile:dataPath atomically:YES];
        
    }
    
}
+(void) addOrderToList:(KCOrder *) order{
    
    
    NSMutableArray * list = [[NSMutableArray alloc] initWithArray:[KCConnectOrder readOrdersFromFile]];
    if (list) {
        [list addObject:order.localDictionary];
    }else{
        list = [[NSMutableArray alloc] init];
        [list addObject:order.localDictionary];
    }
    [KCConnectOrder saveOrdersToFile:list];

}
+(void) deleteOrderList{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Order_List.plist"];

    NSError * error;
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];

}
+(NSData *) setOrderStateWithOrderTitle:(NSString*) orderTitle
                               andState:(NSString *) orderState
                            andDelegate:(id) delegate{
    
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/kc_order_setState.php?Order_Name=%@&Order_State=%@",orderTitle,orderState];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    NSData * data = [NSData dataWithContentsOfURL:insertURL];
    //[request setHTTPMethod:@"GET"];
    //NSURLConnection * insertConnection =  [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return  data;
    
}

+(NSData *) readOrderWithTitle:(NSString *) orderTitle
                   andDelegate:(id) delegate{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Order/order_choose.php?Column=Title&Value=%@",orderTitle];
    NSURL *insertURL = [NSURL URLWithString:strURL];
    NSLog(@"%@", strURL);
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:insertURL];
    NSData * data = [NSData dataWithContentsOfURL:insertURL];
    //[request setHTTPMethod:@"GET"];
    //NSURLConnection * insertConnection =  [NSURLConnection connectionWithRequest:request delegate:delegate];
    
    return  data;

}


@end
