//
//  MADDetailViewController.m
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDetailViewController.h"
#import "MADArticle.h"

@interface MADDetailViewController ()

@end

@implementation MADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Movie Reviews";
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = shareButton;

    [self createdHeadlineLabel];
    [self createdImageView];
    [self createdUpdatedDate];
    [self createdSummaryShort];
    [self createdLinks];
//    [self createButton];
    
//    [self createMovieView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureView];
    
//    [_moviePlayerController play];
}

- (void)setDetailItem:(MADArticle *)detailItem {
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
        [self configureView];
    }
}

- (void)configureView {
    if (_headline && _image && _summaryShort && _updatedDate ) {
        _headline.text = _detailItem.headline;
        _image.image = _detailItem.image;
        _updatedDate.text = [NSString stringWithFormat:@"Updated: %@", _detailItem.updatedDate];
        _summaryShort.text = _detailItem.summaryShort;
        
        for (NSInteger i = 0; i < _detailItem.relatedUrls.count; i++) {
            NSURL *URL = [NSURL URLWithString:_detailItem.relatedUrls[i][@"url"]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_detailItem.relatedUrls[i][@"suggested_link_text"]];
            [str addAttribute:NSLinkAttributeName value:URL range:NSMakeRange(0, str.length)];
            [_links[i] setAttributedText:str];
        }


//        for (NSInteger i = 0; i < _links.count; i++) {
//            NSURL *URL = [NSURL URLWithString:_detailItem.relatedUrls[i][@"url"]];
//            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_detailItem.relatedUrls[i][@"suggested_link_text"]];
//            [str addAttribute:NSLinkAttributeName value:URL range:NSMakeRange(0, str.length)];
//            [_links[i] setAttributedText:str];
//        }
    }
}

- (void)createdHeadlineLabel {
    _headline = [[UILabel alloc] init];
//    _headline.backgroundColor = [UIColor greenColor];
    _headline.textAlignment = NSTextAlignmentLeft;
    _headline.translatesAutoresizingMaskIntoConstraints = NO;
    _headline.font = [UIFont systemFontOfSize:16.0f];
    _headline.numberOfLines = 0;
    [self.view addSubview:_headline];
   
    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:-20];
    
    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1
                                                                         constant:-40];
    
    NSLayoutConstraint *headlineTopSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:85];

    [self.view addConstraints:@[headlineRightSide, headlineLeftSide, headlineTopSide]];
}

- (void)createdImageView {
    _image = [[UIImageView alloc] init];
    _image.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:_image];
    
    NSLayoutConstraint *imageLeftSide = [NSLayoutConstraint constraintWithItem:_image
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:20];
    
    NSLayoutConstraint *imageRightSide = [NSLayoutConstraint constraintWithItem:_image
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                                        toItem:_headline
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-20];
    
    NSLayoutConstraint *imageTopSide = [NSLayoutConstraint constraintWithItem:_image
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationLessThanOrEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:85];
    
    NSLayoutConstraint *imageCenter = [NSLayoutConstraint constraintWithItem:_image
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:_headline
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1
                                                                    constant:0];

    [self.view addConstraints:@[imageLeftSide, imageRightSide, imageTopSide, imageCenter]];
}

- (void)createdUpdatedDate {
    _updatedDate = [[UILabel alloc] init];
//    _updatedDate.backgroundColor = [UIColor orangeColor];
    _updatedDate.textAlignment = NSTextAlignmentLeft;
    _updatedDate.translatesAutoresizingMaskIntoConstraints = NO;
    _updatedDate.font = [UIFont systemFontOfSize:10.0f];
    _updatedDate.numberOfLines = 0;
    _updatedDate.textColor = [UIColor grayColor];
    [self.view addSubview:_updatedDate];
    
    NSLayoutConstraint *updatedDateLeftSide = [NSLayoutConstraint constraintWithItem:_updatedDate
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1
                                                                            constant:-40];
    
    NSLayoutConstraint *updatedDateTopSide = [NSLayoutConstraint constraintWithItem:_updatedDate
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_headline
                                                                          attribute:NSLayoutAttributeBaseline
                                                                         multiplier:1
                                                                           constant:10];
    
    [self.view addConstraints:@[updatedDateLeftSide, updatedDateTopSide]];
}

- (void)createdSummaryShort {
    _summaryShort = [[UILabel alloc] init];
    _summaryShort.textAlignment = NSTextAlignmentCenter;
    _summaryShort.translatesAutoresizingMaskIntoConstraints = NO;
    _summaryShort.font = [UIFont systemFontOfSize:14.0f];
    _summaryShort.numberOfLines = 0;
    _summaryShort.textColor = [UIColor blackColor];
    
    [self.view addSubview:_summaryShort];
    
    NSLayoutConstraint *summaryShortLeftSide = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1
                                                                             constant:20];
    
    NSLayoutConstraint *summaryShortRightSide = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                             attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationLessThanOrEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1
                                                                              constant:-20];

    NSLayoutConstraint *summaryShortTopSide = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_updatedDate
                                                                        attribute:NSLayoutAttributeBaseline
                                                                          multiplier:1
                                                                            constant:20];
    
    [self.view addConstraints:@[summaryShortLeftSide, summaryShortRightSide, summaryShortTopSide]];
}

- (void)createdLinks {
    UIView *temp = _summaryShort;
    _links = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < _detailItem.relatedUrls.count; i++) {
        UITextView *textView = [[UITextView alloc] init];
        textView.editable = NO;
        textView.selectable = YES;
        textView.dataDetectorTypes = UIDataDetectorTypeLink;
        textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor],
                                        NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick)};
        textView.userInteractionEnabled = YES;
        textView.translatesAutoresizingMaskIntoConstraints = NO;
//        textView.font = [UIFont systemFontOfSize:16.0f];

        [self.view addSubview:textView];
        
        NSLayoutConstraint *linkLeftSide = [NSLayoutConstraint constraintWithItem:textView
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:20];
        
        NSLayoutConstraint *linkRightSide = [NSLayoutConstraint constraintWithItem:textView
                                                                         attribute:NSLayoutAttributeRight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeRight
                                                                        multiplier:1
                                                                          constant:-20];
        
        NSLayoutConstraint *linkTopSide = [NSLayoutConstraint constraintWithItem:textView
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:temp
                                                                       attribute:NSLayoutAttributeBaseline
                                                                      multiplier:1
                                                                        constant:10];
        
        NSLayoutConstraint *linkBottom = [NSLayoutConstraint constraintWithItem:textView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1
                                                                       constant:20];

        [self.view addConstraints:@[linkLeftSide, linkRightSide, linkTopSide, linkBottom]];
        
        [_links addObject:textView];
        temp = textView;
    }
}


//- (void)createdLinks {
//    UIView *temp = _summaryShort;
//    _links = [[NSMutableArray alloc] init];
//
//    for (NSInteger i = 0; i < _detailItem.relatedUrls.count; i++) {
//        UIButton *link = [[UIButton alloc] init];
//        link.translatesAutoresizingMaskIntoConstraints = NO;
//        link.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        link.titleLabel.numberOfLines = 0;
//        [link setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        link.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [link addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.view addSubview:link];
//        
//        NSLayoutConstraint *linkLeftSide = [NSLayoutConstraint constraintWithItem:link
//                                                                         attribute:NSLayoutAttributeLeft
//                                                                         relatedBy:NSLayoutRelationEqual
//                                                                            toItem:self.view
//                                                                         attribute:NSLayoutAttributeLeft
//                                                                        multiplier:1
//                                                                          constant:20];
//        
//        NSLayoutConstraint *linkRightSide = [NSLayoutConstraint constraintWithItem:link
//                                                                          attribute:NSLayoutAttributeRight
//                                                                          relatedBy:NSLayoutRelationEqual
//                                                                             toItem:self.view
//                                                                          attribute:NSLayoutAttributeRight
//                                                                         multiplier:1
//                                                                           constant:-20];
//        
//        NSLayoutConstraint *linkTopSide = [NSLayoutConstraint constraintWithItem:link
//                                                                        attribute:NSLayoutAttributeTop
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:temp
//                                                                        attribute:NSLayoutAttributeBaseline
//                                                                       multiplier:1
//                                                                         constant:10];
//        
//        [self.view addConstraints:@[linkLeftSide, linkRightSide, linkTopSide]];
//        [_links addObject:link];
//        temp = link;
//    }
//}

- (void)buttonClicked:(UIButton *)sender {
    __block NSMutableString *urlstr;
    
    for (NSDictionary *obj in _detailItem.relatedUrls) {
        [obj enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj1, BOOL *stop) {
            if ([obj1 isEqualToString:sender.titleLabel.text]) {
                urlstr = obj[@"url"];
            }
        }];
    }
    NSURL *url = [NSURL URLWithString:urlstr];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)share:(UIButton *)sender {
    NSString *headline = _detailItem.link[@"suggested_link_text"];
//    NSURL *link = [[NSURL alloc] initFileURLWithPath:_detailItem.link[@"url"]];
    NSString *link = _detailItem.link[@"url"];
    NSArray *objectsToShare = @[headline, link];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}



















//- (void)createMovieView {
////    NSString *path = @"https://www.youtube.com/watch?v=bY73vFGhSVk";
//    NSString *path = [NSString stringWithFormat:@"%@", _detailItem.relatedUrls[4][@"url"]];
//    NSURL *movieURL = [NSURL fileURLWithPath:path];
//    _moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//    
//    _movieView = [[UIView alloc] init];
//    _movieView.translatesAutoresizingMaskIntoConstraints = NO;
//    _movieView.backgroundColor = [UIColor orangeColor];
//    _movieView.bounds = CGRectMake(0, 85, [[UIScreen mainScreen] bounds].size.width, 200);
//    [_moviePlayerController.view setFrame:_movieView.bounds];
//    [_movieView addSubview:_moviePlayerController.view];
//    _moviePlayerController.controlStyle = MPMovieControlStyleNone;
//    [_moviePlayerController prepareToPlay];
//
//    [self.view addSubview:_movieView];
//
//    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_movieView
//                                                                         attribute:NSLayoutAttributeRight
//                                                                         relatedBy:NSLayoutRelationEqual
//                                                                            toItem:self.view
//                                                                         attribute:NSLayoutAttributeRight
//                                                                        multiplier:1
//                                                                          constant:0];
//    
//    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_movieView
//                                                                        attribute:NSLayoutAttributeLeft
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:self.view
//                                                                        attribute:NSLayoutAttributeLeft
//                                                                       multiplier:1
//                                                                         constant:0];
//    
//    NSLayoutConstraint *headlineTopSide = [NSLayoutConstraint constraintWithItem:_movieView
//                                                                       attribute:NSLayoutAttributeTop
//                                                                       relatedBy:NSLayoutRelationEqual
//                                                                          toItem:self.view
//                                                                       attribute:NSLayoutAttributeTop
//                                                                      multiplier:1
//                                                                        constant:85];
//    
//    [self.view addConstraints:@[headlineRightSide, headlineLeftSide, headlineTopSide]];
//    

//}


@end
