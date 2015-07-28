//
//  KCCustomer.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCCustomer.h"

@implementation KCCustomer


-(id) initWithNetworkID:(NSString *)networkID andPassword:(NSString *)networkPassword andEmail:(NSString *)email andGUNumber:(NSString *)gunumber{
    self = [super init];
    if (self) {
        _elementKeys = [KCCustomer configElementsKey];
        
        _networkID = networkID;
        _networkPassword = networkPassword;
        _email = email;
        _guNumber = gunumber;
        
        _contentArray = [self configContentArray];
        _contentDictionary = [self configContentDictionary];
        
    }
    return self;
}

-(id) initWithContentArray:(NSArray *)contentArray{
    self = [super init];
    if(self) {
        _elementKeys = [KCCustomer configElementsKey];
        
        _contentArray = contentArray;
        _contentDictionary = [self configContentDictionary];
        
        _networkID = [_contentArray objectAtIndex:0];
        _networkPassword = [_contentArray objectAtIndex:1];
        _email = [_contentArray objectAtIndex:2];
        _guNumber = [_contentArray objectAtIndex:3];
        
    }
    return self;
}


-(id) initWithContentDictionary:(NSDictionary *)contentDictionary{
    self = [super init];
    if(self){
        _elementKeys = [KCCustomer configElementsKey];
        
        _contentDictionary = contentDictionary;
        
        _networkID = [_contentDictionary objectForKey:[_elementKeys objectAtIndex:0]];
        _networkPassword = [_contentDictionary objectForKey:[_elementKeys objectAtIndex:1]];
        _email = [_contentDictionary objectForKey:[_elementKeys objectAtIndex:2]];
        _guNumber = [_contentDictionary objectForKey:[_elementKeys objectAtIndex:3]];
        
        _contentArray = [self configContentArray];
    }
    return self;
}


-(NSArray *) configContentArray{
    NSMutableArray * tempContent = [[NSMutableArray alloc] init];
    [tempContent addObject: _networkID];
    [tempContent addObject: _networkPassword];
    [tempContent addObject: _email];
    [tempContent addObject: _guNumber];
    
    return tempContent;
}

-(NSDictionary *) configContentDictionary{
    NSDictionary * tempCotent = [[NSDictionary alloc]initWithObjects:_contentArray forKeys:_elementKeys];
    return tempCotent;
}

-(NSString *) createURL {
    NSMutableString * str = [[NSMutableString alloc]initWithString:@"?"];
    for(NSString * key in _elementKeys){
        
        NSString * value = [_contentDictionary objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        //value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"_"];
        value = [value stringByReplacingOccurrencesOfString:@"@" withString:@"_"];
        NSString *item = [[NSString alloc]initWithFormat:@"%@=%@&", key,value];
        [str appendString:item];
    }
    str = [[NSMutableString alloc]initWithString:[str substringToIndex:[str length] - 1]];
    return str;
}


+(NSArray *) configElementsKey{
    NSArray * keys = @[@"NetworkID", @"NetworkPassword",@"Email", @"GUNumber"];
    return keys;
}


@end
