//
//  EXPersonalCenterViewController.m
//  Charts
//
//  Created by Eleven on 16/7/27.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXPersonalCenterViewController.h"
#import "BMLoginController.h"
#import "EXFeedbackViewController.h"
#import "EXAboutUsViewController.h"
#import "EXPersonInfoViewController.h"
@interface EXPersonalCenterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation EXPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    // Do any additional setup after loading the view.
    self.headerView.height = self.view.frame.size.height * (160.0 / 600);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //tabBar添加向右滑动手势
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipRightAction:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

-(void)swipRightAction:(UISwipeGestureRecognizer *)recognizer
{
    self.tabBarController.selectedIndex = 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identidier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identidier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identidier];
    }
    switch (indexPath.row) {
        case 0:{
            cell.imageView.image = [UIImage imageNamed:@"information"];
            cell.textLabel.text = @"个人信息";
        }break;
        case 1:{
            cell.imageView.image = [UIImage imageNamed:@"feedback"];
            cell.textLabel.text = @"意见反馈";
        }break;
        case 2:{
            cell.imageView.image = [UIImage imageNamed:@"us"];
            cell.textLabel.text = @"关于我们";
        }break;
        case 3:{
            cell.imageView.image = [UIImage imageNamed:@"logout"];
            cell.textLabel.text = @"退出登录";
        }break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            EXPersonInfoViewController *personInfoVC = [[UIStoryboard storyboardWithName:@"PersonInfo" bundle:nil] instantiateInitialViewController];
            [self presentViewController:personInfoVC animated:YES completion:nil];
        }break;
        case 1:{
            EXFeedbackViewController *feedbackViewController = [[UIStoryboard storyboardWithName:@"Feedback" bundle:nil] instantiateInitialViewController];
            [self presentViewController:feedbackViewController animated:YES completion:nil];
        }break;
        case 2:{
            EXAboutUsViewController *aboutUsViewController = [[UIStoryboard storyboardWithName:@"AboutUs" bundle:nil] instantiateInitialViewController];
            [self presentViewController:aboutUsViewController animated:YES completion:nil];
        }break;
        case 3:{
            BMLoginController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginVC"];
            [self presentViewController:loginVC animated:YES completion:nil];
        }break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
