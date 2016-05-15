//
//  ViewController3.h
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController3 : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *foodLabel;

@property (weak, nonatomic) IBOutlet UITextField *calorieLabel;

@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@property (weak, nonatomic) IBOutlet UIStepper *incrementButton;

@property (weak, nonatomic) IBOutlet UIButton *addButton;


- (IBAction)foodLabelEdit:(id)sender;

- (IBAction)foodLabelBeginEdit:(id)sender;

- (IBAction)calorieLabelEdit:(id)sender;

- (IBAction)calorieLabelBeginEdit:(id)sender;

- (IBAction)CancelPressed:(id)sender;

- (IBAction)incrementButtonChanged:(id)sender;

- (IBAction)addButtonChanged:(id)sender;

@end






