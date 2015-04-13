//
//  ViewController.m
//  playingWithMath
//
//  Created by Nelly Santoso on 3/20/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "PlayViewController.h"
#import "FISMathGenerator.h"
#import <QuartzCore/QuartzCore.h>
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import <JTNumberScrollAnimatedView.h>
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import <M13ProgressSuite/M13ProgressViewPie.h>


@interface PlayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mathQuestionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightOrWrongCheckMark;
@property (weak, nonatomic) IBOutlet UILabel *currentScore;
@property (weak, nonatomic) IBOutlet UILabel *highestScore;

@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *animatedView;
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *secondNumberAnimated;
@property (weak, nonatomic) IBOutlet UILabel *mathOperatorLabel;
//@property (weak, nonatomic) IBOutlet UIButton *settingButton;




@property (strong, nonatomic) NSString * correctAnswer;
@property (nonatomic)NSInteger answeredCorrectly;
@property (nonatomic)FISMathGenerator * myMath;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property(strong,nonatomic) NSTimer *clockTimer;
@property(nonatomic)NSInteger counter;

@property(strong, nonatomic)UIProgressView * progressBar;

@property(strong, nonatomic)HTPressableButton * optionOneButton;
@property(strong, nonatomic)HTPressableButton * optionTwoButton;
@property(strong, nonatomic)HTPressableButton * optionThreeButton;
@property(strong, nonatomic)HTPressableButton * optionFourButton;

@property(strong, nonatomic)M13ProgressViewPie * pieTimer;
@property(nonatomic)NSInteger pieCountMovement;
- (IBAction)answerButtonTapped:(id)sender;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setting the progress bar
//    self.progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
//    [self.view addSubview:self.progressBar];
    
//    CGAffineTransform transform = CGAffineTransformMakeScale(2.0f, 5.0f);
//    self.progressBar.transform = transform;
    
    //setting the animate questions
    self.animatedView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    self.secondNumberAnimated.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    self.mathOperatorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:52];
    
    //setting the layout and button shadow
    [self settingLayoutConstraints];
    
    [self settingTimerPie];
    [self restartTheGame];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.animatedView startAnimation];
    [self.secondNumberAnimated startAnimation];
}

-(void)restartTheGame
{
    self.answeredCorrectly = 0;
    NSLog(@"default timer setting is %ld", self.defaultTimerSetting);
//    self.timerLabel.hidden = YES;
    
    //run start the timer
    [self startTimer];
    
    
    self.myMath = [[FISMathGenerator alloc]init];
    
    [self generatorMathProblem];
    [self.animatedView startAnimation];
    [self.secondNumberAnimated startAnimation];
    self.currentScore.text = [NSString stringWithFormat:@"%ld",self.answeredCorrectly];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)answerButtonTapped:(id)sender {
    
    UIButton * option = sender;
//    NSLog(@"which button : %@",option.titleLabel.text);
    
    [self enabledAllButtons:NO];
    
    if ([option.titleLabel.text isEqualToString: self.correctAnswer]) {
        
        self.answeredCorrectly +=1;
        self.currentScore.text = [NSString stringWithFormat:@"%ld",self.answeredCorrectly];
        
        [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                self.rightOrWrongCheckMark.alpha = 1;
                self.rightOrWrongCheckMark.backgroundColor = [UIColor clearColor];
                self.rightOrWrongCheckMark.image = [UIImage imageNamed:@"check.png"];
                self.currentScore.text = [NSString stringWithFormat:@"%ld",self.answeredCorrectly];
            }];
        } completion:^(BOOL finished) {
            self.rightOrWrongCheckMark.alpha = 0;
            
            [self generatorMathProblem];
            [self viewDidAppear:YES];
            [self generateAnimation];
            
        }];
        
    }
    else
    {
        [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                self.rightOrWrongCheckMark.alpha = 1;
                self.rightOrWrongCheckMark.backgroundColor = [UIColor clearColor];
                self.rightOrWrongCheckMark.image = [UIImage imageNamed:@"cross.png"];
                self.currentScore.text = [NSString stringWithFormat:@"%ld",self.answeredCorrectly];
            }];
        } completion:^(BOOL finished) {
            self.rightOrWrongCheckMark.alpha = 0;
            
            [self generatorMathProblem];
            [self viewDidAppear:YES];
            [self generateAnimation];
        }];
    }
}

-(void) generatorMathProblem
{
    [self enabledAllButtons:YES];
    
    [self.myMath settingQuestionAndAnswer];
    
    //setting the label to have the questions
    // in string format
    self.mathQuestionLabel.text = self.myMath.question;
    NSLog(@"question is %@", self.mathQuestionLabel.text);
    
    // in array format
    [self.animatedView setValue:self.myMath.breakDownQuestionInArray[0]];
    self.mathOperatorLabel.text = self.myMath.breakDownQuestionInArray[1];
    [self.secondNumberAnimated setValue: self.myMath.breakDownQuestionInArray[2]];
    
    // grab the correct answer
    self.correctAnswer = self.myMath.answer;
    NSLog(@"correct answer is %@", self.correctAnswer);
    
    //setting the button to have the answers
    NSArray * answersForButton = self.myMath.answers;
    
    NSLog(@"possible answer is %@", answersForButton);
    
    [self.optionOneButton setTitle:answersForButton[0] forState:UIControlStateNormal];
    [self.optionTwoButton setTitle:answersForButton[1] forState:UIControlStateNormal];
    [self.optionThreeButton setTitle:answersForButton[2] forState:UIControlStateNormal];
    [self.optionFourButton setTitle:answersForButton[3] forState:UIControlStateNormal];
    
}

-(void)generateAnimation
{
    self.mathQuestionLabel.alpha = 0;
    self.optionOneButton.alpha = 0;
    self.optionTwoButton.alpha = 0;
    self.optionThreeButton.alpha = 0;
    self.optionFourButton.alpha = 0;
    
    [UIView animateWithDuration:1.5 delay:0.0 options:0 animations:^{
        self.mathQuestionLabel.alpha = 1;
        self.optionOneButton.alpha = 1;
        self.optionTwoButton.alpha = 1;
        self.optionThreeButton.alpha = 1;
        self.optionFourButton.alpha = 1;
    } completion:nil];
}

-(void)startTimer
{
    [self enabledAllButtons:YES];
    

    self.timerLabel.alpha = 0;
    self.counter = self.defaultTimerSetting;
    self.pieCountMovement = 0;
    self.clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %ld", self.counter];

    
}

-(void)countDownTimer
{
    self.counter -=1;
    self.pieCountMovement +=1;
//    self.timerLabel.text = [NSString stringWithFormat:@"Time: %ld", self.counter];
    self.progressBar.hidden = YES;
    self.progressBar.progress = (float)self.counter/(float)self.defaultTimerSetting;
    self.progressBar.progressTintColor = [UIColor greenColor];
    
    NSLog(@"countDownTimer: %ld", self.counter);
    float piePoint = (1.0/self.defaultTimerSetting) * self.pieCountMovement;
    [self.pieTimer setProgress:piePoint animated:NO];

    if (self.counter == 0) {
        self.optionOneButton.enabled = NO;
        self.optionTwoButton.enabled = NO;
        self.optionThreeButton.enabled = NO;
        self.optionFourButton.enabled = NO;
        [self checkUserScore];
        [self.clockTimer invalidate];
    }
    
    if (self.counter < 6) {
        self.timerLabel.textColor = [UIColor redColor];
        self.progressBar.progressTintColor = [UIColor redColor];
    }
    
}


-(void)checkUserScore
{
    if (self.answeredCorrectly > 0) {
//        [self showSuccessAlert:YES];
        
        [self sendUserToConfirmationPageWithController:@"SuccessVC"];
    }
    else if (self.answeredCorrectly == 0)
    {
        [self sendUserToConfirmationPageWithController:@"FailedVC"];
//        [self showSuccessAlert:NO];
    }
    
}


-(void)sendUserToConfirmationPageWithController:(NSString *)controllerName
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:controllerName];
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)showSuccessAlert:(BOOL) isSuccess
{
    SCLAlertView * myAlert = [[SCLAlertView alloc]init];
    [myAlert addButton:@"Play again!" actionBlock:^(void) {
        [self restartTheGame
         ];
    }];
    
    if (isSuccess == NO) {
        
        [myAlert showError:self title:@"Error" subTitle:@"sub view" closeButtonTitle:@"Close" duration:0.0f];
        
        
    }
    else if (isSuccess == YES)
    {
        [myAlert showSuccess:self title:@"Congratulations" subTitle:@"subview" closeButtonTitle:@"Close" duration:0.0f];
    }
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventSubtypeMotionShake) {
        NSLog(@"shake it");
        [self generatorMathProblem];
    }
    
}

-(void)enabledAllButtons:(BOOL) isEnable
{
    self.optionOneButton.enabled = isEnable;
    self.optionTwoButton.enabled = isEnable;
    self.optionThreeButton.enabled = isEnable;
    self.optionFourButton.enabled = isEnable;
    
}

-(HTPressableButton *)createACircularButton
{
    //Circular mint color button
    CGRect frame = CGRectMake(50, 300, 85, 85);
    HTPressableButton *circularButton = [[HTPressableButton alloc] initWithFrame:frame buttonStyle:HTPressableButtonStyleCircular];
    circularButton.buttonColor = [UIColor ht_concreteColor];
    circularButton.shadowColor = [UIColor ht_asbestosColor];
    [circularButton setDisabledButtonColor:[UIColor ht_silverColor]];
    [self.view addSubview:circularButton];
    
    return circularButton;
}


-(void)settingTimerPie
{
    self.pieTimer = [[M13ProgressViewPie alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.view addSubview:self.pieTimer];
    self.pieTimer.center = CGPointMake(self.view.center.x *1.75 , self.view.center.y/5);
}
-(void)settingAnsweredButtons
{
    self.optionOneButton = [self createACircularButton];
    self.optionTwoButton = [self createACircularButton];
    self.optionThreeButton = [self createACircularButton];
    self.optionFourButton = [self createACircularButton];
    
    [self.optionOneButton addTarget:self action:@selector(answerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.optionTwoButton addTarget:self action:@selector(answerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.optionThreeButton addTarget:self action:@selector(answerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.optionFourButton addTarget:self action:@selector(answerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)settingLayoutConstraints
{
    [self.view removeConstraints:self.view.constraints];
    [self.mathQuestionLabel removeConstraints:self.mathQuestionLabel.constraints];
    [self.rightOrWrongCheckMark removeConstraints:self.rightOrWrongCheckMark.constraints];
    [self.currentScore removeConstraints:self.currentScore.constraints];
    [self.highestScore removeConstraints:self.highestScore.constraints];
    [self.progressBar removeConstraints:self.progressBar.constraints];
    [self.animatedView removeConstraints:self.animatedView.constraints];
    [self.secondNumberAnimated removeConstraints:self.secondNumberAnimated.constraints];
    [self.mathOperatorLabel removeConstraints:self.mathOperatorLabel.constraints];
//    [self.settingButton removeConstraints:self.settingButton.constraints];
    
    [self settingAnsweredButtons];
    
    self.mathQuestionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightOrWrongCheckMark.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentScore.translatesAutoresizingMaskIntoConstraints = NO;
    self.highestScore.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.animatedView.translatesAutoresizingMaskIntoConstraints = NO;
    self.secondNumberAnimated.translatesAutoresizingMaskIntoConstraints = NO;
    self.mathOperatorLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.settingButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.optionOneButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.optionTwoButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.optionThreeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.optionFourButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // set answer button
    NSLayoutConstraint * buttonOneCenterX = [NSLayoutConstraint constraintWithItem:self.optionOneButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0];
    [self.view addConstraint:buttonOneCenterX];

    NSLayoutConstraint * buttonOneCenterY = [NSLayoutConstraint constraintWithItem:self.optionOneButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.25 constant:0];
    [self.view addConstraint:buttonOneCenterY];
    
    NSLayoutConstraint * buttonTwoCenterX = [NSLayoutConstraint constraintWithItem:self.optionTwoButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0];
    [self.view addConstraint:buttonTwoCenterX];
    
    NSLayoutConstraint * buttonTwoCenterY = [NSLayoutConstraint constraintWithItem:self.optionTwoButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.25 constant:0];
    [self.view addConstraint:buttonTwoCenterY];
    
    NSLayoutConstraint * buttonThreeCenterX = [NSLayoutConstraint constraintWithItem:self.optionThreeButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0];
    [self.view addConstraint:buttonThreeCenterX];
    
    NSLayoutConstraint * buttonThreeCenterY = [NSLayoutConstraint constraintWithItem:self.optionThreeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.6 constant:0];
    [self.view addConstraint:buttonThreeCenterY];
    
    NSLayoutConstraint * buttonFourCenterX = [NSLayoutConstraint constraintWithItem:self.optionFourButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5 constant:0];
    [self.view addConstraint:buttonFourCenterX];
    
    NSLayoutConstraint * buttonFourCenterY = [NSLayoutConstraint constraintWithItem:self.optionFourButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.6 constant:0];
    [self.view addConstraint:buttonFourCenterY];
    
    // set math question (2 digits and math operator) and check mark
    NSLayoutConstraint * mathQuestionLabelWidth = [NSLayoutConstraint constraintWithItem:self.mathQuestionLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0];
    [self.view addConstraint:mathQuestionLabelWidth];
    
    NSLayoutConstraint * mathQuestionLabelHeight = [NSLayoutConstraint constraintWithItem:self.mathQuestionLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.05 constant:0];
    [self.view addConstraint:mathQuestionLabelHeight];
    
    NSLayoutConstraint * mathQuestionLabelX = [NSLayoutConstraint constraintWithItem:self.mathQuestionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:mathQuestionLabelX];
    
    NSLayoutConstraint * mathQuestionLabelY = [NSLayoutConstraint constraintWithItem:self.mathQuestionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.40 constant:0];
    [self.view addConstraint:mathQuestionLabelY];
    
    NSLayoutConstraint * animatedViewWidth = [NSLayoutConstraint constraintWithItem:self.animatedView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.18 constant:0];
    [self.view addConstraint:animatedViewWidth];
    
    NSLayoutConstraint * animatedViewHeight = [NSLayoutConstraint constraintWithItem:self.animatedView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.08 constant:0];
    [self.view addConstraint:animatedViewHeight];
    
    NSLayoutConstraint * animatedViewCenterX = [NSLayoutConstraint constraintWithItem:self.animatedView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.6 constant:0];
    [self.view addConstraint:animatedViewCenterX];
    
    NSLayoutConstraint * animatedViewCenterY = [NSLayoutConstraint constraintWithItem:self.animatedView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.6 constant:0];
    [self.view addConstraint:animatedViewCenterY];
    
    NSLayoutConstraint * secondNumberAnimatedWidth = [NSLayoutConstraint constraintWithItem:self.secondNumberAnimated attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.18 constant:0];
    [self.view addConstraint:secondNumberAnimatedWidth];
    
    NSLayoutConstraint * secondNumberAnimatedHeight = [NSLayoutConstraint constraintWithItem:self.secondNumberAnimated attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.08 constant:0];
    [self.view addConstraint:secondNumberAnimatedHeight];
    
    NSLayoutConstraint * secondNumberAnimatedCenterX = [NSLayoutConstraint constraintWithItem:self.secondNumberAnimated attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.3 constant:0];
    [self.view addConstraint:secondNumberAnimatedCenterX];
    
    NSLayoutConstraint * secondNumberAnimatedCenterY = [NSLayoutConstraint constraintWithItem:self.secondNumberAnimated attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.6 constant:0];
    [self.view addConstraint:secondNumberAnimatedCenterY];
    
    NSLayoutConstraint * mathOperatorWidth = [NSLayoutConstraint constraintWithItem:self.mathOperatorLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.1 constant:0];
    [self.view addConstraint:mathOperatorWidth];
    
    NSLayoutConstraint * mathOperatorHeight = [NSLayoutConstraint constraintWithItem:self.mathOperatorLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.08 constant:0];
    [self.view addConstraint:mathOperatorHeight];
    
    NSLayoutConstraint * mathOperatorCenterX = [NSLayoutConstraint constraintWithItem:self.mathOperatorLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:mathOperatorCenterX];
    
    NSLayoutConstraint * mathOperatorCenterY = [NSLayoutConstraint constraintWithItem:self.mathOperatorLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.6 constant:0];
    [self.view addConstraint:mathOperatorCenterY];
    
    NSLayoutConstraint * checkMarkWidth = [NSLayoutConstraint constraintWithItem:self.rightOrWrongCheckMark attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0];
    [self.view addConstraint:checkMarkWidth];
    
    NSLayoutConstraint * checkMarkHeight = [NSLayoutConstraint constraintWithItem:self.rightOrWrongCheckMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.10 constant:0];
    [self.view addConstraint:checkMarkHeight];
    
    NSLayoutConstraint *checkMarkCenterX = [NSLayoutConstraint constraintWithItem:self.rightOrWrongCheckMark attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:checkMarkCenterX];
    
    NSLayoutConstraint *checkMarkCenterY = [NSLayoutConstraint constraintWithItem:self.rightOrWrongCheckMark attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.9 constant:0];
    [self.view addConstraint:checkMarkCenterY];
    
    
    // set currentscore, highest score, timer, progress bar, and setting wheel button
    NSLayoutConstraint * currentScoreWidth = [NSLayoutConstraint constraintWithItem:self.currentScore attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0];
    [self.view addConstraint:currentScoreWidth];
    
    NSLayoutConstraint * currentScoreHeight = [NSLayoutConstraint constraintWithItem:self.currentScore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.05 constant:0];
    [self.view addConstraint:currentScoreHeight];
    
    NSLayoutConstraint * currentScoreCenterX = [NSLayoutConstraint constraintWithItem:self.currentScore attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.4 constant:0];
    [self.view addConstraint:currentScoreCenterX];
    
    NSLayoutConstraint * currentScoreCenterY = [NSLayoutConstraint constraintWithItem:self.currentScore attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.2 constant:0];
    [self.view addConstraint:currentScoreCenterY];
    
    NSLayoutConstraint * highestScoreWidth = [NSLayoutConstraint constraintWithItem:self.highestScore attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.2 constant:0];
    [self.view addConstraint:highestScoreWidth];
    
    NSLayoutConstraint * highestScoreHeight = [NSLayoutConstraint constraintWithItem:self.highestScore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.05 constant:0];
    [self.view addConstraint:highestScoreHeight];
    
    NSLayoutConstraint * highestScoreCenterX = [NSLayoutConstraint constraintWithItem:self.highestScore attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.6 constant:0];
    [self.view addConstraint:highestScoreCenterX];
    
    NSLayoutConstraint * highestScoreCenterY = [NSLayoutConstraint constraintWithItem:self.highestScore attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.2 constant:0];
    [self.view addConstraint:highestScoreCenterY];
    
    NSLayoutConstraint * timerLabelWidth = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0];
    [self.view addConstraint:timerLabelWidth];
    
    NSLayoutConstraint * timerLabelHeight = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.03 constant:0];
    [self.view addConstraint:timerLabelHeight];
    
    NSLayoutConstraint * timerLabelCenterX = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:timerLabelCenterX];
    
    NSLayoutConstraint * timerLabelCenterY = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.80 constant:0];
    [self.view addConstraint:timerLabelCenterY];
    
//    NSLayoutConstraint *progressBarWidth = [NSLayoutConstraint constraintWithItem:self.progressBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.45 constant:0];
//    [self.view addConstraint:progressBarWidth];
//    
//    NSLayoutConstraint *progressBarHeight = [NSLayoutConstraint constraintWithItem:self.progressBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.003 constant:0];
//    [self.view addConstraint:progressBarHeight];
//    
//    NSLayoutConstraint *progressBarCenterX = [NSLayoutConstraint constraintWithItem:self.progressBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    [self.view addConstraint:progressBarCenterX];
//    
//    NSLayoutConstraint *progressBarCenterY = [NSLayoutConstraint constraintWithItem:self.progressBar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.85 constant:0];
//    [self.view addConstraint:progressBarCenterY];
    
//    NSLayoutConstraint * wheelHeight = [NSLayoutConstraint constraintWithItem:self.settingButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.07 constant:0];
//    [self.view addConstraint:wheelHeight];
//
//    NSLayoutConstraint * wheelWidth = [NSLayoutConstraint constraintWithItem:self.settingButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.08 constant:0];
//    [self.view addConstraint:wheelWidth];
//
//    NSLayoutConstraint * wheelButtonCenterX = [NSLayoutConstraint constraintWithItem:self.settingButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.80 constant:0];
//    [self.view addConstraint:wheelButtonCenterX];
//    
//    NSLayoutConstraint * wheelButtonCenterY = [NSLayoutConstraint constraintWithItem:self.settingButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.9 constant:0];
//    [self.view addConstraint:wheelButtonCenterY];
    

    
}



@end
