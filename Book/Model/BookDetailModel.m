//
//  BookDetailModel.m
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BookDetailModel.h"

@implementation BookDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"userReadBookList" : [BookDetailUserreadbooklist class], @"bookNameList" : [BookDetailBooknamelist class], @"bookInfoList" : [BookDetailBookinfolist class], @"bookCommentList" : [BookDetailBookcommentlist class], @"bookChaperList" : [BookDetailBookchaperlist class]};
}
@end
@implementation BookDetailUserreadbooklist

@end


@implementation BookDetailBooknamelist

@end


@implementation BookDetailBookinfolist

@end


@implementation BookDetailBookcommentlist

@end


@implementation BookDetailBookchaperlist

@end






