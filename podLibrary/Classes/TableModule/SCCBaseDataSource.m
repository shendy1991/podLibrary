//
//  SCCBaseDataSource.m
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import "SCCBaseDataSource.h"
#import "SCCBaseTableCell.h"
#import "SCCUtils.h"

@interface SCCBaseDataSource()

@property (copy, nonatomic) NSString *cellLayoutClassName;
@property (copy, nonatomic) NSString *emptyCellLayoutClassName;

@end

@implementation SCCBaseDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCCBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSClassFromString([self _subClassName]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.parentController = self.parentController;
    }
    
    [self loadCellDataWithCell:cell indexPath:indexPath];
    
    return cell;
    
}

- (void)loadCellDataWithCell:(SCCBaseTableCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (!isNullArray(self.tableDatas)) {
        [cell loadData:self.tableDatas[indexPath.row]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableDatas count];
}

- (NSString *)_subClassName
{
    if (self.cellLayoutClassName) {
        return self.cellLayoutClassName;
    }else{
        return NSStringFromClass([SCCBaseTableCell class]);
    }
}

- (void)registerCellLayoutClass:(Class)registerClass
{
    self.cellLayoutClassName = NSStringFromClass(registerClass);
}

#pragma mark - 初始化数据
- (NSMutableArray *)tableDatas
{
    if (!_tableDatas) {
        _tableDatas = [[NSMutableArray alloc] init];
    }
    return _tableDatas;
}

@end
