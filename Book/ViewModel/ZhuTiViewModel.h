//
//  ZhuTiViewModel.h
//  Book
//
//  Created by Apple on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseViewModel.h"
#import "ZhuTiNetManager.h"
@interface ZhuTiViewModel : BaseViewModel

- (instancetype)initWithZhuTiId:(NSInteger)ZhuTiId;
@property(nonatomic) NSInteger ZhuTiId;


/** 几行数据*/
@property (nonatomic) NSInteger rowNumber;

/** 每行数据的图片地址*/
- (NSURL *)bookIconForRow:(NSInteger)row;
/** 作者名字*/
- (NSString *)authorForRow:(NSInteger)row;
/** 图书名字*/
- (NSString *)bookNameForRow:(NSInteger)row;
/** 图书简介*/
- (NSString *)bookDeatilsForRow:(NSInteger)row;
- (NSInteger)bookIdForRow:(NSInteger)row;

@end
