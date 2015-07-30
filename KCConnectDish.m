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
+(UIImage *) configImagesWithDish: (KCDish *) dish{
    //[KCConnectDish readImageFromServerWithDish:[[KCDish alloc]init] andDelegate:self];
    NSMutableString *url_Img1 = [[NSMutableString alloc] initWithString:@"http://chrisyao4700.com/Knights_Club/Knights_Menu/menu_icon/"];
    [url_Img1 appendFormat:@"%@.png",dish.dishName];
    //[url_Img1 appendString:@"GU_Full_Logo.png"];
    UIImage * image;
    NSString * url_full = [KCConnectDish urlHandler:url_Img1];
    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_full]]];
    
    
    NSLog(@"%@", url_full);
    return image;
}
+(NSString *) urlHandler: (NSString *) value{
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    value = [value stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    
    
    return [[NSMutableString alloc] initWithString: value] ;

}


@end
