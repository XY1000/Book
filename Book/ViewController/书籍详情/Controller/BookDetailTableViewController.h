//
//  BookDetailTableViewController.h
//  inject
//
//  Created by tmp on 16/4/8.
//  Copyright © 2016年 hxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailTableViewController : UITableViewController


//图书的id
@property (nonatomic) NSInteger BookId;
//pageFlg
@property (nonatomic) NSInteger PageFlg;
@property (nonatomic) NSInteger UserID;

- (id)initWithBookId:(NSInteger)bookId PageFlg:(NSInteger)PageFlg UserId:(NSInteger)UserId;
@end
