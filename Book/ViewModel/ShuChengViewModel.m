//
//  ShuChengViewModel.m
//  Book
//
//  Created by Apple on 16/4/6.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ShuChengViewModel.h"

@implementation ShuChengViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [ShuChengNetManager getBookMenuCompletionHandle:^(ShuChengModel * model, NSError *error) {
        
        self.gunArr = model.NewSpecialColumn;
        self.liangArr = model.tailoredBook;
        self.bottomArr = model.agoSpecialColumn;
        self.duArr = model.aloneBook;
        self.reArr = model.hotBook;
        self.xinArr = model.NewGoodBook;
        completionHandle(error);
    }];
}

- (NSInteger)gunNumber
{
    return self.gunArr.count;
}
- (NSArray *)gunArr
{
    if (!_gunArr) {
        _gunArr = [NSArray array];
    }return _gunArr;
}
- (NSArray *)liangArr
{
    if (!_liangArr) {
        _liangArr = [NSArray array];
    }return _liangArr;
}
-(NSArray *)reArr
{
    if (!_reArr) {
        _reArr = [NSArray array];
    }
    return _reArr;
}
- (NSArray *)duArr
{
    if (!_reArr) {
        _reArr = [NSArray array];
    }return _reArr;
}
/** 滚动图片数组*/
- (NSInteger)ZhuTiIdForRow:(NSInteger)row
{
    BoolNewspecialcolumnModel *model = self.gunArr[row];
    return model.bookspecialcolumnid;
}
- (NSURL *)guniconForRow:(NSInteger)row
{

        BoolNewspecialcolumnModel *model = self.gunArr[row];
        NSURL *url = [NSURL URLWithString:model.bookspecialcolumnthumbnailurl];
    
    return url;
}
- (NSURL *)BigImageForRow:(NSInteger)row
{
    BoolNewspecialcolumnModel *model = self.gunArr[row];
    NSURL *url = [NSURL URLWithString:model.bookspecialoriginalimageurl];
    return url;
}
- (NSString *)ZhuTitleForRow:(NSInteger)row
{
    BoolNewspecialcolumnModel *model = self.gunArr[row];
    NSString *title = model.bookspecialintroduction;
    return title;
}
-(BOOL)isExistIndexPic{
    return self.gunArr != nil && self.gunArr.count != 0;
}
/** 量身打造数组*/
- (NSInteger)liangBookIdForRow:(NSInteger)row
{
    ShuChengTailoredbookModel *model = self.liangArr[row];
    return model.bookid;
}

- (NSURL *)liangiconForRow:(NSInteger)row
{
    ShuChengTailoredbookModel *model = self.liangArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
}
- (NSString *)liangbookNameForRow:(NSInteger)row
{
    ShuChengTailoredbookModel *model = self.liangArr[row];
    return model.bookname;
}
- (NSString *)liangAuthorForRow:(NSInteger)row
{
    ShuChengTailoredbookModel *model = self.liangArr[row];
    return model.bookauthor;
}
- (NSString *)liangBookDetailForRow:(NSInteger)row
{
     ShuChengTailoredbookModel *model = self.liangArr[row];
    return model.bookpreface;
}
//底部图片数组
- (NSURL *)bottomImageForRow:(NSInteger)row
{
    ShuChengAgospecialcolumnModel *model = self.bottomArr[row];
    NSURL *url = [NSURL URLWithString:model.bookspecialcolumnthumbnailurl];
    return url;
}
- (NSInteger)BZhuTiIdForRow:(NSInteger)row
{
    ShuChengAgospecialcolumnModel *model = self.bottomArr[row];
    return model.bookspecialcolumnid;
}
- (NSURL *)BBigImageForRow:(NSInteger)row
{
    ShuChengAgospecialcolumnModel *model = self.bottomArr[row];
    NSURL *url = [NSURL URLWithString:model.bookspecialoriginalimageurl];
    return url;
}
- (NSString *)BZhuTitleForRow:(NSInteger)row
{
    ShuChengAgospecialcolumnModel *model = self.bottomArr[row];
    return model.bookspecialintroduction;
}
/** 新书推荐
 图书图片
 图书名字
 图书作者
 */
- (NSInteger)xinBookIdForRow:(NSInteger)row
{
    ShuChengNewgoodbookModel *model = self.xinArr[row];
    return model.bookid;
}
- (NSURL *)xiniconForRow:(NSInteger)row
{
    ShuChengNewgoodbookModel *model = self.xinArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
    
}
- (NSString *)xinbookNameForRow:(NSInteger)row
{
    ShuChengNewgoodbookModel *model = self.xinArr[row];
    return model.bookname;
}
- (NSString *)xinAuthorForRow:(NSInteger)row
{
    ShuChengNewgoodbookModel *model = self.xinArr[row];
    return model.bookauthor;
}
- (NSString *)xinBookDetailForRow:(NSInteger)row
{
    ShuChengNewgoodbookModel *model = self.xinArr[row];
    return model.bookpreface;
}
/** 热门欣赏
 图书图片
 图书名字
 图书作者
 */
- (NSInteger)reBookIdForRow:(NSInteger)row
{
    ShuChengHotbookModel *model = self.reArr[row];
    return model.bookid;
}
- (NSURL *)reiconForRow:(NSInteger)row
{
    ShuChengHotbookModel *model = self.reArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
}
- (NSString *)rebookNameForRow:(NSInteger)row
{
    ShuChengHotbookModel *model = self.reArr[row];
    return model.bookname;
}
- (NSString *)reAuthorForRow:(NSInteger)row
{
    ShuChengHotbookModel *model = self.reArr[row];
    return model.bookauthor;
}
- (NSString *)reBookDetailForRow:(NSInteger)row
{
    ShuChengHotbookModel *model = self.reArr[row];
    return model.bookpreface;
}
/** 独家首发
 图书图片
 图书名字
 图书作者
 */
- (NSInteger)duBookIdForRow:(NSInteger)row
{
    ShuChengAlonebookModel *model = self.duArr[row];
    return model.bookid;
}
- (NSURL *)duiconForRow:(NSInteger)row
{
    ShuChengAlonebookModel *model = self.duArr[row];
    NSURL *url = [NSURL URLWithString:model.bookimageurl];
    return url;
}
- (NSString *)dubookNameForRow:(NSInteger)row
{
    ShuChengAlonebookModel *model = self.duArr[row];
    return model.bookname;
}
- (NSString *)duAuthorForRow:(NSInteger)row
{
    ShuChengAlonebookModel *model = self.duArr[row];
    return model.bookauthor;
}
- (NSString *)duBookDetailForRow:(NSInteger)row
{
    ShuChengAlonebookModel *model = self.duArr[row];
    return model.bookpreface;
}
@end
