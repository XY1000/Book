//
//  qidongViewController.m
//  Book
//
//  Created by Apple on 16/3/29.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "qidongViewController.h"
#import "iCarousel.h"
#import "AppDelegate.h"
#import "BookViewController.h"

@interface qidongViewController ()<iCarouselDelegate,iCarouselDataSource>
@property(nonatomic,strong) iCarousel *ic;
//存储图片名称
@property(nonatomic,strong) NSArray *imageNames;
@end

@implementation qidongViewController



- (NSArray *)imageNames{
    if (!_imageNames) {
        
        UIImage *img0 = [UIImage imageNamed:@"qidong0"];
        UIImage *img1 = [UIImage imageNamed:@"qidong1"];
        UIImage *img2 = [UIImage imageNamed:@"qidong2"];
        
        
        _imageNames =@[img0,img1,img2];
    }
    return _imageNames;
}

- (iCarousel *)ic{
    if (!_ic) {
        _ic = [iCarousel new];
        //就是仿写的CollectionView
        _ic.delegate = self;
        _ic.dataSource = self;
        //修改3D显示模式, type是枚举类型，数值0 ~ 11
        _ic.type =10;
        //自动展示, 0表示不滚动 越大滚动的越快
        _ic.autoscroll = 0;
        //改变为竖向展示
        _ic.vertical = NO;
        
        // 改为翻页模式
        _ic.pagingEnabled = YES;
        //滚动速度
        _ic.scrollSpeed = 2;
    }
    return _ic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.ic];
    [self.ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}
#pragma mark - iCarousel
//添加循环滚动
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return NO; //type0的默认循环滚动模式是否
    }
    // 修改缝隙
    if (option == iCarouselOptionSpacing) {
        return value;
    }
    // 取消后背的显示
    if (option == iCarouselOptionShowBackfaces) {
        return YES;
    }
    
    return value;
}


//问：有多少个Cell
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imageNames.count;
}
//问：每个Cell什么样
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    if (!view) {
        //这里x.y 是无作用的, 图片的宽高 300*500
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 100;
        [view addSubview:imageView];
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        if (index == 0) {
            imageView.image = self.imageNames[0];
        }else if (index == 1){
            imageView.image = self.imageNames[1];
        }else{
            imageView.image = self.imageNames[2];
        }
        
    }
    
    
    return view;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (index == self.imageNames.count-1) {
        BookViewController *vc = [BookViewController new];
        //为了在进入主界面后，welcome界面从内存中被释放
        //所以需要更换window的根视图控制为vc
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController= vc;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
