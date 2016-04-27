//
//  GerenViewController.m
//  Book
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "GerenViewController.h"
#import "Factory.h"

@interface TXCell : UITableViewCell
/** 头像*/
@property (nonatomic, strong) UIImageView *txImage;
/** 编辑个人资料*/
@property (nonatomic, strong) UIButton *gerenButton;
@end
@implementation TXCell
- (UIImageView *)txImage
{
    if (!_txImage) {
        _txImage = [[UIImageView alloc]init];
        
    }return _txImage;
}
- (UIButton *)gerenButton
{
    if (!_gerenButton) {
        _gerenButton = [UIButton buttonWithType:0];
        
        [_gerenButton setTitle:@"编辑个人资料" forState:UIControlStateNormal];
        [_gerenButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
       
        
            }return _gerenButton;
}
//重写初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.txImage];
        [self.contentView addSubview:self.gerenButton];
        [self.txImage mas_makeConstraints:^(MASConstraintMaker *make) {
           make.size.mas_equalTo(CGSizeMake(40,40));
            make.centerY.mas_equalTo(-20);
            make.centerX.mas_equalTo(0);
        }];
        [self.gerenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 20));
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
            
        }];
        
    }return self;
}


@end

@interface GerenViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBt;
@property (nonatomic, strong) UIButton *leftBt;
@end

@implementation GerenViewController
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [_tableView registerClass:[TXCell class] forCellReuseIdentifier:@"Cell1"];
}
    return _tableView;
}
/** 设置*/
- (UIButton *)rightBt
{
    if (!_rightBt) {
        _rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBt setTitle:@"设置" forState:UIControlStateNormal];
        [_rightBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBt setTitleColor:[UIColor colorWithRed:0 green:0 blue:255 alpha:0.2] forState:UIControlStateHighlighted];
        _rightBt.frame = CGRectMake(0, 0, 45, 45);
        
    }return _rightBt;
}
/** 消息*/
- (UIButton *)leftBt
{
    if (!_leftBt) {
        _leftBt= [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBt setTitle:@"消息" forState:UIControlStateNormal];
        [_leftBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBt setTitleColor:[UIColor colorWithRed:0 green:0 blue:255 alpha:0.2] forState:UIControlStateHighlighted];
        _leftBt.frame = CGRectMake(0, 0, 45, 45);
        
    }return _leftBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"颜如玉";
    self.view.backgroundColor = [UIColor redColor];
//    添加导航栏颜色
    [Factory addTabbarColor:self.navigationController];
    
//    添加按钮
    [self addButton];
//    添加表格
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
       
    }];
    
}



- (void)addButton
{
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightBt];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:self.leftBt];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

#pragma mark - UITabelViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

/* 问二：表格的每一个分区有多少行 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {//第一个分区
        return 1;
    }else if (section == 1){//第二个分区
        return 2;
    }else {//第三个分区
        return 3;
    }
}

/* 问三：每一行什么样 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    cell.accessoryType = 0;
     cell.imageView.image = [UIImage imageNamed:@"icon40"];
    if (indexPath.section == 0) {
        TXCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        cell1.txImage.image = [UIImage imageNamed:@"icon40"];
        cell1.accessoryType = 1;
        [cell1.gerenButton bk_addEventHandler:^(id sender) {
            NSLog(@"aaa");
        } forControlEvents:UIControlEventTouchUpInside];
        return cell1;
    }
    
    
    
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"账户";
        }else{
            cell.textLabel.text = @"好友排名";
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"想法";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"收藏";
        }
        else{
            cell.textLabel.text = @"关注";
        }
    }
    return cell;
}

#pragma mark - 代理协议UITableViewDelegate

/* 一答：选中某一行之后做什么  */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/* 设置单元格的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    return 50;
}

//移除左侧分隔线
kRemoveCellSeparator

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
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
