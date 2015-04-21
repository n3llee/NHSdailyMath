//
//  DataStore.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/12/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "DataStore.h"
#import "Score.h"

@implementation DataStore
@synthesize managedObjectContext = _managedObjectContext;


+ (instancetype)sharedDataStore {
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[DataStore alloc] init];
    });
    
    return _sharedDataStore;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        _scoreLeaderboard = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"playingWithMath.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MathDataStore" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)generateTestData
{
    [self createNewDataWithName:@"Hana" scorePoint:@30 selectedTime:@"30 seconds"];
}

- (void)fetchData
{
    NSFetchRequest *messagesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Score"];
    
    NSSortDescriptor *createdAtSorter = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    messagesRequest.sortDescriptors = @[createdAtSorter];
//    [messagesRequest setFetchLimit:6];
    
    self.scoreLeaderboard = [self.managedObjectContext executeFetchRequest:messagesRequest error:nil];
    
    NSLog(@"scoreLeaderboard count %ld", [self.scoreLeaderboard count]);
    
    if ([self.scoreLeaderboard count]==0) {
        [self generateTestData];
    }
    
}

-(void)createNewDataWithName:(NSString *)playerName scorePoint:(NSNumber *)scorePoint selectedTime:(NSString *)selectedTime
{
    Score *scoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:self.managedObjectContext];
    
    scoreData.name  = playerName;
    scoreData.time = selectedTime;
    scoreData.score = scorePoint;
    scoreData.createdAt = [NSDate date];
    
    
    [self saveContext];
    [self fetchData];
}


-(BOOL)isUserExists:(NSString *)playerName
{
    [self fetchData];
    
    BOOL found = NO;
    for (Score * data in self.scoreLeaderboard) {
        if ([data.name isEqualToString:playerName]) {
            found = YES;
        }
    }
    return found;
}
@end
