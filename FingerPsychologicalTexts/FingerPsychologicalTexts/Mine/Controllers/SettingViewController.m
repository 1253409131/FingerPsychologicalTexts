//
//  SettingViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "UIViewController+Common.h"
#import "PrefixHeader.pch"
@interface SettingViewController ()
@property (nonatomic,strong) UIButton *aBtn;
@property (nonatomic,strong) UIButton *ideaBtn;
@property (nonatomic,strong) UIButton *testBtn;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    self.title = @"设置";
    [self.view addSubview:self.aBtn];
    [self.view addSubview:self.ideaBtn];
    [self.view addSubview:self.testBtn];
}
#pragma mark ---------- Lazyloading
- (UIButton *)aBtn{
    if (_aBtn == nil) {
        self.aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.aBtn.frame = CGRectMake(10, 100, kWidth-20, 44);
        [self.aBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.aBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.aBtn.backgroundColor = [UIColor whiteColor];
        self.aBtn.layer.cornerRadius = 5;
        [self.aBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.aBtn.tag = 1;
    }
    return _aBtn;
}
- (UIButton *)ideaBtn{
    if (_ideaBtn == nil) {
        self.ideaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ideaBtn.frame = CGRectMake(10, 150, kWidth-20, 44);
        [self.ideaBtn setTitle:@"反馈意见" forState:UIControlStateNormal];
        [self.ideaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.ideaBtn.backgroundColor = [UIColor whiteColor];
        self.ideaBtn.layer.cornerRadius = 5;
        [self.ideaBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.ideaBtn.tag = 2;
    }
    return _ideaBtn;
}
- (UIButton *)testBtn{
    if (_testBtn == nil) {
        self.testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.testBtn.frame = CGRectMake(10, 200, kWidth-20, 44);
        [self.testBtn setTitle:@"检测最新版本" forState:UIControlStateNormal];
        [self.testBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.testBtn.backgroundColor = [UIColor whiteColor];
        self.testBtn.layer.cornerRadius = 5;
        [self.ideaBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.testBtn.tag = 3;
    }
    return _testBtn;
}
- (void)threeBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
