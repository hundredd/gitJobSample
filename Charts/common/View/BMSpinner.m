//
//  BMSpinner.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/29.
//
//

#import "BMSpinner.h"

@interface BMSpinner () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation BMSpinner

- (instancetype)init
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self configuraion];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self configuraion];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hide];
    if (_selected) {
        _selected(nil);
    }
}

- (void)configuraion
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
    tableView.layer.cornerRadius = 5.f;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(self.height / 4, self.width / 4, self.height / 4, self.width / 4));
    }];
    self.tableView = tableView;
    _show = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hide];
    if (_selected) {
        _selected(indexPath);
    }
}

- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    
    [self.tableView reloadData];
}

#pragma mark - 公开方法
- (void)show
{
    if (_show) return;
    
    _show = YES;
    
    [kWindow addSubview:self];
    
    self.tableView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.layer.transform = CATransform3DIdentity;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide
{
    if (!_show) return;
    
    _show = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.tableView.layer.transform = CATransform3DIdentity;
    }];
}

@end
