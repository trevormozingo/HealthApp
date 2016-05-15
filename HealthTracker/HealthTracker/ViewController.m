//
//  ViewController.m
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

/*
 https://developer.apple.com/library/ios/samplecode/Fit/Listings/Fit_AAPLProfileViewController_m.html
 */

#import "ViewController.h"
#import "AppDelegate.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if ([HKHealthStore isHealthDataAvailable] == NO) { return; }
    
    self.healthStore = [[HKHealthStore alloc] init];
    
    NSArray *readTypes = @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
                           [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:[NSSet setWithArray:readTypes] completion:^(BOOL success, NSError *error) { NSLog(@"Success is %d and error is %@", success, error);
        
        [self updateBodyMassIndex];
        [self updateActiveEnergyBurned];
    }];
    
    [self updateBodyMassIndex];
    [self updateActiveEnergyBurned];
    [self updateCalsEarned];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBodyMassIndex];
    [self updateActiveEnergyBurned];
    [self updateCalsEarned];
    [_calsEarnedLabel reloadInputViews];
    [_calsBurnedLabel reloadInputViews];
    [_netCalsLabel reloadInputViews];
    [_bmiLabel reloadInputViews];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateBodyMassIndex];
    [self updateActiveEnergyBurned];
    [self updateCalsEarned];
    [_calsEarnedLabel reloadInputViews];
    [_calsBurnedLabel reloadInputViews];
    [_netCalsLabel reloadInputViews];
    [_bmiLabel reloadInputViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateCalsEarned
{
    int total = 0;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    for (NSManagedObject *entity in results)
    {
        total += [[entity valueForKey:@"calories"] integerValue] * [[entity valueForKey:@"quantity"] integerValue];
    }
    
    _calsEarned = [NSNumber numberWithInteger:total];
    _calsEarnedLabel.text = [NSString stringWithFormat:@"%@", _calsEarned];
    _netCalsLabel.text =[NSString stringWithFormat:@"%@",
                         [NSNumber numberWithInt:   (int)(_calsEarned.integerValue - _calsBurned.integerValue)]];
}


-(void)updateActiveEnergyBurned
{
    NSDate *startDate, *endDate;
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate
                                                                     limit:1 //HKObjectQueryNoLimit
                                                           sortDescriptors:@[sortDescriptor]
                                                            resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                                                if(!error && results)
                                                                {
                                                                    HKUnit *en = [HKUnit calorieUnit];
                                                                    HKQuantitySample *samples = results.firstObject;
                                                                    HKQuantity *quantity = samples.quantity;
                                                                    _calsBurned = [NSNumber numberWithDouble:[quantity doubleValueForUnit:en]];
                                                                    
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        _calsBurnedLabel.text = [NSString stringWithFormat:@"%@", _calsBurned];
                                                                        
                                                                        _netCalsLabel.text =[NSString stringWithFormat:@"%@",
                                                                                             [NSNumber numberWithInt:   (int)(_calsEarned.integerValue - _calsBurned.integerValue)]];
                                                                    });
                                                                }
                                                            }];
    [_healthStore executeQuery:sampleQuery];
}

-(void)updateBodyMassIndex
{
    NSDate *startDate, *endDate;
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate
                                                         limit:1 //HKObjectQueryNoLimit
                                                          sortDescriptors:@[sortDescriptor]
                                                            resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                                                if(!error && results)
                                                                {
                                                                    HKUnit *bmi = [HKUnit countUnit];
                                                                    HKQuantitySample *samples = results.firstObject;
                                                                    HKQuantity *quantity = samples.quantity;
                                                                    _bmi = [NSNumber numberWithDouble:[quantity doubleValueForUnit:bmi]];
                                                                    
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        _bmiLabel.text = [NSString stringWithFormat:@"%@", _bmi];
                                                                    });
                                                                }
                                                            }];
    [_healthStore executeQuery:sampleQuery];
}








@end
















