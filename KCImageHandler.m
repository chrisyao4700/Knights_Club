//
//  KCImageHandler.m
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCImageHandler.h"

@implementation KCImageHandler

+(void) saveImagesToLocalFileWithImageDictionary: (NSDictionary *) image_dictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/Menu_Icon.plist"];
    if (image_dictionary) {
        [image_dictionary writeToFile:dataPath atomically:YES];
    }
    
}

+(NSDictionary *) readImagesFromFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"%@",documentsDirectory);
    NSString * dataPath = [[NSString alloc]initWithFormat:@"%@%@",documentsDirectory,@"/Menu_Icon.plist"];
    
    NSDictionary * image_dictionary = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    
    return image_dictionary;
}

@end
