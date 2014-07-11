//
//  transactionHistoryCustomCellVCTableViewCell.m
//  myBudget2
//
//  Created by Maciek Caputa on 03.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "transactionHistoryTableViewCell.h"

@implementation transactionHistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
