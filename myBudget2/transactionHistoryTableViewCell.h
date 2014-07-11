//
//  transactionHistoryCustomCellVCTableViewCell.h
//  myBudget2
//
//  Created by Maciek Caputa on 03.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transactionHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
