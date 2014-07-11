//
//  TransactionCategory+CategoryHelper.h
//  myBudget2
//
//  Created by Maciek Caputa on 05.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "TransactionCategory.h"

@interface TransactionCategory (CategoryHelper)

+ (NSArray *)getCategoriesInManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSDictionary *)getCategoriesSummaryinManagedObjectContext:(NSManagedObjectContext *)context;
+ (TransactionCategory *)categoryWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)addCategories:(NSArray *)categoriesArray inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSNumber *)getCategorysum:(NSString *)name inManagedObjectContext:context;
@end
