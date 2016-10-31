//
//  SCCBaseTableCell.m
//  SCCExeTableView
//
//  Created by shen on 16/10/27.
//  Copyright © 2016年 shen. All rights reserved.
//

#import "SCCBaseTableCell.h"

@interface SCCBaseTableCell()

@property (copy, nonatomic) id cellData;

@end

@implementation SCCBaseTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellUI];
    }
    return self;
}

- (void)initCellUI {
    
}

- (void)loadData:(id)data {
    
}

@end
