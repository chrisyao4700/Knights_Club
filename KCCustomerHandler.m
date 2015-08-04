//
//  KCCustomerHandler.m
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCCustomerHandler.h"

@implementation KCCustomerHandler

+(void) saveCustomerToFileWithCustomer: (KCCustomer *) customer{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/Default_Customer.plist"];
    if (customer) {
        [[customer contentDictionary] writeToFile:dataPath atomically:YES];
    }
}
+(KCCustomer *) readCustomerFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/Default_Customer.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        NSDictionary * contentDictionary = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        KCCustomer * customer = [[KCCustomer alloc] initWithContentDictionary:contentDictionary];
        return customer;
    }else{
        return nil;
    }
    
    
    
}
+(void)deleteCustomerFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/Default_Customer.plist"];
    NSError * error;
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];
}

@end
