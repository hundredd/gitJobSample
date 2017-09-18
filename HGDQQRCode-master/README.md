# HGDQQRCode
##iOS原生的二维码生成和读取图片中的二维码
效果：<br>
![](https://github.com/zhuming3834/HGDQQRCode/blob/master/Simulator%20Screen%20Shot%202016年3月9日%20下午3.43.38.png)<br>
以前写过一篇关于苹果原生的二维码和条形码扫描的博客[《【iOS】AVFoundation架构下的原生二维码和条形码扫描》](http://blog.csdn.net/zhuming3834/article/details/49126489)<br>
[代码地址](https://github.com/zhuming3834/AVFoundationEWM)
##生成二维码
1.首先在项目中加入两个文件
```OC
HGDQQRCodeView.h
HGDQQRCodeView.m
```
2.在需要使用的地方加入头文件
```OC
#import "HGDQQRCodeView.h"
```
3.调用生成二维码的方法
```OC
/**
 *  生成带logo的二维码
 *  二维码和logo都是正方形的
 *  @param urlString     二维码中的链接
 *  @param logoImage     二维码中的logo
 *  @param logoImageSize logo的大小
 *  @param cornerRadius  logo的圆角值大小
 *
 *  @return 生成的二维码
 */
+ (HGDQQRCodeView *)creatQRCodeWithURLString:(NSString *)urlString superView:(UIView *)superView logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize logoImageWithCornerRadius:(CGFloat)cornerRadius;
```
eg:
```OC
[HGDQQRCodeView creatQRCodeWithURLString:@"http://blog.csdn.net/zhuming3834" superView:self.QRView logoImage:[UIImage imageNamed:@"logo"] logoImageSize:CGSizeMake(40, 40) logoImageWithCornerRadius:0];
```
效果就是上面图片中生成的二维码。
生成不带logo的二维码时把参数logoImage传个nil就可以。
##读取图片中的二维码
读取图片中的二维码返回的是一个数组的集合，图片中有多少个识别出来的二维码数组里面就会有几个元素，每个元素是一个CIQRCodeFeature对象。
```OC
/**
 *  读取图片中的二维码
 *
 *  @param image 图片
 *
 *  @return 图片中的二维码数据集合 CIQRCodeFeature对象
 */
+ (NSArray *)readQRCodeFromImage:(UIImage *)image;
```
实际使用
在使用之前，使用可一个截屏的方法，截取屏幕，生成一个UIImage的对象作为参数传递给方法：
```OC
+ (NSArray *)readQRCodeFromImage:(UIImage *)image;
```
截屏方法的实现：
```OC
/**
 *  截图
 *
 *  @param view 需要截取的视图
 *
 *  @return 截图 图片
 */
+ (UIImage *)screenShotFormView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
```
最后就是显示识别出来二维码中的url链接
```OC
 // 截图
    UIImage *im = [HGDQQRCodeView screenShotFormView:self.view];
    // 读取图片中的二维码
    NSArray *array = [HGDQQRCodeView readQRCodeFromImage:im];
    // 显示二维码中的信息
    NSMutableString *str = [[NSMutableString alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CIQRCodeFeature *temp = (CIQRCodeFeature *)obj;
        [str appendFormat:@"地址:%@",temp.messageString];
    }];
```
关于iOS下原生的二维码的生成和识别可以看这两篇博客，里面有详细的说明。<br>
[《【iOS】CoreImage原生二维码生成（一）》](http://blog.csdn.net/zhuming3834/article/details/50832953)<br>
[《【iOS】CoreImage原生二维码生成（二）一个方法生成带logo的二维码》](http://blog.csdn.net/zhuming3834/article/details/50835659)<br>
[《【iOS】一个方法读取图片中的二维码信息》](http://blog.csdn.net/zhuming3834/article/details/50835808)<br>


