//
//  BookDetailNetManager.h
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseNetManager.h"
#import "BookDetailModel.h"
@interface BookDetailNetManager : BaseNetManager
/**
 *  获取图书一周数据
 *
 *  @param pageFlg:2为看书页面;1为查看图书简介页面
 *         bookid
        userid
 *  @return 网络请求任务
 */
+ (id)getBookDetailWithPageFlg:(NSInteger)PageFlg BookId:(NSInteger)BookId UserId:(NSInteger)UserID CompletionHandle:(void(^)(id model, NSError *error))completionHandle;
@end
