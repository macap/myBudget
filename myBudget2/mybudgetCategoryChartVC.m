//
//  mybudgetCategoryChartVC.m
//  myBudget2
//
//  Created by Maciek Caputa on 14.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "mybudgetCategoryChartVC.h"
#import "pieChartView.h"
#import "pieChartLegendView.h"
#import "dateHelper.h"
#import "mybudgetFiltered.h"
#import "TransactionCategory+CategoryHelper.h"

@interface mybudgetCategoryChartVC ()
@property (weak, nonatomic) IBOutlet pieChartView *chartView;
@property (weak, nonatomic) IBOutlet pieChartLegendView *legendView;
@property (strong, nonatomic) NSDictionary *data;
@end

@implementation mybudgetCategoryChartVC

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint where = [sender locationInView:self.legendView];
        NSInteger index = [self.legendView getTappedItemIndexAtPoint:where];
        if (index != -1) {
            NSArray *keys = [self.data allKeys];
            
            NSString *categoryName=keys[index];
            
            [self performSegueWithIdentifier:@"categoryDetails" sender:categoryName];
            
            
        }
    }
}

- (NSNumber *)budgetSum
{
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    dateHelper *dh = [[dateHelper alloc]init];
    
    request.predicate = [NSPredicate
                         predicateWithFormat:@"(date >= %@) AND (date <= %@) AND value <0",
                         [dh firstDateOfMonth],
                         [dh lastDateOfMonth]];

    NSError *error;
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSNumber *theSum = [NSNumber numberWithFloat:[[objects valueForKeyPath:@"@sum.value"] floatValue]*-1] ;
    
    if (objects == nil) {
        return 0;
    }
    
     return theSum;
}

- (NSDictionary *)getCategoryData
{
    NSNumber *sum = [self budgetSum];
    NSDictionary *catdata = [TransactionCategory getCategoriesSummaryinManagedObjectContext:self.managedObjectContext];
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in catdata) {
        NSNumber *value = catdata[key];
        value= [NSNumber numberWithFloat:[value floatValue]/[sum floatValue]];
        [d setValue:value forKey:key];
    }
    
    return d;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.data = [self getCategoryData];
    self.legendView.data=self.data;
    self.chartView.data=self.data;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.data = [self getCategoryData];
    self.legendView.data=self.data;
    self.chartView.data=self.data;
    [self.legendView setNeedsDisplay];
    [self.chartView setNeedsDisplay];
}

- (NSPredicate *)getPredicateForCategory:(NSString *)catname
{
    NSPredicate *predicate;
    dateHelper *dh = [[dateHelper alloc] init];
    
    predicate= [NSPredicate
                predicateWithFormat:@"(date >= %@) AND (date <= %@) AND cat.name == %@",
                [dh firstDateOfMonth],
                [dh lastDateOfMonth],
                catname];
    
    return predicate;
}

- (IBAction)addCategoryTapped:(UIBarButtonItem *)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Add category"
                                                     message:@"Enter category name"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert addButtonWithTitle:@"Add"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        UITextField *text = [alertView textFieldAtIndex:0];
        [TransactionCategory categoryWithName:text.text inManagedObjectContext:self.managedObjectContext];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"categoryDetails"]) {
        if ([sender isKindOfClass:[NSString class]]) {
                id <mybudgetFiltered, mybudgetData> vc = [segue destinationViewController];
                 vc.predicate = [self getPredicateForCategory:sender];
                vc.managedObjectContext = self.managedObjectContext;
        }
    }
}


@end
