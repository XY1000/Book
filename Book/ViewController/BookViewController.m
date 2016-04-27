//
//  BookViewController.m
//  Book
//
//  Created by Apple on 16/3/21.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BookViewController.h"
#import "FindViewController.h"
#import "ShuKuTableViewController.h"
#import "XiangfaViewController.h"
#import "GerenViewController.h"
//启动动画
#import "SKSplashIcon.h"

static const NSInteger itemNum = 4.0 ;

@interface BookViewController ()<SKSplashDelegate>

//启动动画View
@property (strong, nonatomic) SKSplashView *splashView;

@end

@implementation BookViewController
+ (BookViewController *)standardinstance
{
    static BookViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [BookViewController new];
        
    });return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self twitterSplash];
    self.tabBar.translucent= NO;
    
    FindViewController *vc1 = [FindViewController new];
    
    ShuKuTableViewController *vc2 = [[UIStoryboard storyboardWithName:@"ShuKu" bundle:nil] instantiateInitialViewController];
   
    XiangfaViewController *vc3 = [XiangfaViewController new];
    
    GerenViewController *vc4 = [GerenViewController new];
    
    UINavigationController *FindNavi = [[UINavigationController alloc]initWithRootViewController:vc1];
    FindNavi.tabBarItem.tag = 100;
    FindNavi.title = @"推荐";
    FindNavi.tabBarItem.image = [UIImage imageNamed:@"Focus"];

    UINavigationController *ShuJiaNavi = [[UINavigationController alloc]initWithRootViewController:vc2];
    ShuJiaNavi.tabBarItem.tag = 200;
    ShuJiaNavi.title = @"书城";
    ShuJiaNavi.tabBarItem.image = [UIImage imageNamed:@"Bookw"];

    UINavigationController *XiangNavi = [[UINavigationController alloc]initWithRootViewController:vc3];
    XiangNavi.tabBarItem.tag = 300;
    XiangNavi.title = @"书评";
    XiangNavi.tabBarItem.image = [UIImage imageNamed:@"Shape1w"];

    UINavigationController *GerenNavi = [[UINavigationController alloc]initWithRootViewController:vc4];
    GerenNavi.title = @"颜如玉";
    GerenNavi.tabBarItem.tag = 400;
    GerenNavi.tabBarItem.image = [UIImage imageNamed:@"Userw"];
   
  

    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = RGB(80, 80, 200);

    
    self.viewControllers = @[FindNavi,ShuJiaNavi,XiangNavi,GerenNavi];
    
    
    self.tabLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / itemNum, 1)];
    
    self.tabLine.backgroundColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:200/255.0 alpha:1.0];
    [self.tabBar addSubview:self.tabLine];
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITabbarDalegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    CGFloat lineWid = self.view.bounds.size.width / itemNum;
    
    switch (item.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.5 animations:^{
               
                self.tabLine.frame = CGRectMake(0, self.tabLine.frame.origin.y, lineWid
                                                , 1);
                
            }];
            
            break;
        }
        case 200:{
            [UIView animateWithDuration:0.5 animations:^{
                
                self.tabLine.frame = CGRectMake(lineWid, self.tabLine.frame.origin.y, lineWid, 1);
                
            }];
            
            break;
        }
            case 300:
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                self.tabLine.frame = CGRectMake(2*lineWid, self.tabLine.frame.origin.y, lineWid, 1);
                
            }];
            break;
        }
            case 400:
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                self.tabLine.frame = CGRectMake(3*lineWid, self.tabLine.frame.origin.y, lineWid, 1);
                
            }];
            break;
        }
        default:
            break;
    }
    
}


- (void) twitterSplash
{
    
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"twitterIcon.png"] animationType:SKIconAnimationTypePing];
    UIColor *twitterColor = [UIColor grayColor];
    self.splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeBounce];
        self.splashView.animationDuration = 2.0f; //Optional -> set animation duration. Default: 1s
    [self.view addSubview:self.splashView];
    [_splashView startAnimation];
}


@end
