//
//  ZhuTiNetManager.h
//  Book
//
//  Created by Apple on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseNetManager.h"
#import "ZhuanTiModel.h"
@interface ZhuTiNetManager : BaseNetManager
/**
 *  获取图书一周数据
 *
 *  @param ZhuTiId 专题id
 *
 *  @return 网络请求任务
 */
+ (id)getZhuanTiDataWithZhuanTiId:(NSInteger)ZhuanTiId CompletionHandle:(void(^)(id model, NSError *error))completionHandle;
@end
