//
//  PicTools.m
//  CompositePic
//
//  Created by hun on 2017/9/12.
//  Copyright © 2017年 hun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PicTools.h"

@implementation PicTools


+ (UIImage *)addImage:(UIImage *)image1
             andDetail:(NSString *)string
             andQRCode:(UIImage *)QRCodeImg
{
    UIGraphicsBeginImageContext(image1.size);
    
    CGSize backImgSize = (CGSize){[uis],image1.size.height};
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0,backImgSize.width,backImgSize.height)];
    
    
    
    CGFloat QCHW = 50;
    CGFloat magin = 10;
    //底部的高度
    CGFloat bottonMinH = backImgSize.height-QCHW-magin;
    // Draw image2
    [QRCodeImg drawInRect:CGRectMake(backImgSize.width-QCHW-magin, backImgSize.height-QCHW-magin, QCHW, QCHW)];
    
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor] };
    CGSize textSize = (CGSize){backImgSize.width-QCHW,QCHW};
    //位置显示
    [string drawInRect:CGRectMake(magin, bottonMinH, textSize.width, textSize.height) withAttributes:attr];

    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)wipeView:(UIView *)view
                point:(CGPoint)point
                 size:(CGSize)size {
    //开启图形上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //渲染
    [view.layer renderInContext:ctx];
    //计算擦除的rect
    CGFloat clipX = point.x - size.width/2;
    CGFloat clipY = point.y - size.height/2;
    CGRect clipRect = CGRectMake(clipX, clipY, size.width, size.height);
    //将该区域设置为透明
    CGContextClearRect(ctx, clipRect);
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
