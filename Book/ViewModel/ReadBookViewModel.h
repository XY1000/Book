//
//  ReadBookViewModel.h
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "BaseViewModel.h"
#import "BookDetailModel.h"

@interface ReadBookViewModel : BaseViewModel

//接收控制层传过来的数据
@property (nonatomic,readwrite,strong)BookDetailBookchaperlist *model;
//接受对字体的设置
@property (nonatomic,readwrite,strong)NSDictionary *attributes;

/** 只能使用这个初始化
 *  @author HXY
 *
 *  初始化
 *
 *  @param chapterList 接收控制层传过来的数据
 *  @param attributes  接受对字体的设置
 *  @param contentSize 显示区域的大小
 *
 *  @return 实例对象
 */
- (instancetype)initWithChapterList:(BookDetailBookchaperlist *)chapterListModel  fontConfigure:(NSDictionary *)attributes contentSize:(CGSize)contentSize;

//全部内容
@property (nonatomic,strong)NSAttributedString *allContent;

//返回某个章节的全部内容 (通过通知 返回数据 name:@"下载完成")
- (void)getChapterContentWithRow:(NSInteger)row;

//调整 章节内容
- (NSArray *)adjustContentWith:(NSDictionary *)attr;


@end
