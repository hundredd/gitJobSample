//
//  EXSearchViewController.m
//  Charts
//
//  Created by Eleven on 16/8/12.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXSearchViewController.h"
#import "EXSearchCollectionViewCell.h"
#import "EXProductionViewController.h"
#import "EXComprehensiveViewController.h"
#import "EXLogisticsUpdateViewController.h"
#import "EXMValueViewController.h"
#import "EXMValue_changeViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface EXSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
@implementation EXSearchViewController
static NSString *identifier = @"cell";
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    //tabBar添加向右滑动手势
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipRightAction:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    //tabBar添加向左滑动手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeftAction:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

}

-(void)swipRightAction:(UISwipeGestureRecognizer *)recognizer
{
    self.tabBarController.selectedIndex = 0;
}

-(void)swipLeftAction:(UISwipeGestureRecognizer *)recognizer
{
    self.tabBarController.selectedIndex = 2;
}


#pragma  mark -- UICollectionViewDataSource/UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    switch (indexPath.row) {
        case 0:{
            cell.imageView.image = [UIImage imageNamed:@"production"];
            cell.textLabel.text = @"生产类";
            cell.backgroundColor = [UIColor colorWithRed:61 / 255.0 green:158 / 255.0 blue:251 / 255.0 alpha:1];
        }break;
        case 1:{
            cell.imageView.image = [UIImage imageNamed:@"customerService"];
            cell.textLabel.text = @"客服商务类";
            cell.backgroundColor = [UIColor colorWithRed:223 / 255.0 green:182 / 255.0 blue:47 / 255.0 alpha:1];
        }break;
        case 2:{
            cell.imageView.image = [UIImage imageNamed:@"logistics"];
            cell.textLabel.text = @"物流类";
            cell.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:46 / 255.0 blue:195 / 255.0 alpha:1];
        }break;
        case 3:{
            cell.imageView.image = [UIImage imageNamed:@"technology"];
            cell.textLabel.text = @"技术类";
            cell.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:115 / 255.0 blue:57 / 255.0 alpha:1];
        }break;
        case 4:{
            cell.imageView.image = [UIImage imageNamed:@"comprehensive"];
            cell.textLabel.text = @"综合类";
            cell.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:201 / 255.0 blue:171 / 255.0 alpha:1];
        }break;
        default:{
            cell.imageView.image = [UIImage imageNamed:@"reserved"];
            cell.textLabel.text = [NSString stringWithFormat:@"预留%ld", indexPath.row - 4];
            cell.backgroundColor = [UIColor colorWithRed:171 / 255.0 green:168 / 255.0 blue:168 / 255.0 alpha:1];
        }break;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = (kWidth - 15 - 15 - 20) / 3;
    return CGSizeMake(width, width);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            EXProductionViewController *productionVC = [[UIStoryboard storyboardWithName:@"Production" bundle:nil] instantiateInitialViewController];
            [self presentViewController:productionVC animated:YES completion:nil];
            
            }break;
        case 1:{
//            EXMValueViewController *mValueVC = [[UIStoryboard storyboardWithName:@"MValue" bundle:nil] instantiateInitialViewController];
//            [self presentViewController:mValueVC animated:YES completion:nil];
            EXMValue_changeViewController *mValueVC = [[UIStoryboard storyboardWithName:@"MValue_change" bundle:nil] instantiateInitialViewController];
            [self presentViewController:mValueVC animated:YES completion:nil];
        }break;
        case 2:{
            EXLogisticsUpdateViewController *logisticsUpdateVC = [[UIStoryboard storyboardWithName:@"LogisticsUpdate" bundle:nil] instantiateInitialViewController];
            [self presentViewController:logisticsUpdateVC animated:YES completion:nil];
            
        }break;
            
        case 3:{
            
            
        }break;
        case 4:{
            EXComprehensiveViewController *comprehensiveVC = [[UIStoryboard storyboardWithName:@"Comprehensive" bundle:nil] instantiateInitialViewController];
            [self presentViewController:comprehensiveVC animated:YES completion:nil];
            
        }break;
        
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
