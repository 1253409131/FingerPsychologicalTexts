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
#import "TestModel.h"
#import "ResultViewController.h"
#import "ZMYNetManager.h"
#import "Reachability.h"
@interface TestViewController ()
{
    NSInteger currentNum;
}
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIScrollView *textScrollView;
@property (nonatomic, strong) UILabel *viewnumLable;
@property (nonatomic, strong) UILabel *commentnumLable;
@property (nonatomic, strong) UIProgressView *testProgressView;//进度条
@property (nonatomic, strong) UILabel *jinduLable;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) UIButton *submitBtn;//提交按钮
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
    [self.textScrollView addSubview:self.jinduLable];
    [self.textScrollView addSubview:self.titleLable];
    [self.textScrollView addSubview:self.btn1];
    [self.textScrollView addSubview:self.btn2];
    [self.textScrollView addSubview:self.btn3];
    [self.textScrollView addSubview:self.submitBtn];
    currentNum = 1;
}
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@&ceshi_id=%@",kTest,self.testId];
    QJZLog(@"----------%@",url);
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *dict in dataArray) {
            TestModel *testModel = [[TestModel alloc] initWithContentDictionary:dict];
            [self.testArray addObject:testModel];
        }
        //得到数据之后重新给界面控件添加值
        [self configViewWithTestModel:self.testArray[currentNum]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
}
- (void)touch{
    //不管点哪个按钮,创建一个全局的变量记录当前是第几个测试，默认是0
    if (currentNum <= self.testArray.count) {
        currentNum += 1;
    }
    [self configViewWithTestModel:self.testArray[currentNum]];
}
- (void)configViewWithTestModel:(TestModel *)testModel {
    self.titleLable.text = testModel.title;
    [self.btn1 setTitle:testModel.firstChoices forState:UIControlStateNormal];
    [self.btn2 setTitle:testModel.secondChoices forState:UIControlStateNormal];
    if (![testModel.thirdChoices isEqualToString:testModel.secondChoices]) {
        [self.btn3 setTitle:testModel.thirdChoices forState:UIControlStateNormal];
    }
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
//进度：
- (UILabel *)jinduLable{
    if (_jinduLable == nil) {
        self.jinduLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 44, 44)];
        self.jinduLable.text = @"进度：";
        self.jinduLable.font = [UIFont systemFontOfSize:14.0];
        self.jinduLable.textColor = [UIColor grayColor];
    }
    return _jinduLable;
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
        [self.btn1 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn1.tag = 1;
    }
    return _btn1;
}
- (UIButton *)btn2{
    if (_btn2 == nil) {
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame = CGRectMake(10, 290, kWidth - 20, 44);
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.layer.cornerRadius = 5;
        [self.btn2 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn2.tag = 2;
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (_btn3 == nil) {
        self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn3.frame = CGRectMake(10, 335, kWidth - 20, 44);
        self.btn3.backgroundColor = [UIColor whiteColor];
        self.btn3.layer.cornerRadius = 5;
        [self.btn3 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn3.tag = 3;
    }
    return _btn3;
}
- (NSMutableArray *)testArray{
    if (_testArray == nil) {
        self.testArray = [NSMutableArray new];
    }
    return _testArray;
}
- (void)selectBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            
            
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
//提交按钮
- (UIButton *)submitBtn{
    if (_submitBtn == nil) {
        self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submitBtn.frame = CGRectMake(300, 385, 44, 40);
        self.submitBtn.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submitBtn addTarget:self action:@selector(result) forControlEvents:UIControlEventTouchUpInside];
        self.submitBtn.layer.cornerRadius = 5;
        self.submitBtn.font = [UIFont systemFontOfSize:14.0];
    }
    return _submitBtn;
}

- (void)result{
    ResultViewController *resultVC = [[ResultViewController alloc] init];
    //给测试结果页面设置标题
    resultVC.title = self.title;
    resultVC.viewnum = self.viewnum;
    resultVC.commentnum = self.commentnum;
    resultVC.testId = self.testId;
    [self.navigationController pushViewController:resultVC animated:YES];
    
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
