//
//  ZPTableViewCell.h
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPDeal;

@interface ZPTableViewCell : UITableViewCell

@property (nonatomic, strong) ZPDeal *deal;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
