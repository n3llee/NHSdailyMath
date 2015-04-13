//
//  DataStore.h
//  playingWithMath
//
//  Created by Nelly Santoso on 4/12/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@interface DataStore : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong, nonatomic)NSArray * scoreLeaderboard;

+ (instancetype)sharedDataStore;


- (void)generateTestData;
- (void)fetchData;
-(void)createNewDataWithName:(NSString *)playerName scorePoint:(NSNumber *)scorePoint selectedTime:(NSString *)selectedTime;
@end
