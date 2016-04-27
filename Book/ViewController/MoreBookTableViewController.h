//
//  MoreBookTableViewController.h
//  Book
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuChengViewModel.h"
#import "BookDetailViewModel.h"
@interface MoreBookTableViewController : UITableViewController
@property (nonatomic, strong) ShuChengViewModel *shuVM;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSString *topTitle;

@property (nonatomic, strong)BookDetailViewModel *bookVM;
@property (nonatomic, assign) NSInteger BookSection;

@end
