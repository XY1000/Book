//
//  MoreBookCell.h
//  Book
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLb;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLb;
@property (weak, nonatomic) IBOutlet UILabel *bookDescLb;

@end
