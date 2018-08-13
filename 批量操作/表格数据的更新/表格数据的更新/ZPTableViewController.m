//
//  ZPTableViewController.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTableViewController.h"
#import "ZPDeal.h"
#import "ZPTableViewCell.h"

@interface ZPTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *deals;
@property (nonatomic, strong) NSMutableArray *deleteDeals;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZPTableViewController

#pragma mark ————— 懒加载 —————
-(NSMutableArray *)deals
{
    if (_deals == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray)
        {
            ZPDeal *deal = [ZPDeal dealWithDict:dic];
            [tempArray addObject:deal];
        }
        
        _deals = tempArray;
    }
    
    return _deals;
}

- (NSMutableArray *)deleteDeals
{
    if (_deleteDeals == nil)
    {
        _deleteDeals = [NSMutableArray array];
    }
    
    return _deleteDeals;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark ————— 点击“删除”按钮 —————
- (IBAction)remove:(id)sender
{
    //把一个数组从另一个数组中删除
    [self.deals removeObjectsInArray:self.deleteDeals];
    
    [self.tableView reloadData];
    
    //在删除对象后清空数组，否则数组里面的元素会越来越多
    [self.deleteDeals removeAllObjects];
}

#pragma mark ————— UITableViewDataSource —————
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZPTableViewCell *cell = [ZPTableViewCell cellWithTableView:tableView];
    
    ZPDeal *deal = [self.deals objectAtIndex:indexPath.row];
    cell.deal = deal;
    
    if ([self.deleteDeals containsObject:deal])
    {
        cell.checkImageView.hidden = NO;
    }else
    {
        cell.checkImageView.hidden = YES;
    }
    
    return cell;
}

#pragma mark ————— UITableViewDelegate —————
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZPDeal *deal = [self.deals objectAtIndex:indexPath.row];
    if ([self.deleteDeals containsObject:deal])  //点击的cell所对应的对象包含在删除对象数组中，则把该对象移出数组
    {
        [self.deleteDeals removeObject:deal];
    }else  //点击的cell所对应的对象不包含在删除对象数组中，则把该对象添加到数组中
    {
        [self.deleteDeals addObject:deal];
    }
    
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
