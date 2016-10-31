//
//  SCCSectionDataSource.m
//  SCCExeTableView
//
//  Created by shen on 16/10/31.
//  Copyright © 2016年 shen. All rights reserved.
//

#import "SCCSectionDataSource.h"
#import "SCCTableSectionModel.h"
#import "SCCUtils.h"
#import "SCCBaseTableCell.h"

@implementation SCCSectionDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableDatas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SCCTableSectionModel *model = self.tableDatas[section];
    return [model.cellDatas count];
}

- (void)loadCellDataWithCell:(SCCBaseTableCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    SCCTableSectionModel *model = self.tableDatas[indexPath.section];
    if (!isNullArray(model.cellDatas)) {
        [cell loadData:model.cellDatas[indexPath.row]];
    }
    
}

@end
