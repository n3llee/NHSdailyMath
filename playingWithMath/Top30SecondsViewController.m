//
//  Top30SecondsViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/12/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "Top30SecondsViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface Top30SecondsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@end

@implementation Top30SecondsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.homeButton layer] setBorderWidth:2.0f];
    [[self.homeButton layer] setBorderColor:[UIColor whiteColor].CGColor];
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
