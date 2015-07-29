//
//  KCDish.m
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCDish.h"

@implementation KCDish
- (id)initWithName: (NSString *) dishName
          forPrice: (NSString *) dishPrice
    forDescription: (NSString *) dishDescription
      forCategoryt: (NSString *) dishCategory
{
    self = [super init];
    if (self) {
        _elementsKey = [KCDish getElementKey];
        
        _dishName = dishName;
        
        _dishPrice = dishPrice;
        _dishDescription = dishDescription;
        _dishCategory = dishCategory;
        
        _contentArray = [self configContentArray];
        _contentDictionary = [self configContentDictionary];
        
    }
    return self;
}
-(id)initWithContentArray:(NSArray *) contentArray{
    self = [super init];
    if(self){
        _elementsKey = [KCDish getElementKey];
        _contentArray = contentArray;
        _contentDictionary = [self configContentDictionary];
        
        //  _dishNumber = [contentArray objectAtIndex:0];
        _dishName= [contentArray objectAtIndex:0];
        _dishPrice = [contentArray objectAtIndex:1];
        _dishDescription = [contentArray objectAtIndex:2];
        _dishCategory = [contentArray objectAtIndex:3];
        
        
    }
    return self;
}
-(id) initWithContentDictionary:(NSDictionary *) contentDictionary{
    
    self = [super init];
    if (self) {
        _elementsKey = [KCDish getElementKey];
        _contentDictionary = contentDictionary;
        
        // _dishNumber = [contentDictionary objectForKey:[_elementsKey objectAtIndex:0]];
        _dishName = [contentDictionary objectForKey:[_elementsKey objectAtIndex:0]];
        _dishPrice = [contentDictionary objectForKey:[_elementsKey objectAtIndex:1]];
        _dishDescription = [contentDictionary objectForKey:[_elementsKey objectAtIndex:2]];
        
        NSString * value  = [[contentDictionary objectForKey:[_elementsKey objectAtIndex:3]] stringByReplacingOccurrencesOfString:@" " withString:@""];
        _dishCategory = value;
        
        
        _contentArray = [self configContentArray];
    }
    return self;
    
}


-(NSArray *) configContentArray{
    NSMutableArray * tempContent = [[NSMutableArray alloc]init];
    
    //[tempContent addObject: _dishNumber];
    [tempContent addObject: _dishName];
    [tempContent addObject: _dishPrice];
    [tempContent addObject: _dishDescription];
    [tempContent addObject: _dishCategory];
    
    
    return tempContent;
    
}
-(NSDictionary *) configContentDictionary{
    NSDictionary *tempContent = [[NSDictionary alloc]initWithObjects:_contentArray forKeys:_elementsKey];
    
    return tempContent;
}


+(NSArray *) getElementKey{
    NSArray * keys = @[ @"Dish_Name",@"Dish_Price",@"Dish_Description",@"Dish_Category"];
    return keys;
}

-(NSString *) createLinkURL{
    
    
    NSMutableString * str = [[NSMutableString alloc]initWithString:@"?"];
    for(NSString * key in _elementsKey){
        
        NSString * value = [_contentDictionary objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
        value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *item = [[NSString alloc]initWithFormat:@"%@=%@&", key,value];
        [str appendString:item];
    }
    str = [[NSMutableString alloc]initWithString:[str substringToIndex:[str length] - 1]];
    return str;
    
}

@end
