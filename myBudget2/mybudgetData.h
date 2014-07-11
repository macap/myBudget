//
//  mybudgetData.h
//  myBudget2
//
//  Created by Maciek Caputa on 02.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol mybudgetData <NSObject>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
