//
//  HomeViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/8/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "HomeViewController.h"
#import "PlayViewController.h"
#import <M13ProgressSuite/M13ProgressViewPie.h>

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *optionOneLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionThreeLabel;
@property(nonatomic) NSInteger selectedLabel;
- (IBAction)chooseChallenges:(id)sender;




@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.optionThreeLabel.enabled = NO;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayViewController *playVC = segue.destinationViewController;
    
    playVC.defaultTimerSetting = self.selectedLabel;
}


- (IBAction)chooseChallenges:(id)sender {
    UIButton * userChoosenButton = sender;
    
    if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionOne"]) {
        self.selectedLabel = 10;
    }
    else if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionTwo"])
    {
        self.selectedLabel = 60;
    }
    else if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionThree"])
    {
        self.selectedLabel = 300;
    }
}
@end
