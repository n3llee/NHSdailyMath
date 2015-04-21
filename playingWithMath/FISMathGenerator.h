//
//  FISMathGenerator.h
//  playingWithMath
//
//  Created by Nelly Santoso on 3/20/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISMathGenerator : NSObject

@property(strong, nonatomic)NSString * question;
@property(strong, nonatomic)NSString * answer;
@property(strong, nonatomic)NSArray * mathOperations;
@property(nonatomic) NSInteger firstNumber;
@property(nonatomic) NSInteger secondNumber;
@property(strong, nonatomic) NSString * singleMathOperation;
@property(strong, nonatomic)NSArray * breakDownQuestionInArray;
@property(strong, nonatomic)NSArray * answers;


-(NSString *)findMathOperation;
-(NSDictionary *)randomMathQuestion;
-(NSString *) gettingMathAnswer;
-(NSArray *)collectionOfPossibleAnswer;
-(void)settingQuestionAndAnswer;

@end
