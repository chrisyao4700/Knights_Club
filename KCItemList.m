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
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id) initWithDataArray:(NSArray *) dataArray{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] initWithArray:dataArray];
        _selectedItemArray = [[NSMutableArray alloc] init];
        for ( NSDictionary * itemDataDict in dataArray) {
            NSDictionary * dishDictionary = [itemDataDict objectForKey:@"SelectedDish"];
            KCDish * dish = [[KCDish alloc] initWithContentDictionary:dishDictionary];
            
            NSNumber * itemQuantity = [itemDataDict objectForKey:@"Quantity"];
            NSInteger itQuantity = itemQuantity.integerValue;
            
            KCItem * item = [[KCItem alloc] initWithDish:dish andQuantity:itQuantity  andRequirement:[itemDataDict objectForKey:@"Requirement"] andImageData:[itemDataDict objectForKey:@"Image_Data"]];
            [_selectedItemArray addObject:item.contentDictionary];
        }
        
    }
    return self;
}

-(void)addItem:(KCItem *)item{
    if (_selectedItemArray) {
        [_selectedItemArray addObject:item.contentDictionary];
        [_dataArray addObject:item.dataDictionary];
        
    }
}

-(void) deleteItemWithIndext:(NSInteger)index{
    if (_selectedItemArray) {
        [_selectedItemArray removeObjectAtIndex:(NSUInteger)index];
        [_dataArray removeObjectAtIndex:(NSUInteger)index];
    }
}
-(void) resetList{
    if (_selectedItemArray) {
        if (_selectedItemArray.count != 0) {
            [_selectedItemArray removeAllObjects];
            [_dataArray removeAllObjects];
        }
    }
}

@end
