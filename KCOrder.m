//
//  KCOrder.m
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCOrder.h"

@implementation KCOrder

-(id) initWithItemList:(NSArray *)itemList andOrderTips:(NSNumber *)orderTips andFinalRequirement:(NSString *)finalRequirement andPaymentType:(NSString *)paymentType andPaymentInfo:(NSString *)paymentInfo andCustomer: (KCCustomer *) customer{
    self =[super init];
    if (self) {
        _onlineElementsKey = [KCOrder configOnlineElementsKey];
        
        _kc_order_itemList = itemList;
        _kc_order_tips = orderTips;
        _kc_order_finalRequirement = finalRequirement;
        _kc_customer = customer;
        _kc_order_date = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                        dateStyle:NSDateFormatterShortStyle
                                                        timeStyle:NSDateFormatterNoStyle];
        _kc_order_time = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                        dateStyle:NSDateFormatterNoStyle
                                                        timeStyle:NSDateFormatterShortStyle];
        
          _kc_orderState= @"Unpayed";
        _kc_order_paymentType = paymentType;
        _kc_order_paymentInfo = paymentInfo;
        _kc_orderString = [self configOrderString];
        _kc_orderTitle = [self configOrderTitle];
      
        
        
        
        _contentDictionary = [self configContentDictionary];
        
    }
    
    return self;
}

-(id)initWithContentDictionary:(NSDictionary *)contentDictionary{
    return nil;
}



-(NSString *) configOrderTitle{
    NSMutableString * titleStr = [[NSMutableString alloc] initWithString:@"KCORD"];
    NSString * date = [_kc_order_date stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString * time = [_kc_order_time stringByReplacingOccurrencesOfString:@" " withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    
    NSString * campusNumber = [_kc_customer guNumber];
    
    [titleStr appendFormat:@"%@%@%@",date,time,campusNumber];
    
    return titleStr;
    
}

-(NSString *) configOrderString{
    NSMutableString * contentStr =[[NSMutableString alloc]initWithString:@"Payment Type:"];
    [contentStr appendFormat:@" %@.//",_kc_order_paymentType];
    float price = 0.0;
    int itemCount = 1;
    for (int i = 0;i<_kc_order_itemList.count;i++) {
        NSDictionary * itemDic = [_kc_order_itemList objectAtIndex:i];
        KCDish * dish = [[KCDish alloc] initWithContentDictionary:[itemDic objectForKey:@"SelectedDish"]];
        NSNumber* quantity = [itemDic objectForKey:@"Quantity"];
        NSString * requirement = [itemDic objectForKey:@"Requirement"];
        float quan_int = quantity.floatValue;
        
//        NSString * testDishStr = dish.dishPrice;
//        NSLog(@"%@",testDishStr);
        
       // float testDish = dish.dishPrice.floatValue;
        
        float itemprice = dish.dishPrice.floatValue * quan_int;
        [contentStr appendFormat:@"Item%d: %@/Quantity:%@/Subtotal:$%.2f/Requirement: %@//", itemCount, dish.dishName,quantity, itemprice, requirement];
        price += itemprice;
        itemCount ++;
        
    }
    [contentStr appendFormat:@"Order: $%.2f/", price];
    float tax = price * 0.06;
    [contentStr appendFormat:@"Tax: $%.2f/", tax];
    [contentStr appendFormat:@"Tips: $%.2f/", _kc_order_tips.floatValue];
    price += _kc_order_tips.floatValue;
    price += tax;
    [contentStr appendFormat:@"Total: $%.2f/", price];
    [contentStr appendFormat:@"Final Requirement: %@/", _kc_order_finalRequirement];
    NSString * date = [_kc_order_date stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString * time = [_kc_order_time stringByReplacingOccurrencesOfString:@" " withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];

    [contentStr appendFormat:@"Time: %@ %@/",date,time];
    [contentStr appendFormat:@"GU Card: %@", _kc_customer.guNumber];
    
  //  NSLog(@"%@", contentStr);
    return contentStr;
    
}

+(NSArray *)configOnlineElementsKey{
    

    
    NSArray * keys = @[@"Title", @"Content", @"State", @"Payment_Type", @"Payment_Info", @"Date", @"Time"];
    
    return keys;
    
}

-(NSDictionary *) configContentDictionary {
    NSMutableArray * valueArray = [[NSMutableArray alloc] init];
    [valueArray addObject:_kc_orderTitle];
    [valueArray addObject:_kc_orderString];
    [valueArray addObject:_kc_orderState];
    [valueArray addObject:_kc_order_paymentType];
    [valueArray addObject:_kc_order_paymentInfo];
    [valueArray addObject:_kc_order_date];
    [valueArray addObject:_kc_order_time];
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjects:valueArray forKeys:_onlineElementsKey];
    return dic;
    
}

-(NSString *) createLinkURL{
    
    
    NSMutableString * str = [[NSMutableString alloc]initWithString:@"?"];
    for(NSString * key in _onlineElementsKey){
        
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
