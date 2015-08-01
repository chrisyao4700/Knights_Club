//
//  KCItemListHandler.h
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCItemList.h"

@interface KCItemListHandler : NSObject
+(void) saveItemListToFileWithList: (KCItemList *) list;
+(KCItemList *) readItemListFromFile;
+(void) deleteItemListInFile;


@end
