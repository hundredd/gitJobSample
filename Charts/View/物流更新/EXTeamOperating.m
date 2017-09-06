//
//  EXTeamOperating.m
//  Charts
//
//  Created by Eleven on 16/8/24.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXTeamOperating.h"
#import "EXTeamOperatingData.h"
#import "EXTeamOperatingRightTableViewCell.h"
@interface EXTeamOperating  () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewRight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@property (weak, nonatomic) UITableView *teamOperatingTableView;
@property (strong, nonatomic) NSArray *teamOperatingArray;

@property (assign, nonatomic) NSInteger selectIndex;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
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

@implementation EXTeamOperating

static NSString *teamOperatingCell = @"teamOperatingCell";
- (void)awakeFromNib{
    
    self.scrollViewTop.delegate = self;
    self.scrollViewRight.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
   
    //上部视图
    UIView *topView = [[[NSBundle mainBundle] loadNibNamed:@"EXTeamOperatingTop" owner:nil options:nil] firstObject];
    [self.scrollViewTop addSubview:topView];
    self.scrollViewTop.contentSize = CGSizeMake(topView.frame.size.width, 0);
    self.tableView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
    topView.frame = CGRectMake(0, 0, 3940, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
    
    UITableView *teamOperatingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, kScreenHeight - 64 - kScreenHeight * 1 / 15 - 80 - 80) style:UITableViewStylePlain];
    teamOperatingTableView.dataSource = self;
    teamOperatingTableView.delegate = self;
    teamOperatingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    teamOperatingTableView.userInteractionEnabled = NO;
    [teamOperatingTableView registerNib:[UINib nibWithNibName:@"EXTeamOperatingRightTableViewCell" bundle:nil] forCellReuseIdentifier:teamOperatingCell];
    teamOperatingTableView.scrollEnabled = NO;
    [self.scrollViewRight addSubview:teamOperatingTableView];
    self.scrollViewRight.contentSize = CGSizeMake(3940, teamOperatingTableView.frame.size.height);
    self.teamOperatingTableView = teamOperatingTableView;
    
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
    _X = 0;
    _Y = 0;
    self.selectIndex = 0;
    [self getData];
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
        [self getDetailData];
    }
    
    [self.timeTextField resignFirstResponder];
}

- (void)getData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Station/GetStationData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&MenuCode=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, @""] dataUsingEncoding:NSUTF8StringEncoding];
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
        NSMutableArray *stationNames = [NSMutableArray arrayWithCapacity:5];
        NSMutableArray *stationIds = [NSMutableArray arrayWithCapacity:5];
        NSArray *tempArray = dict[@"AppendData"];
        for (NSDictionary *tem in tempArray) {
            NSString *stationName = tem[@"StationName"];
            NSString *stationId = tem[@"StationId"];
            [stationNames addObject:stationName];
            [stationIds addObject:stationId];
        }
        self.stationNames = [stationNames copy];
        self.stationIds = [stationIds copy];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self getDetailData];
    }];
    //7.执行任务
    [dataTask resume];
    
}

- (void)getDetailData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/VehicleWorking/GetVehicleWorkingData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&Selectmonth=%@&PageIndex=%@&PageSize=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.stationIds[self.selectIndex], self.timeTextField.text, @"1", @"20"] dataUsingEncoding:NSUTF8StringEncoding];
    //测试
//    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&Selectmonth=%@&PageIndex=%@&PageSize=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.stationIds[self.selectIndex], @"2016-08-01", @"1", @"20"] dataUsingEncoding:NSUTF8StringEncoding];
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
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *temArray = dict[@"AppendData"];
            for (NSDictionary *temDic in temArray) {
                EXTeamOperatingData *teamOperatingData = [EXTeamOperatingData mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:teamOperatingData];
            }
        }
        self.teamOperatingArray = [tempDataArray copy];
        [self.teamOperatingTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
    
}

#pragma mark -- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.stationNames.count;
    }
    if (tableView == self.teamOperatingTableView) {
        self.scrollViewRight.contentSize = CGSizeMake(3940, self.teamOperatingArray.count * 60 + 2);
        self.teamOperatingTableView.frame = CGRectMake(0, 0, self.teamOperatingTableView.frame.size.width, self.teamOperatingArray.count * 60);
        return self.teamOperatingArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        static NSString *cellIdentifier = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = self.stationNames[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            NSIndexPath *selectRow = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:selectRow animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        cell.textLabel.textColor = [UIColor colorWithRed:87 / 255.0 green:84 / 255.0 blue:84/ 255.0 alpha:1];
        cell.selectedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:188 / 255.0 green:185 / 255.0 blue:188 / 255.0 alpha:1];
        return cell;
    }
    if (tableView == self.teamOperatingTableView) {
        EXTeamOperatingRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teamOperatingCell];
        cell.teamOperatingData = self.teamOperatingArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _X = 0;
    _Y = 0;
    self.selectIndex = indexPath.row;
    [self getDetailData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.teamOperatingTableView) {
        return 60;
    }
    return 60;
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollViewRight) {
        static CGFloat xPoint = 0;
        static CGFloat yPoint = 0;
        xPoint = scrollView.contentOffset.x;
        yPoint = scrollView.contentOffset.y;
        CGPoint bottomViewContentOffset = self.scrollViewRight.contentOffset;
        if (xPoint != _X) {
            bottomViewContentOffset.y = _Y;
            CGPoint topViewContentOffset = self.scrollViewTop.contentOffset;
            topViewContentOffset.x = scrollView.contentOffset.x;
            [self.scrollViewTop setContentOffset:topViewContentOffset animated:NO];
            _X = xPoint;
            [self.scrollViewRight setContentOffset:bottomViewContentOffset animated:NO];
        }
        if (yPoint != _Y) {
            bottomViewContentOffset.x = _X;
            _Y = yPoint;
            [self.scrollViewRight setContentOffset:bottomViewContentOffset animated:NO];
        }
        scrollView.contentOffset = CGPointMake(_X, _Y);
        return;
    }
    if (scrollView == self.scrollViewTop) {
        [self.scrollViewRight setContentOffset:scrollView.contentOffset animated:NO];
        return;
    }
}



@end
