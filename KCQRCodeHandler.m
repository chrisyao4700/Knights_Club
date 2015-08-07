//
//  KCQRCodeHandler.m
//  The Knights Club
//
//  Created by 姚远 on 8/6/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "KCQRCodeHandler.h"

@implementation KCQRCodeHandler

+(UIImage *) generateQRCodeImageWithString:(NSString *) qrString{
    CIImage * inputImage = [KCQRCodeHandler createQRForString:qrString];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    return [UIImage imageWithCIImage:filter.outputImage];

}
+(CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // Send the image back
    return qrFilter.outputImage;
}



@end
