//
//  HotViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "HotViewController.h"
#import "HotTableViewCell.h"
#import "HotModel.h"
#import "PullingRefreshTableView.h"
#import "HWTool.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PrefixHeader.pch"
#import "Header.h"
#import "StarTextViewController.h"
@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource,PullingRefreshTableViewDelegate>
{
    NSInteger _offset;//定义请求的页码
}
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotArray;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"HotTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    [self.tableView launchRefreshing];
    
}

#pragma mark ---------- UITableViewDatagate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    hotCell.hotModel = self.hotArray[indexPath.row];
    
    return hotCell;
}


#pragma mark ---------- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotModel *hotModel = self.hotArray[indexPath.row];
    StarTextViewController *startTextVC = [[StarTextViewController alloc] init];
    startTextVC.title = hotModel.title;
    startTextVC.viewnum = hotModel.viewnum;
    startTextVC.commentnum = hotModel.commentnum;
    startTextVC.image = hotModel.image;
    startTextVC.content = hotModel.content;
    [self.navigationController pushViewController:startTextVC animated:YES];
}


#pragma mark -------- PULLingRefreshViewDelegate
//tableView开始刷新的时候调用
//上拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    _offset += 10;
}


//下拉
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    _offset = 0;
}

//刷新时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTool getSystemNowDate];
}

//加载数据
- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:[NSString stringWithFormat:@"%@&offset=%ld",kHot,_offset] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        //下拉刷新的时候需要移除数组中的数据
        if (self.refreshing) {
            if (self.hotArray.count > 0) {
                [self.hotArray removeAllObjects];
            }
        }
        
        for (NSDictionary *dict in dataArray) {
            HotModel *model = [[HotModel alloc] initWithDictionary:dict];
            [self.hotArray addObject:model];
        }
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
    
    //完成加载
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    
}

//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}


#pragma mark ------- Lazy loading
- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) pullingDelegate:self];
        self.tableView.rowHeight = 120;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

    }
    return _tableView;
}

- (NSMutableArray *)hotArray{
    if (_hotArray == nil) {
        self.hotArray = [NSMutableArray new];
    }
    return _hotArray;
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
