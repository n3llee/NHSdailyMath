//
//  FISMathGenerator.m
//  playingWithMath
//
//  Created by Nelly Santoso on 3/20/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "FISMathGenerator.h"

@implementation FISMathGenerator


- (instancetype)init
{
    self = [super init];

    return self;
}

-(void)settingQuestionAndAnswer
{
    NSDictionary * questionDictionary = [self randomMathQuestion];
    self.question = questionDictionary[@"inString"];
    self.breakDownQuestionInArray = questionDictionary[@"inArray"];
    self.answer = [self gettingMathAnswer];
    self.answers = [self collectionOfPossibleAnswer];
}

-(NSString *)findMathOperation
{
    self.mathOperations = @[@"+", @"/", @"-", @"*"];
    
    NSUInteger indexFromArray = arc4random_uniform((int)[self.mathOperations count]);
    
    return self.mathOperations[indexFromArray];
    
}

-(NSDictionary *)randomMathQuestion
{
    NSMutableDictionary * questions = [[NSMutableDictionary alloc]init];
    NSMutableArray * questionInArray = [[NSMutableArray alloc]init];
    self.singleMathOperation= self.findMathOperation;
    
    NSInteger findFirst = 1+arc4random_uniform(10);
    NSInteger findSecond= 1+arc4random_uniform(10);
    
    
    if ([self.singleMathOperation isEqualToString:@"/"])
    {
        self.firstNumber = findFirst * findSecond;
    }
    else
    {
        self.firstNumber = findFirst;
    }
    self.secondNumber = findSecond;
    
    
    
    
    NSString * questionInString = [NSString stringWithFormat:@"%ld %@ %ld =", self.firstNumber, self.singleMathOperation, self.secondNumber];
    [questionInArray addObject:[NSNumber numberWithInteger:self.firstNumber]];
    [questionInArray addObject:self.singleMathOperation];
    [questionInArray addObject:[NSNumber numberWithInteger:self.secondNumber]];
    
    questions[@"inString"] = questionInString;
    questions[@"inArray"] = questionInArray;
    
    
    return questions;

}

//-(NSString *) randomMathQuestionInString
//{
//    NSInteger findFirst = 1+arc4random_uniform(10);
//    NSInteger findSecond= 1+arc4random_uniform(10);
//    
//    self.singleMathOperation= self.findMathOperation;
//    
//    
//    if (findFirst == 0 && findSecond == 0) {
//        NSLog(@"got both zero");
//        findFirst = 1;
//        findSecond = 1;
//    }
//    
//    if ([self.singleMathOperation isEqualToString:@"/"]) {
//        
//        self.firstNumber = findFirst * findSecond;
//    }
//    else
//    {
//        self.firstNumber = findFirst;
//        
//    }
//    self.secondNumber = findSecond;
//    
//    self.question = [NSString stringWithFormat:@"%ld %@ %ld =", self.firstNumber, self.singleMathOperation, self.secondNumber];
//    
//    
//    return self.question;
//
//}

//NSLog(@"first number %ld", self.firstNumber);
//NSLog(@"second number %ld", self.secondNumber);
//NSLog(@"operation %@", self.singleMathOperation );

-(NSString *)gettingMathAnswer
{
    double result;
    
    if ([self.singleMathOperation isEqualToString:@"+"]) {
        result = self.firstNumber + self.secondNumber;
    }
    else if ([self.singleMathOperation isEqualToString:@"-"]){
        result = self.firstNumber - self.secondNumber;
    }
    else if ([self.singleMathOperation isEqualToString:@"*"]){
        result = self.firstNumber * self.secondNumber;
    }
    else if ([self.singleMathOperation isEqualToString:@"/"]) {
        result = self.firstNumber / self.secondNumber;
    }
    
    self.answer = [NSString stringWithFormat:@"%ld", lroundf(result)];
    
    return self.answer;
}

-(NSArray *)collectionOfPossibleAnswer
{
    NSMutableArray *results = [[NSMutableArray alloc]init];
    [results addObject:self.answer];
    
    NSMutableArray * listOfFakeNumber = [self generateFakeAnswer];

    for (NSInteger i = 0; i < 3; i++) {
        NSUInteger indexToBeChoosen = arc4random_uniform((int)[listOfFakeNumber count]);
        NSString * answerAdded = listOfFakeNumber[indexToBeChoosen];
        [listOfFakeNumber removeObject:answerAdded];
        [results addObject:answerAdded];
    }
    
    [self shuffle:results];
    
    return results;
    
}

- (void)shuffle:(NSMutableArray *)collectionOfLists
{
    NSUInteger count = [collectionOfLists count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [collectionOfLists exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

-(NSMutableArray *)generateFakeAnswer
{
    NSMutableArray * fakeAnswers= [[NSMutableArray alloc]init];
    
    if ([self.singleMathOperation isEqualToString:@"+"]) {
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", self.firstNumber - self.secondNumber]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", self.firstNumber * self.secondNumber]];
    }
    else if ([self.singleMathOperation isEqualToString:@"*"]) {
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", self.firstNumber + self.secondNumber]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld%ld", self.firstNumber,self.secondNumber]];
    }
    else if ([self.singleMathOperation isEqualToString:@"-"]) {
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", self.firstNumber + self.secondNumber]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", self.secondNumber - self.firstNumber]];
    }
    else if ([self.singleMathOperation isEqualToString:@"/"]) {
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] - 2)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 1)]];
        [fakeAnswers addObject:[NSString stringWithFormat:@"%ld", lroundf([self.answer floatValue] + 2)]];
    }
    
    if ([self isNumbersSingleDigits] == YES) {
        if (self.firstNumber > self.secondNumber && self.firstNumber >0) {
            [fakeAnswers addObject:[NSString stringWithFormat:@"%ld%ld",self.firstNumber, self.secondNumber]];
        }
        else if (self.firstNumber == 0 || self.secondNumber == 0)
        {
            [fakeAnswers addObject:@"10"];
        }
        else
        {
            [fakeAnswers addObject:[NSString stringWithFormat:@"%ld%ld",self.secondNumber, self.firstNumber]];
        }
    }
    
    NSLog(@"fake number is %@", fakeAnswers);
    return fakeAnswers;
}

-(BOOL) isNumbersSingleDigits
{
    NSInteger lengthFirstNumber = [[NSString stringWithFormat:@"%ld", self.firstNumber] length];
    NSInteger lengthSecondNumber = [[NSString stringWithFormat:@"%ld", self.secondNumber] length];
    
    if (lengthFirstNumber == 1 && lengthSecondNumber == 1) {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
