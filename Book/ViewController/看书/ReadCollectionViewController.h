//
//  ReadCollectionViewController.h
//  Book
//
//  Created by tmp on 16/4/25.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"
#import "TopViewForRead.h"

@interface ReadCollectionViewController : UICollectionViewController

@property (nonatomic,strong)BookDetailBookchaperlist *chapterModel;

@property (nonatomic,strong)NSDictionary *attributes; //格式

@property (nonatomic,readwrite,assign)BOOL taped;

@end
