//
//  ZXView.h
//  折线图
//
//  Created by hundred on 2017/7/11.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartModel.h"

@interface LineChartView : UIView

@property(nonatomic,strong)LineChartModel *model ;//数据模型

@property(nonatomic,copy)NSString *topTitle ;//顶部图标
@property(nonatomic,copy)NSString *yRightTitle ;//右边y轴的名称
@property(nonatomic,copy)NSString *yLeftTitle ;//左边y轴的名称
@property(nonatomic,copy)NSString *xTitle ;//x轴的名称
@property (nonatomic, strong) NSArray<NSString *> *xDataArray;//x坐标 数据


@property(nonatomic,assign)NSNumber *leftAvg;       //左边平均值
@property(nonatomic,assign)NSNumber *rightAvg;      //右边平均值
@property (nonatomic, strong) NSArray<NSNumber *> *dataArray;           //折线上点对应的数据 (单条参照左边数据)
@property (nonatomic, strong) NSArray<NSNumber *> *dataRightArray;      //折线上点对应的数据 (单条参照右边数据)

//目前没做
@property (nonatomic, strong) NSArray<NSArray *> *mutiLeftDataArray;    //折线上点对应多条的数据(参考左边数据)
@property (nonatomic, strong) NSArray<NSArray *> *mutiRightDataArray;   //折线上点对应多条的数据(参考右边数据)

- (instancetype)initWithFrame:(CGRect)frame withColumCount:(int)columCount rowCount:(int)rowCount;

//重新绘图!
- (void)resetDrawWithAnimate:(BOOL)isAnimate;

//
//-(void)showDetailLineStyle;

@end
