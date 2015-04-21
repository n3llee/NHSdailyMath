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
@property (weak, nonatomic) IBOutlet UIButton *optionFourLabel;

@property(nonatomic) NSInteger selectedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eyesImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateEyes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateTreeOnY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateTreeOnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateTreeOnHCenterY;

@property(strong,nonatomic) NSTimer *clockTimer;
@property(nonatomic)NSInteger counter;
@property(nonatomic)NSInteger defaultTimer;

- (IBAction)chooseChallenges:(id)sender;




@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.optionThreeLabel.enabled = NO;
    self.optionFourLabel.enabled = YES;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.defaultTimer = 300;
    
    [self startTimer];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *selectedButton = sender;
    NSLog(@"sender: %@", selectedButton.accessibilityLabel);
    
    if (![selectedButton.accessibilityLabel isEqualToString:@"optionFour"]) {
        PlayViewController *playVC = segue.destinationViewController;
        
        playVC.defaultTimerSetting = self.selectedLabel;
    }
    
}


- (IBAction)chooseChallenges:(id)sender {
    UIButton * userChoosenButton = sender;
    
    if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionOne"]) {
        self.selectedLabel = 30;
    }
    else if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionTwo"])
    {
        self.selectedLabel = 60;
    }
    else if ([userChoosenButton.accessibilityLabel isEqualToString:@"optionThree"])
    {
        self.selectedLabel = 300;
    }
    else{
        self.selectedLabel = 0;
    }
    
    [self.clockTimer invalidate];
}

#pragma mark - Timer
-(void)startTimer
{
    
    self.counter = self.defaultTimer;
    
    
    self.clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    
    
}

-(void)countDownTimer
{
    self.counter -=1;
    
    NSLog(@"countDownTimer: %ld", self.counter);
    
    if (self.counter == 288) {
        [self animateBlinkingEyes];
        [self animateMovementOfTreeOnY];
    }
    else if (self.counter %5 == 0) {
        [self animateBlinkingEyes];
    }
    else if (self.counter %7 == 0) {
        [UIView animateWithDuration:2.0 animations:^{
            [self animateMovementOfEyes];
        }];
    
    }
    else if (self.counter %2 == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [self animateMovementOfTreeOnY];
//            [self animateMovementOfTreeOnH];
        }];
        
    }
    
}

#pragma mark - Animate
-(void)animateBlinkingEyes
{
    [UIView animateWithDuration:0.6 animations:^{
        self.eyesImageView.image = [UIImage imageNamed:@"daily_math_eyes_closed"];
    } completion:^(BOOL finished) {
        self.eyesImageView.image = [UIImage imageNamed:@"daily_math_eyes_open"];
    }];
}
-(void)animateMovementOfEyes
{

    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.animateEyes.constant = 139;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0.25 options:UIViewAnimationOptionCurveLinear animations:^{
            self.animateEyes.constant = 130;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.25 options:UIViewAnimationOptionCurveLinear animations:^{
                self.animateEyes.constant = 121;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 delay:0.25 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.animateEyes.constant = 130;
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                }];
                
            }];
            
        }];
        
    }];
}

-(void)animateMovementOfTreeOnY
{
    
    [UIView animateWithDuration:0.1 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.animateTreeOnY.constant = 44;
        self.animateTreeOnHCenterY.constant = 44;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.animateTreeOnY.constant = 36;
            self.animateTreeOnHCenterY.constant = 35;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.animateTreeOnY.constant = 44;
                self.animateTreeOnHCenterY.constant = 44;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.animateTreeOnY.constant = 36;
                    self.animateTreeOnHCenterY.constant = 35;
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                }];
                
            }];
            
        }];
        
    }];
}

-(void)animateMovementOfTreeOnH
{
    
    [UIView animateWithDuration:0.1 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.animateTreeOnH.constant = -154;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.animateTreeOnH.constant = -156;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                self.animateTreeOnH.constant = -158;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.animateTreeOnH.constant = -156;
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                }];
                
            }];
            
        }];
        
    }];
}
@end
