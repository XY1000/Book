//
//  ShuKuCollectionViewCell.h
//  Book
//
//  Created by Apple on 16/4/5.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuKuCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookIcon;

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *writerLb;
@end
