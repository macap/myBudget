//
//  setFilterViewController.m
//  myBudget2
//
//  Created by Maciek Caputa on 10.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import "setFilterViewController.h"
#import "mybudgetMasterViewController.h"
#import "dateHelper.h"

@interface setFilterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *dateFromLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateToLabel;
@property (strong,nonatomic) dateHelper *datehelper;
@end

@implementation setFilterViewController

- (dateHelper *)datehelper
{
    if (!_datehelper) _datehelper= [[dateHelper alloc] init];
    return _datehelper;
}

- (NSPredicate *)predicate
{
    [self generatePredicate];
    return _predicate;
}

- (void)generatePredicate
{
   if (self.dateFromLabel.text || self.dateToLabel.text) {
        self.predicate= [NSPredicate
                         predicateWithFormat:@"(date >= %@) AND (date <= %@)",
                         [self.datehelper dateFromString:self.dateFromLabel.text],
                         [self.datehelper dateFromString:self.dateToLabel.text]];
    
    
    }
    
    
}

- (IBAction)addButtonPressed:(id)sender {
    self.delegate.predicate = self.predicate;
    self.delegate.reloadData = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //datepickers init
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker setDate:[self.datehelper firstDateOfMonth]];
    [datePicker addTarget:self action:@selector(updatedateFromLabel:) forControlEvents:UIControlEventValueChanged];
    [self.dateFromLabel setInputView:datePicker];
    
    UIDatePicker *datePicker2 = [[UIDatePicker alloc]init];
    datePicker2.datePickerMode=UIDatePickerModeDate;
    [datePicker2 setDate:[NSDate date]];
    [datePicker2 addTarget:self action:@selector(updatedateToLabel:) forControlEvents:UIControlEventValueChanged];
    [self.dateToLabel setInputView:datePicker2];
    
    self.dateFromLabel.text=[self.datehelper stringFromDate:[self.datehelper firstDateOfMonth]];
    self.dateToLabel.text=[self.datehelper stringFromDate:[self.datehelper lastDateOfMonth]];
}


-(void)updatedateFromLabel:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateFromLabel.inputView;
    self.dateFromLabel.text = [self.datehelper stringFromDate:picker.date];
}

-(void)updatedateToLabel:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateToLabel.inputView;
    self.dateToLabel.text = [self.datehelper stringFromDate:picker.date];
}


@end
