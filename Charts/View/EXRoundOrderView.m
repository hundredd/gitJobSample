//
//  EXRoundOrderView.m
//  Charts
//
//  Created by Eleven on 16/7/28.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXRoundOrderView.h"

@implementation EXRoundOrderView
{
    NSTimer *_timer;//减速定时器
    CGFloat _numOfSubView;//子视图数量
    UIImageView *_circleView;//圆形图
    NSMutableArray *_subViewArray;//子视图数组
    CGPoint beginPoint;//第一触碰点
    CGPoint movePoint;//第二触碰点
    BOOL _isPlaying;//正在跑
    NSDate * date;//滑动时间
    
    NSDate *startTouchDate;
    NSInteger _decelerTime;//减速计数
    CGSize _subViewSize;//子试图大小
    UIPanGestureRecognizer *_pgr;
    
    double mStartAngle;   //转动的角度
    int mFlingableValue;   //转动临界速度，超过此速度便是快速滑动，手指离开仍会转动
    int mRadius;  //半径
    NSMutableArray *btnArray;
    float mTmpAngle;   //检测按下到抬起时旋转的角度
    
}
-(void)dealloc
{
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
}
-(id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    if(self=[super initWithFrame:frame]){
        _decelerTime=0;
        _subViewArray=[[NSMutableArray alloc] init];
        _circleView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if(image==nil){
            _circleView.backgroundColor=[UIColor redColor];
            _circleView.layer.cornerRadius=frame.size.width/2;
        }else{
            _circleView.image=image;
            _circleView.backgroundColor=[UIColor clearColor];
        }
        mRadius =frame.size.width/2;
        mStartAngle = 100;
        mFlingableValue = 300;
        _isPlaying = false;
        _circleView.userInteractionEnabled=YES;
        [self addSubview:_circleView];
    }
    return self;
}
#pragma mark -  加子视图
-(void)addSubViewWithSubView:(NSArray *)imageArray andTitle:(NSArray *)titleArray andSize:(CGSize)size andcenterImage:(UIImage *)centerImage
{
    _subViewSize=size;
    //    if(titleArray.count==0){
    //        _numOfSubView=(CGFloat)imageArray.count;
    //    }
    //    if(imageArray.count==0){
    //        _numOfSubView=(CGFloat)titleArray.count;
    //    }
    _numOfSubView=(CGFloat)imageArray.count;
    btnArray = [[NSMutableArray alloc]init];
    for(NSInteger i=0; i<_numOfSubView ;i++){
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        if(imageArray==nil){
            button.backgroundColor=[UIColor clearColor];
            button.layer.cornerRadius=size.width/2;
        }else{
            button.backgroundColor=[UIColor clearColor];
//            button.layer.cornerRadius=size.width/2;
            [button setImage:imageArray[i] forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(-10, 10, 0, -70);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -40, -80, 0);
        }
        button.titleLabel.font = [UIFont fontWithName:@"Semibold" size:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag=100+i;
        [btnArray addObject:button];
        [_subViewArray addObject:button];
        [_circleView addSubview:button];
    }
    [self layoutBtn];
    
    //中间视图
    UIButton *buttonCenter=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, self.frame.size.height/3.0)];
    buttonCenter.tag=100+_numOfSubView+1;
    if(centerImage==nil){
        buttonCenter.layer.cornerRadius=self.frame.size.width/6.0;
        buttonCenter.backgroundColor=[UIColor whiteColor];
        [buttonCenter setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [buttonCenter setTitle:@"" forState:UIControlStateNormal];
    }else{
        [buttonCenter setImage:centerImage forState:UIControlStateNormal];
    }
    buttonCenter.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [_subViewArray addObject:buttonCenter];
    [_circleView addSubview:buttonCenter];
    //加转动手势
    _pgr=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zhuanPgr:)];
    [_circleView addGestureRecognizer:_pgr];
    //加点击效果
    for (NSInteger i=0; i<_subViewArray.count; i++) {
        UIButton *button=_subViewArray[i];
        [button addTarget:self action:@selector(subViewOut:) forControlEvents:UIControlEventTouchUpInside];
    }
}


//按钮布局
-(void)layoutBtn{
    
    for (NSInteger i=0; i<_numOfSubView ;i++) {// 178,245
        CGFloat yy=self.frame.size.width * 1.8 / 4.0+sin((i/_numOfSubView)*M_PI*2+mStartAngle)*(self.frame.size.width/2-_subViewSize.width/2-20);
        CGFloat xx=self.frame.size.width * 1.8 / 4.0+cos((i/_numOfSubView)*M_PI*2+mStartAngle)*(self.frame.size.width/2-_subViewSize.width/2-20);
        UIButton *button=[btnArray objectAtIndex:i];
        button.center=CGPointMake(xx + 10, yy + 10);
    }
}

    NSTimer *flowtime;
    float anglePerSecond;
    float speed;  //转动速度

#pragma mark - 转动手势
-(void)zhuanPgr:(UIPanGestureRecognizer *)pgr
{
    //    UIView *view=pgr.view;
    if(pgr.state==UIGestureRecognizerStateBegan){
        mTmpAngle = 0;
        beginPoint=[pgr locationInView:self];
        startTouchDate=[NSDate date];
    }else if (pgr.state==UIGestureRecognizerStateChanged){
        float StartAngleLast = mStartAngle;
        movePoint= [pgr locationInView:self];
        float start = [self getAngle:beginPoint];   //获得起始弧度
        float end = [self getAngle:movePoint];     //结束弧度
        if ([self getQuadrant:movePoint] == 1 || [self getQuadrant:movePoint] == 4) {
            mStartAngle += end - start;
            mTmpAngle += end - start;
            //            NSLog(@"第一、四象限____%f",mStartAngle);
        } else
            // 二、三象限，色角度值是付值
        {
            mStartAngle += start - end;
            mTmpAngle += start - end;
            //            NSLog(@"第二、三象限____%f",mStartAngle);
            //             NSLog(@"mTmpAngle is %f",mTmpAngle);
        }
        [self layoutBtn];
        beginPoint=movePoint;
        speed = mStartAngle - StartAngleLast;
        NSLog(@"speed is %f",speed);
    }else if (pgr.state==UIGestureRecognizerStateEnded){
        // 计算，每秒移动的角度
        
        NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:startTouchDate];
        anglePerSecond = mTmpAngle*50/ time;
        NSLog(@"anglePerSecond is %f",anglePerSecond);
        // 如果达到该值认为是快速移动
        if (fabsf(anglePerSecond) > mFlingableValue && !_isPlaying) {
            // post一个任务，去自动滚动
            _isPlaying = true;
            flowtime = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                        target:self
                                                      selector:@selector(flowAction)
                                                      userInfo:nil
                                                       repeats:YES];
        }
    }
}

//获取当前点弧度

-(float)getAngle:(CGPoint)point {
    double x = point.x - mRadius;
    double y = point.y - mRadius;
    return (float) (asin(y / hypot(x, y)));
}

/**
 * 根据当前位置计算象限
 *
 * @param x
 * @param y
 * @return
 */
-(int) getQuadrant:(CGPoint) point {
    int tmpX = (int) (point.x - mRadius);
    int tmpY = (int) (point.y - mRadius);
    if (tmpX >= 0) {
        return tmpY >= 0 ? 1 : 4;
    } else {
        return tmpY >= 0 ? 2 : 3;
    }
}

-(void)flowAction{
    if (speed < 0.1) {
        _isPlaying = false;
        [flowtime invalidate];
        flowtime = nil;
        return;
    }
    // 不断改变mStartAngle，让其滚动，/30为了避免滚动太快
    mStartAngle += speed ;
    speed = speed/1.1;
    // 逐渐减小这个值
    //    anglePerSecond /= 1.1;
    [self layoutBtn];
}

-(void)subViewOut:(UIButton *)button
{
    //点击
    if(self.clickSomeOne){
        self.clickSomeOne([NSString stringWithFormat:@"%ld",(long)button.tag]);
    }
}



@end
