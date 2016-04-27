//
//  ReadCollectionViewController.m
//  Book
//
//  Created by tmp on 16/4/25.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ReadCollectionViewController.h"
#import "ReadCollectionViewCell.h"
#import "ReadBookViewModel.h"
#import "LeftViewController.h"
#import "ReadBookViewController.h"

@interface ReadCollectionViewController ()<UICollectionViewDelegateFlowLayout,UITextViewDelegate>

@property (nonatomic,copy)NSArray *pageNum;
@property (nonatomic,strong)ReadBookViewModel *readViewModel;

@end

@implementation ReadCollectionViewController
{
   
    NSMutableParagraphStyle * _paragraphStyle;
    ReadBookViewController *_readVC;

}

static NSString * const reuseIdentifier = @"readCollectionCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNetData:) name:@"下载完成" object:nil];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource =self;
    [self initData];
    
    [self initMenuForSelected];

    [self.readViewModel getChapterContentWithRow:0];
    
}

- (void)initData {
    
    _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    _paragraphStyle.lineSpacing = 10;// 字体的行间距
    
     _readVC = (ReadBookViewController *)self.parentViewController;
    
    [self settingBackgroundColor];
    [self settingScreenLight];
    [self settingFont];
    
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)loadNetData:(NSNotification *)not {
    
    
    self.pageNum = not.userInfo[@"data"];
    
    [self.collectionView reloadData];
    
//    if (GetObjectUserDefault(HBookContentNum)) {
//        
//        NSNumber *num = GetObjectUserDefault(HBookContentNum);
//        
//        [self.collectionView setContentOffset:CGPointMake(num.integerValue * kWindowW, 0)];
//    }
    
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.pageNum.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(ReadCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (GetObjectUserDefault(HBackgroundColor)) {
        
         CIColor *ciColor = [CIColor colorWithString:GetObjectUserDefault(HBackgroundColor)];
        cell.contentTextView.backgroundColor = [UIColor colorWithCIColor:ciColor];
    }
    
    cell.headerLb.text = self.chapterModel.bookchapterno;
    cell.footerLb.text = [NSString stringWithFormat:@"%ld / %lu",indexPath.row + 1,(unsigned long)self.pageNum.count];
    cell.contentTextView.attributedText = [self underLineStr:self.pageNum[indexPath.row]];
    cell.tag = indexPath.row;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {

        [self tapClick];
        
    }];
    [cell.contentTextView addGestureRecognizer:tap];
}

//点击TextView
- (void)tapClick {
    
    if (_taped) {
        
        [_readVC hideBottomAndNav];
        
        _taped = NO;
        
    }else {
        
        [_readVC showBottomAndNav];
        _taped = YES;
    }
}

//对下划线的处理
- (NSAttributedString *)underLineStr:(NSString *)str {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttributes:_attributes range:NSMakeRange(0, str.length)];
    
    if (GetObjectUserDefault(HBookUnderLineArr)) {
        
        for (NSString *underStr in GetObjectUserDefault(HBookUnderLineArr)) {
            
            if ([str containsString:underStr]) {
                
                NSRange ran = [str rangeOfString:underStr];
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:ran];
                [attrStr addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:ran];
                
            }
            
        }
        
    }

    return attrStr;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kWindowW - 10, kWindowH);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return  10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
      [_readVC hideBottomAndNav];
    
}

#pragma mark - 主视图

- (void)setAttributes:(NSDictionary *)attributes {
    //设置字体时 进行的操作
    
    _attributes = attributes;
    
    self.readViewModel.attributes = attributes;
    self.pageNum = [self.readViewModel adjustContentWith:_attributes];
    [self.collectionView reloadData];
}

#pragma mark - 手势

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 选中文字

- (void)initMenuForSelected {
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(customCopy:)];
    UIMenuItem *menuItem1 = [[UIMenuItem alloc]initWithTitle:@"划线" action:@selector(drawLine:)];
    UIMenuItem *menuItem2 = [[UIMenuItem alloc]initWithTitle:@"写想法" action:@selector(writeSomething:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setMenuItems:@[menuItem,menuItem1,menuItem2]];
}

- (void)drawLine:(id)sender {
    
    ReadCollectionViewCell *cell = self.collectionView.visibleCells.firstObject;
    
    NSRange ran = cell.contentTextView.selectedRange;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithAttributedString:cell.contentTextView.attributedText];
    
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:ran];
    [attrStr addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:ran];
    
    cell.contentTextView.attributedText = attrStr;
    
    [_readVC.underLineArr addObject:[attrStr.string substringWithRange:ran]];
    
    if (GetObjectUserDefault(HBookUnderLineArr)) {
        
        [_readVC.underLineArr addObjectsFromArray:GetObjectUserDefault(HBookUnderLineArr)];
    }
    
    SetObjectUserDefault([_readVC.underLineArr copy], HBookUnderLineArr);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)writeSomething:(id)sender {

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"写想吧" message:@"asd" preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"退出" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

- (void)customCopy:(id)sender {
    
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    ReadCollectionViewCell *cell = self.collectionView.visibleCells.firstObject;
    
    NSRange ran = cell.contentTextView.selectedRange;
    
    NSAttributedString *str = [cell.contentTextView.attributedText attributedSubstringFromRange:ran];
    
    board.string = str.string;
    
}

#pragma mark - 设置的配置

- (void)settingBackgroundColor {
    
    if (GetObjectUserDefault(HBackgroundColor)) {
        
        CIColor *ciColor = [CIColor colorWithString:GetObjectUserDefault(HBackgroundColor)];
        
        self.collectionView.backgroundColor = [UIColor colorWithCIColor:ciColor];
        
    }else {
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        NSString *str = [CIColor colorWithCGColor:[UIColor whiteColor].CGColor].stringRepresentation;
        
        SetObjectUserDefault(str, HBackgroundColor);
    }
}

- (void)settingScreenLight {
    
    if (GetObjectUserDefault(HLight)) {
        
        NSNumber *num = GetObjectUserDefault(HLight);
        
        [[UIScreen mainScreen] setBrightness:num.floatValue];
        
    }else {
        
        SetObjectUserDefault(@([UIScreen mainScreen].brightness), HLight);
    }
    
}

- (void)settingFont {
    
    if (GetObjectUserDefault(HFontSize)) {
        
        NSNumber *num = GetObjectUserDefault(HFontSize);
        
        _attributes = @{
                        NSFontAttributeName:[UIFont systemFontOfSize:num.floatValue],
                        NSUnderlineColorAttributeName:[UIColor redColor],
                        NSParagraphStyleAttributeName:_paragraphStyle
                        };
        
        
    }else {
        
        
        _attributes = @{
                        NSFontAttributeName:[UIFont systemFontOfSize:15],
                        
                        NSUnderlineColorAttributeName:[UIColor redColor],
                        NSParagraphStyleAttributeName:_paragraphStyle
                        };
        
        SetObjectUserDefault(@(15), HFontSize);
        
    }
    
}

- (ReadBookViewModel *)readViewModel {
	if(_readViewModel == nil) {
		_readViewModel = [[ReadBookViewModel alloc] initWithChapterList:self.chapterModel fontConfigure:_attributes contentSize:CGSizeMake(kWindowW - 20, kWindowH - 40)];
        
	}
	return _readViewModel;
}


@end
