//
//  mybudgetMasterViewController.h
//  myBudget2
//
//  Created by Maciek Caputa on 31.05.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mybudgetData.h"
#import "mybudgetFiltered.h"
#import <CoreData/CoreData.h>

@interface mybudgetMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, mybudgetData, mybudgetFiltered>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSPredicate *predicate;
@property (nonatomic) BOOL reloadData;

@end
