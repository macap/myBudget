//
//  mybudgetSummaryViewController.m
//  myBudget2
//
//  Created by Maciek Caputa on 06.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "mybudgetSummaryViewController.h"
#import "Transaction.h"
#import "dateHelper.h"

@interface mybudgetSummaryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *spentLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end


@implementation mybudgetSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshView];
}

- (void)viewDidAppear:(BOOL)animated
{
        [self refreshView];
}

- (void)refreshView
{
    NSString *balance, *spent, *earned;
    balance=[self getBalance];
    spent =[self getSpent];
    earned = [NSString stringWithFormat:@"%.2f $", [balance floatValue] - [spent floatValue]];
    
    self.balanceLabel.text = balance;
    self.spentLabel.text = spent;
    self.earnedLabel.text = earned;
    self.daysLeftLabel.text = [self getDaysLeft];
    self.statusLabel.text=[self statusLabelForDiff:[earned floatValue] + [spent floatValue]];
}

- (NSString *)sumFromPredicate:(NSPredicate *)predicate
{
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
        request.predicate = predicate;
    
    // Execute the fetch.
    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    float theSum = [[objects valueForKeyPath:@"@sum.value"] floatValue];
    
    return [NSString stringWithFormat:@"%.2f $", theSum];
}

- (NSString *)getBalance
{
    dateHelper *dh = [[dateHelper alloc]init];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(date >= %@) AND (date <= %@)",
                              [dh firstDateOfMonth],
                              [dh lastDateOfMonth]];
    
    return [self sumFromPredicate:predicate];
}

- (NSString *)getSpent
{
    dateHelper *dh = [[dateHelper alloc]init];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(date >= %@) AND (date <= %@) AND (value <0)",
                              [dh firstDateOfMonth],
                              [dh lastDateOfMonth]];

    return [self sumFromPredicate:predicate];
}

- (NSString *)getDaysLeft
{
    dateHelper *dh = [[dateHelper alloc]init];
    NSTimeInterval diff = [[dh lastDateOfMonth] timeIntervalSinceDate:[NSDate date]];
    
    NSNumber *days = [NSNumber numberWithInt:(diff / 3600 / 24)];
    
    
    return [days stringValue];
    
}

- (NSString *)statusLabelForDiff:(float)diff
{
    NSString *status;

    if (diff >100) {
        self.weatherIcon.image = [UIImage imageNamed:@"sun"];
        status= @"Congratulations!";
    }
    else if (diff>0) {
        status= @"Be careful!";
        self.weatherIcon.image = [UIImage imageNamed:@"rain"];
    } else {
        status= @"You're in debt!";
        self.weatherIcon.image = [UIImage imageNamed:@"thunder"];
    }
    
    return status;
}

@end
