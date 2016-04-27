//
//  BottomCell.h
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailViewModel.h"
@interface BottomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
