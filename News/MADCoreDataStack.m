//
//  MADCoreDataStack.m
//  News
//
//  Created by Mariia Cherniuk on 06.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCoreDataStack.h"
#import <CoreData/CoreData.h>
#import "MADArticle+CoreDataProperties.h"

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
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory]
                       URLByAppendingPathComponent:@"News.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                                             URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSDate *)convertPublicationDateFrom:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFromString = [dateFormatter dateFromString:date];
    
    return dateFromString;
}

- (NSDate *)convertUpdateDateFrom:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *dateFromString = [[NSDate alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFromString = [dateFormatter dateFromString:date];
    
    return dateFromString;
}

- (void)saveArticles:(NSArray *)articles {
    NSManagedObjectContext *context = self.managedObjectContext;

    for (NSDictionary *article in articles) {
        NSManagedObject *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"MADArticle" inManagedObjectContext:context];

        [newArticle setValue:article[@"summary_short"] forKey:@"summaryShort"];
        [newArticle setValue:article[@"headline"] forKey:@"headline"];
        [newArticle setValue:article[@"byline"] forKey:@"author"];
        [newArticle setValue:article[@"multimedia"] forKey:@"multimedia"];
        [newArticle setValue:article[@"link"] forKey:@"link"];
        [newArticle setValue:[self convertPublicationDateFrom:article[@"publication_date"]] forKey:@"publicationDate"];
        [newArticle setValue:[self convertUpdateDateFrom:article[@"date_updated"]] forKey:@"updatedDate"];
//        [newArticle setValue:article[@"multimedia"][@"src"] forKey:@"image"];
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

//- (NSArray *)uniquenessCheck:(NSArray *)articles {
//    NSMutableArray *uniqueArticles = [[NSMutableArray alloc] init];
//    NSArray *respone = [self fetchingRecords];
//    
//    if (respone.count == 0) {
//        [uniqueArticles addObjectsFromArray:articles];
//    } else {
//        for (NSInteger i = 0; i < articles.count; i++) {
//            if ((articles[i][@"date_updated"] != [respone[i] updatedDate]) && ![articles[i][@"headline"] isEqualToString:[respone[i] headline]]) {
//                [uniqueArticles addObject:articles[i]];
//            }
//        }
//    }
//
//    return uniqueArticles;
//}

//- (NSArray *)fetchingRecords {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADArticle" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//
//    NSError *error = nil;
//    NSArray *result = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
//
//    if (error) {
//        NSLog(@"Unable to execute fetch request.");
//        NSLog(@"%@, %@", error, error.localizedDescription);
//    }
//
//    return result;
//}

- (NSArray *)uniquenessCheck:(NSArray *)articles {
    NSMutableArray *uniqueArticles = [[NSMutableArray alloc] init];
    NSArray *respone = [self fetchingDistinctValueByPredicate:
                        [NSPredicate predicateWithFormat:@"updatedDate==max(updatedDate)"]];
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:@"date_updated" ascending:YES];
    
    [articles sortedArrayUsingDescriptors:@[desc]];
    
    if (respone.count == 0) {
        [uniqueArticles addObjectsFromArray:articles];
    } else {
        for (NSInteger i = articles.count - 1; i >= 0; i--) {
            NSDate *date = [self convertUpdateDateFrom:articles[i][@"date_updated"]];
            
            if ([date compare:[respone[0] updatedDate]] == NSOrderedDescending) {
                NSArray *unique = [articles subarrayWithRange:NSMakeRange(0, i)];
                NSLog(@"%@", unique);
                
                [uniqueArticles addObjectsFromArray:unique];
            }
        }
    }
    
    return uniqueArticles;
}

- (NSArray *)fetchingDistinctValueByPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADArticle"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    request.predicate = predicate;
    request.sortDescriptors = [NSArray array];
    
    NSError *error = nil;
    NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
    
    return array;
}

- (void)saveImage:(NSData *)data url:(NSURL *)url {
    UIImage *image = [[UIImage alloc] initWithData:data];
    //    updating record
    NSManagedObjectContext *context = self.managedObjectContext;
    NSArray *respone = [self fetchingDistinctValueByPredicate:
                        [NSPredicate predicateWithFormat:@"image==%@", [url absoluteString]]];

    if (respone.count != 0) {
        [respone[0] setValue:image forKey:@"image"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

@end
