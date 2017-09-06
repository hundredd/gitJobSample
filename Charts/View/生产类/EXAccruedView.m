//
//  EXAccruedView.m
//  Charts
//
//  Created by Eleven on 16/8/22.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXAccruedView.h"
#import "EXAddViewController.h"
#import "EXProductionViewController.h"
#import "EXAccruedTopItem.h"
#import "EXAccruedRightTableViewCell.h"
#import "EXAccruedData.h"
@interface EXAccruedView ()<UIScrollViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLeft;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewRight;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) UIView *topAddView;
@property (weak, nonatomic) UIView *topItemView;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger removeIndex;
@property (nonatomic, strong) NSArray *accruedDataArray;
@property (nonatomic, strong) NSMutableArray *accruedDataMutableArray;
@property (nonatomic, weak) UITableView *tableView;
/**
 *  添加的站点
 */

@property (nonatomic, strong) NSMutableArray *addStationNameArray;
@property (nonatomic, strong) NSMutableArray *addStationIdArray;
#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;
@end
@implementation EXAccruedView

static NSString *cellReuse_1 = @"cellReuse_1";
- (void)awakeFromNib{
    self.scrollViewTop.delegate = self;
    self.scrollViewLeft.delegate = self;
    self.scrollViewRight.delegate = self;
    self.count = 0;
    _X = 0;
    _Y = 0;
    self.addStationNameArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.addStationIdArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.accruedDataMutableArray = [[NSMutableArray alloc] initWithCapacity:5];
    //上部视图
    UIView *topAddView = [[[NSBundle mainBundle] loadNibNamed:@"EXAccruedTop" owner:nil options:nil] firstObject];
    topAddView.frame = CGRectMake(0, 0, 160, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
    [self.scrollViewTop addSubview:topAddView];
    self.topAddView = topAddView;
    topAddView.tag = 1000;
    //左部视图
    UIView *leftView = [[[NSBundle mainBundle] loadNibNamed:@"EXAccruedLeft" owner:nil options:nil] firstObject];
    [self.scrollViewLeft addSubview:leftView];
    leftView.frame = CGRectMake(0, 0, kScreenWidth * 4 / 15, leftView.frame.size.height);
    self.scrollViewLeft.contentSize = CGSizeMake(0, leftView.frame.size.height);
    
    //时间选择器
    self.timeTextField.delegate = self;
    UIDatePicker *dateInputView = [[UIDatePicker alloc] init];
    dateInputView.datePickerMode = UIDatePickerModeDate;
    dateInputView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.timeTextField.inputView = dateInputView;
    self.timeTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.datePickerView = dateInputView;
    
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.timeTextField.text = dateString;
    self.scrollViewLeft.directionalLockEnabled = YES;
    self.scrollViewRight.directionalLockEnabled = YES;
    self.scrollViewTop.directionalLockEnabled = YES;
}


- (IBAction)toolbarCancle:(id)sender {
    [self.timeTextField resignFirstResponder];
}

- (IBAction)toolbarOK:(id)sender {
    NSDate *date = self.datePickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if (dateString != self.timeTextField.text) {
        self.timeTextField.text = dateString;
        if (self.stationDic != nil) {
            [self getDetailData];
        }
    }
    
    [self.timeTextField resignFirstResponder];
}


- (IBAction)accruedAddAction:(UIButton *)sender{

    EXAddViewController *addVC = [[UIStoryboard storyboardWithName:@"Add" bundle:nil] instantiateInitialViewController];
    [addVC feedbackData:^(NSDictionary *dic) {
        self.stationDic = dic;
        if (self.stationDic != nil) {
            NSString *stationName = self.stationDic[@"stationName"];
            [self.addStationNameArray addObject:stationName];
            [self.addStationIdArray addObject:self.stationDic[@"stationId"]];
            NSLog(@">>>>>>>>%@", self.stationDic);
        }
    }];
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            [(UIViewController *)nextResponder showViewController:addVC sender:nil];
            return ;
        }
    }
}

- (IBAction)accruedRemoveAction:(UIButton *)sender{
   
    for (int i = 0; i < self.count; i++) {
        if (sender.superview.tag == i) {
            self.removeIndex = i;
        }
    }
    [self removeViewAction];
    
}


- (void)removeViewAction{
    for (UIView *topItemView in self.scrollViewTop.subviews) {
        if (topItemView.tag == self.removeIndex) {
            [topItemView removeFromSuperview];
            for (UIView *topItemView in self.scrollViewTop.subviews) {
                if (topItemView.tag > self.removeIndex) {
                    topItemView.frame = CGRectMake((topItemView.tag - 1) * 160, 0, 160, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
                    topItemView.tag--;
                    self.topItemView = topItemView;
                }

            }
            
            if (self.addStationNameArray.count > 0) {
                [self.addStationNameArray removeObjectAtIndex:self.removeIndex];
                [self.addStationIdArray removeObjectAtIndex:self.removeIndex];
            }
            break;
        }
        
    }
    for (UITableView *tableView in self.scrollViewRight.subviews) {
        if (tableView.tag == self.removeIndex) {
            [tableView removeFromSuperview];
            for (UITableView *tableView in self.scrollViewRight.subviews) {
                if (tableView.tag > self.removeIndex) {
                    tableView.frame = CGRectMake(160 * (tableView.tag - 1), 0, 160, 829);
                    tableView.tag--;
                    self.tableView = tableView;
                }

            }
            break;
        }
       
    }
    self.count--;
    self.topAddView.frame = CGRectMake((self.count) * 160, 0, 160, (kScreenHeight - 64 - kScreenHeight * 1/ 15) / 11 + 1);
}

- (void)changeViewAction{
    
        [self getDetailData];
        //添加右边视图
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(160 * self.count, 0, 160, 829) style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:@"EXAccruedRightTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuse_1];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.userInteractionEnabled = NO;
        tableView.scrollEnabled = NO;
        tableView.tag = self.count;
        self.tableView = tableView;
        [self.scrollViewRight addSubview:tableView];
        self.scrollViewRight.contentSize = CGSizeMake(160 * (self.count + 1), 829);
        
        //添加上部视图
        EXAccruedTopItem *topItemView = [[[NSBundle mainBundle] loadNibNamed:@"EXAccruedTop" owner:nil options:nil] lastObject];
        topItemView.stationNameLabel.text = self.addStationNameArray[self.count];
        topItemView.tag = self.count;
        topItemView.frame = CGRectMake(topItemView.tag * 160, 0, 160, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
        self.topItemView = topItemView;
        [self.scrollViewTop addSubview:topItemView];
        self.topAddView.frame = CGRectMake((self.count + 1)* 160, 0, 160, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
        self.scrollViewTop.contentSize = CGSizeMake((self.count + 2) * 160, 0);
        self.count ++;
}

- (void)getDetailData{
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/AcceptPayable/GetAcceptPayableData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    //    request.HTTPBody = [@"UserId=387441b0-177e-4e67-8f9d-c2d0cf194300&AccessToken=Mzg3NDQxYjAtMTc3ZS00ZTY3LThmOWQtYzJkMGNmMTk0MzAwJDIwMTYvOC8zMSAxNjoyNzo1NA==&stationId=" dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&SelectDate=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, [self.addStationIdArray lastObject], self.timeTextField.text] dataUsingEncoding:NSUTF8StringEncoding];
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        id result = dict[@"AppendData"];
        NSMutableArray *tempDataArray = [[NSMutableArray alloc] initWithCapacity:5];
        [self.accruedDataMutableArray removeAllObjects];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *temArray = dict[@"AppendData"];
            for (NSDictionary *temDic in temArray) {
                EXAccruedData *accruedData = [EXAccruedData mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:accruedData];
            }
        }
//        self.accruedDataArray = [tempDataArray copy];
        [self.accruedDataMutableArray addObject:[tempDataArray lastObject]];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
    
}

#pragma mark -- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EXAccruedRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse_1];
    cell.accruedData = [self.accruedDataMutableArray lastObject];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 829;
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollViewRight) {
        self.X = scrollView.contentOffset.x;
        self.Y = scrollView.contentOffset.y;
        self.scrollViewLeft.contentOffset = CGPointMake(self.scrollViewLeft.contentOffset.x, self.Y);
        self.scrollViewTop.contentOffset =  CGPointMake(self.X, self.scrollViewTop.contentOffset.y);
    }
    if (scrollView == self.scrollViewTop) {
        self.X = scrollView.contentOffset.x;
        self.scrollViewRight.contentOffset = CGPointMake(self.X, self.Y);
    }
    if (scrollView == self.scrollViewLeft) {
        self.Y = scrollView.contentOffset.y;
        self.scrollViewRight.contentOffset = CGPointMake(self.X, self.Y);
    }
}

@end
