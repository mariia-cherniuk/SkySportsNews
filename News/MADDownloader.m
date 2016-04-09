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

+ (void)loadData {
    NSURL *url = [[NSURL alloc] initWithString:@"https://skysportsapi.herokuapp.com/sky/getnews/football/v1.0/"];
    NSURL *url2 = [[NSURL alloc] initWithString:@"https://skysportsapi.herokuapp.com/sky/getnews/tennis/v1.0/"];
    NSURL *url3 = [[NSURL alloc] initWithString:@"https://skysportsapi.herokuapp.com/sky/getnews/boxing/v1.0/"];
    NSURL *url4 = [[NSURL alloc] initWithString:@"https://skysportsapi.herokuapp.com/sky/getnews/motorsport/v1.0/"];
    NSArray *urls = @[url, url2, url3, url4];
    
    for (NSURL *url in urls) {
        NSString *categoryName = [self categoryNameByURL:url];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLSession *sesion = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data,
                                                                       NSURLResponse *response,
                                                                       NSError *error) {
                                                       if (data) {
                                                           NSArray *articles = [[MADCoreDataStack sharedCoreDataStack] uniquenessCheck:[self parseData:data]];
                                                           
                                                           [[MADCoreDataStack sharedCoreDataStack] saveArticles:articles category:categoryName];
                                                       } else if (error) {
                                                           NSLog(@"%@", error);
                                                       }
                                                   }];
        
        [dataTask resume];
    }
}

+ (NSString *)categoryNameByURL:(NSURL *)url {
    NSString *categoryName = [url.absoluteString substringFromIndex:47];
    NSRange range1 = [categoryName rangeOfString:@"/"];
    
    if (range1.location != NSNotFound) {
        categoryName = [categoryName substringToIndex:range1.location];
    }
    
    return categoryName;
}

+ (NSArray *)parseData:(NSData *)data {
    NSArray *articlesDict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
    return articlesDict;
}

+ (void)loadImageWithURL:(NSString *)url complitionBlock:(void (^)(NSData *image))complitionBlock {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sesion dataTaskWithRequest:request
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *error) {
                                                   if (data) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           if (complitionBlock) {                                                           
                                                               complitionBlock(data);
                                                           }
                                                       });
                                                   } else if (error) {
                                                        NSLog(@"%@", error);
                                                   }
                                               }];
    
    [dataTask resume];
}

@end
