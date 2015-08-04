//
//  KCItemListHandler.m
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCItemListHandler.h"

@implementation KCItemListHandler
+(void)saveItemListToFileWithList:(KCItemList *)list{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_ItemList.plist"];
    if (list) {
        [list.dataArray writeToFile:dataPath atomically:YES];
    }

}
+(KCItemList *)readItemListFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_ItemList.plist"];
  //  BOOL isExisted= [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
       NSArray * contentArray = [NSArray arrayWithContentsOfFile:dataPath];
        KCItemList * list = [[KCItemList alloc] initWithDataArray:contentArray];
        return list;
    }else{
        return nil;
    }

    
}
+(void)deleteItemListInFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/KC_Current_ItemList.plist"];

    NSError * error;
    [[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error];

    
}
@end
