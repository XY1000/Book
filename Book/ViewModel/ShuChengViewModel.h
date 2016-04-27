//
//  ShuChengViewModel.h
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseViewModel.h"
#import "ShuChengNetManager.h"
@interface ShuChengViewModel : BaseViewModel

/** 滚动视图数组*/
@property (nonatomic, strong) NSArray *gunArr;
/** 量身打造数组*/
@property (nonatomic, strong) NSArray *liangArr;
/** 独家首发数组*/
@property (nonatomic, strong) NSArray *duArr;
/** 热门欣赏数组*/
@property (nonatomic, strong) NSArray *reArr;
/** 新书推荐数组*/
@property (nonatomic, strong) NSArray *xinArr;
/** 底部图片*/
@property (nonatomic, strong) NSArray *bottomArr;
/** 滚动图片的个数*/
@property(nonatomic)NSInteger gunNumber;
/** 滚动图片*/
- (NSURL *)guniconForRow:(NSInteger)row;
- (NSInteger)ZhuTiIdForRow:(NSInteger)row;
- (NSURL *)BigImageForRow:(NSInteger)row;
- (NSString *)ZhuTitleForRow:(NSInteger)row;
/** 是否有滚动视图*/
-(BOOL)isExistIndexPic;
/** 量身打造  
    图书图片
    图书名字
    图书作者
    图书ID
    图书简介
 */
- (NSURL *)liangiconForRow:(NSInteger)row;
- (NSString *)liangbookNameForRow:(NSInteger)row;
- (NSString *)liangAuthorForRow:(NSInteger)row;
- (NSInteger)liangBookIdForRow:(NSInteger)row;
- (NSString *)liangBookDetailForRow:(NSInteger)row;


/** 新书推荐
 图书图片
 图书名字
 图书作者
 图书ID
 图书简介
 */
- (NSURL *)xiniconForRow:(NSInteger)row;
- (NSString *)xinbookNameForRow:(NSInteger)row;
- (NSString *)xinAuthorForRow:(NSInteger)row;
- (NSInteger)xinBookIdForRow:(NSInteger)row;
- (NSString *)xinBookDetailForRow:(NSInteger)row;

/** 热门欣赏
 图书图片
 图书名字
 图书作者
 图书ID
 图书简介
 */
- (NSURL *)reiconForRow:(NSInteger)row;
- (NSString *)rebookNameForRow:(NSInteger)row;
- (NSString *)reAuthorForRow:(NSInteger)row;
- (NSInteger)reBookIdForRow:(NSInteger)row;
- (NSString *)reBookDetailForRow:(NSInteger)row;

/** 独家首发
 图书图片
 图书名字
 图书作者
 图书ID
 图书简介
 */
- (NSURL *)duiconForRow:(NSInteger)row;
- (NSString *)dubookNameForRow:(NSInteger)row;
- (NSString *)duAuthorForRow:(NSInteger)row;
- (NSInteger)duBookIdForRow:(NSInteger)row;
- (NSString *)duBookDetailForRow:(NSInteger)row;

//底部图片
- (NSURL *)bottomImageForRow:(NSInteger)row;
- (NSInteger)BZhuTiIdForRow:(NSInteger)row;
- (NSURL *)BBigImageForRow:(NSInteger)row;
- (NSString *)BZhuTitleForRow:(NSInteger)row;




@end
