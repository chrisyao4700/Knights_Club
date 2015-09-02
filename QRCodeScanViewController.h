//
//  QRCodeScanViewController.h
//  The Knights Club
//
//  Created by 姚远 on 8/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanOrderProtocol.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property id <ScanOrderProtocol> selectOrderDelegate;

@end