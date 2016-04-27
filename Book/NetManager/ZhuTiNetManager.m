//
//  ZhuTiNetManager.m
//  Book
//
//  Created by Apple on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ZhuTiNetManager.h"

@implementation ZhuTiNetManager

+ (id)getZhuanTiDataWithZhuanTiId:(NSInteger)ZhuanTiId CompletionHandle:(void (^)(id, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:@"http://120.25.158.69:8080/BookReadPublished/bookInfo/selectSpecialBook?bookspecialcolumnid=%ld",(long)ZhuanTiId];
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([Zhutiesarraymodel mj_objectArrayWithKeyValuesArray:responseObj],error);
    }];
}

@end
