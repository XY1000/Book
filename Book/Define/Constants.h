//
//  Constants.h
//  Book
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

//导航栏题字体的颜色
#define kNaviTitleColor     [UIColor colorWithRed:141/255.0 green:105/255.0 blue:62/255.0 alpha:1.0]

//设置RGB颜色
#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]



#endif /* Constants_h */
