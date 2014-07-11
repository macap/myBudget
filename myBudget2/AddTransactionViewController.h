//
//  AddTransactionViewController.h
//  myBudget2
//
//  Created by Maciek Caputa on 01.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mybudgetData.h"

@interface AddTransactionViewController : UITableViewController <mybudgetData, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
