//
//  MADDetailViewController.h
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class MADArticle;

@interface MADDetailViewController : UIViewController

@property (strong, nonatomic, readwrite) MADArticle *detailItem;
@property (strong, nonatomic, readwrite) UILabel *headline;
@property (strong, nonatomic, readwrite) UILabel *summaryShort;
@property (strong, nonatomic, readwrite) UIImageView *image;
@property (strong, nonatomic, readwrite) UILabel *updatedDate;
@property (strong, nonatomic, readwrite) NSMutableArray *links;
@property (strong, nonatomic, readwrite) UITextView *textView;

//@property (strong, nonatomic, readwrite) MPMoviePlayerController *moviePlayerController;
//@property (strong, nonatomic, readwrite) UIView *movieView;
//
@end
