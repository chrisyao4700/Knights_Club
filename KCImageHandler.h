//
//  KCImageHandler.h
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageHandler : NSObject
+(void) saveImagesToLocalFileWithImageDictionary: (NSDictionary *) image_dictionary;

+(NSDictionary *) readImagesFromFile;
@end
