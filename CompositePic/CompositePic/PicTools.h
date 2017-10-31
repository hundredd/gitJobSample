//
//  PicTools.h
//  CompositePic
//
//  Created by hun on 2017/9/12.
//  Copyright © 2017年 hun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicTools : NSObject

/**
 合成图片

 @param image1 背景图
 @param headImg 头像
 @param name 名称
 @param subtitle 副标题
 @param telStr 电话
 @param QRCodeImg 二维码
 @return 返回图片!
 */
+ (UIImage *)addImage:(UIImage *)image1
           addHeadImg:(UIImage *)headImg
              andName:(NSString *)name
          andSubtitle:(NSString *)subtitle
               andTel:(NSString *)telStr
            andQRCode:(UIImage *)QRCodeImg;
@end
