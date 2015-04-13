//
//  Score.h
//  playingWithMath
//
//  Created by Nelly Santoso on 4/12/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Score : NSManagedObject

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSDate * createdAt;

@end
