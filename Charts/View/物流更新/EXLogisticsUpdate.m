//
//  EXLogisticsUpdate.m
//  Charts
//
//  Created by Eleven on 16/8/24.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXLogisticsUpdate.h"
#import "EXEquipmentInfo.h"
#import "EXLogisticsUpdateRightTableViewCell.h"
@interface EXLogisticsUpdate () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewRight;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UITableView *equipmentTableView;
@property (strong, nonatomic) NSArray *equipmentInfoArray;
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

@implementation EXLogisticsUpdate

static NSString *equipmentCell = @"equipmentCell";

- (void)awakeFromNib{
   
    self.scrollViewTop.delegate = self;
    self.scrollViewRight.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //上部视图
    UIView *topView = [[[NSBundle mainBundle] loadNibNamed:@"EXLogisticsUpdateTop" owner:nil options:nil] firstObject];
    [self.scrollViewTop addSubview:topView];
    self.scrollViewTop.contentSize = CGSizeMake(topView.frame.size.width, 0);
    topView.frame = CGRectMake(0, 0, 2425, (kScreenHeight - 64 - kScreenHeight * 1 / 15) / 11 + 1);
    self.tableView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
    
    UITableView *equipmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, kScreenHeight - 64 - kScreenHeight * 1 / 15 - 80 - 80) style:UITableViewStylePlain];
    equipmentTableView.dataSource = self;
    equipmentTableView.delegate = self;
    equipmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    equipmentTableView.userInteractionEnabled = NO;
    [equipmentTableView registerNib:[UINib nibWithNibName:@"EXLogisticsUpdateRightTableViewCell" bundle:nil] forCellReuseIdentifier:equipmentCell];
    equipmentTableView.scrollEnabled = NO;
    [self.scrollViewRight addSubview:equipmentTableView];
    self.scrollViewRight.contentSize = CGSizeMake(2425, equipmentTableView.frame.size.height);
    self.equipmentTableView = equipmentTableView;

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
    self.scrollViewTop.directionalLockEnabled = YES;
    self.scrollViewRight.directionalLockEnabled = YES;
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
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Equipment/GetEquipmentData"];
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
                EXEquipmentInfo *equipmentInfo = [EXEquipmentInfo mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:equipmentInfo];
            }
        }
        self.equipmentInfoArray = [tempDataArray copy];
        [self.equipmentTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.stationNames.count;
    }
    if (tableView == self.equipmentTableView) {
        self.scrollViewRight.contentSize = CGSizeMake(2425, self.equipmentInfoArray.count * 60 + 2);
        self.equipmentTableView.frame = CGRectMake(0, 0, self.equipmentTableView.frame.size.width, self.equipmentInfoArray.count * 60);

        return self.equipmentInfoArray.count;
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
    if (tableView == self.equipmentTableView) {
        EXLogisticsUpdateRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:equipmentCell];
        cell.equipmentInfo = self.equipmentInfoArray[indexPath.row];
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
    if (tableView == self.equipmentTableView) {
        return 60;
    }
    return 60;
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollViewRight) {
        self.X = scrollView.contentOffset.x;
        self.Y = scrollView.contentOffset.y;
        self.scrollViewTop.contentOffset =  CGPointMake(self.X, self.scrollViewTop.contentOffset.y);
    }
    if (scrollView == self.scrollViewTop) {
        self.X = scrollView.contentOffset.x;
        self.scrollViewRight.contentOffset = CGPointMake(self.X, self.Y);
    }
}


@end
