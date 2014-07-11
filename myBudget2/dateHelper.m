//
//  dateHelper.m
//  myBudget2
//
//  Created by Maciek Caputa on 13.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "dateHelper.h"

@interface dateHelper()

@property (strong,nonatomic) NSDateFormatter *formatter;

@end

@implementation dateHelper

@synthesize dateFormat = _dateFormat;


-(NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:self.dateFormat];
    }
    return _formatter;
}

- (void)setDateFormat:(NSString *)dateFormat
{
    _dateFormat = dateFormat;
    [self.formatter setDateFormat:_dateFormat];
}

- (NSString *)dateFormat
{
    if (!_dateFormat) _dateFormat=@"yyyy-MM-dd";
    return _dateFormat;
}

- (NSDate *)dateFromString:(NSString *)string
{
    return [self.formatter dateFromString:string];
};

- (NSString *)stringFromDate:(NSDate *)date
{
    return [self.formatter stringFromDate:date];
};

- (NSDate *)firstDateOfMonth {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    return [self returnDateForMonth:comps.month year:comps.year day:1];
};

- (NSDate *)lastDateOfMonth {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    return [self returnDateForMonth:comps.month+1 year:comps.year day:0];
};

#pragma mark - month dates

- (NSDate *)returnDateForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorian dateFromComponents:components];
}

@end
