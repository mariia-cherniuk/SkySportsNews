//
//  MADCoreDataStack.h
//  News
//
//  Created by Mariia Cherniuk on 06.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MADCoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedCoreDataStack;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)parseData:(NSData *)data;
- (void)saveImage:(NSData *)data;

@end
