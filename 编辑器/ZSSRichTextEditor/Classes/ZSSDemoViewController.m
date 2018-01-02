//
//  ZSSDemoViewController.m
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 11/29/13.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import "ZSSDemoViewController.h"
#import "ZSSDemoPickerViewController.h"


#import "DemoModalViewController.h"


@interface ZSSDemoViewController ()

@end

@implementation ZSSDemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Standard";
    
    //Set Custom CSS
    NSString *customCSS = @"";
    [self setCSS:customCSS];
        
    self.alwaysShowToolbar = YES;
    self.receiveEditorDidChangeEvents = NO;
    
    // Export HTML
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    
    NSString *htmla = @"<div class='test'></div><!-- This is an HTML comment -->""<img src=\"http://test.cfapp.jushenghua.com/wfss/20171228/Rc04cd9b70cf24e8cb414fa37a52b7ec3.png\" width=\"100%\"/><p style=\"text-indent:0em;margin:4px auto 0px auto;\"></p><img src=\"http://test.cfapp.jushenghua.com/wfss/20171228/R4aa94228bbe049eda5516013ff6bba14.png\" width=\"100%\"/><p style=\"text-indent:0em;margin:4px auto 0px auto;\"></p><p style=\"text-indent:0em;margin:4px auto 0px auto;\"><font style=\"font-size:14.000000;color:#000000\">嗲破婆婆跟你你好</font></p>,";
    NSString *htmlb = @"<img src=\"https://himg.bdimg.com/sys/portrait/item/a4a6e586b0e99baae7ac91e5a4a91d21\" alt=\"\">";
    // HTML Content to set in the editor
    NSString *html = @"<div class='test'></div><!-- This is an HTML comment -->"
    "<p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>";
    
    NSLog(html);
    // Set the base URL if you would like to use relative links, such as to images.
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    self.shouldShowKeyboard = NO;
    // Set the HTML contents of the editor
    [self setPlaceholder:@"请输入文章内容"];
    self.titleStr = @"123";
    self.oweStr = @"123123";
    [self setHTML:html];
    
    
}


- (void)showInsertURLAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    picker.isInsertImagePicker = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)exportHTML {
    
    NSLog(@"%@", [self getHTML]);
    NSLog(@"%@", [self getTitleText]);
    NSLog(@"%@", [self getOweText]);
}

- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html {
    
    NSLog(@"Text Has Changed: %@", text);
    
    NSLog(@"HTML Has Changed: %@", html);
    
}


//图片选择
-(void)selectorPickerWithImg:(UIImage *)img andData:(NSData *)data andSelfImgStr:(NSString *)selfImageBase64String andImgStr:(NSString *)imageBase64String
{
    NSLog(@"%@",img);
//    for (int i =0; i<10;i++) {
//        if (!selfImageBase64String) {
//            [self insertImageBase64String:imageBase64String alt:@""];
//        } else {
//            [self updateImageBase64String:imageBase64String alt:@"1"];
//        }
////            [self insertImage:@"https://himg.bdimg.com/sys/portrait/item/a4a6e586b0e99baae7ac91e5a4a91d21" alt:@""];
//    }

}

- (void)hashtagRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Hashtag has been recognized: %@", word);
    
}

- (void)mentionRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Mention has been recognized: %@", word);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
