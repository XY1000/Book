//
//  BookDetailNetManager.m
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BookDetailNetManager.h"

@implementation BookDetailNetManager
+ (id)getBookDetailWithPageFlg:(NSInteger)PageFlg BookId:(NSInteger)BookId UserId:(NSInteger)UserID CompletionHandle:(void(^)(id model, NSError *error))completionHandle
{
    NSString *str = [NSString stringWithFormat:@"http://120.25.158.69:8080/BookReadPublished/bookInfo/getBookInfoCommentList?pageFlg=%ld&bookId=%ld&userId=%ld",(long)PageFlg,(long)BookId,(long)UserID];
    return [self GET:str parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([BookDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}
@end
