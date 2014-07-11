//
//  mybudgetCategoryChartVC.h
//  myBudget2
//
//  Created by Maciek Caputa on 14.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mybudgetData.h"

@interface mybudgetCategoryChartVC : UIViewController <mybudgetData, UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
