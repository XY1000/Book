//
//  ShuKuCell.m
//  Book
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ShuKuCell.h"
#import "ShuKuCollectionViewCell.h"

@interface ShuKuCell ()

@end

@implementation ShuKuCell

- (void)awakeFromNib {

    
}

- (void)prepareForReuse {
    
    
    [self.collectionView reloadData];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
