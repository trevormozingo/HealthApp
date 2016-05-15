//
//  ViewController.h
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (nonatomic, retain) HKHealthStore *healthStore;

@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;

@property (weak, nonatomic) IBOutlet UILabel *calsEarnedLabel;

@property (weak, nonatomic) IBOutlet UILabel *calsBurnedLabel;

@property (weak, nonatomic) IBOutlet UILabel *netCalsLabel;


@property (weak, nonatomic) NSNumber *bmi;

@property (weak, nonatomic) NSNumber *calsEarned;

@property (weak, nonatomic) NSNumber *calsBurned;


@end





















