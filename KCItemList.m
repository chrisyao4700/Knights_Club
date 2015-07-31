//
//  KCItemList.m
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCItemList.h"

@implementation KCItemList

- (id)init
{
    self = [super init];
    if (self) {
        _selectedItemArray =[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addItem:(KCItem *)item{
    if (_selectedItemArray) {
        [_selectedItemArray addObject:item.contentDictionary];
    }
}

-(void) deleteItemWithIndext:(NSInteger *)index{
    if (_selectedItemArray) {
        [_selectedItemArray removeObjectAtIndex:(NSUInteger)index];
    }
}
-(void) resetList{
    if (_selectedItemArray) {
        if (_selectedItemArray.count != 0) {
            [_selectedItemArray removeAllObjects];
        }
    }
}

@end
