//
//  BookDetailViewModel.h
//  Book
//
//  Created by Apple on 16/4/12.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseViewModel.h"
#import "BookDetailNetManager.h"

@interface BookDetailViewModel : BaseViewModel

@property (nonatomic) NSInteger BookId;
@property (nonatomic) NSInteger PageFlg;
@property (nonatomic) NSInteger UserId;
- (instancetype)initWithPageFlg:(NSInteger)PageFlg BookId:(NSInteger)BookId UserId:(NSInteger)UserId;

//评论数量
@property (nonatomic) NSInteger bookCommentNum;
//作者其他书的个数
@property (nonatomic)  NSInteger bookNameNum;
//其他好友在读的图书个数
@property (nonatomic)  NSInteger ueserReadBookNum;
/**书籍基础信息数组*/
@property (nonatomic, strong) NSArray *bookInfoArr;
/**书籍评论想法数组*/
@property (nonatomic, strong) NSArray *bookCommentArr;

/**作者其他作品数组*/
@property (nonatomic, strong) NSArray *bookNameArr;
/**读过此书的好友在读*/
@property (nonatomic, strong) NSArray *userReadBookArr;

@property (nonatomic, strong) NSArray<BookDetailBookchaperlist *> *bookChapterArr;


/** 头部图书地址*/
- (NSURL *)topBookIconForRow:(NSInteger)row;
/** 头部书名*/
- (NSString *)topBookNameForRow:(NSInteger)row;
/** 头部作者名*/
- (NSString *)topBookAuthorForRow:(NSInteger)row;
/** 头部热度*/
- (NSInteger) topBookHotForRow:(NSInteger)row;
/** 书籍简介*/
- (NSString *) topBookDetailForRow:(NSInteger)row;
/** 评论内容*/
- (NSString *)bookCommentStrForRow:(NSInteger)row;
/**评论时间*/
- (NSString *)bookCommentTimeForRow:(NSInteger)row;
/** 好友头像*/
- (NSURL *)friendImageUrlForRow:(NSInteger)row;
/** 好友名字*/
- (NSString *)friendNameForRow:(NSInteger)row;
/**被评论的书籍内容*/
- (NSString *)BookCommentDetailForRow:(NSInteger)row;
/**共xxx人赞*/
- (NSInteger)CommentPraisCountForRow:(NSInteger)row;
/**查看全部评论数XXXX*/
- (NSInteger)CommentReplyCountForRow:(NSInteger)row;
/** 作者其他作品图书图片地址*/
- (NSURL *) bookNameIconUrlForRow:(NSInteger)row;
/** 作者其他作品图书名字*/
- (NSString *) bookNameBookForRow:(NSInteger)row;
/** 作者其他作品的作者*/
- (NSString *) bookNameAuthorForRow:(NSInteger)row;
/**作者其他作品的简介*/
- (NSString *) bookNameDetailForRow:(NSInteger)row;
/** 其他作者作品图书的Id*/
- (NSInteger) bookNameIdForRow:(NSInteger)row;
/** 其他好友在读图书的个数*/
- (NSInteger)ueserReadBookNum;
/** 其他好友在读图书的图片*/
- (NSURL *)userReadBookIconUrlForRow:(NSInteger)row;
/** 其他好友在读书的名字*/
- (NSString *)userReadBookNameForRow:(NSInteger)row;
/** 其他好友在读的书的id*/
- (NSInteger)userReadBookIdForRow:(NSInteger)row;
/** 其他好友在读作品的作者*/
- (NSString *) userReadAuthorForRow:(NSInteger)row;
/**其他好友在读其他作品的简介*/
- (NSString *) userReadDetailForRow:(NSInteger)row;



@end
