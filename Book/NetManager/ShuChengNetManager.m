//
//  ShuChengNetManager.m
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ShuChengNetManager.h"

@implementation ShuChengNetManager

+ (id)getBookMenuCompletionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = @"http://120.25.158.69:8080/BookReadPublished/bookInfo/getBookCity";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ShuChengModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
