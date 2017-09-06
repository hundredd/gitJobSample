//
//  EXPersonInfoViewController.m
//  Charts
//
//  Created by Eleven on 16/9/14.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXPersonInfoViewController.h"

@interface EXPersonInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EXPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *silly = @"silly";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:silly];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:silly];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"姓名";
            cell.detailTextLabel.text = @"张三疯";
        }break;
        case 1:{
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = @"张三疯";
        }break;
        case 2:{
            cell.textLabel.text = @"电话";
            cell.detailTextLabel.text = @"11054110";
        }break;
            
        default:
            break;
    }
   
    return cell;
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
