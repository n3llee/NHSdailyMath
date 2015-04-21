//
//  SuccessViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/12/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "SuccessViewController.h"
#import "DataStore.h"
#import "Score.h"

@interface SuccessViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;
@property(strong, nonatomic)DataStore * dataManager;
@property(nonatomic)CGPoint originalCenter;
- (IBAction)saveDataTapped:(id)sender;


@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.messageLabel.text = @"You made it to our top scoring list.";
    // Do any additional setup after loading the view.
    self.dataManager = [DataStore sharedDataStore];
    
    [self.userNameLabel setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    self.originalCenter = self.view.center;
    [self.view addGestureRecognizer:tap];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameLabel resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard
{
    [self.userNameLabel resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y-30);
    } completion:^(BOOL finished) {
    }];
    
}
- (IBAction)saveDataTapped:(id)sender {
    
    NSString * selectedChallengesTime;

    if ([self.challengeTime isEqualToString:@"30"])
    {
        selectedChallengesTime = @"30 seconds";
    }
    else if ([self.challengeTime isEqualToString:@"60"])
    {
        selectedChallengesTime = @"full minutes";
    }
    
    if ([self.userNameLabel.text length] > 0 && [self.userNameLabel.text length] < 13) {
        [self.dataManager createNewDataWithName:self.userNameLabel.text scorePoint:self.pointsCollected selectedTime:selectedChallengesTime];
        
        NSLog(@"data store :%@", [self.dataManager scoreLeaderboard ]);
        
        [self.dataManager saveContext];
        [self.dataManager fetchData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Name"
                                                        message:@"You're record will not be saved."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

- (IBAction)tappedShareButton:(id)sender {
    
    NSString *textToShare = [NSString stringWithFormat:@"I earned %@ points in a minutes on Daily Math App, can you beat my points?", self.pointsCollected];
    
    UIImage * logo = [UIImage imageNamed:@"daily_math_main_header"];
    
    NSArray *objectsToShare = @[textToShare, logo];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [activityVC setValue:@"Daily Math Challenge!" forKey:@"Subject"];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
