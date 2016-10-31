//
//  SCCBaseTableCell.h
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCBaseTableCell : UITableViewCell

@property (nonatomic, weak) UIViewController *parentController;

//子类继承父类，重写此方法，自定义每个cell 样式
- (void)initCellUI;

- (void)loadData:(id)data;
@end
