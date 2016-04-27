//
//  HTextView.m
//  Book
//
//  Created by tmp on 16/4/22.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "HTextView.h"

@implementation HTextView

/* 选中文字后是否能够呼出菜单 */
- (BOOL)canBecameFirstResponder {
    return YES;
}

/* 选中文字后的菜单响应的选项 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
  
    // 事实上一个return NO就可以将系统的所有菜单项全部关闭了
    return NO;
}



@end
