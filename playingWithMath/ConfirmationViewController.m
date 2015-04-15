//
//  ConfirmationViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/14/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "ConfirmationViewController.h"

@interface ConfirmationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pointsEarned;

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pointsEarned.text = self.pointsCollected;
    // Do any additional setup after loading the view.
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

@end
