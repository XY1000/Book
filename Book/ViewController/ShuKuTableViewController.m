 //
//  ShuKuTableViewController.m
//  Book
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ShuKuTableViewController.h"
#import "ShuKuCell.h"
#import "ShuKuCollectionViewCell.h"
#import "iCarousel.h"
#import "ShuChengViewModel.h"
#import "NSObject+Common.h"       //个人添加的在界面上弹出提示的类拓展
#import "ZhuanTiTableViewController.h"
#import "BookDetailTableViewController.h"
#import "MoreBookTableViewController.h"

@interface ShuKuTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource>
@property (nonatomic, strong) ShuChengViewModel *shuVM;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation ShuKuTableViewController

{
    //添加成员变量,因为不需要懒加载,所以不需要是属性
    iCarousel *_ic;
    UIPageControl *_pageControl;
    NSTimer *_timer;
}
/** 头部滚动视图 */
-(UIView *)headerView{
    [_timer invalidate];
    //如果当前没有头部视图,返回nil
    if(!self.shuVM.isExistIndexPic) return nil;
    //头部视图origin无效,宽度无效,肯定是与table同宽
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kWindowW/1240 * 630)];
    
    //添加滚动栏
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
       
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.shuVM.gunNumber;
    [_ic addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_lessThanOrEqualTo(60);
        make.width.mas_greaterThanOrEqualTo(20);
        make.bottom.mas_equalTo(0);
       
    }];
    //如果只有一张图,则不显示圆点
    _pageControl.hidesForSinglePage = YES;
    //如果只有一张图,则不可以滚动
    _ic.scrollEnabled = self.shuVM.gunNumber != 1;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];

    
   
    if (self.shuVM.gunNumber > 1) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
        } repeats:YES];
    }

   
    //小圆点 不能与用户交互
    _pageControl.userInteractionEnabled = NO;
    return headView;
}
#pragma mark - iCarousel Delegate
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.shuVM.gunNumber;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/1240 * 630 )];
        UIImageView *imageView = [UIImageView new];
        [view addSubview:imageView];
        imageView.tag = 100;
        imageView.contentMode = 0;
        view.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    
    [imageView setImageWithURL:[self.shuVM guniconForRow:index]];
    
    
    return view;
}

/** 允许循环滚动 */
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

/** 监控当前滚到到第几个 */
-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    _pageControl.currentPage = carousel.currentItemIndex;
}
- (ShuChengViewModel *)shuVM
{
    if (!_shuVM) {
        _shuVM = [ShuChengViewModel new];
    }return _shuVM;
}
//滚动栏选中时候触发
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
  
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"TuiJian" bundle:nil];
    ZhuanTiTableViewController *vc = [story instantiateInitialViewController];
    vc.imageUrl = [self.shuVM BigImageForRow:index];
    vc.TopTitle = [self.shuVM ZhuTitleForRow:index];
    vc.ZhuTiId = [self.shuVM ZhuTiIdForRow:index];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
/** 底部视图*/
- (UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [UIImageView new];
        [self.bottomView addSubview:_imageView1];
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(self.tableView.frame.size.width/2-15, self.bottomView.frame.size.height/2-15));
            ;
        }];
        UIButton *btn = [UIButton buttonWithType:0];
        [_imageView1 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _imageView1.userInteractionEnabled = YES;
        btn.backgroundColor = [UIColor clearColor];
        [btn bk_addEventHandler:^(id sender) {
    
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"TuiJian" bundle:nil];
            ZhuanTiTableViewController *vc = [story instantiateInitialViewController];
            vc.imageUrl = [self.shuVM BBigImageForRow:0];
            vc.TopTitle = [self.shuVM BZhuTitleForRow:0];
            vc.ZhuTiId = [self.shuVM BZhuTiIdForRow:0];
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }return _imageView1;
}
- (UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [UIImageView new];
        
        [self.bottomView addSubview:_imageView2];
        [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(self.tableView.frame.size.width/2-15, self.bottomView.frame.size.height/2-15));
            ;
        }];
        UIButton *btn = [UIButton buttonWithType:0];
        [_imageView2 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _imageView2.userInteractionEnabled = YES;
        btn.backgroundColor = [UIColor clearColor];
        [btn bk_addEventHandler:^(id sender) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"TuiJian" bundle:nil];
            ZhuanTiTableViewController *vc = [story instantiateInitialViewController];
            vc.imageUrl = [self.shuVM BBigImageForRow:1];
            vc.TopTitle = [self.shuVM BZhuTitleForRow:1];
            vc.ZhuTiId = [self.shuVM BZhuTiIdForRow:1];
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];

    }return _imageView2;
}
- (UIImageView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [UIImageView new];
        [self.bottomView addSubview:_imageView3];
        [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(self.tableView.frame.size.width/2-15, self.bottomView.frame.size.height/2-15));
            ;
        }];
        UIButton *btn = [UIButton buttonWithType:0];
        [_imageView3 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _imageView3.userInteractionEnabled = YES;
        btn.backgroundColor = [UIColor clearColor];
        [btn bk_addEventHandler:^(id sender) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"TuiJian" bundle:nil];
            ZhuanTiTableViewController *vc = [story instantiateInitialViewController];
            vc.imageUrl = [self.shuVM BBigImageForRow:2];
            vc.TopTitle = [self.shuVM BZhuTitleForRow:2];
            vc.ZhuTiId = [self.shuVM BZhuTiIdForRow:2];
            [self.navigationController pushViewController:vc animated:YES];

        } forControlEvents:UIControlEventTouchUpInside];

    }return _imageView3;
}
- (UIImageView *)imageView4
{
    if (!_imageView4) {
        _imageView4 = [UIImageView new];
        _imageView4.image = [UIImage imageNamed:@"qidong0"];
        [self.bottomView addSubview:_imageView4];
        [_imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            
            make.bottom.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(self.tableView.frame.size.width/2-15, self.bottomView.frame.size.height/2-15));
        }];
        UIButton *btn = [UIButton buttonWithType:0];
        [_imageView4 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _imageView4.userInteractionEnabled = YES;
        btn.backgroundColor = [UIColor clearColor];
        [btn bk_addEventHandler:^(id sender) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"TuiJian" bundle:nil];
            ZhuanTiTableViewController *vc = [story instantiateInitialViewController];
            vc.imageUrl = [self.shuVM BBigImageForRow:3];
            vc.TopTitle = [self.shuVM BZhuTitleForRow:3];
            vc.ZhuTiId = [self.shuVM BZhuTiIdForRow:3];
            [self.navigationController pushViewController:vc animated:YES];

        } forControlEvents:UIControlEventTouchUpInside];

    }return _imageView4;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, kWindowW/1240*750)];
        _bottomView.backgroundColor = RGB(247, 247, 247);
    }return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书城";
//    半透明
    self.navigationController.navigationBar.translucent = NO;

//    左按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = item1;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
//  右按钮
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = item2;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
        
//    底部视图
     self.tableView.tableFooterView = self.bottomView;
    [self showProgress];
    //    刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self.shuVM getDataFromNetCompleteHandle:^(NSError *error) {
            if (error) {
                    [self showErrorMsg:error.localizedDescription];
            }else{
            [self hideProgress];
            self.tableView.tableHeaderView = [self headerView];
            [self.imageView1 setImageWithURL:[self.shuVM bottomImageForRow:0]];
            [self.imageView2 setImageWithURL:[self.shuVM bottomImageForRow:1]];
            [self.imageView3 setImageWithURL:[self.shuVM bottomImageForRow:2]];
            [self.imageView4 setImageWithURL:[self.shuVM bottomImageForRow:3]];
        
                [self.tableView reloadData];
        
            }
                 [self.tableView.mj_header endRefreshing];
        }];
  }];
         [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
/** 表格底部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   ShuKuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShuKuCell" forIndexPath:indexPath];

    NSArray *nameArr = @[@"量身打造",@"新书推荐",@"热门欣赏",@"独家首发"];
    
    cell.titleLb.text = nameArr[indexPath.section];
    cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self;
    [cell.collectionView reloadData];
    return cell;
}
//每个cell间的距离
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
//更多按钮
- (IBAction)moreBtn:(UIButton *)sender {
    UITableViewCell *tab = (UITableViewCell*)sender.superview.superview;
     NSIndexPath *index = [self.tableView indexPathForCell:tab];
    MoreBookTableViewController *vc = [MoreBookTableViewController new];
    vc.shuVM = self.shuVM;
    vc.section = index.section;
    vc.topTitle = @[@"量身打造",@"新书推荐",@"热门欣赏",@"独家首发"][index.section];
    [self.navigationController pushViewController:vc animated:YES];
}



//分割线
kRemoveCellSeparator
#pragma mark - UICollectionDelegate / DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    switch (index.section) {
        case 0:
            if (self.shuVM.liangArr.count <= 6) {

                return self.shuVM.liangArr.count;
            }
            return 6;
            break;
        case 1:
            if (self.shuVM.xinArr.count <= 6) {
                return self.shuVM.xinArr.count;
            }
            return 6;
            break;
        case 2:
            if (self.shuVM.reArr.count <= 6) {
                return self.shuVM.reArr.count;
            }
            return 6;
            break;
        case 3:
            if (self.shuVM.duArr.count <= 6) {
                return self.shuVM.duArr.count;
               
            }
            return 6;
            break;
            
            
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShuKuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookCell"forIndexPath:indexPath];
        UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
        switch (index.section) {
            case 0:
    [cell.bookIcon setImageWithURL:[self.shuVM liangiconForRow:indexPath.section]];
    cell.bookName.text = [self.shuVM liangbookNameForRow:indexPath.section];
    cell.writerLb.text = [self.shuVM liangAuthorForRow:indexPath.section];
                break;
            case 1:
                [cell.bookIcon setImageWithURL:[self.shuVM xiniconForRow:indexPath.section]];
            
                cell.bookName.text = [self.shuVM xinbookNameForRow:indexPath.section];
                cell.writerLb.text = [self.shuVM xinAuthorForRow:indexPath.section];
                break;
            case 2:
                [cell.bookIcon setImageWithURL:[self.shuVM reiconForRow:indexPath.section]];
                cell.bookName.text = [self.shuVM rebookNameForRow:indexPath.section];
                cell.writerLb.text = [self.shuVM reAuthorForRow:indexPath.section];
                break;
            case 3:
                [cell.bookIcon setImageWithURL:[self.shuVM duiconForRow:indexPath.section]];
                cell.bookName.text = [self.shuVM dubookNameForRow:indexPath.section];
                cell.writerLb.text = [self.shuVM duAuthorForRow:indexPath.section];
                break;
    
            default:
                break;
        }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (kWindowW - 3 * 15 - 5 ) / 3.5;
    
    return CGSizeMake(width, collectionView.bounds.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BookDetail" bundle:nil];
    
    BookDetailTableViewController *vc = [story instantiateInitialViewController];
    UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    switch (index.section) {
        case 0:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM liangBookIdForRow:indexPath.section] PageFlg:1 UserId:1];
            
            break;
        case 1:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM xinBookIdForRow:indexPath.section] PageFlg:1 UserId:1];
            break;

        case 2:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM reBookIdForRow:indexPath.section] PageFlg:1 UserId:1];
            break;

        case 3:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM duBookIdForRow:indexPath.section] PageFlg:1 UserId:1];
            break;

            
        default:
            break;
    }
    
    //            break;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
