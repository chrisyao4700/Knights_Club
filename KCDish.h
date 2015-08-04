//
//  KCDish.h
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCDish : NSObject
@property NSString * dishName;
@property NSString * dishPrice;
@property NSString * dishDescription;
@property NSString * dishCategory;

@property NSDictionary * contentDictionary;
@property NSArray * contentArray;
@property NSArray * elementsKey;

- (id)initWithName: (NSString *) dishName
          forPrice: (NSString *) dishPrice
    forDescription: (NSString *) dishDescription
      forCategoryt: (NSString *) dishCategory;

-(id)initWithContentDictionary:(NSDictionary *) contentDictionary;
-(id)initWithContentArray:(NSArray *) contentArray;
+(NSArray *) getElementKey;
-(NSString *) createLinkURL;

@end
