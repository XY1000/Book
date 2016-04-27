//
//  ZhuTiViewModel.m
//  Book
//
//  Created by Apple on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ZhuTiViewModel.h"

@implementation ZhuTiViewModel

- (instancetype)initWithZhuTiId:(NSInteger)ZhuTiId
{
    if (self = [super init]) {
        _ZhuTiId = ZhuTiId;
    
        
    }return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [ZhuTiNetManager getZhuanTiDataWithZhuanTiId:_ZhuTiId CompletionHandle:^(id model, NSError *error) {
        self.dataArr = model;
        completionHandle(error);
    }];
}

- (NSInteger)rowNumber
{
   
    return self.dataArr.count;
}
- (Zhutiesarraymodel *)modelForRow:(NSInteger)row
{

    return self.dataArr[row];
}
/** 每行数据的图片地址*/
- (NSURL *)bookIconForRow:(NSInteger)row
{
    NSString *str = [self modelForRow:row].bookimageurl;
    NSURL *url = [NSURL URLWithString:str];
    return url;
}
/** 作者名字*/
- (NSString *)authorForRow:(NSInteger)row
{
    return [self modelForRow:row].bookauthor;
}
/** 图书名字*/
- (NSString *)bookNameForRow:(NSInteger)row
{
    return [self modelForRow:row].bookname;
}
/** 图书简介*/
- (NSString *)bookDeatilsForRow:(NSInteger)row
{
    return [self modelForRow:row].bookpreface;
}
- (NSInteger)bookIdForRow:(NSInteger)row
{
    return [self modelForRow:row].bookid;
}


@end
