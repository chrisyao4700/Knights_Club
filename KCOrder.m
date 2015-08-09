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
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM:dd:yyyy"];
        _kc_order_date = [dateFormatter stringFromDate:[NSDate date]];
     
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        _kc_order_time = [timeFormatter stringFromDate:[NSDate date]];
      
       
        
        
          _kc_orderState= @"Waiting";
        _kc_order_paymentType = paymentType;
        _kc_order_paymentInfo = paymentInfo;
        
        
        _kc_orderString = [self configOrderString];
        _kc_orderTitle = [self configOrderTitle];
        _kc_customer_name = _kc_customer.networkID;
        
        
        _contentDictionary = [self configContentDictionary];
        _localDictionary = [self configLocalDictionary];
        
    }
    
    return self;
}

-(id)initWithContentDictionary:(NSDictionary *)contentDictionary{
    self = [super init];
    if (self) {
        _onlineElementsKey = [KCOrder configOnlineElementsKey];
        
        _contentDictionary = contentDictionary;
        
        _kc_orderTitle = [contentDictionary objectForKey:@"Title"];
        _kc_orderString = [contentDictionary objectForKey:@"Content"];
        _kc_orderState = [contentDictionary objectForKey:@"State"];
        _kc_order_paymentType = [contentDictionary objectForKey:@"Payment_Type"];
        _kc_order_paymentInfo = [contentDictionary objectForKey:@"Payment_Info"];
        _kc_order_date = [contentDictionary objectForKey:@"Date"];
        _kc_order_time = [contentDictionary objectForKey:@"Time"];
        _kc_customer_name = [contentDictionary objectForKey:@"Customer"];
        _kc_menu_items = [contentDictionary objectForKey:@"Menu_Items"];
    }
    
    return self;
}

+(NSArray *)configOnlineElementsKey{
    
    
    
    NSArray * keys = @[@"Title", @"Content", @"State", @"Payment_Type", @"Payment_Info", @"Date", @"Time", @"Customer", @"Menu_Items"];
    
    return keys;
    
}




-(NSString *) configOrderTitle{
    NSMutableString * titleStr = [[NSMutableString alloc] initWithString:@"KCORD"];
    NSString * date = [_kc_order_date stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString * time = [_kc_order_time stringByReplacingOccurrencesOfString:@" " withString:@""];
    date = [date stringByReplacingOccurrencesOfString:@":" withString:@""];
    time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    
    NSString * campusNumber = [_kc_customer guNumber];
    
    [titleStr appendFormat:@"%@%@%@",date,time,campusNumber];
    
    return titleStr;
    
}

-(id) initWithLocalDictionary:(NSDictionary *)localDictionary{
    self = [super init];
    if (self) {
        _localDictionary = localDictionary;
        
        _kc_orderTitle = [localDictionary objectForKey:@"Title"];
        _kc_order_itemList = [localDictionary objectForKey:@"ItemList"];
    }
    return self;
}

-(NSString *) configOrderString{
    NSMutableString * menuItemStr = [[NSMutableString alloc] init];
    NSMutableString * contentStr =[[NSMutableString alloc]initWithString:@"Payment Type:"];
    [contentStr appendFormat:@" %@.//",_kc_order_paymentType];
    float price = 0.0;
    int itemCount = 1;
    for (int i = 0;i<_kc_order_itemList.count;i++) {
        NSDictionary * itemDic = [_kc_order_itemList objectAtIndex:i];
        KCDish * dish = [[KCDish alloc] initWithContentDictionary:[itemDic objectForKey:@"SelectedDish"]];
        [menuItemStr appendFormat:@"%@,",dish.dishName];
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
        _kc_menu_items = [[NSString alloc]initWithString:[menuItemStr substringToIndex:[menuItemStr length] - 1]];
        
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
    //time = [time stringByReplacingOccurrencesOfString:@":" withString:@""];

    [contentStr appendFormat:@"Time: %@ %@/",date,time];
    [contentStr appendFormat:@"GU Card: %@", _kc_customer.guNumber];
    
  //  NSLog(@"%@", contentStr);
    return contentStr;
    
}

-(NSDictionary *) configLocalDictionary{
    NSMutableArray * values = [[NSMutableArray alloc] init];
    
    [values addObject:_kc_orderTitle];
    [values addObject:_kc_order_itemList];
    
    NSArray * keys = @[@"Title", @"ItemList"];
    
    NSDictionary * localDict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    return localDict;
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
    [valueArray addObject:_kc_customer_name];
    [valueArray addObject:_kc_menu_items];
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjects:valueArray forKeys:_onlineElementsKey];
    return dic;
    
}

-(NSString *) createLinkURL{
    
    
    NSMutableString * str = [[NSMutableString alloc]initWithString:@"?"];
    for(NSString * key in _onlineElementsKey){
        
        NSString * value = [_contentDictionary objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        NSString *item = [[NSString alloc]initWithFormat:@"%@=%@&", key,value];
        [str appendString:item];
    }
    str = [[NSMutableString alloc]initWithString:[str substringToIndex:[str length] - 1]];
    return str;
    
}



@end
