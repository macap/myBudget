//
//  Transaction.h
//  myBudget2
//
//  Created by Maciek Caputa on 01.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TransactionCategory;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * decription;
@property (nonatomic, retain) NSNumber * planned;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) TransactionCategory *cat;

@end
