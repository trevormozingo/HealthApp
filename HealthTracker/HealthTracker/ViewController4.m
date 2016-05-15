//
//  ViewController4.m
//  HealthTracker
//
//  Created by Trevor Mozingo on 4/30/16.
//  Copyright © 2016 Trevor Mozingo. All rights reserved.
//

#import "ViewController4.h"


@interface ViewController4()

@property NSArray *mySplit;

@end

@implementation ViewController4


- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *myPath = [[NSBundle mainBundle]pathForResource:@"estimates" ofType:@"txt"];
    NSString *myFile = [[NSString alloc]initWithContentsOfFile:myPath encoding:NSUTF8StringEncoding error:nil];
    _mySplit = [myFile componentsSeparatedByString:@"\n"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ return 1; }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return [_mySplit count]; }

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = _mySplit[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:(32/255.0) green:(33/255.0) blue:(37/255.0) alpha:1];
    cell.textLabel.textColor = [UIColor greenColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"Selected: %@", _mySplit[indexPath.row]);
}


@end
























