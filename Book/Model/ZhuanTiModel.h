//
//  ZhuanTiModel.h
//  Book
//
//  Created by Apple on 16/4/11.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseModel.h"

@class Zhutiesarraymodel;
@interface ZhuanTiModel : BaseModel

@property (nonatomic, strong) NSArray<Zhutiesarraymodel *> *ZhuTiesArrayModel;

@end
@interface Zhutiesarraymodel : BaseModel

@property (nonatomic, assign) CGFloat bookprice;

@property (nonatomic, assign) NSInteger bookdiscountprice;

@property (nonatomic, assign) NSInteger bookid;

@property (nonatomic, copy) NSString *bookauthor;

@property (nonatomic, copy) NSString *booktype;

@property (nonatomic, copy) NSString *bookimageurl;

@property (nonatomic, copy) NSString *bookpress;

@property (nonatomic, copy) NSString *bookpublicationyear;

@property (nonatomic, assign) NSInteger bookpviews;

@property (nonatomic, assign) long long bookcreattime;

@property (nonatomic, copy) NSString *bookname;

@property (nonatomic, assign) long long bookupdatetime;

@property (nonatomic, copy) NSString *bookinfoflag;

@property (nonatomic, assign) NSInteger bookwordnumber;

@property (nonatomic, copy) NSString *bookisbn;

@property (nonatomic, copy) NSString *bookpreface;

@end

