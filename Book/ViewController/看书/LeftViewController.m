//
//  LeftViewController.m
//  Book
//
//  Created by tmp on 16/4/22.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "ReadBookViewController.h"
#import "ReadCollectionViewController.h"
#import "UnderLineTableViewCell.h"

typedef NS_ENUM(NSUInteger, SegementStyle) {
    SegementStyleList,
    SegementStyleBookMark,
    SegementStyleUnderLine,
};

@interface LeftViewController ()<RESideMenuDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentRightLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayout;

@property (nonatomic,assign)SegementStyle style;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rightLayout.constant = kWindowW / 6.0;
    self.segmentRightLayout.constant = self.rightLayout.constant + 10;

    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UnderLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"underLineCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    ReadBookViewController *vc = (ReadBookViewController *)self.sideMenuViewController.contentViewController;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.style = SegementStyleList;
            self.allChapterList = vc.allChapterList;
            break;
        case 1:
            self.style = SegementStyleBookMark;
            
            break;
        case 2:
            self.style = SegementStyleUnderLine;
            self.allChapterList = GetObjectUserDefault(HBookUnderLineArr);
             break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allChapterList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    switch (self.style) {
        case SegementStyleList: {
            LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell" forIndexPath:indexPath];
            BookDetailBookchaperlist *model = self.allChapterList[indexPath.row];
            
            cell.chapterNumLb.text = model.bookchapterno;
            //    cell.chapterNameLb.text = @"";
            BOOL lock = model.bookchapterlock;
            
            if (!lock) {
                
                cell.lockImGv.image = nil;
            }
            return cell;
            break;
        }
        case SegementStyleBookMark: {
            
            break;
        }
        case SegementStyleUnderLine: {
            
            UnderLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"underLineCell" forIndexPath:indexPath];
            cell.titleLb.text = self.allChapterList[indexPath.row];
            
            return cell;
            break;
        }
    }
    
    
    
    return nil;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReadBookViewController *vc = (ReadBookViewController *)self.sideMenuViewController.contentViewController;
    
    [vc hideBottomAndNav];
    
    [vc.chapterCollectionView setContentOffset:CGPointMake(indexPath.row * kWindowW, 0)];
    
    [self.sideMenuViewController hideMenuViewController];

}



#pragma mark - SiderMenuDelegate

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    
    [self.view endEditing:YES];
    
   
}


@end
