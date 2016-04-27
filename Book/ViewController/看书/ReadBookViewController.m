//
//  ReadBookViewController.m
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ReadBookViewController.h"
#import "ReadCollectionViewController.h"
#import "ReadCollectionViewCell.h"

@interface ReadBookViewController ()<UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

//进度
@property (weak, nonatomic) IBOutlet UILabel *progressTitleLb;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *progressBtn;

//亮度
@property (weak, nonatomic) IBOutlet UISlider *lightSlider;
@property (weak, nonatomic) IBOutlet UIButton *lightBtn;

//字体
@property (weak, nonatomic) IBOutlet UISlider *fontSlider;
@property (weak, nonatomic) IBOutlet UIButton *fontBtn;

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIScrollView *bottomScrollView;
@property (nonatomic,strong) TopViewForRead *navigationView;
@property (nonatomic,strong) UIView *statuseBackgroundView;

@property (nonatomic,readwrite,assign) BOOL hideStatue;//隐藏状态栏

@end

@implementation ReadBookViewController
{
    CGRect _originTabbar;
     BOOL _taped;//用于记录是否点击过了
    ReadCollectionViewController *_readCollectVC;
}

static NSString * const cellId = @"chapterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    _hideStatue = YES;
    
    _underLineArr = [NSMutableArray array];
}

- (void)setHideStatue:(BOOL)hideStatue {
    
    _hideStatue = hideStatue;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    _originTabbar = self.tabBarController.tabBar.frame;
    [self.tabBarController.tabBar setFrame:(CGRectZero)];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
    [self.tabBarController.tabBar setFrame:_originTabbar];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self initBottomAndNavView];
}

- (void)initView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.chapterCollectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    [self.view addSubview:self.chapterCollectionView];
    
    self.chapterCollectionView.pagingEnabled = YES;
    self.chapterCollectionView.showsHorizontalScrollIndicator = NO;
//    self.chapterCollectionView.scrollEnabled = NO;
    self.chapterCollectionView.delegate = self;
    self.chapterCollectionView.dataSource = self;
    
}

- (void)initBottomAndNavView {
    
    [self initNavitionView];
    
    [self initStatuseBackgroundView];
    
    //初始化 底部所需的视图
    [self initBottomView];
}

#pragma mark  - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return  1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allChapterList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.chapterCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%ld%@",indexPath.row,cellId]];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%ld%@",indexPath.row,cellId] forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
     ReadCollectionViewController *vc = (ReadCollectionViewController *)[UIStoryboard storyboardWithName:@"ReadCollectionView" bundle:nil].instantiateInitialViewController;
    _readCollectVC = vc;
    
    vc.taped = _taped;
    vc.chapterModel = self.allChapterList[indexPath.row];
    [self addChildViewController:vc];
    vc.view.bounds = cell.contentView.bounds;
    
    [cell.contentView addSubview:vc.view];
    
}

#pragma mark - 状态栏

- (void)initStatuseBackgroundView {
    
    self.statuseBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, kWindowW, 20)];
    _statuseBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_statuseBackgroundView];
    
}

- (BOOL)prefersStatusBarHidden {

    return _hideStatue;
    
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return UIStatusBarAnimationSlide;
}

#pragma mark - 底部

- (void)initBottomView {
    
    self.bottomView = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"BottomViewForRead" owner:self options:nil].firstObject;
   
    _bottomView.frame = CGRectMake(0,kWindowH, kWindowW, 49);
    
    [self.view addSubview:_bottomView];
    //加载后续的视图
    self.bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kWindowH, kWindowW, 100)];

    self.bottomScrollView.contentSize = CGSizeMake(3 * kWindowW, 0);
    
    self.bottomScrollView.showsVerticalScrollIndicator = NO;
    self.bottomScrollView.showsHorizontalScrollIndicator = NO;
    self.bottomScrollView.scrollEnabled = NO;
    
    [self.view addSubview:self.bottomScrollView];
    
    [self initProgressView];
    [self initLightView];
    [self initFontView];
}

- (IBAction)menuClick:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
    if (self.bottomScrollView.frame.origin.y != kWindowH) {
        
        self.bottomScrollView.frame = CGRectMake(0, kWindowH, kWindowW, 100);
    }
    
    self.hideStatue = YES;
    
    [self deselectAllBtn];
}

- (IBAction)progressClick:(UIButton *)sender {
    
    [self showBottomScrollerWithOffset:CGPointZero];
    [self selectedBtn:sender];
}

- (IBAction)lightClick:(UIButton *)sender {
    
    [self showBottomScrollerWithOffset:CGPointMake(self.bottomScrollView.bounds.size.width, 0)];
    [self selectedBtn:sender];
}

- (IBAction)fontClick:(UIButton *)sender {
    
    [self selectedBtn:sender];
    [self showBottomScrollerWithOffset:CGPointMake( 2 * self.bottomScrollView.bounds.size.width, 0)];
}

- (void)showBottomScrollerWithOffset:(CGPoint)offset {
    
    
    if (self.bottomScrollView.frame.origin.y == kWindowH) {
        
        [UIView animateWithDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration animations:^{
            
            self.bottomScrollView.frame = CGRectMake(0, kWindowH - 100 - self.bottomView.bounds.size.height, kWindowW, 100);
            
        }];
        
    }
    
    [self.bottomScrollView setContentOffset:offset animated:NO];
    
}

- (void)selectedBtn:(UIButton *)sender {
    
    switch (sender.tag) {
            
        case 1000:
            
            self.progressBtn.selected = YES;
            self.lightBtn.selected = NO;
            self.fontBtn.selected = NO;
            
            break;
        case 2000:
            
            self.progressBtn.selected = NO;
            self.lightBtn.selected = YES;
            self.fontBtn.selected = NO;
            
            break;
            
        case 3000:
            
            self.progressBtn.selected = NO;
            self.lightBtn.selected = NO;
            self.fontBtn.selected = YES;
            
            break;
        default:
            break;
    }
    
}

- (void)deselectAllBtn {
    
    self.progressBtn.selected = NO;
    self.lightBtn.selected = NO;
    self.fontBtn.selected = NO;
    
}

#pragma mark - 查看进度

- (void)initProgressView {
    
    UIView *progressV = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"ProgressView" owner:self options:nil].firstObject;
    
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"circlex1"] forState:(UIControlStateNormal)];
     self.progressSlider.maximumValue = self.allChapterList.count;
     self.progressSlider.minimumValue = 1;
    progressV.frame = CGRectMake(0, 0, self.bottomScrollView.bounds.size.width, self.bottomScrollView.bounds.size.height);
    
    [self.bottomScrollView addSubview:progressV];
}

- (IBAction)leftBtn:(UIButton *)sender {
    
    if (self.chapterCollectionView.contentOffset.x != 0) {
        
        //获取第几章
        NSIndexPath *num = [self.chapterCollectionView indexPathForCell:self.chapterCollectionView.visibleCells.firstObject];
        
        BookDetailBookchaperlist *model = self.allChapterList[num.row - 1];
        self.progressTitleLb.text = model.bookchapterno;
        
        [self.chapterCollectionView setContentOffset:CGPointMake((num.row- 1) * kWindowW, 0) animated:YES];
        
        [self.progressSlider setValue:num.row animated:YES];
        
    }
    
    
}

- (IBAction)rigthBtn:(UIButton *)sender {
    
    if (self.chapterCollectionView.contentOffset.x != (self.allChapterList.count - 1) * kWindowW) {
        
        //获取第几章
        NSIndexPath *num = [self.chapterCollectionView indexPathForCell:self.chapterCollectionView.visibleCells.firstObject];
        
        BookDetailBookchaperlist *model = self.allChapterList[num.row + 1];
        self.progressTitleLb.text = model.bookchapterno;
        
        
        [self.chapterCollectionView setContentOffset:CGPointMake((num.row+ 1) * kWindowW, 0) animated:YES];
        
        [self.progressSlider setValue:num.row+2 animated:YES];

    }
    
}

- (IBAction)sliderChangeForProgress:(UISlider *)sender {
    
    NSInteger num = (NSInteger)sender.value;
    
    [self.chapterCollectionView setContentOffset:CGPointMake((num - 1) * kWindowW, 0) animated:NO];
    
    BookDetailBookchaperlist *model = self.allChapterList[num - 1];
    
    self.progressTitleLb.text = model.bookchapterno;
    //[sender setValue:num animated:YES];
    
}

#pragma mark - 调节亮度

- (void)initLightView {
    
    UIView *lightV = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"Light" owner:self options:nil].firstObject;
    
    _lightSlider.minimumValue = 0;
    _lightSlider.maximumValue = 1;
    NSNumber *num = GetObjectUserDefault(HLight);
    self.lightSlider.value = num.floatValue;
    
    [self.lightSlider setThumbImage:[UIImage imageNamed:@"circlex1"] forState:(UIControlStateNormal)];
    
    lightV.frame = CGRectMake(self.bottomScrollView.bounds.size.width, 0, self.bottomScrollView.bounds.size.width, self.bottomScrollView.bounds.size.height);
    [self.bottomScrollView addSubview:lightV];
}

- (IBAction)configureBackgroundColor:(UIButton *)sender {
    
    SetObjectUserDefault([CIColor colorWithCGColor:sender.superview.backgroundColor.CGColor].stringRepresentation, HBackgroundColor);
    
    _readCollectVC.collectionView.backgroundColor =  sender.superview.backgroundColor;
    
    ReadCollectionViewCell *cell = _readCollectVC.collectionView.visibleCells.firstObject;
    
    cell.contentTextView.backgroundColor = sender.superview.backgroundColor;
    
}

- (IBAction)SliderChangeForLight:(UISlider *)sender {
    
    [[UIScreen mainScreen] setBrightness:sender.value];
    
    SetObjectUserDefault(@(sender.value), HLight);
}

#pragma mark - 字体

- (void)initFontView {
    
    UIView *fontV  = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"FontView" owner:self options:nil].firstObject;
    
    fontV.frame = CGRectMake( 2 * self.bottomScrollView.bounds.size.width, 0, self.bottomScrollView.bounds.size.width, self.bottomScrollView.bounds.size.height);
    
    self.fontSlider.minimumValue = 15;
    self.fontSlider.maximumValue = 35;
    NSNumber *num = GetObjectUserDefault(HFontSize);
    self.fontSlider.value = num.floatValue;
    
    [self.fontSlider setThumbImage:[UIImage imageNamed:@"circlex1"] forState:(UIControlStateNormal)];
    
    [self.bottomScrollView addSubview:fontV];
}

- (IBAction)sliderChangeForFont:(UISlider *)sender {
    
    _readCollectVC.attributes = @{
                        NSFontAttributeName:[UIFont systemFontOfSize:sender.value],
                        NSUnderlineColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:_readCollectVC.attributes[NSParagraphStyleAttributeName]
                        };
    
    SetObjectUserDefault(@(sender.value), HFontSize);
    
}

#pragma mark - 导航
- (void)initNavitionView {
    
    self.navigationView = (TopViewForRead *)[[NSBundle mainBundle] loadNibNamed:@"TopViewForRead" owner:self options:nil].firstObject;
  
    self.navigationView.frame = CGRectMake(0, -64, kWindowW, 44);
    
    [self.view addSubview:self.navigationView];
    
}

- (IBAction)backBtnCLick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)showBottomAndNav {
    //显示
    NSTimeInterval time = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:time animations:^{
        
        _bottomView.frame = CGRectMake(0, kWindowH - 49, kWindowW, 49);
        
        self.navigationView.frame = CGRectMake(0, 20, kWindowW, 44);
        
        _statuseBackgroundView.frame = CGRectMake(0, 0, kWindowW, 20);
    }];
    _taped = YES;
    self.hideStatue = NO;
    
    //因为不确定网络是否完成，所以在这里初始化进度的数据
     self.progressTitleLb.text = _readCollectVC.chapterModel.bookchapterno;
}

- (void)hideBottomAndNav {
    
    NSTimeInterval time = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    //隐藏出现的视图
    
    [UIView animateWithDuration:time animations:^{
        
        _bottomView.frame = CGRectMake(0,kWindowH, kWindowW, 49);
        
        self.navigationView.frame = CGRectMake(0, -64, kWindowW, 44);
        
        self.bottomScrollView.frame = CGRectMake(0, kWindowH, kWindowW, 100);
        
        _statuseBackgroundView.frame = CGRectMake(0, 0, kWindowW, 0);
    }];
    
    _taped = NO;
    
    self.hideStatue = YES;
}

@end
