//
//  EXFeedbackViewController.m
//  Charts
//
//  Created by Eleven on 16/9/14.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXFeedbackViewController.h"
#import "ZDTextView.h"
@interface EXFeedbackViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet ZDTextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

@end

@implementation EXFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.textView.placeholder = @"请输入您的宝贵意见(您可以输入200个字)";
}
- (IBAction)submitAction:(UIBarButtonItem *)sender {
}
- (IBAction)uploadImage:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController new];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
            imageVC.delegate = self;
            imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imageVC animated:YES completion:nil];
        } else {
            [self showHint:@"照相机不可用"];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"本地上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imageVC animated:YES completion:nil];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info; {
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        image = [image fixOrientation];
        _uploadButton.selected = YES;
        _uploadButton.tag = 1;
        [_uploadButton setBackgroundImage:image forState:UIControlStateSelected];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
