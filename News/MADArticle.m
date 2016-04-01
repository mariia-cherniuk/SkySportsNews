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
        _multimedia = [article[@"multimedia"] objectForKey:@"resource"];
        _link = article[@"link"];
        _publicationDate = article[@"publication_date"];
        _updatedDate = article[@"date_updated"];
        _relatedUrls = article[@"related_urls"];
        _image = nil;
    }
    
    return self;
}

@end
