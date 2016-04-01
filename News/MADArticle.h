//
//  MADArticle.h
//  News
//
//  Created by Mariia Cherniuk on 18.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MADCategory;

@interface MADArticle : NSObject

@property (copy, nonatomic, readwrite) NSString *summaryShort;
@property (copy, nonatomic, readwrite) NSString *headline;
@property (strong, nonatomic, readwrite) NSDictionary *multimedia;
@property (strong, nonatomic, readwrite) NSDictionary *link;
@property (strong, nonatomic, readwrite) NSArray *relatedUrls;
@property (copy, nonatomic, readwrite) NSString *publicationDate;
@property (copy, nonatomic, readwrite) NSString *updatedDate;
@property (strong, nonatomic, readwrite) UIImage *image;

- (instancetype)initWithDictionary:(NSDictionary *)article;

@end
