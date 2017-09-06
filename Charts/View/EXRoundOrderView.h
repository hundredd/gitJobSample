//
//  EXRoundOrderView.h
//  Charts
//
//  Created by Eleven on 16/7/28.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXRoundOrderView : UIView
//根据子试图数量 圆形盘的图片 初始化
-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
//加子视图 图片 文字 大小
-(void)addSubViewWithSubView:(NSArray *)imageArray andTitle:(NSArray *)titleArray andSize:(CGSize)size andcenterImage:(UIImage *)centerImage;
@property (nonatomic,strong)void(^clickSomeOne)(NSString *);
@end
