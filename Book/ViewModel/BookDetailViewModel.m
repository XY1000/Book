//
//  BookDetailViewModel.m
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BookDetailViewModel.h"

@implementation BookDetailViewModel

- (instancetype)initWithPageFlg:(NSInteger)PageFlg BookId:(NSInteger)BookId UserId:(NSInteger)UserId
{
    if (self = [super init]) {
        _BookId = BookId;
        _PageFlg = PageFlg;
        _UserId = UserId;
    }return self;
}

- (NSArray *)bookInfoArr {
    if(_bookInfoArr == nil) {
        _bookInfoArr = [[NSArray alloc] init];
    }
    return _bookInfoArr;
}

- (NSArray *)bookCommentArr {
    if(_bookCommentArr == nil) {
        _bookCommentArr = [[NSArray alloc] init];
    }
    return _bookCommentArr;
}



- (NSArray *)bookNameArr {
    if(_bookNameArr == nil) {
        _bookNameArr = [[NSArray alloc] init];
    }
    return _bookNameArr;
}

- (NSArray *)userReadBookArr {
    if(_userReadBookArr == nil) {
        _userReadBookArr = [[NSArray alloc] init];
    }
    return _userReadBookArr;
}
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [BookDetailNetManager getBookDetailWithPageFlg:_PageFlg BookId:1 UserId:_UserId CompletionHandle:^(BookDetailModel * model, NSError *error) {
        self.bookInfoArr = model.bookInfoList;
        self.bookCommentArr = model.bookCommentList;
        self.bookChapterArr = model.bookChaperList;
        self.bookNameArr = model.bookNameList;
        self.userReadBookArr = model.userReadBookList;
        completionHandle(error);
    }];
}
/** 头部图书地址*/
- (NSURL *)topBookIconForRow:(NSInteger)row
{
    BookDetailBookinfolist *model = self.bookInfoArr[row];
    NSURL *url  = [NSURL URLWithString:model.bookimageurl];
    return url;
}
/** 头部书名*/
- (NSString *)topBookNameForRow:(NSInteger)row
{
    BookDetailBookinfolist *model = self.bookInfoArr[row];
    return model.bookname;
}
/** 头部作者名*/
- (NSString *)topBookAuthorForRow:(NSInteger)row
{
    BookDetailBookinfolist *model = self.bookInfoArr[row];
    return model.bookauthor;
}
/** 头部热度*/
- (NSInteger) topBookHotForRow:(NSInteger)row
{
    BookDetailBookinfolist *model = self.bookInfoArr[row];
    NSInteger hotNum = model.bookpviews/100;
    return hotNum;
}
/** 书籍简介*/
- (NSString *) topBookDetailForRow:(NSInteger)row
{
    BookDetailBookinfolist *model = self.bookInfoArr[row];
    return model.bookpreface;
}
/** 全部论坛评论数*/
- (NSInteger)bookCommentNum
{
    return self.bookCommentArr.count;
}
/** 好友头像*/
- (NSURL *)friendImageUrlForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    NSURL *url = [NSURL URLWithString:model.usePhotoUrl];
    return url;
}
/** 好友名字*/
- (NSString *)friendNameForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    return model.userName;
    
}
/** 评论内容*/
- (NSString *)bookCommentStrForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    return model.bookcommentcontent;
}
/**评论时间*/
- (NSString *)bookCommentTimeForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 时间戳
    NSTimeInterval createTime = model.bookcommenttime/1000;
   
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time >= 0 && time<=59) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    //     秒转分钟
    NSInteger mins = time/3600*60;
    if (mins < 60) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)mins];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];

    
}
/**被评论的书籍内容*/
- (NSString *)BookCommentDetailForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    return model.bookcommentlocation;
}
/**共xxx人赞*/
- (NSInteger)CommentPraisCountForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    return model.countCommentPraise;
}
/**查看全部评论数XXXX*/
- (NSInteger)CommentReplyCountForRow:(NSInteger)row
{
    BookDetailBookcommentlist *model = self.bookCommentArr[row];
    return model.countCommentReplys;
}

/** 作者其他作品图书的个数*/
- (NSInteger)bookNameNum
{
    return self.bookNameArr.count;
}
/** 作者其他作品图书图片地址*/
- (NSURL *) bookNameIconUrlForRow:(NSInteger)row
{
    BookDetailBooknamelist *model = self.bookNameArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
}
/** 作者其他作品图书名字*/
- (NSString *) bookNameBookForRow:(NSInteger)row
{
    BookDetailBooknamelist *model = self.bookNameArr[row];
    return model.bookname;
}
- (NSInteger)bookNameIdForRow:(NSInteger)row
{
    BookDetailBooknamelist *model = self.bookNameArr[row];
    return model.bookid;
}
/** 作者其他作品的作者*/
- (NSString *) bookNameAuthorForRow:(NSInteger)row
{
    BookDetailBooknamelist *model = self.bookNameArr[row];
    return model.bookauthor;
}
/**作者其他作品的简介*/
- (NSString *) bookNameDetailForRow:(NSInteger)row
{
    BookDetailBooknamelist *model = self.bookNameArr[row];
    return model.bookpreface;
}
/** 其他好友在读图书的个数*/
- (NSInteger)ueserReadBookNum
{
    return self.userReadBookArr.count;
}
/** 其他好友在读图书的图片*/
- (NSURL *)userReadBookIconUrlForRow:(NSInteger)row
{
    BookDetailUserreadbooklist *model = self.userReadBookArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
}
/** 其他好友在读书的名字*/
- (NSString *)userReadBookNameForRow:(NSInteger)row
{
    BookDetailUserreadbooklist *model = self.userReadBookArr[row];
    return model.bookname;
}
- (NSInteger)userReadBookIdForRow:(NSInteger)row
{
    BookDetailUserreadbooklist *model = self.userReadBookArr[row];
    return model.bookid;
}
/** 其他好友在读作品的作者*/
- (NSString *) userReadAuthorForRow:(NSInteger)row
{
    BookDetailUserreadbooklist *model = self.userReadBookArr[row];
    return model.bookauthor;
}
/**其他好友在读其他作品的简介*/
- (NSString *) userReadDetailForRow:(NSInteger)row
{
    BookDetailUserreadbooklist *model = self.userReadBookArr[row];
    return model.bookpreface;
}







@end
