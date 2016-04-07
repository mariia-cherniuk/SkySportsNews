//
//  MADArticle+CoreDataProperties.h
//  News
//
//  Created by Mariia Cherniuk on 06.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MADArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MADArticle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *summaryShort;
@property (nullable, nonatomic, retain) NSString *headline;
@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSDate *publicationDate;
@property (nullable, nonatomic, retain) NSDate *updatedDate;
@property (nullable, nonatomic, retain) id link;
@property (nullable, nonatomic, retain) id image;
@property (nullable, nonatomic, retain) id multimedia;

@end

NS_ASSUME_NONNULL_END
