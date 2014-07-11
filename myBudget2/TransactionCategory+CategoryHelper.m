//
//  TransactionCategory+CategoryHelper.m
//  myBudget2
//
//  Created by Maciek Caputa on 05.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "TransactionCategory+CategoryHelper.h"
#import "dateHelper.h"

@implementation TransactionCategory (CategoryHelper)


+ (NSArray *)getCategoriesInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TransactionCategory"];
    request.predicate=nil;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                           ascending:YES
                                                            selector:@selector(localizedStandardCompare:)];
    
    request.sortDescriptors = @[sort];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    

    
    return matches;
}
+ (TransactionCategory *)categoryWithName:(NSString *)name
                   inManagedObjectContext:(NSManagedObjectContext *)context {
    TransactionCategory *cat = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TransactionCategory"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            NSLog(@"matches count");
        } else if (![matches count]) {
            cat = [NSEntityDescription insertNewObjectForEntityForName:@"TransactionCategory"
                                                         inManagedObjectContext:context];
            
            cat.name = name;
            [context save:NULL];
            
        } else {
            cat = [matches lastObject];
        }
    }
    
    return cat;
}

+ (void)addCategories:(NSArray *)categoriesArray
inManagedObjectContext:(NSManagedObjectContext *)context
{
    for (NSString *name in categoriesArray)
        [self categoryWithName:name inManagedObjectContext:context];
}

+ (NSDictionary *)getCategoriesSummaryinManagedObjectContext:(NSManagedObjectContext *)context
{
    NSMutableDictionary *summary = [[NSMutableDictionary alloc] init];
    NSArray *cats = [TransactionCategory getCategoriesInManagedObjectContext:context];
    
    for (TransactionCategory *cat in cats) {
         NSNumber *value = [TransactionCategory getCategorysum:cat.name
                                     inManagedObjectContext:context];
        
        [summary setValue:value forKey:cat.name];
    }
    
    return summary;
}

+ (NSNumber *)getCategorysum:(NSString *)name inManagedObjectContext:context
{
    
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Transaction" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    dateHelper *dh = [[dateHelper alloc]init];
    
    request.predicate = [NSPredicate
                         predicateWithFormat:@"(date >= %@) AND (date <= %@) AND cat.name == %@ AND value <0",
                         [dh firstDateOfMonth],
                         [dh lastDateOfMonth],
                         name];
    
    // Execute the fetch.
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSNumber *theSum = [NSNumber numberWithFloat:[[objects valueForKeyPath:@"@sum.value"] floatValue]*-1] ;
    
    if (objects == nil) {
        return  0;
    }
    
    return theSum;
}

@end
