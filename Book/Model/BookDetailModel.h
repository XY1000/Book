//
//  BookDetailModel.h
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseModel.h"

@class BookDetailUserreadbooklist,BookDetailBooknamelist,BookDetailBookinfolist,BookDetailBookcommentlist,BookDetailBookchaperlist;
@interface BookDetailModel : BaseModel



@property (nonatomic, strong) NSArray<BookDetailBookcommentlist *> *bookCommentList;

@property (nonatomic, strong) NSArray<BookDetailBooknamelist *> *bookNameList;

@property (nonatomic, strong) NSArray<BookDetailBookinfolist *> *bookInfoList;

@property (nonatomic, strong) NSArray<BookDetailUserreadbooklist *> *userReadBookList;

@property (nonatomic, strong) NSArray<BookDetailBookchaperlist *> *bookChaperList;



@end
@interface BookDetailUserreadbooklist : BaseModel

@property (nonatomic, copy) NSString *bookprice;

@property (nonatomic, copy) NSString *bookdiscountprice;

@property (nonatomic, assign) NSInteger bookid;

@property (nonatomic, copy) NSString *bookauthor;

@property (nonatomic, copy) NSString *booktype;

@property (nonatomic, copy) NSString *bookimageurl;

@property (nonatomic, copy) NSString *bookpress;

@property (nonatomic, copy) NSString *bookpublicationyear;

@property (nonatomic, copy) NSString *bookpviews;

@property (nonatomic, copy) NSString *bookcreattime;

@property (nonatomic, copy) NSString *bookname;

@property (nonatomic, copy) NSString *bookupdatetime;

@property (nonatomic, copy) NSString *bookinfoflag;

@property (nonatomic, copy) NSString *bookwordnumber;

@property (nonatomic, copy) NSString *bookisbn;

@property (nonatomic, copy) NSString *bookpreface;

@end

@interface BookDetailBooknamelist : BaseModel

@property (nonatomic, copy) NSString *bookprice;

@property (nonatomic, copy) NSString *bookdiscountprice;

@property (nonatomic, assign) NSInteger bookid;

@property (nonatomic, copy) NSString *bookauthor;

@property (nonatomic, copy) NSString *booktype;

@property (nonatomic, copy) NSString *bookimageurl;

@property (nonatomic, copy) NSString *bookpress;

@property (nonatomic, copy) NSString *bookpublicationyear;

@property (nonatomic, copy) NSString *bookpviews;

@property (nonatomic, copy) NSString *bookcreattime;

@property (nonatomic, copy) NSString *bookname;

@property (nonatomic, copy) NSString *bookupdatetime;

@property (nonatomic, copy) NSString *bookinfoflag;

@property (nonatomic, copy) NSString *bookwordnumber;

@property (nonatomic, copy) NSString *bookisbn;

@property (nonatomic, copy) NSString *bookpreface;

@end

@interface BookDetailBookinfolist : BaseModel

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

@interface BookDetailBookcommentlist : BaseModel

@property (nonatomic, assign) NSInteger bookid;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *bookcommentlocation;

@property (nonatomic, assign) NSInteger bookcommentid;

@property (nonatomic, copy) NSString *bookcommentcontent;

@property (nonatomic, assign) long long bookcommenttime;

@property (nonatomic, assign) NSInteger bookchaperid;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *usePhotoUrl;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic) NSInteger countCommentPraise;

@property (nonatomic, assign) NSInteger countCommentReplys;

@property (nonatomic, strong) NSString *commentreplycontent;
@end

@interface BookDetailBookchaperlist : BaseModel

@property (nonatomic, assign) NSInteger bookid;

@property (nonatomic, copy) NSString *bookchaptercontenturl;

@property (nonatomic, copy) NSString *bookchaptertitly;

@property (nonatomic, copy) NSString *bookchapterimageurl;

@property (nonatomic, assign) NSInteger bookchapterid;

@property (nonatomic, copy) NSString *bookchapterno;

@property (nonatomic, assign) BOOL bookchapterlock;

@end


