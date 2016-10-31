//
//  SCCBaseTableView.m
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import "SCCBaseTableView.h"
#import "SCCBaseDataSource.h"
#import "SCCUtils.h"
#import "SCCBaseTableCell.h"
#import <MJRefresh/MJRefresh.h>
#import "Masonry.h"
#import "SCCSectionDataSource.h"
#import "SCCTableSectionModel.h"

@interface SCCBaseTableView()<UITableViewDelegate>

@property (nonatomic, strong) SCCBaseDataSource *dataSource;;
@property (nonatomic, weak) Class cellClass;
@property (nonatomic, assign) CGFloat sectionHeaderViewHeight;
@end

@implementation SCCBaseTableView

- (instancetype)initWithCellClass:(Class)cellClass
{
    self = [super init];
    if (self) {
        self.cellClass = cellClass;
        [self _generateTableViewConfigs];
    }
    return self;
}

#pragma mark - 基本UI定义

- (void)_generateTableViewConfigs
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    if ([self.dataSource isKindOfClass:[SCCSectionDataSource class]]) {
        self.tableView.estimatedSectionHeaderHeight = 20;
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    }
    [self tableViewConfigs];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self _addTableViewPullDownRefresh];
    [self _addTAbleViewPullUpRefresh];
    
}

- (void)tableViewConfigs
{
    
}

#pragma mark - 集成刷新控件

- (void)_addTableViewPullDownRefresh
{
    @weakify(self)
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self _refreshTop];
    }];
}

- (void)_addTAbleViewPullUpRefresh
{
    @weakify(self)
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self _loadNextData];
    }];
}

- (void)_refreshTop
{
    @weakify(self)
    [self loadDataSuccessBlock:^(NSArray *datas) {
        
        @strongify(self)
        [self _loadTableWithDatas:datas];
        [self.tableView.header endRefreshing];
        
        if(!isNullArray(datas)){
            self.tableView.footer.hidden = NO;
            
        }else{
            self.tableView.footer.hidden = YES;
        }
        
        
    }];
}

- (void)_loadTableWithDatas:(NSArray *)datas {
    
    [self beforeLoadData];
    
    [self.dataSource.tableDatas removeAllObjects];
    
    if(!isNullArray(datas)){
        [self.dataSource.tableDatas addObjectsFromArray: datas];
        
    }else{
        self.tableView.tableFooterView = [[UIView alloc] init];
    }

    [self.tableView reloadData];
    
    [self finishLoadData];
    
}

- (void)_loadNextData {
    [self loadNextDataSuccessBlock:^(NSArray *arr) {
        if (isNullArray(arr)) {
            self.tableView.footer.hidden = YES;
        }else{
            [self.dataSource.tableDatas addObjectsFromArray: arr];
            [self.tableView reloadData];
        }
        [self.tableView.footer endRefreshing];
    }];
}

- (void)loadDataSuccessBlock:(void(^)(NSArray* datas))successBlock {
    successBlock(nil);
}

- (void)loadNextDataSuccessBlock:(void(^)(NSArray* datas))successBlock {
    successBlock(nil);
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!isNullArray(self.dataSource.tableDatas) && self.cellClickBlock) {
        
        id data;
        if ([self.dataSource isKindOfClass:[SCCSectionDataSource class]]) {
            SCCTableSectionModel *model = self.dataSource.tableDatas[indexPath.section];
            data = model.cellDatas[indexPath.row];
        } else {
            data = self.dataSource.tableDatas[indexPath.row];
        }
        
        self.cellClickBlock(indexPath, data);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self genenrateSectionHeaderWithSection:section sectionModel:self.dataSource.tableDatas[section]];
}

- (UIView *)genenrateSectionHeaderWithSection:(NSInteger)section sectionModel:(SCCTableSectionModel *)model
{
    return nil;
}

#pragma mark - action

- (void)beforeLoadData {
    
}

- (void)finishLoadData {
    
}

#pragma mark - 属性初始化

- (SCCBaseDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[[self dataSourceClass] alloc] init];
        [_dataSource registerCellLayoutClass:self.cellClass];
    }
    return _dataSource;
}

- (Class)dataSourceClass
{
    return [SCCBaseDataSource class];
}

- (void)setParentController:(UIViewController *)parentController {
    _parentController = parentController;
    self.dataSource.parentController = parentController;
}
@end
