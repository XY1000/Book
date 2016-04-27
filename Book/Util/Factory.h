//
//  Factory.h
//  Book
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject


/** 添加导航栏颜色*/
+ (void)addTabbarColor:(UINavigationController *)contoroller;

+ (UIViewController *)viewController:(UIView *)view1;

@end
