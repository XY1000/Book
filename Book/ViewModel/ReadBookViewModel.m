//
//  ReadBookViewModel.m
//  Book
//
//  Created by Apple on 16/4/16.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "ReadBookViewModel.h"
#import "BookDetailModel.h"


@interface ReadBookViewModel ()<NSURLSessionDelegate>

@property (nonatomic, strong)NSMutableData *fileData;
@property (nonatomic,assign)NSInteger allPageNum;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger allPage;

@end

@implementation ReadBookViewModel
{
    BOOL _isFinish;
    NSInteger totalPages_;
    CGSize _contentSize;
    NSString *_fileName;//保存文件的名字
   
}


- (instancetype)initWithChapterList:(BookDetailBookchaperlist *)chapterListModel fontConfigure:(NSDictionary *)attributes contentSize:(CGSize)contentSize {
    
    self = [super init];
    if (self) {
        
        self.attributes = attributes;
        self.model = chapterListModel;
        _contentSize  = contentSize;
        
        [[NSUserDefaults standardUserDefaults] setObject:@(_contentSize.height) forKey:@"contentH"];
        [[NSUserDefaults standardUserDefaults] setObject:@(_contentSize.width) forKey:@"contentW"];
        
    }
    
    return self;
}

//返回某个章节的全部内容
- (void)getChapterContentWithRow:(NSInteger)row {
    
    [self requestDataWithRow:row];
    
}

- (NSArray *)adjustContentWith:(NSDictionary *)attr {
    
    _attributes = attr;
    
    return [self textForPerPage];
}

- (void)requestDataWithRow:(NSInteger)row {
    
    
    NSString *str = self.model.bookchaptercontenturl;
    
    _fileName = [NSString stringWithFormat:@"%ld+%@.txt",(long)self.model.bookid,self.model.bookchapterno];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:_fileName];
    
    BOOL isExist = [manager fileExistsAtPath:path];
    
    //有缓存
    if (isExist) {
        
        NSNumber *contentH =  [[NSUserDefaults standardUserDefaults] objectForKey:@"contentH"];
        NSNumber *contentW = [[NSUserDefaults standardUserDefaults] objectForKey:@"contentW"];
        _contentSize = CGSizeMake(contentW.floatValue, contentH.floatValue);
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        self.allContent = [[NSAttributedString alloc]initWithString:[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]];
           
            [[NSNotificationCenter defaultCenter] postNotificationName:@"下载完成" object:self userInfo:@{
                                                                                                      
                                                                                                      /* 所有页的信息*/                               @"data":[self textForPerPage],
                                                                                                                                            
                                                                                                                                                @"exist":@(1)
                                                                                                                                                }];

        
      
        
        return;
    }
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *reques = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    [session downloadTaskWithRequest:reques completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        
    }];
    self.fileData = nil;
    self.fileData = [NSMutableData data];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:reques];
    
    [task resume];
    
}


#pragma mark - NSURLSessionDataDelegte

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
    [self.fileData appendData:data];
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
    
    [task cancel];
    
    NSString *docPath = NSTemporaryDirectory();
    NSString *filePath = [docPath stringByAppendingPathComponent:_fileName];
    BOOL saveSuccess =  [self.fileData writeToFile:filePath atomically:YES];
    
    if (saveSuccess) {
        
        NSLog(@"filePath %@", filePath);
        
        NSString *str = [[NSString alloc]initWithData:self.fileData encoding:NSUTF8StringEncoding];
        
        
        self.allContent = [[NSAttributedString alloc]initWithString:str];
        
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"下载完成" object:self userInfo:@{
                                                                                                          
                                                                                                          /* 所有页的信息*/                               @"data":[self textForPerPage],
                                                           @"exist":@(0)
                                                                                                                                                    
                                                                                                                                                    }];
                
                
            });
      
        
    }else {
        
        NSLog(@"写入失败");
        
    }
}

- (NSMutableData *)fileData {
    if(_fileData == nil) {
        _fileData = [[NSMutableData alloc] init];
    }
    return _fileData;
}


/* 对内容进行分页 */
-(NSArray *)textForPerPage
{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    CGFloat contentH = _contentSize.height;
    CGFloat contentW  = _contentSize.width - 20;
    /* 设定每页的页面尺寸 */
    NSUInteger height = contentH - 130; // 页面的高度
    
    
    /* 获取文本的总尺寸 */
    
    CGSize totalTextSize = [self.allContent.string boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:_attributes
                                                                context:nil].size;

    NSInteger textLength_ = 0;
    /* 开始分页 */
    if (totalTextSize.height < height) {
        /* 如果一页就能显示完，直接显示所有文本 */
        self.allPageNum   = 1;             // 设定总页数为1
        
        
        [arr addObject:self.allContent.string];
        
        // 不用分页
    }
    else {
        /* 计算理想状态下的页面数量和每页所显示的字符数量，用来作为参考值用 */
        textLength_                       = [self.allContent length] ;                   // 文本的总长度
        NSUInteger referTotalPages        = (int)totalTextSize.height / (int)height + 1; // 理想状态下的总页数
        NSUInteger referCharactersPerPage = textLength_ / referTotalPages;               // 理想状态下每页的字符数
        // 输出理想状态下的参数信息
        
        
        /* 根据referCharactersPerPage和text view的高度开始动态调整每页的字符数 */
        // 如果referCharactersPerPage过大，则直接调整至下限值，减少调整的时间
        if (referCharactersPerPage > 1000) {
            referCharactersPerPage = 1000;
        }
        
        // 获取理想状态下的每页文本的范围和pageText及其尺寸
        NSRange range       = NSMakeRange(referCharactersPerPage, referCharactersPerPage); // 一般第一页字符数较少，所以取第二页的文本范围作为调整的参考标准
        NSString *pageText  = [self.allContent.string substringWithRange:range]; // 获取该范围内的文本
        NSLog(@"%@",pageText);
        
        NSRange ptrange = NSMakeRange(0, pageText.length);
        NSDictionary *ptdic = [[self.allContent attributedSubstringFromRange:ptrange] attributesAtIndex:0 effectiveRange:&ptrange];
        CGSize pageTextSize = [pageText boundingRectWithSize:_contentSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:ptdic
                                                     context:nil].size;
        
        // 若pageText超出text view的显示范围，则调整referCharactersPerPage
        
        while (pageTextSize.height > height) {
            
            referCharactersPerPage -= 2;                                      // 每页字符数减2
            range                   = NSMakeRange(referCharactersPerPage, referCharactersPerPage); // 重置每页字符的范围
            ptdic = [[self.allContent attributedSubstringFromRange:range] attributesAtIndex:0 effectiveRange:&range];
            CGSize pageTextSize = [pageText boundingRectWithSize:_contentSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:ptdic
                                                         context:nil].size;
            pageText                = [self.allContent.string substringWithRange:range];        // 重置pageText
            
            pageTextSize = [pageText boundingRectWithSize:_contentSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin 
                                               attributes:ptdic
                                                  context:nil].size; // 获取pageText的尺寸
        }
        
        // 根据调整后的referCharactersPerPage设定好charsPerPage_
        NSInteger  charsPerPage_ = referCharactersPerPage;
        //        NSLog(@"cpp: %d", charsPerPage_);
        
        // 计算totalPages_
         totalPages_ = (int)self.allContent.string.length / charsPerPage_ + 1;

        // 计算最后一页的字符数，防止范围溢出
        NSInteger  charsOfLastPage_ = textLength_ - (totalPages_ - 1) * charsPerPage_;
    
        for (int i  = 0; i < totalPages_; i++) {
            
            NSRange ran ;
            
            if (i == totalPages_ - 1) {
                
                ran = NSMakeRange(i * charsPerPage_, charsOfLastPage_);
                
            }else {
                
                ran = NSMakeRange(i*charsPerPage_, charsPerPage_);
            }
            
            NSString *str = [self.allContent.string substringWithRange:ran];
            
            [arr addObject:str];
        }
        
    }
    return [arr copy];
    
}


@end
