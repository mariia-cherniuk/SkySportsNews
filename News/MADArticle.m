//
//  MADArticle.m
//  News
//
//  Created by Mariia Cherniuk on 18.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADArticle.h"

@implementation MADArticle

- (instancetype)initWithDictionary:(NSDictionary *)article {
    self = [super init];
    
    if (self) {
        _summaryShort = article[@"summary_short"];
        _headline = article[@"headline"];
        _author = article[@"byline"];
        _multimedia = article[@"multimedia"];
        _link = article[@"link"];
        _publicationDate = article[@"publication_date"];
        _updatedDate = article[@"date_updated"];
        _image = nil;
    }
    
    return self;
}

@end
