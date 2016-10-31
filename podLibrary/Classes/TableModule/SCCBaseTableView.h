//
//  SCCBaseTableView.h
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCCBaseDataSource;
@class SCCTableSectionModel;

/*
 定义一个TableView的基类，不同数据源的Table模块只需继承此基类，实现借口函数即可
 */

@interface SCCBaseTableView : UIView

@property (nonatomic, weak) UIViewController *parentController;
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithCellClass:(Class)cellClass;

/*
 tableView cell的点击事件block
 */
@property (copy, nonatomic) void (^cellClickBlock)(NSIndexPath *indexPath, id data);

/*
 上拉加载新一页数据
 datas：下一页数据源
 */
- (void)loadNextDataSuccessBlock:(void(^)(NSArray* datas))successBlock;

/*
 下拉刷新数据源
 datas：新数据源
 */
- (void)loadDataSuccessBlock:(void(^)(NSArray* datas))successBlock;

/*
 可自行配置一些TableView参数
 */
- (void)tableViewConfigs;

/*
 数据加载结束
 */
- (void)finishLoadData;

/*
 数据加载前
 */
- (void)beforeLoadData;

/*
 注册不同的自定义dataSource
 */
- (Class)dataSourceClass;

/*
 创建section Header View
 */
- (UIView *)genenrateSectionHeaderWithSection:(NSInteger)section sectionModel:(SCCTableSectionModel *)model;
@end
