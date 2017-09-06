//
//  EXProductionData.m
//  Charts
//
//  Created by Eleven on 16/8/15.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXProductionData.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "EXProduction.h"
#import "EXProductionDataRightTableViewCell.h"
#import "EXHeaderView.h"
#import <MJRefresh.h>
@interface EXProductionData () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *dayCumulativeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthCumulativeLabel;
@property (weak, nonatomic) IBOutlet UITextField *beginDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) UITableView *productionDataTableView;
@property (nonatomic, copy) NSString *NumberDay;
@property (nonatomic, copy) NSString *NumberMonth;
/**
 *  请求页数
 */
@property (assign, nonatomic) NSInteger page;
/**
 *  每组数据的第一条
 */
@property (nonatomic, strong) NSDictionary *constantDic;
/**
 *  存储返回的数据
 */
@property (nonatomic, strong) NSArray *dataArray;
/**
 *  用于存储站点名
 */
@property (nonatomic, strong) NSArray *stationNames;
/**
 *  用于存储站点id
 */
@property (nonatomic, strong) NSArray *stationIds;

#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;
@end

@implementation EXProductionData

static NSString *cellId = @"reuseCell";

- (void)awakeFromNib{
    //创建每个section里第一条固定数据的字典
    self.constantDic = @{@"ProjectName" : @"工程名称", @"UnitName" : @"施工单位", @"ParticularPart" : @"施工部位", @"PlyPlan" : @"浇筑方式", @"ProductGrade" : @"强度等级", @"vehicleno" : @"车次", @"Number" : @"方量", @"ConMan" : @"客服", @"ConTel" : @"客服电话"};
    self.scrollView.delegate = self;
    self.scrollView.directionalLockEnabled = YES;
    //时间选择器
    self.beginDateTextField.delegate = self;
    self.endDateTextField.delegate = self;
    UIDatePicker *dateInputView = [[UIDatePicker alloc] init];
    dateInputView.datePickerMode = UIDatePickerModeDate;
    dateInputView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.beginDateTextField.inputView = dateInputView;
    self.endDateTextField.inputView = dateInputView;
    self.beginDateTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.endDateTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.datePickerView = dateInputView;
    
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.beginDateTextField.text = dateString;
    self.endDateTextField.text = dateString;
    
    //创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1110, 800) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.userInteractionEnabled = NO;
    [tableView registerNib:[UINib nibWithNibName:@"EXProductionDataRightTableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
//    tableView.scrollEnabled = NO;
    
    //tableView刷新界面操作
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    [self.scrollView addSubview:tableView];
    self.productionDataTableView = tableView;
    [self getData];
    [self getCumulativeData];
    [tableView.mj_header beginRefreshing];
}

/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.productionDataTableView.mj_header endRefreshing];
    [self.productionDataTableView.mj_footer endRefreshing];
}

- (IBAction)toolbarCancle:(id)sender {
    [self.beginDateTextField resignFirstResponder];
    [self.endDateTextField resignFirstResponder];
}

- (IBAction)toolbarOK:(id)sender {
    NSDate *date = self.datePickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if (self.beginDateTextField.isFirstResponder) {
        self.beginDateTextField.text = dateString;
        [self.beginDateTextField resignFirstResponder];
    }
    if (self.endDateTextField.isFirstResponder) {
        self.endDateTextField.text = dateString;
        [self.endDateTextField resignFirstResponder];
        [self getData];
        [self getCumulativeData];
    }
}

- (void)getData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Production/GetSimpleProductionData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&MenuCode=%@&BeginDate=%@&EndDate=%@&PageIndex=%ld&PageSize=%@", [BMAccountManager sharedInstance].user.UserId, [BMAccountManager sharedInstance].loginInfo.AccessToken, @"product",self.beginDateTextField.text, self.endDateTextField.text, self.page, @"20"] dataUsingEncoding:NSUTF8StringEncoding];
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
        NSMutableArray *stationArray = [[NSMutableArray alloc] initWithCapacity:20];
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        NSArray *tempArray = dict[@"AppendData"];
        self.dataArray  = tempArray;
        if (tempArray.count != 0) {
            for (NSDictionary *tempDic in tempArray) {
                NSString *stationName = tempDic[@"StationName"];
                [stationArray addObject:stationName];
            }
        }
        self.stationNames = [stationArray copy];
        if (stationArray.count != 0) {
            NSLog(@"---%@", stationArray[0]);
        }
        [self.productionDataTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self endRefresh];
    }];
    //7.执行任务
    [dataTask resume];

}

- (void)getCumulativeData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Production/GetAllProductionData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&MenuCode=%@&BeginDate=%@&EndDate=%@", [BMAccountManager sharedInstance].user.UserId, [BMAccountManager sharedInstance].loginInfo.AccessToken, @"product",self.beginDateTextField.text, self.endDateTextField.text] dataUsingEncoding:NSUTF8StringEncoding];
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
//        NSLog(@"%@",dict);
        NSArray *tempArray = dict[@"AppendData"];
        if (tempArray != nil) {
            for (NSDictionary *tempDic in tempArray) {
                NSString *numberDay = tempDic[@"NumberDay"];
                NSString *numberMonth = tempDic[@"NumberMonth"];
                self.NumberDay = [@(self.NumberDay.integerValue + numberDay.integerValue) stringValue];
                self.NumberMonth = [@(self.NumberMonth.integerValue + numberMonth.integerValue) stringValue];
            }
        }else{
            self.NumberDay = @"-";
            self.NumberMonth = @"-";
        }
        //        NSLog(@"------%@------%@", self.NumberDay, self.NumberMonth);
        [self performSelectorOnMainThread:@selector(changeValue) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
}

- (void)changeValue{
    if ([self.NumberDay isEqualToString:@"-"]) {
        self.dayCumulativeLabel.text = self.NumberDay;
    }else{
       self.dayCumulativeLabel.text = [NSString stringWithFormat:@"%.1f", [self.NumberDay floatValue]];
    }
    if ([self.NumberMonth isEqualToString:@"-"]) {
        self.monthCumulativeLabel.text = self.NumberMonth;
    }else{
       self.monthCumulativeLabel.text = [NSString stringWithFormat:@"%.1f", [self.NumberMonth floatValue]];
    }
}

#pragma mark --- UITableViewDataSource/ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.stationNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *countArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSString *stationName in self.stationNames) {
        for (NSDictionary *dataDic in self.dataArray) {
            if ([stationName isEqualToString:dataDic[@"StationName"]]) {
                NSArray * listArray = dataDic[@"ListData"];
                [countArray addObject:@(listArray.count)];
            }
        }
    }
        return [countArray[section] integerValue] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EXProductionDataRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    tableView.frame = CGRectMake(0, 0, 1100, self.stationNames.count * 30 + 21 * 60);
    tableView.frame = CGRectMake(0, 0, 1100, self.frame.size.height);
    if (indexPath.row == 0) {
        cell.production = [EXProduction mj_objectWithKeyValues:self.constantDic];
    }else{
        for (NSString *stationName in self.stationNames) {
            for (NSDictionary *dataDic in self.dataArray) {
                if ([stationName isEqualToString:dataDic[@"StationName"]]) {
                    NSArray * listArray = dataDic[@"ListData"];
                    cell.production = [EXProduction mj_objectWithKeyValues:listArray[indexPath.row - 1]];
                }
            }
        }
    }
    self.scrollView.contentSize = CGSizeMake(tableView.frame.size.width, tableView.frame.size.height);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EXHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"EXHeaderView" owner:nil options:nil] lastObject];
    headerView.headerTitle = self.stationNames[section];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
    return footView;
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
