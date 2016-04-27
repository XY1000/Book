//
//  ZhuanTiTableViewController.m
//  Book
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ZhuanTiTableViewController.h"
#import "ZhuanTiCell.h"
#import "ZhuTiViewModel.h"
#import "NSObject+Common.h"
#import "BookDetailTableViewController.h"
@interface ZhuanTiTableViewController ()
@property (nonatomic, strong) UIImageView *TopImage;
@property (nonatomic, strong) UIImageView *HuaImage;
@property (nonatomic, strong) UILabel *miaoLb;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImageView *footerImage;
@property (nonatomic, strong) ZhuTiViewModel *ZhuVM;
@end

@implementation ZhuanTiTableViewController
{
    
    ZhuanTiCell *_tmpCell;
}
- (ZhuTiViewModel *)ZhuVM
{
    if (!_ZhuVM) {
        _ZhuVM = [[ZhuTiViewModel alloc]initWithZhuTiId:self.ZhuTiId];
    }return _ZhuVM;
}
- (id)initWithImageUrl:(NSURL *)imageUrl TopTitle:(NSString *)TopTitle ZhuTiId:(NSInteger)ZhuTiId
{
    if (self = [super init]) {
        _imageUrl = imageUrl;
        _TopTitle = TopTitle;
        _ZhuTiId = ZhuTiId;
    }return self;
}
- (UIImageView *)TopImage
{
    if (!_TopImage) {
        _TopImage = [UIImageView new];
        [self.headerView addSubview:_TopImage];
        [_TopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(self.headerView.frame.size.width,self.headerView.frame.size.width/1240*630 ));
        }];
        
    }return _TopImage;
}
- (UIImageView *)HuaImage
{
    if (!_HuaImage) {
        _HuaImage = [UIImageView new];
        [self.headerView addSubview:_HuaImage];
        [_HuaImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.miaoLb.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(self.headerView.frame.size.width, (self.headerView.frame.size.width)/1240*90));
            
        }];
        
    }return _HuaImage;
}
- (UILabel *)miaoLb
{
    if (!_miaoLb) {
        _miaoLb = [UILabel new];
        [self.headerView addSubview:_miaoLb];
        [_miaoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.TopImage.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            
        }];
        _miaoLb.font = [UIFont systemFontOfSize:14];
        _miaoLb.numberOfLines = 2;
        _miaoLb.textColor = RGB(41, 41, 41);
    }return _miaoLb;
}
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/1240*940)];
        
    }return _headerView;
}
- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.headerView.frame.size.width/1240*160)];
    }return _footerView;
}
- (UIImageView *)footerImage
{
    if (!_footerImage) {
        _footerImage = [UIImageView new];
        [self.footerView addSubview:_footerImage];
        [_footerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width, self.headerView.frame.size.width/1240*90));
        }];
    }return _footerImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    右按钮
    

   
    
    
    self.title = @"专题";
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Share"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = item1;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    //    左按钮
    UIBarButtonItem *item2= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Left-arrow-2"] style:UIBarButtonItemStylePlain target:self action:@selector(backShuKu)];
    self.navigationItem.leftBarButtonItem = item2;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
    [self.TopImage setImageWithURL:self.imageUrl];
    self.HuaImage.image = [UIImage imageNamed:@"flower1"];
    self.footerImage.image = [UIImage imageNamed:@"flower2"];
    self.miaoLb.text = [NSString stringWithFormat:@"      %@",self.TopTitle];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    [self showProgress];
    //    刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.ZhuVM getDataFromNetCompleteHandle:^(NSError *error) {
            
            if (error) {
                [self showErrorMsg:error.localizedDescription];
            }else{
                [self hideProgress];
                
                [self.tableView reloadData];
                
                
            }
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    

}
- (void)backShuKu{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.ZhuVM.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhuanTiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TuiJianCell" forIndexPath:indexPath];
    
   
  
    
    if (cell.haveLine) {
        
        
        _tmpCell = cell;
    }
    
    
    UIView *yelloView=[UIView new];
    yelloView.backgroundColor=RGB(254, 249, 236);
    cell.selectedBackgroundView = yelloView;
    cell.BookNameLb.text = [self.ZhuVM bookNameForRow:indexPath.row];
    cell.JianjiLb.text = [self.ZhuVM authorForRow:indexPath.row];
    cell.JianjiLb.font = [UIFont systemFontOfSize:16];
    cell.JianjiLb.textColor = RGB(40, 40, 40);
     cell.BookAuthorLb.text = [self.ZhuVM bookDeatilsForRow:indexPath.row];
    [cell.ZhuanImageVIew setImageWithURL:[self.ZhuVM bookIconForRow:indexPath.row]];

   
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //self.oppen = YES;
    
    _tmpCell.haveLine = NO;
    ZhuanTiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.haveLine = YES;
    _tmpCell = cell;
    NSIndexPath *index = [tableView indexPathForCell:_tmpCell];
    
    [tableView reloadRowsAtIndexPaths:@[index,indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BookDetail" bundle:nil];
    
    BookDetailTableViewController *vc = [story instantiateInitialViewController];
    vc = [[BookDetailTableViewController alloc]initWithBookId:[self.ZhuVM bookIdForRow:index.row] PageFlg:1 UserId:1];
    [self.navigationController pushViewController:vc animated:YES];
    
   
    
    
}




@end
