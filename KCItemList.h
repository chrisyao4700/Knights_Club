//
//  KCItemList.h
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCItem.h"

@interface KCItemList : NSObject

@property NSMutableArray * selectedItemArray;

- (id)init;
-(void) addItem: (KCItem *) item;
-(void) deleteItemWithIndext: (NSInteger) index;
-(void) resetList;

@end
