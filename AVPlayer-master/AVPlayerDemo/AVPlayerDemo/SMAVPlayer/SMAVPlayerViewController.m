//
//  SMAVPlayerViewController.m
//  AVPlayerDemo
//
//  Created by Yx on 15/11/29.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "SMAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SMSliderBar.h"
#import "MBMessageTip.h"
#import "VedioModel.h"
#import "VedioHistory.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface SMAVPlayerViewController ()<SMSliderDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewHead;              //显示返回按钮View
@property (weak, nonatomic) IBOutlet UIView *viewLogin;             //加载view
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogin;   //加载image
@property (weak, nonatomic) IBOutlet UIView *viewAvPlayer;          //播放视图
@property (weak, nonatomic) IBOutlet SMSliderBar *slider;           //进度条
@property (weak, nonatomic) IBOutlet UIView *viewBottom;            //底部控制view
@property (weak, nonatomic) IBOutlet UIButton *btnPause;            //暂停播放按钮
@property (weak, nonatomic) IBOutlet UIButton *btnNetx;             //下一个按钮
@property (weak, nonatomic) IBOutlet UILabel *labelTimeNow;         //当前时间label
@property (weak, nonatomic) IBOutlet UILabel *labelTimeTotal;       //总时间label
@property (strong, nonatomic) AVPlayer *player;                     //播放器对象
@property (strong, nonatomic) id timeObserver;                      //视频播放时间观察者
@property (assign, nonatomic) float totalTime;                      //视频总时长
@property (assign, nonatomic) BOOL isHasMovie;                      //是否进行过移动
@property (assign, nonatomic) BOOL isBottomViewHide;                //底部的view是否隐藏
@property (assign, nonatomic) NSInteger subscript;                  //数组下标，记录当前播放视频
@property (assign, nonatomic) NSInteger currentTime;                //当前视频播放时间位置
@end

@implementation SMAVPlayerViewController
@synthesize subscript;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.type = SMSliderTypeHoz;
    self.slider.progressBgColor = [UIColor whiteColor];
    self.slider.isAllowDrag = YES;
    self.slider.delegate=self;
    subscript = 0;
    self.currentTime = 0;
    [self prohibitOperation];
    [self setMediaPlayer];
    [self addPlayerClick];//双击,单击事件
    [self addProgressObserver];//进度监听
    [self addNotification];//广播监听播放状态
    [self setupObservers];//监听应用状态
    self.viewLogin.layer.cornerRadius = 8;
    self.imageViewLogin.layer.masksToBounds = YES;
    self.imageViewLogin.layer.cornerRadius = 34/2;
    splashTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(roteImageView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:splashTimer forMode:NSRunLoopCommonModes];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    //接受远程控制事件
    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [splashTimer invalidate];
}

- (void)setMediaPlayer{
    //创建播放器层
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = CGRectMake(0, 0, ScreenHeight ,ScreenWidth );
    [self.viewAvPlayer.layer addSublayer:playerLayer];
    [self.player seekToTime:CMTimeMakeWithSeconds(self.startTime, 1000)];//设置播放位置1000 为帧率
    [_player play];
}


#pragma mark - set/get
- (AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem = [self getPlayItem:subscript];
        [self addObserverToPlayerItem:playerItem];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
    }
    return _player;
}

- (AVPlayerItem *)getPlayItem:(NSUInteger)videoIndex{
    /*播放本地视频*/
    VedioModel *vedioModel = _arrVedio[videoIndex];
//    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"testav.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:vedioModel.strURL];
    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
    return playerItem;
    
    // 播放网络的!
    /*
    //NSString *urlStr= @"http://7xoour.com2.z0.glb.qiniucdn.com/9605401000";
    _currentTime = 0;
    [self savePayHistory];
    VedioModel *vedioModel = _arrVedio[videoIndex];
    NSString *urlStr =[vedioModel.strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    /*获取总帧数与帧率
     NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
     AVURLAsset *myAsset = [[AVURLAsset alloc] initWithURL:url options:opts];
     CMTimeValue  value = myAsset.duration.value;//总帧数
     CMTimeScale  timeScale =   myAsset.duration.timescale; //timescale为帧率  fps
     
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    return playerItem;
    */
}

#pragma mark - 通知
//给AVPlayerItem添加播放完成通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
}

// 播放完成通知
- (void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [self prohibitOperation];
    [self savePayHistory];
    [self nextClick:nil];
}

//注册通知
- (void)setupObservers
{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    [notification addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    if (self.player.rate == 0) {
        [self.player play];
        [self.btnPause setTitle:@"暂停" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if (self.player.rate == 1){
        [self.player pause];
        [self.btnPause setTitle:@"播放" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
    }
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - KVO
- (void)addProgressObserver{
    AVPlayerItem *playerItem = self.player.currentItem;
    //这里设置每秒执行一次
    __weak __typeof(self) weakself = self;
    self.timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
        NSLog(@"当前已经播放%f",current);
        weakself.currentTime = current;
        if (current) {
            [weakself setTime:current withTotal:total];
        }
    }];
}

/**
 *  给AVPlayerItem添加监控
 *  @param playerItem AVPlayerItem对象
 */
- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}
/**
 *  通过KVO监控播放器状态
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            self.totalTime = CMTimeGetSeconds(playerItem.duration);
            NSLog(@"开始播放,视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            [self.btnPause setTitle:@"暂停" forState:UIControlStateNormal];
             [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
            [_player play];
            [self.viewLogin setHidden:YES];
            [self clearProhibitOperation];
        }else if(status == AVPlayerStatusUnknown){
            NSLog(@"%@",@"AVPlayerStatusUnknown");
        }else if (status == AVPlayerStatusFailed){
            NSLog(@"%@",@"AVPlayerStatusFailed");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        if (self.currentTime < (startSeconds + durationSeconds + 8)) {
            self.viewLogin.hidden  = YES;
            if ([self.btnPause.titleLabel.text isEqualToString:@"暂停"]) {
                [_player play];
            }
        }else{
            self.viewLogin.hidden = NO;
        }
        self.slider.bufferValue = totalBuffer/self.totalTime;
        NSLog(@"缓冲：%.2f",totalBuffer);
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        NSLog(@"playbackBufferEmpty");
        [self.viewLogin setHidden:YES];
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        [self.viewLogin setHidden:NO];
        NSLog(@"playbackLikelyToKeepUp");
    }
}

#pragma mark - 手势监听
- (void)addPlayerClick{
    //单机手势监听
    UITapGestureRecognizer * tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerSingleClick:)];
    tapGes.numberOfTapsRequired=1;
    [self.viewAvPlayer addGestureRecognizer:tapGes];
    /*
    //双击手势监听
    UITapGestureRecognizer * tapGesDouble=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerDoubleTap:)];
    tapGesDouble.numberOfTapsRequired=2;
    [self.viewAvPlayer addGestureRecognizer:tapGesDouble];
    //双击手势确定监测失败才会触发单击手势的相应操作
    [tapGes requireGestureRecognizerToFail:tapGesDouble];*/
}

//显示或隐藏控制view
- (void)playerSingleClick:(UITapGestureRecognizer*)recognizer{
    if (self.isBottomViewHide) {
        //显示
        [UIView animateWithDuration:0.3 animations:^{
            [self.viewBottom setAlpha:1];
            [self.viewHead setAlpha:1];
        }];
    }else{
        //隐藏
        [UIView animateWithDuration:0.3 animations:^{
            [self.viewBottom setAlpha:0.0];
            [self.viewHead setAlpha:0.0];
        }];
    }
    self.isBottomViewHide=!self.isBottomViewHide;
}

//改变播放模式
- (void)playerDoubleTap:(UITapGestureRecognizer*)recognizer{
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    if ([playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]) {
        playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    }else if ([playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspectFill]){
        playerLayer.videoGravity=AVLayerVideoGravityResize;
    }else if ([playerLayer.videoGravity isEqualToString:AVLayerVideoGravityResize]){
        playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
    }
}

#pragma mark - smSliderDelegate
- (void)SMSliderBar:(UIView *)slider valueChanged:(float)value{
    self.isHasMovie = YES;
}

- (void)SMSliderBarBeginTouch:(UIView *)slider{
    [_player pause];
    self.isHasMovie = NO;
}

- (void)SMSliderBarEndTouch:(UIView *)slider{
    if (self.isHasMovie) {
        [_player seekToTime:CMTimeMakeWithSeconds(self.totalTime*self.slider.value, _player.currentItem.duration.timescale)completionHandler:^(BOOL finished) {
            if (finished) {
                [_player play];
            }
        }];
    }
}


#pragma mark - IBAction

- (IBAction)pauseClick:(id)sender {
    if (_player.rate == 0) {
        [_player play];
        [self.btnPause setTitle:@"暂停" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
    }else{
        [_player pause];
        [self.btnPause setTitle:@"播放" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)nextClick:(id)sender {
    ++subscript;
    self.labelTimeNow.text = @"00:00:00";
    self.labelTimeTotal.text = @"00:00:00";
    self.slider.value = 0;
    if (subscript < self.arrVedio.count) {
        [self.player seekToTime:CMTimeMakeWithSeconds(0, _player.currentItem.duration.timescale)];
        [self removeNotification];
        [self removeObserverFromPlayerItem:self.player.currentItem];
        [self.player removeTimeObserver:self.timeObserver];
         [_player replaceCurrentItemWithPlayerItem:[self getPlayItem:subscript]];
        [self addObserverToPlayerItem:self.player.currentItem];
        [self addNotification];
        [self addProgressObserver];
        if (self.player.rate == 0 ) {
            [self.player play];
        }
    }else{
        --subscript;
        /*
         [self.player.currentItem cancelPendingSeeks];
         [self.player.currentItem.asset cancelLoading];
         */
        [self.btnPause setTitle:@"播放" forState:UIControlStateNormal];
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
        self.labelTimeTotal.text = @"00:00:00";
        self.labelTimeNow.text = @"00:00:00";
        [MBMessageTip messageWithTip:self.view withMessage:@"没有更多了" ];
    }
}

- (IBAction)backAction:(id)sender {
    [self savePayHistory];
    [self.player pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - interface rotation

//横屏
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSString *frameString = NSStringFromCGRect(self.viewAvPlayer.frame);
    
    NSLog(@"视频窗口的frame:%@",frameString);
}

#pragma mark - 私有方法
//设置播放时长
- (void)setTime:(float)current withTotal:(float)total{
    self.slider.value = current/total;
    self.labelTimeNow.text = [self displayTime:(int)current];
    self.labelTimeTotal.text = [self displayTime:(int)total];
}

- (NSString*)displayTime:(int)timeInterval{
    NSString * time = @"";
    int seconds = timeInterval % 60;
    int minutes = (timeInterval / 60) % 60;
    int hours = timeInterval / 3600;
    NSString * secondsStr=seconds<10?[NSString stringWithFormat:@"%@%d",@"0",seconds]:[NSString stringWithFormat:@"%d",seconds];
    NSString * minutesStr=minutes<10?[NSString stringWithFormat:@"%@%d",@"0",minutes]:[NSString stringWithFormat:@"%d",minutes];
    NSString * hoursStr=hours<10?[NSString stringWithFormat:@"%@%d",@"0",hours]:[NSString stringWithFormat:@"%d",hours];
    time = [NSString stringWithFormat:@"%@%@%@%@%@",hoursStr,@":",minutesStr,@":",secondsStr];
    return time;
}

//视频加载指示条
- (void)roteImageView{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.duration = 1;
    [self.imageViewLogin.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//保存播放历史
- (void)savePayHistory{
    NSDate *currentDate = [NSDate date];//获取当前时间,日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    VedioModel *vedioModel = _arrVedio[subscript];
    VedioHistory *vedioHistory = [[VedioHistory alloc] init];
    [vedioHistory insertTitle:vedioModel.strTitle createTime:dateString userId:[NSNumber numberWithInt:[vedioModel.strUserID intValue]] videoType:[NSNumber numberWithInt:vedioModel.vedioType]  playTime:[NSNumber numberWithInteger:self.currentTime] videoUrl:vedioModel.strURL picUrl:vedioModel.strImage];
}

//视频未播放时禁止点击
- (void)prohibitOperation{
    self.btnNetx.enabled = NO;
    self.btnPause.enabled = NO;
    self.slider.isAllowDrag = NO;
}

//视频播放时取消禁止点击
- (void)clearProhibitOperation{
    self.btnNetx.enabled = YES;
    self.btnPause.enabled = YES;
    self.slider.isAllowDrag = YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [self.player removeTimeObserver:self.timeObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
