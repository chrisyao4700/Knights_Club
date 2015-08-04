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

+(NSData *) configImagesWithDish: (KCDish *) dish andDelegate:(id)delegate{
   
    NSString * stringURL= [NSString stringWithFormat:@"http://chrisyao4700.com/Knights_Club/Knights_Menu/menu_icon/%@.png",[dish dishName]];

   // UIImage * image;
    stringURL = [KCConnectDish urlHandler:stringURL];
    NSURL * imageURL= [NSURL URLWithString:stringURL];
    NSData * imageData =  [NSData dataWithContentsOfURL:imageURL];
  
  // image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_full]]];
    
    
  // NSLog(@"%@", stringURL);
    return imageData;
}
+(NSString *) urlHandler: (NSString *) value{
    value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    value = [value stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    
    
    return [[NSMutableString alloc] initWithString: value] ;

}


@end
