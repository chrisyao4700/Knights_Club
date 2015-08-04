//
//  KCOrder.h
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCItemList.h"
#import "KCCustomer.h"

@interface KCOrder : NSObject

@property NSArray * kc_order_itemList;
@property NSNumber * kc_order_tips;
@property NSString * kc_order_finalRequirement;
@property KCCustomer * kc_customer;



//Online Order Element.

@property NSString * kc_orderTitle;
@property NSString * kc_orderState;
@property NSString * kc_orderString;
@property NSString * kc_order_paymentType;
@property NSString * kc_order_paymentInfo;
@property NSString * kc_order_date;
@property NSString * kc_order_time;
@property NSString * kc_customer_name;
@property NSString * kc_menu_items;



@property NSDictionary * contentDictionary;
@property NSArray * onlineElementsKey;




+(NSArray *) configOnlineElementsKey;


-(id) initWithItemList:(NSArray *) itemList
          andOrderTips:(NSNumber *) orderTips
   andFinalRequirement:(NSString *) finalRequirement
        andPaymentType:(NSString *) paymentType
        andPaymentInfo:(NSString *) paymentInfo
           andCustomer: (KCCustomer *) customer;


-(id) initWithContentDictionary:(NSDictionary *) contentDictionary;

-(NSString *) createLinkURL;



@end
