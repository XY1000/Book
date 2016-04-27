//
//  ZhuanTiCell.h
//  Book
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuanTiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ZhuanImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *BookNameLb;
@property (weak, nonatomic) IBOutlet UILabel *BookAuthorLb;
@property (weak, nonatomic) IBOutlet UILabel *JianjiLb;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) BOOL haveLine;


@end
