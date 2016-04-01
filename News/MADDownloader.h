//
//  MADLoadData.h
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MADDownloader : NSObject

+ (void)loadDataWithCompletionBlock:(void (^)(NSArray *articles))completioBlock;
+ (void)loadImageWithURL:(NSURL *)url completionBlock:(void (^)(UIImage *image))completionBlock;

@end
