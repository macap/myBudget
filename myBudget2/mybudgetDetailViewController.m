//
//  mybudgetDetailViewController.m
//  myBudget2
//
//  Created by Maciek Caputa on 31.05.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "mybudgetDetailViewController.h"

@interface mybudgetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isPlannedSwitch;

- (void)configureView;

@end

@implementation mybudgetDetailViewController

- (IBAction)plannedSwitchChange:(UISwitch *)sender {
    if (sender.isOn) self.detailItem.planned = [NSNumber numberWithInt:1];
    else self.detailItem.planned=[NSNumber numberWithInt:0];
    [self.managedObjectContext save:NULL];
}

#pragma mark - Remove transaction

- (IBAction)removeButtonTap:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Remove transaction"
                                                     message:@"Are you sure to remove this transaction?"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
        [self removeTransaction];
    
}

- (void)removeTransaction
{
    [self.managedObjectContext deleteObject:self.detailItem];
    [self.managedObjectContext save:NULL];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    _detailItem=newDetailItem;
    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleLabel.text=self.detailItem.decription;
        self.categoryLabel.text=self.detailItem.cat.name;
        self.valueLabel.text=[NSString stringWithFormat:@"%.2f $", [self.detailItem.value floatValue]];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
       if ([self.detailItem.planned integerValue]) [self.isPlannedSwitch setOn:YES animated:YES];
        self.dateLabel.text=[dateFormat stringFromDate:self.detailItem.date];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
