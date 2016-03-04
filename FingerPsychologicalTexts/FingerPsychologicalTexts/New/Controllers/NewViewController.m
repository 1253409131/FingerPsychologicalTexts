//
//  NewViewController.m
//  
//
//  Created by scjy on 16/3/3.
//
//

#import "NewViewController.h"
#import "NewTableViewCell.h"
#import "PullingRefreshTableView.h"
@interface NewViewController ()<UITableViewDelegate, UITableViewDataSource, PullingRefreshTableViewDelegate>

@property(nonatomic, strong) PullingRefreshTableView *tableView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
//    //在最新页面隐藏tabBar
//    self.tabBarController.tabBar.hidden = YES;
    self.tableView.tableFooterView = [[UITableView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.tableView];
    
}


#pragma mark ---------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return newCell;
}



#pragma mark ---------- PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    
}



#pragma mark ----------- Lazy loading
- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) pullingDelegate:self];
        self.tableView.rowHeight = 200;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
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
