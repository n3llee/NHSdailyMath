//
//  TopHalfMinuteTableViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/20/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "TopHalfMinuteTableViewController.h"
#import "DataStore.h"
#import "Score.h"
#import <M13ProgressViewBar.h>

@interface TopHalfMinuteTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *customLabelName;
@end

@implementation TopHalfMinuteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataManager = [DataStore sharedDataStore];
    [self.dataManager fetchData];
//    NSLog(@"%@", [self.dataManager scoreLeaderboard]);

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.dataManager fetchData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[self.dataManager scoreLeaderboard]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    UIView *graphView = (UIView *) [cell.contentView viewWithTag:2];
    UILabel *scoreLabel = (UILabel *) [cell.contentView viewWithTag:3];

    Score *userRank = self.dataManager.scoreLeaderboard[indexPath.row];
    
    Score *topUser = self.dataManager.scoreLeaderboard[0];
    float highestNumber = [topUser.score floatValue];
    label.text = userRank.name;
    
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    int userScore = [userRank.score intValue];
    progressView.progressTintColor = [UIColor colorWithRed:0.2 green:0.7 blue:0.2 alpha:1];
    progressView.progress = userScore/highestNumber;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.3f, 8.0f);
    progressView.transform = transform;
    [graphView addSubview:progressView];

    scoreLabel.text = [NSString stringWithFormat:@"%@ pts", userRank.score];
    self.tableView.separatorColor = [UIColor whiteColor];

    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 20;
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
