//
//  BaseModel.m
//  Book
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id", @"desc": @"description",@"NewGoodBook":@"newGoodBook",@"NewSpecialColumn":@"newSpecialColumn"};
}

@end
