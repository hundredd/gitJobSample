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
           addHeadImg:(UIImage *)headImg
             andName:(NSString *)name
          andSubtitle:(NSString *)subtitle
            andTel:(NSString *)telStr
             andQRCode:(UIImage *)QRCodeImg
{
    UIGraphicsBeginImageContext(image1.size);
    
    CGSize backImgSize = (CGSize){image1.size.width,image1.size.height};
    CGRect imgRect = CGRectMake(0, 0,backImgSize.width,backImgSize.height);
    // Draw image1
    [image1 drawInRect:imgRect];
    
    
    CGFloat QCHW = 50;
    CGFloat magin = 10;
    CGFloat sMagin = 5;
    // ---- 二维码部分
    //底部的高度
    CGFloat bottonMinH = backImgSize.height-QCHW-magin;
    // Draw image2
    [QRCodeImg drawInRect:CGRectMake(backImgSize.width-QCHW-magin, backImgSize.height-QCHW-magin, QCHW, QCHW)];
    
    
    // ---- 二维码部分 个人部分
    // -- 个人头像部分
    CGRect headImgRect = CGRectMake(magin,backImgSize.height-QCHW-magin,QCHW,QCHW);
    //剪切圆倒角
    [[self circleImageWithImage:headImg andRect:headImgRect]  drawInRect:headImgRect];
    
    // -- 个人名字
    NSDictionary *nameAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor blackColor] };
    CGFloat nameLeft = headImgRect.origin.x+headImgRect.size.width+magin;
    CGSize nameSize = [name sizeWithAttributes:nameAttr];
    //位置显示
    [name drawInRect:CGRectMake(nameLeft,
                                headImgRect.origin.y,
                                nameSize.width, nameSize.height) withAttributes:nameAttr];

    // -- 个人职业
    NSDictionary *subAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor] };
    CGSize subSize = [subtitle sizeWithAttributes:subAttr];
    CGFloat subLeft = nameLeft+nameSize.width+sMagin;
    //位置显示
    [subtitle drawInRect:CGRectMake(subLeft, headImgRect.origin.y, subSize.width, subSize.height) withAttributes:subAttr];
    
    // -- 个人电话Icon
    CGFloat iconWH = 10;
    // -- 个人头像部分
    CGRect iconImgRect = CGRectMake(nameLeft,headImgRect.origin.y+nameSize.height+magin,iconWH,iconWH);
    //剪切圆倒角
    [[self circleImageWithImage:headImg andRect:iconImgRect]  drawInRect:iconImgRect];
    
    // -- 个人电话
    NSDictionary *telAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor blackColor] };
    CGSize telSize = [telStr sizeWithAttributes:telAttr];
    CGFloat telLeft = iconImgRect.origin.x+iconImgRect.size.width+sMagin;
    //位置显示
    [telStr drawInRect:CGRectMake(telLeft, iconImgRect.origin.y, telSize.width, telSize.height) withAttributes:telAttr];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

//圆倒角!
+ (UIImage *)circleImageWithImage:(UIImage *)imageO andRect:(CGRect)rects
{
    UIGraphicsBeginImageContext(rects.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, rects.size.width, rects.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [imageO drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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

- (UIImage *)convertViewToImage:(UIView *)view
{
    //https://github.com/alskipp/ASScreenRecorder 录屏代码
    // 第二个参数表示是否非透明。如果需要显示半透明效果，需传NO，否则YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,[UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
