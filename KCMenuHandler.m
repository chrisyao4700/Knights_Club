//
//  KCMenuHandler.m
//  The Knights Club
//
//  Created by 姚远 on 8/12/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCMenuHandler.h"


@implementation KCMenuHandler

+(void)saveMenuToFile:(NSDictionary *) menuDict{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Menu.plist"];
    if (menuDict) {
        [menuDict writeToFile:dataPath atomically:YES];
    }
    
}
+(NSDictionary *) readMenuFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Menu.plist"];
    NSDictionary * menuDictionary;
    //BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
         menuDictionary = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    }
    
    
    return menuDictionary;
    
}
@end
