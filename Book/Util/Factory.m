//
//  Factory.m
//  Book
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "Factory.h"

@implementation Factory

/** 添加导航栏颜色*/
+ (void)addTabbarColor:(UINavigationController *)contoroller
{
    /** 设置导航栏字体大小颜色*/
    [contoroller.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:RGB(50, 50, 50)}];
    /** 设置导航栏背景色*/
//    [contoroller.navigationBar setBarTintColor:[UIColor colorWithRed:33/255.0 green:34/255.0 blue:42/255.0 alpha:1.000]];
    [contoroller.navigationBar setBarTintColor:[UIColor whiteColor]];
}
/* 时间戳
// //时间转换
class func  timeWithsting(string:String,type:timeType) ->String {
    
    let time = Double(string)
    
    let detailDate = NSDate(timeIntervalSince1970: time!)
    
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateFormat = type.rawValue
    
    let currentDateStr = dateFormatter.stringFromDate(detailDate)
    
    return currentDateStr
}
*/

//- (NSString *)timeWithString:(NSString *)str type:(NSString*)type {
//    
//    double time = [str doubleValue];
//    
//    NSDate *[detailDate = NSDta ]e 
//    
//}

+ (UIViewController*)viewController:(UIView *)view1 {
    for (UIView* next = [view1 superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
