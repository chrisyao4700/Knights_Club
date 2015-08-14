//
//  KCMenuHandler.h
//  The Knights Club
//
//  Created by 姚远 on 8/12/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCMenuHandler : NSObject
+(void)saveMenuToFile:(NSDictionary *) menuDict;
+(NSDictionary *) readMenuFromFile;
@end
