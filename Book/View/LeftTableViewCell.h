//
//  LeftTableViewCell.h
//  Book
//
//  Created by tmp on 16/4/19.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chapterNumLb;
@property (weak, nonatomic) IBOutlet UILabel *chapterNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *lockImGv;

@end
