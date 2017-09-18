//
//  PicTools.h
//  CompositePic
//
//  Created by hun on 2017/9/12.
//  Copyright © 2017年 hun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicTools : NSObject

+ (UIImage *)addImage:(UIImage *)image1
            andDetail:(NSString *)string
            andQRCode:(UIImage *)QRCodeImg;
@end
