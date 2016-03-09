//
//  TestViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "TestViewController.h"
#import "StarTextViewController.h"
#import "PrefixHeader.pch"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+Common.h"
#import "Header.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface TestViewController ()
{
    NSInteger _num;
}

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) UIScrollView *textScrollView;
@property (nonatomic, strong) UILabel *viewnumLable;
@property (nonatomic, strong) UILabel *commentnumLable;
@property (nonatomic, retain) UIProgressView *testProgressView;//进度条
@property (nonatomic, retain) UILabel *titleLable;

@property (nonatomic, retain) UIButton *btn1;
@property (nonatomic, retain) UIButton *btn2;
@property (nonatomic, retain) UIButton *btn3;
@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    
    [self.view addSubview:self.textScrollView];
    [self.textScrollView addSubview:self.viewnumLable];
    [self.textScrollView addSubview:self.commentnumLable];
    //添加进度条
    [self.textScrollView addSubview:self.testProgressView];
    [self.textScrollView addSubview:self.titleLable];
    [self.textScrollView addSubview:self.btn1];
    [self.textScrollView addSubview:self.btn2];
    [self.textScrollView addSubview:self.btn3];
   
    
}

- (void)loadData{
    _num = 351;
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@&ceshi_id=%ld",kTest,_num];
    QJZLog(@"----------%@",url);
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *dict in dataArray) {
            self.titleLable.text = dict[@"title"];
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
}


#pragma mark ---------- Lazy loading 
//可以滑动
- (UIScrollView *)textScrollView{
    if (_textScrollView == nil) {
        self.textScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.textScrollView.contentSize = CGSizeMake(kWidth, kHeight-64);
    }
    return _textScrollView;
}

- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray new];
    }
    return _titleArray;
}
//测试人数
- (UILabel *)viewnumLable{
    if (_viewnumLable == nil) {
        self.viewnumLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, 44)];
        self.viewnumLable.text = [NSString stringWithFormat:@"%@人测过",self.viewnum];
        self.viewnumLable.font = [UIFont systemFontOfSize:14.0];
        self.viewnumLable.textColor = [UIColor  grayColor];
    }
    return _viewnumLable;
}
//评论人数
- (UILabel *)commentnumLable{
    if (_commentnumLable == nil) {
        self.commentnumLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 70, 44)];
        self.commentnumLable.text = [NSString stringWithFormat:@"%@评论",self.commentnum];
        self.commentnumLable.font = [UIFont systemFontOfSize:14.0];
        self.commentnumLable.textColor = [UIColor  grayColor];
    }
    return _commentnumLable;
}
//进度条
- (UIProgressView *)testProgressView{
    if (_testProgressView == nil) {
        self.testProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(120, 88, kWidth-130, 44)];
    }
    return _testProgressView;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, kWidth - 20, 100)];
        self.titleLable.backgroundColor = [UIColor whiteColor];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLable;
}


#pragma mark ---------- 3个btn
- (UIButton *)btn1{
    if (_btn1 == nil) {
        self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.frame = CGRectMake(10, 245, kWidth - 20, 44);
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.layer.cornerRadius = 5;
        
    }
    return _btn1;
}

- (UIButton *)btn2{
    if (_btn2 == nil) {
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame = CGRectMake(10, 290, kWidth - 20, 44);
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.layer.cornerRadius = 5;
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (_btn3 == nil) {
        self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn3.frame = CGRectMake(10, 335, kWidth - 20, 44);
        self.btn3.backgroundColor = [UIColor whiteColor];
        self.btn3.layer.cornerRadius = 5;
    }
    return _btn3;
}

//当页面将要出现的时候隐藏tabBar
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
