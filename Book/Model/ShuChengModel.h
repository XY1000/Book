//
//  ShuChengModel.h
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseModel.h"

@class ShuChengAlonebookModel,ShuChengTailoredbookModel,ShuChengAgospecialcolumnModel,BoolNewspecialcolumnModel,ShuChengHotbookModel,ShuChengNewgoodbookModel;
@interface ShuChengModel : BaseModel

@property (nonatomic, strong) NSArray<ShuChengAgospecialcolumnModel *> *agoSpecialColumn;

@property (nonatomic, strong) NSArray<ShuChengTailoredbookModel *> *tailoredBook;

@property (nonatomic, strong) NSArray<ShuChengHotbookModel *> *hotBook;

@property (nonatomic, strong) NSArray<ShuChengNewgoodbookModel *> *NewGoodBook;

@property (nonatomic, strong) NSArray<ShuChengAlonebookModel *> *aloneBook;

@property (nonatomic, strong) NSArray<BoolNewspecialcolumnModel *> *NewSpecialColumn;

@end
@interface ShuChengAlonebookModel : NSObject

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

@interface ShuChengTailoredbookModel : NSObject

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

@interface ShuChengAgospecialcolumnModel : NSObject

@property (nonatomic, copy) NSString *bookspeciallisttitlyurl;

@property (nonatomic, copy) NSString *bookspecialoriginalimageurl;

@property (nonatomic, copy) NSString *bookspecialcolumnthumbnailurl;

@property (nonatomic, assign) NSInteger bookspecialcolumnid;

@property (nonatomic, copy) NSString *bookspecialtitly;

@property (nonatomic, copy) NSString *bookspecialintroduction;

@end

@interface BoolNewspecialcolumnModel : NSObject

@property (nonatomic, copy) NSString *bookspeciallisttitlyurl;

@property (nonatomic, copy) NSString *bookspecialoriginalimageurl;

@property (nonatomic, copy) NSString *bookspecialcolumnthumbnailurl;

@property (nonatomic, assign) NSInteger bookspecialcolumnid;

@property (nonatomic, copy) NSString *bookspecialtitly;

@property (nonatomic, copy) NSString *bookspecialintroduction;

@end

@interface ShuChengHotbookModel : NSObject

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

@interface ShuChengNewgoodbookModel : NSObject

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

