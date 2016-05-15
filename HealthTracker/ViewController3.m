//
//  ViewController3.m
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

#import "ViewController3.h"
#import "AppDelegate.h"
#import "ViewController2.h"

@implementation ViewController3
{
    NSString *food;
    NSNumber *calories;
    NSNumber *quantity;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [_foodLabel resignFirstResponder];
    [_calorieLabel resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    quantity = [NSNumber numberWithInt:1];
    _foodLabel.delegate = self;
    _calorieLabel.delegate = self;
    

}

- (IBAction)foodLabelEdit:(id)sender { food  = _foodLabel.text; }

- (IBAction)foodLabelBeginEdit:(id)sender { }

- (IBAction)calorieLabelEdit:(id)sender { calories = [NSNumber numberWithInt:[_calorieLabel.text intValue]]; }

- (IBAction)calorieLabelBeginEdit:(id)sender { }

- (IBAction)CancelPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)incrementButtonChanged:(id)sender
{
    quantity = [NSNumber numberWithInt:(int)_incrementButton.value];
    _quantityLabel.text = [NSString stringWithFormat:@"%@", quantity];
}

- (IBAction)addButtonChanged:(id)sender
{
    if (food != nil && calories != nil && quantity != nil)
    {
        if ([food length] > 0 && calories > 0 && [_calorieLabel.text length] > 0)
        {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            NSManagedObject *newFood;
            newFood = [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
            
            [newFood setValue:food forKey:@"name"];
            [newFood setValue:calories forKey:@"calories"];
            [newFood setValue:quantity forKey:@"quantity"];
            
            NSError *error;
            [context save:&error];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else { return; }
}




@end
















