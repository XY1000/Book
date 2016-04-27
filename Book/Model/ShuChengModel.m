//
//  ShuChengModel.m
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ShuChengModel.h"

@implementation ShuChengModel


+ (NSDictionary *)objectClassInArray{
    return @{@"aloneBook" : [ShuChengAlonebookModel class], @"tailoredBook" : [ShuChengTailoredbookModel class], @"agoSpecialColumn" : [ShuChengAgospecialcolumnModel class], @"NewSpecialColumn" : [BoolNewspecialcolumnModel class], @"hotBook" : [ShuChengHotbookModel class], @"NewGoodBook" : [ShuChengNewgoodbookModel class]};
}
@end
@implementation ShuChengAlonebookModel

@end


@implementation ShuChengTailoredbookModel

@end


@implementation ShuChengAgospecialcolumnModel

@end


@implementation BoolNewspecialcolumnModel

@end


@implementation ShuChengHotbookModel

@end


@implementation ShuChengNewgoodbookModel

@end


