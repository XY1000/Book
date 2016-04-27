//
//  TopView.h
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView
//书的图片
@property (weak, nonatomic) IBOutlet UIImageView *icon;
//书名
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
//作者
@property (weak, nonatomic) IBOutlet UILabel *writerLb;
//描述
@property (weak, nonatomic) IBOutlet UITextView *descLb;
//热度
@property (nonatomic,readwrite,assign)NSInteger redu;
@end
