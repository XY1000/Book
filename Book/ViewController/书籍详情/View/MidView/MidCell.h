//
//  MidCell.h
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidCell : UITableViewCell
//头像
@property (weak, nonatomic) IBOutlet UIImageView *icon;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
//文章
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
//描述
@property (weak, nonatomic) IBOutlet UILabel *descLb;
//展开
@property (weak, nonatomic) IBOutlet UIButton *zhanBtn;
//3月27日
@property (weak, nonatomic) IBOutlet UILabel *dayLb;
//22：48
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
//❤️按钮
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
//评论按钮
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
//共43人赞
@property (weak, nonatomic) IBOutlet UILabel *likeNumLb;
//查看全部评论
@property (weak, nonatomic) IBOutlet UIButton *allCommentLb;
@property (nonatomic, assign) BOOL islike;

@end
