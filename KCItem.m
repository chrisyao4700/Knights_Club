//
//  KCItem.m
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCItem.h"

@implementation KCItem



-(id) initWithDish: (KCDish *) selectedDish
       andQuantity:(NSInteger) quantity
    andRequirement: (NSString *) requirement
andImageData:(NSData *)imageData{
    self = [super init];
    if (self) {
        _kc_selectedDish = selectedDish;
        _kc_quantity = [NSNumber numberWithInteger:quantity];
        _kc_requirement = requirement;
        _kc_imageData = imageData;
        
        _contentDictionary = [self configContentDictionary];
        
    }
    return self;
}
-(id) initWithDictionary: (NSDictionary *) dictionary{
    self = [super init];
    if (self) {
        _contentDictionary = dictionary;
        
        _kc_selectedDish = [dictionary objectForKey:@"SelectedDish"];
        _kc_quantity = [dictionary objectForKey:@"Quantity"];
        _kc_requirement = [dictionary objectForKey:@"Requirement"];
        _kc_imageData = [dictionary objectForKey:@"Image_Data"];
    }
    return self;
    
}

-(NSDictionary *) configContentDictionary{
    NSArray * keysArray = @[@"SelectedDish", @"Quantity",@"Requirement",@"Image_Data"];
    NSMutableArray * valueArray = [[NSMutableArray alloc] init];
    
    [valueArray addObject:_kc_selectedDish];
    [valueArray addObject:_kc_quantity];
    [valueArray addObject:_kc_requirement];
    [valueArray addObject:_kc_imageData];
    
    NSDictionary * tmp = [[NSDictionary alloc]initWithObjects:valueArray forKeys:keysArray];
    
    return tmp;
    
}

@end
