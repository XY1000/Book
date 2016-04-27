//
//  ZhuanTiCell.m
//  Book
//
//  Created by Apple on 16/4/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ZhuanTiCell.h"

@implementation ZhuanTiCell

- (void)awakeFromNib {
    // Initialization code
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 140)];
    self.lineView.backgroundColor = [UIColor redColor];
    
    [self addSubview:self.lineView];
    
    self.haveLine = NO;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHaveLine:(BOOL)haveLine {
    
    _haveLine = haveLine;
    
    if (haveLine) {
        
        self.lineView.hidden = NO;
        
    }else {
        
        self.lineView.hidden = YES;
    }
    
    
}


@end
