//
//  LeftViewController.h
//  Book
//
//  Created by tmp on 16/4/22.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadBookViewModel.h"


@interface LeftViewController : UIViewController
@property (nonatomic, strong) NSArray *allChapterList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
