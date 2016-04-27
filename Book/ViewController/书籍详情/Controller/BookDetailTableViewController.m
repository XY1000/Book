//
//  BookDetailTableViewController.m
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import "BookDetailTableViewController.h"
#import "HeaderViewController.h"
#import "SecondCell.h"
#import "MidCell.h"
#import "MoreCell.h"
#import "BottomCell.h"
#import "BottomCollectionCell.h"
#import "TopView.h"
#import "BookDetailViewModel.h"
#import "NSObject+Common.h"
#import "MoreBookTableViewController.h"
@interface BookDetailTableViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) BookDetailViewModel *BookDetailVM;
@end

@implementation BookDetailTableViewController

static  NSString *SecondeCellID = @"SecondCell";
static  NSString *MidCellID = @"MidCell";
static  NSString *MoreCellID = @"MoreCell";
static  NSString *BottomCellID = @"BottomCell";
static  NSString *BottomCollectionCellID = @"BottomCollectionCell";


- (BookDetailViewModel *)BookDetailVM
{
    if (!_BookDetailVM) {
        _BookDetailVM = [[BookDetailViewModel alloc]initWithPageFlg:self.PageFlg BookId:self.BookId UserId:self.UserID];
        
    }return _BookDetailVM;
}
- (id)initWithBookId:(NSInteger)bookId PageFlg:(NSInteger)PageFlg UserId:(NSInteger)UserId
{
    if (self = [super init]) {
        _BookId = bookId;
        _PageFlg = PageFlg;
        _UserID = UserId;
    }return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIButton *rightButton = [UIButton buttonWithType:0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"Share"]forState:UIControlStateNormal];
    [rightButton bk_addEventHandler:^(id sender) {
        NSLog(@"分享按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton1 setImage:[UIImage imageNamed:@"Star"]forState:UIControlStateNormal];
    [rightButton1 bk_addEventHandler:^(id sender) {
        NSLog(@"收藏按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    UIButton*rightButton2 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton2 setImage:[UIImage imageNamed:@"Create"]forState:UIControlStateNormal];
    [rightButton2 bk_addEventHandler:^(id sender) {
        NSLog(@"写评论按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    UIBarButtonItem*rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton2];
    self.navigationItem.rightBarButtonItems= @[rightItem,rightItem1,rightItem2];
    UIBarButtonItem *item5= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Left-arrow-2"] style:UIBarButtonItemStylePlain target:self action:@selector(backShuKu)];
    self.navigationItem.leftBarButtonItem = item5;

    [self registerAllCell];
//    [self configureHeaderView];
    
    [self configureTableView];
    
    [self showProgress];
    //    刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.BookDetailVM getDataFromNetCompleteHandle:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.localizedDescription];
            }else{
                [self hideProgress];
                [self configureHeaderView];
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
- (void)configureTableView {
    
    self.tableView.estimatedRowHeight =  200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册Cell
- (void)registerAllCell {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:nil] forCellReuseIdentifier:SecondeCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MidCell" bundle:nil] forCellReuseIdentifier:MidCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:MoreCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"BottomCell" bundle:nil] forCellReuseIdentifier:BottomCellID];
    
    
}

#pragma mark - 头部视图
- (void)configureHeaderView {
    
    HeaderViewController *vc = [[HeaderViewController alloc]init];
    [self addChildViewController:vc];
    TopView *topV = [[NSBundle mainBundle] loadNibNamed:@"TopView" owner:vc options:nil].lastObject;
    vc.chapterList = self.BookDetailVM.bookChapterArr;
    
   topV.nameLb.text = [self.BookDetailVM topBookNameForRow:0];
    
    topV.writerLb.text =[self.BookDetailVM topBookAuthorForRow:0];
    topV.descLb.text = [self.BookDetailVM topBookDetailForRow:0];
    
    [topV.icon setImageWithURL:[self.BookDetailVM topBookIconForRow:0]];
    NSInteger redu = [self.BookDetailVM topBookHotForRow:0];
    if (redu > 5) {
        topV.redu = 5;
    }else{
        topV.redu = redu;}

    topV.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    
    self.tableView.tableHeaderView = topV;
}

#pragma mark - UITableViewDelegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie {
    
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.BookDetailVM.bookCommentNum;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:{
        
            cell = [tableView dequeueReusableCellWithIdentifier:SecondeCellID forIndexPath:indexPath];
            
        }
            break;
        case 1:{
            
            cell = [tableView dequeueReusableCellWithIdentifier:MidCellID forIndexPath:indexPath];
            
            
        }
            break;
        case 2:{
            
            cell = [tableView dequeueReusableCellWithIdentifier:MoreCellID forIndexPath:indexPath];
            
        }
            break;
        case 3:{
            
        cell = (BottomCell *)[tableView dequeueReusableCellWithIdentifier:BottomCellID forIndexPath:indexPath];
            
            
            }
            break;
        case 4:{
            
            cell = (BottomCell *)[tableView dequeueReusableCellWithIdentifier:BottomCellID forIndexPath:indexPath];
            
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

//在这里配置数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([cell isKindOfClass:[SecondCell class]]) {
        
        SecondCell *myCell = (SecondCell *)cell;
        NSInteger num = self.BookDetailVM.bookCommentNum;
        myCell.SecondLb.text = [NSString stringWithFormat:@"全部论坛内容·%ld",(long)num];
        
        
        
    }else if ([cell isKindOfClass:[MidCell class]]) {
#pragma mark - 中部的视图
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MidCell *mdCell = (MidCell *)cell;
        [mdCell.icon setImageWithURL:[self.BookDetailVM friendImageUrlForRow:indexPath.row]];
        mdCell.nameLb.text = [self.BookDetailVM friendNameForRow:indexPath.row];
        mdCell.titleLb.text = [self.BookDetailVM bookCommentStrForRow:indexPath.row];
        
//        if (mdCell.timeLb.numberOfLines < 2) {
//            [mdCell.zhanBtn  setTitle:@"" forState:UIControlStateNormal];
//        }
        mdCell.descLb.text = [self.BookDetailVM BookCommentDetailForRow:indexPath.row];
        mdCell.dayLb.text = [self.BookDetailVM bookCommentTimeForRow:indexPath.row];
    
        mdCell.likeBtn.selected = mdCell.islike;
        
        NSInteger likeNum = [self.BookDetailVM CommentPraisCountForRow:indexPath.row];
        if (likeNum == 0) {
             mdCell.likeNumLb.text = @"快来点赞吧";
        }else{
            mdCell.likeNumLb.text = [NSString stringWithFormat:@"共%ld人赞",(long)likeNum];}
        NSInteger allCommentNum = [self.BookDetailVM CommentReplyCountForRow:indexPath.row];
        if (allCommentNum == 0) {
            [mdCell.allCommentLb setTitle:@"暂无评论" forState:UIControlStateNormal];
            
        }else{
        
            [mdCell.allCommentLb setTitle:[NSString stringWithFormat:@"查看全部评论 %ld",(long)allCommentNum] forState:UIControlStateNormal];
        }
        
    }else if ([cell isKindOfClass:[MoreCell class]]) {
        

        
        
    }else if ([cell isKindOfClass:[BottomCell class]]) {
#pragma mark - 最后几行的视图
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        BottomCell *btCell = (BottomCell *)cell;
        [btCell.collectionView reloadData];
        if (indexPath.section == 3) {
            btCell.titleLb.text = @"作者其他作品";
            btCell.collectionView.delegate =self;
            btCell.collectionView.dataSource = self;
             [btCell.collectionView registerNib:[UINib nibWithNibName:@"BottomCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BottomCollectionCell"];
            
        }
        if (indexPath.section == 4) {
             btCell.titleLb.text = @"读过此书的好友在读";
            btCell.collectionView.delegate =self;
            btCell.collectionView.dataSource = self;
              [btCell.collectionView registerNib:[UINib nibWithNibName:@"BottomCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BottomCollectionCell"];
        }
    }
    
    
    
}
//更多按钮被点击
- (IBAction)MoreBBt:(UIButton *)sender {
    
    UITableViewCell *tab = (UITableViewCell*)sender.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    MoreBookTableViewController *vc = [MoreBookTableViewController new];
    vc.bookVM= self.BookDetailVM;
    vc.BookSection = index.section;
    NSLog(@"%ld",(long)vc.BookSection);
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];

            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 20;
    
}

#pragma mark - MidCell中按钮的点击
//展开
- (IBAction)zhanClick:(UIButton *)sender {

    
    [self.tableView beginUpdates];
    
    MidCell *cell = (MidCell *)sender.superview.superview;
    
    if (cell.titleLb.numberOfLines == 2) {
        
       cell.titleLb.numberOfLines = 0;
        
        [sender setTitle:@"收起" forState:(UIControlStateNormal)];
        
    }else {
        
        cell.titleLb.numberOfLines = 2;
        
        [sender setTitle:@"展开" forState:(UIControlStateNormal)];
    }
    
    [self.tableView endUpdates];
    
}

//喜欢
- (IBAction)likeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    MidCell *cell = (MidCell *)sender.superview.superview;
    
    cell.islike = sender.selected;
    
    
}

//评论
- (IBAction)commentClick:(UIButton *)sender {
    
    NSLog(@"评论点击了");
    
}

//查看更多评论
- (IBAction)lookClick:(UIButton *)sender {
    
    NSLog(@"查看更多评论");
}

#pragma mark - collectionView的配置
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    NSInteger bookNum = self.BookDetailVM.bookNameNum;
    NSInteger userNum = self.BookDetailVM.ueserReadBookNum;
    if (index.section == 3) {
        if (bookNum > 4) {
            return 4;
        }
        return bookNum;
    }
    if (index.section == 4) {
        if (userNum > 4) {
            return 4;
        }
        return userNum;
    }
    
    
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BottomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BottomCollectionCellID forIndexPath:indexPath];
    UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    if (index.section == 3) {
        cell.bookNameLb.text = [self.BookDetailVM bookNameBookForRow:indexPath.row];
        [cell.bookImageView setImageWithURL:[self.BookDetailVM bookNameIconUrlForRow:indexPath.row]];
    }
    if (index.section == 4) {
        cell.bookNameLb.text = [self.BookDetailVM userReadBookNameForRow:indexPath.row];
        [cell.bookImageView setImageWithURL:[self.BookDetailVM userReadBookIconUrlForRow:indexPath.row]];
    }
    
    
    return cell;
}
/** section的上下左右边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (collectionView.frame.size.width- 3 * 20  ) / 4;
    
    //    return CGSizeMake(width, collectionView.bounds.size.height);
    //
    return CGSizeMake(width, 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BookDetail" bundle:nil];
    
    BookDetailTableViewController *vc = [story instantiateInitialViewController];
    UITableViewCell *tab = (UITableViewCell*)collectionView.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:tab];
    if (index.section == 3) {
         vc = [[BookDetailTableViewController alloc]initWithBookId:[self.BookDetailVM bookNameIdForRow:indexPath.row] PageFlg:1 UserId:1];
    }
    if (index.section == 4) {
         vc = [[BookDetailTableViewController alloc]initWithBookId:[self.BookDetailVM userReadBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
