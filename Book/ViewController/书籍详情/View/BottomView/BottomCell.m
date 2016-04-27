//
//  BottomCell.m
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import "BottomCell.h"
#import "BottomCollectionCell.h"

@interface BottomCell ()

@end

@implementation BottomCell

static  NSString *BottomCollectionCellID = @"BottomCollectionCell";

- (void)awakeFromNib {
    
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BottomCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BottomCollectionCell"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//    return 4;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//     BottomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BottomCollectionCellID forIndexPath:indexPath];
//   
//   
//   
//    return cell;
//}
///** section的上下左右边距 */
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGFloat width = (collectionView.frame.size.width- 3 * 20  ) / 4;
//    
////    return CGSizeMake(width, collectionView.bounds.size.height);
////
//    return CGSizeMake(width, 150);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    
//    return 10;
//}

@end
