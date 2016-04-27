//
//  ShuChengNetManager.h
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseNetManager.h"
#import "ShuChengModel.h"
@interface ShuChengNetManager : BaseNetManager
/** 获取书城列表 */
+ (id)getBookMenuCompletionHandle:(void(^)(id model, NSError *error))completionHandle;
@end
