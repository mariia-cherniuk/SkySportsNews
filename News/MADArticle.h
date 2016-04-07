//
//  MADArticle.h
//  News
//
//  Created by Mariia Cherniuk on 18.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MADArticle : NSObject

@property (copy, nonatomic, readwrite) NSString *summaryShort;
@property (copy, nonatomic, readwrite) NSString *headline;
@property (copy, nonatomic, readwrite) NSString *author;
@property (strong, nonatomic, readwrite) NSDictionary *multimedia;
@property (strong, nonatomic, readwrite) NSDictionary *link;
@property (strong, nonatomic, readwrite) NSDate *publicationDate;
@property (strong, nonatomic, readwrite) NSDate *updatedDate;
@property (strong, nonatomic, readwrite) UIImage *image;

- (instancetype)initWithDictionary:(NSDictionary *)article;

@end
