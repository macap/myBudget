//
//  setFilterViewController.h
//  myBudget2
//
//  Created by Maciek Caputa on 10.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mybudgetFiltered.h"

@interface setFilterViewController : UITableViewController

@property (strong,nonatomic) NSPredicate *predicate;
@property (weak, nonatomic) id<mybudgetFiltered> delegate;

@end
