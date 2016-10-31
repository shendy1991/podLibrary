//
//  SCCBaseDataSource.h
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SCCBaseTableCell;

/*
 定义一个DataSource的基类，如果定义不同cell layout 只需继承此接口修改指定不同cell layout
 */
@interface SCCBaseDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *tableDatas;
@property (nonatomic, weak) UIViewController *parentController;

- (void)loadCellDataWithCell:(SCCBaseTableCell *)cell indexPath:(NSIndexPath *)indexPath;
//注册cell样式的类名
- (void)registerCellLayoutClass:(Class)registerClass;
@end
