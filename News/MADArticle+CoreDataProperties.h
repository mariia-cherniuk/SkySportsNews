//
//  MADArticle+CoreDataProperties.h
//  News
//
//  Created by Mariia Cherniuk on 09.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MADArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MADArticle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSString *summaryShort;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
