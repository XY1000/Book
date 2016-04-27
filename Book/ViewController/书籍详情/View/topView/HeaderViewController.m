//
//  HeaderViewController.m
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import "HeaderViewController.h"
#import "ReadBookViewController.h"
#import "TopView.h"
#import "LeftViewController.h"

@interface HeaderViewController ()



@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)clickHeaderView:(id)sender {
    
    ReadBookViewController *vc = [[ReadBookViewController alloc]init];
    vc.view.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    
    LeftViewController *leftVC = [UIStoryboard storyboardWithName:@"LeftViewController" bundle:nil].instantiateInitialViewController;

    RESideMenu *menu = [[RESideMenu alloc]initWithContentViewController:vc leftMenuViewController:leftVC rightMenuViewController:nil];
    
    //配置菜单
    menu.scaleContentView = NO;
    menu.scaleMenuView = NO;
    menu.contentViewInPortraitOffsetCenterX = ((self.view.bounds.size.width / 2.0 ) - self.view.bounds.size.width / 6.0);
    menu.delegate = leftVC;
    menu.panFromEdge = NO;
    menu.panGestureEnabled = NO;
    
    self.navigationController.delegate = menu;
    leftVC.allChapterList = self.chapterList;
    vc.allChapterList = self.chapterList;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:menu animated:YES];
}


//目录
- (IBAction)catalogBtnClick:(UIButton *)sender {
    
    NSLog(@"目录被点击了");
    
}
//版权
- (IBAction)versionBtnClick:(UIButton *)sender {
    
    NSLog(@"版权被点击了");
}


@end
