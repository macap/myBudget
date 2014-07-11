//
//  mybudgetDetailViewController.h
//  myBudget2
//
//  Created by Maciek Caputa on 31.05.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "mybudgetData.h"
#import "TransactionCategory+CategoryHelper.h"

@interface mybudgetDetailViewController: UITableViewController <UIAlertViewDelegate, mybudgetData>

@property (strong, nonatomic) Transaction *detailItem;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
