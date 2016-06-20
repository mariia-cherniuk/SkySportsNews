//
//  MADCoreDataStack.m
//  News
//
//  Created by Mariia Cherniuk on 06.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCoreDataStack.h"
#import "MADDownloader.h"
#import "MADArticle.h"

@implementation MADCoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedCoreDataStack {
    static MADCoreDataStack *coreDataStack = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        coreDataStack = [[MADCoreDataStack alloc] init];
    });
    
    return coreDataStack;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"News" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"News.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    if (!self.persistentStoreCoordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    return _managedObjectContext;
}


#pragma mark - Core Data Saving support

- (void)saveArticles:(NSArray *)articles category:(NSString *)category {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    for (NSDictionary *article in articles) {
        MADArticle *newArticle = (MADArticle *)[NSEntityDescription insertNewObjectForEntityForName:
                                                @"MADArticle" inManagedObjectContext:context];
        newArticle.title = article[@"title"];
        newArticle.link = article[@"link"];
        newArticle.summaryShort = article[@"shortdesc"];
        newArticle.imageURL = article[@"imgsrc"];
        newArticle.category = category;
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma mark - Private

- (NSArray *)uniquenessCheck:(NSArray *)articles {
    NSArray *titles = [articles valueForKeyPath:@"title"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title IN %@", titles];
    NSArray *response = [[self fetchingDistinctValueByPredicate:predicate] valueForKeyPath:@"title"];
    NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:
                                    ^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
                                        return ![response containsObject:evaluatedObject[@"title"]];
                                    }];
    
    return [articles filteredArrayUsingPredicate:filterPredicate];
}

- (NSArray *)fetchingDistinctValueByPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADArticle"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    request.predicate = predicate;
    request.sortDescriptors = [[NSArray alloc] init];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    NSLog(@"%@", array);
    
    return array;
}

@end
