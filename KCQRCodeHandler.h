//
//  KCQRCodeHandler.h
//  The Knights Club
//
//  Created by 姚远 on 8/6/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KCQRCodeHandler : NSObject
+(UIImage *) generateQRCodeImageWithString:(NSString *) qrString;

@end
