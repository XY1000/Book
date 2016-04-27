//
//  ZhuanTiTableViewController.h
//  Book
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuanTiTableViewController : UITableViewController
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic) NSInteger ZhuTiId;
@property (nonatomic, strong) NSString  *TopTitle;

- (id)initWithImageUrl:(NSURL *)imageUrl TopTitle:(NSString *)TopTitle ZhuTiId:(NSInteger)ZhuTiId;


@end
