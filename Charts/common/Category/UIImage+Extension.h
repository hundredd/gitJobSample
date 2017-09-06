//
//  UIImage+Extension.h
//  FaBo
//
//  Created by hxp on 15/7/31.
//  Copyright (c) 2015年 hxp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)resizedImage:(NSString *)name;


/**
 *  生成二维码
 *
 *  @param qrString 需要生成二维码的字符串
 *  @param size     图片大小
 *  @param red      red description
 *  @param green    green description
 *  @param blue     blue description
 *
 *  @return return value description
 */
+ (UIImage *)createQRWithString:(NSString *)qrString withSize:(CGFloat)size withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;



/**
 *  创建灰度图片
 *
 *  @param name name description
 *
 *  @return return value description
 */
+ (UIImage*)createGrayImageWithName:(NSString*)name;


- (UIImage *)grayImage;





@end
