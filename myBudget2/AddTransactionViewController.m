//
//  AddTransactionViewController.m
//  myBudget2
//
//  Created by Maciek Caputa on 01.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

//!  Controller to add new transaction view.

#import "AddTransactionViewController.h"
#import "Transaction.h"
#import "TransactionCategory+CategoryHelper.h"

@interface AddTransactionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *transactionTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transactionType;
@property (weak, nonatomic) IBOutlet UITextField *transactionValue;
@property (weak, nonatomic) IBOutlet UISwitch *transactionIsPlanned;
@property (weak, nonatomic) IBOutlet UITextField *transactionCategory;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) UIPickerView *picker;

@property (strong,nonatomic) NSArray *cats;

@end

@implementation AddTransactionViewController

- (void)viewDidLoad
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateField setInputView:datePicker];
    
    [self getCats];
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 43, 320, 480)];
    self.picker.delegate=self;
    self.picker.dataSource=self;
    [_picker setShowsSelectionIndicator:YES];

    
    [self.transactionCategory setInputView:_picker];
    
    
    
    self.transactionTitle.delegate = self;
    self.transactionCategory.delegate = self;
    
    
    [self clearView];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)addButtonPressed:(UIButton *)sender {
    Transaction *transaction =
    [NSEntityDescription insertNewObjectForEntityForName:@"Transaction"
                               inManagedObjectContext:self.managedObjectContext];
    transaction.decription=self.transactionTitle.text;
    
    float value=[self.transactionValue.text floatValue];
    
    if (self.transactionType.selectedSegmentIndex==0)
        value*=-1;
    transaction.value =[NSNumber numberWithFloat:value];
    
    NSNumber *planned = [[NSNumber alloc] initWithInt:(self.transactionIsPlanned.isOn) ? 1 : 0];
    transaction.planned = planned;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];

    transaction.date=[dateFormat dateFromString:self.dateField.text];

    transaction.cat = [TransactionCategory categoryWithName:self.transactionCategory.text inManagedObjectContext:self.managedObjectContext];
    
    [self.managedObjectContext save:NULL];
    
    [self clearView];
    
}

- (NSArray *)getCats {
    if (!_cats) {
        NSArray *categories = [TransactionCategory getCategoriesInManagedObjectContext:self.managedObjectContext];
        NSMutableArray *categoriesNames = [[NSMutableArray alloc]init];
        
        if ([categories count])
            for (TransactionCategory *c in categories)
                [categoriesNames addObject:c.name];
        
        _cats=categoriesNames;
    }
    
    return _cats;
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];

    self.dateField.text = [dateFormat stringFromDate:picker.date];
}

- (void)clearView
{
    NSDateFormatter *today = [[NSDateFormatter alloc] init];
    [today setDateFormat:@"yyyy-MM-dd"];
    
    self.transactionTitle.text = @"";
    self.transactionValue.text = @"";
    self.transactionIsPlanned.on = 0;
    self.transactionCategory.text = @"";
    self.dateField.text= [today stringFromDate:[NSDate date]];
    
}
- (IBAction)doneButtonTap:(UIBarButtonItem *)sender {
    [self.transactionCategory resignFirstResponder];
    [self.transactionTitle resignFirstResponder];
    [self.transactionValue resignFirstResponder];
    [self.dateField resignFirstResponder];
}

#pragma mark - PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _cats.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _cats[row];
}

#pragma mark - PickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.transactionCategory.text = _cats[row];
    [self.transactionCategory resignFirstResponder];
}

@end
