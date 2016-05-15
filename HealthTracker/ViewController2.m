//
//  ViewController2.m
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

#import "ViewController2.h"
#import "AppDelegate.h"

@interface ViewController2 ()

@property NSMutableArray* tableEntries;

@end

@implementation ViewController2

- (void)viewDidLoad { [super viewDidLoad]; }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _tableEntries = [[NSMutableArray alloc]  init];
        
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
        
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
        
    if ([results count] == 0) { NSLog(@"No matches"); }
    else
    {
        for (NSManagedObject *entity in results)
        {
            [_tableEntries addObject:entity];
        }
    }
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ return 1; }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return [_tableEntries count]; }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@ cal x %@",
                           [[_tableEntries objectAtIndex:indexPath.row] valueForKey:@"name"],
                           [[_tableEntries objectAtIndex:indexPath.row] valueForKey:@"calories"],
                           [[_tableEntries objectAtIndex:indexPath.row] valueForKey:@"quantity"]];
                           
    
    cell.backgroundColor = [UIColor colorWithRed:(32/255.0) green:(33/255.0) blue:(37/255.0) alpha:1];
    cell.textLabel.textColor = [UIColor greenColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath { }

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Food"];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:request error:&error];
        
        [_tableEntries removeObjectAtIndex:indexPath.row];
        [context deleteObject:[results objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [context save:&error];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end





















