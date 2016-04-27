//
//  BookViewController.h
//  Book
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookViewController : UITabBarController

//单利 保证整个进程只有一个
+ (BookViewController *)standardinstance;
@property (nonatomic, strong) UIView *tabLine;//tabbar 上的线
@end
