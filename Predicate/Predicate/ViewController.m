//
//  ViewController.m
//  Predicate
//
//  Created by hun on 2017/8/31.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ViewController.h"
#import "Way.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _text.text = @"M99999999";
}

- (IBAction)action:(id)sender
{
    NSLog(@"正则是否正确: %d",[Way validateGangPassbook:_text.text]);
}


@end
