//
//  MADLoadData.m
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDownloader.h"
#import "MADArticle.h"

@implementation MADDownloader

+ (void)loadDataWithCompletionBlock:(void (^)(NSArray *articles))completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:@"http://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=70fa840d78c03e84491215dd512385d2:12:74726916"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *error) {
                                                   if (data) {
                                                       NSDictionary *articles = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
                                                       NSArray *allArticles = [NSArray arrayWithArray:
                                                                               [self parseArticles:articles]];
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           if (completionBlock) {
                                                               completionBlock(allArticles);
                                                           }
                                                       });
                                                   } else if (error) {
                                                       NSLog(@"%@", error);
                                                   }
                                               }];
    
    [dataTask resume];
}

+ (NSArray *)parseArticles:(NSDictionary *)articles {
    NSArray *results = articles[@"results"];
    NSMutableArray *allArticle = [[NSMutableArray alloc] init];
    
    for (NSDictionary *article in results) {
        [allArticle addObject:[[MADArticle alloc] initWithDictionary:article]];
    }
    
    return allArticle;
}

+ (void)loadImageWithURL:(NSURL *)url completionBlock:(void (^)(UIImage *image))completionBlock {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *error) {
                                                   if (data) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           UIImage *image = [[UIImage alloc] initWithData:data];
                                                           completionBlock(image);
                                                       });
                                                   } else if (error) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           NSLog(@"%@", error);
                                                           completionBlock(nil);
                                                       });
                                                   }
                                               }];
    
    [dataTask resume];
}

@end
