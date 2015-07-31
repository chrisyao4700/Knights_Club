//
//  KCItem.h
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCDish.h"

@interface KCItem : NSObject
@property KCDish * kc_selectedDish;
@property NSData * kc_imageData;
@property NSNumber * kc_quantity;
@property NSString * kc_requirement;
@property NSDictionary * contentDictionary;

-(id) initWithDish: (KCDish *) selectedDish
       andQuantity:(NSInteger) quantity
    andRequirement: (NSString *) requirement
      andImageData: (NSData *) imageData;

-(id) initWithDictionary: (NSDictionary *) dictionary;
@end
