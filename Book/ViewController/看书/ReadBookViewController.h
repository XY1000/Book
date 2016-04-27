//
//  ReadBookViewController.h
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopViewForRead.h"
@interface ReadBookViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) NSArray *allChapterList;
@property (strong, nonatomic) UICollectionView *chapterCollectionView;
@property (nonatomic,strong)  NSMutableArray *underLineArr;


- (void)showBottomAndNav;

- (void)hideBottomAndNav;

@end
