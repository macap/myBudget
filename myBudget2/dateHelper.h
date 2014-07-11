//
//  dateHelper.h
//  myBudget2
//
//  Created by Maciek Caputa on 13.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dateHelper : NSObject

@property (strong,nonatomic) NSString *dateFormat;

- (NSDate *)dateFromString:(NSString *)string;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSDate *)firstDateOfMonth;
- (NSDate *)lastDateOfMonth;

@end
