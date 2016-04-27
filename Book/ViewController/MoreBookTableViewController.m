//
//  MoreBookTableViewController.m
//  Book
//
//  Created by Apple on 16/4/15.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "MoreBookTableViewController.h"
#import "MoreBookCell.h"
#import "BookDetailTableViewController.h"
@interface MoreBookTableViewController ()

@end

@implementation MoreBookTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreBookCell" bundle:nil] forCellReuseIdentifier:@"MoreBookCell"];
        self.title = self.topTitle;
    UIBarButtonItem *item2= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Left-arrow-2"] style:UIBarButtonItemStylePlain target:self action:@selector(backShuKu)];
    self.navigationItem.leftBarButtonItem = item2;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
//返回上个界面
- (void)backShuKu{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (ShuChengViewModel *)shuVM
{
    if (!_shuVM) {
        _shuVM = [ShuChengViewModel new];
    }return _shuVM;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.BookSection == 0) {
        
    switch (self.section) {
        case 0:
            return self.shuVM.liangArr.count;
            break;
        case 1:
            return self.shuVM.xinArr.count;
            break;
        case 2:
            return self.shuVM.reArr.count;
            break;
        case 3:
            return self.shuVM.duArr.count;
            break;
        default:
            break;
    }
    }
    if (self.BookSection == 3) {
        NSLog(@"%ld",(long)self.bookVM.bookNameNum);
        return self.bookVM.bookNameNum;
    }
    if (self.BookSection == 4) {
        return self.bookVM.ueserReadBookNum;
    }

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreBookCell" forIndexPath:indexPath];
    if (self.BookSection == 0) {
    switch (self.section) {
        case 0:
            cell.bookNameLb.text = [self.shuVM liangbookNameForRow:indexPath.row];
            cell.bookAuthorLb.text = [self.shuVM liangAuthorForRow:indexPath.row];
            cell.bookDescLb.text = [self.shuVM liangBookDetailForRow:indexPath.row];
            [cell.bookImageView setImageWithURL:[self.shuVM liangiconForRow:indexPath.row]];
            break;
        case 1:
            cell.bookNameLb.text = [self.shuVM xinbookNameForRow:indexPath.row];
            cell.bookAuthorLb.text = [self.shuVM xinAuthorForRow:indexPath.row];
            cell.bookDescLb.text = [self.shuVM xinBookDetailForRow:indexPath.row];
            [cell.bookImageView setImageWithURL:[self.shuVM xiniconForRow:indexPath.row]];
            break;
        case 2:
            cell.bookNameLb.text = [self.shuVM rebookNameForRow:indexPath.row];
            cell.bookAuthorLb.text = [self.shuVM reAuthorForRow:indexPath.row];
            cell.bookDescLb.text = [self.shuVM reBookDetailForRow:indexPath.row];
            [cell.bookImageView setImageWithURL:[self.shuVM reiconForRow:indexPath.row]];
            break;
        case 3:
            cell.bookNameLb.text = [self.shuVM dubookNameForRow:indexPath.row];
            cell.bookAuthorLb.text = [self.shuVM duAuthorForRow:indexPath.row];
            cell.bookDescLb.text = [self.shuVM duBookDetailForRow:indexPath.row];
            [cell.bookImageView setImageWithURL:[self.shuVM duiconForRow:indexPath.row]];
            break;
        default:
            break;
    }
    }
    if (self.BookSection == 3 ) {
        [cell.bookImageView setImageWithURL:[self.bookVM bookNameIconUrlForRow:indexPath.row]];
        cell.bookNameLb.text = [self.bookVM bookNameBookForRow:indexPath.row];
        cell.bookAuthorLb.text = [self.bookVM bookNameAuthorForRow:indexPath.row];
        cell.bookDescLb.text = [self.bookVM bookNameDetailForRow:indexPath.row];
    }
    if (self.section == 4) {
        [cell.bookImageView setImageWithURL:[self.bookVM userReadBookIconUrlForRow:indexPath.row]];
        cell.bookNameLb.text = [self.bookVM userReadBookNameForRow:indexPath.row];
        cell.bookAuthorLb.text = [self.bookVM userReadAuthorForRow:indexPath.row];
        cell.bookDescLb.text = [self.bookVM userReadDetailForRow:indexPath.row];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BookDetail" bundle:nil];
    
    BookDetailTableViewController *vc = [story instantiateInitialViewController];
    if (self.BookSection == 0 ) {
    switch (self.section) {
        case 0:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM liangBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
            
            break;
        case 1:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM xinBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
            break;
            
        case 2:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM reBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
            break;
            
        case 3:
            vc = [[BookDetailTableViewController alloc]initWithBookId:[self.shuVM duBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
            break;
            
            
        default:
            break;
    }
    }
    if (self.BookSection == 3) {
        vc = [[BookDetailTableViewController alloc]initWithBookId:[self.bookVM bookNameIdForRow:indexPath.row] PageFlg:1 UserId:1];
    }
    if (self.BookSection == 4) {
        vc = [[BookDetailTableViewController alloc]initWithBookId:[self.bookVM userReadBookIdForRow:indexPath.row] PageFlg:1 UserId:1];
    }
    //            break;
    [self.navigationController pushViewController:vc animated:YES];

    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
