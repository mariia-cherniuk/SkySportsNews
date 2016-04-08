//
//  MADLoadData.m
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDownloader.h"
#import "MADArticle.h"
#import "MADCoreDataStack.h"

@implementation MADDownloader

+ (void)loadDataWithCompletionBlock:(void (^)(NSArray *articles))completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:
                  @"https://skysportsapi.herokuapp.com/sky/getnews/football/v1.0/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                    NSError *error) {
                                                   if (data) {
                                                       NSArray *articles = [[MADCoreDataStack sharedCoreDataStack] uniquenessCheck:[self parseData:data]];
                                                       
                                                       [[MADCoreDataStack sharedCoreDataStack] saveArticles:articles];

                                                       for (NSDictionary *article in articles) {                                                           
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               if (![article[@"multimedia"] isKindOfClass:[NSNull class]]) {
                                                                   [MADDownloader loadImageWithURL:[[NSURL alloc] initWithString:article[@"multimedia"][@"src"]]];
                                                               }
                                                           });
                                                       }
                                        
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           if (completionBlock) {
                                                               completionBlock(articles);
                                                           }
                                                       });
                                                   } else if (error) {
                                                       NSLog(@"%@", error);
                                                   }
                                               }];
    
    [dataTask resume];
}
//
//+ (NSArray *)parseArticles:(NSDictionary *)articles {
//    NSArray *results = articles[@"results"];
//    NSMutableArray *allArticle = [[NSMutableArray alloc] init];
//    
//    for (NSDictionary *article in results) {
//        [allArticle addObject:[[MADArticle alloc] initWithDictionary:article]];
//    }
//    
//    return allArticle;
//}

+ (NSArray *)parseData:(NSData *)data {
    NSArray *articlesDict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
    NSLog(@"%@", articlesDict[0][@"imgsrc"]);
    NSLog(@"%@", articlesDict[0][@"link"]);
    NSLog(@"%@", articlesDict[0][@"shortdesc"]);
    
    return articlesDict;
}

+ (void)loadImageWithURL:(NSURL *)url {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *error) {
                                                   if (data) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [[MADCoreDataStack sharedCoreDataStack] saveImage:data url:url];
                                                       });
                                                   } else if (error) {
                                                        NSLog(@"%@", error);
                                                   }
                                               }];
    
    [dataTask resume];
}

@end
