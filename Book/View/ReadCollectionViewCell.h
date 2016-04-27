//
//  ReadCollectionViewCell.h
//  Book
//
//  Created by tmp on 16/4/25.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTextView.h"

@interface ReadCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerLb;
@property (weak, nonatomic) IBOutlet UILabel *footerLb;
@property (weak, nonatomic) IBOutlet HTextView *contentTextView;

@end
