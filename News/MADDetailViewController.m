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

@property (strong, nonatomic, readwrite) UILabel *headline;
@property (strong, nonatomic, readwrite) UIImageView *image;
@property (strong, nonatomic, readwrite) UILabel *updatedDate;
@property (strong, nonatomic, readwrite) UILabel *summaryShort;
@property (strong, nonatomic, readwrite) UILabel *link;
@property (strong, nonatomic, readwrite) UIScrollView *scrollView;
@property (weak, nonatomic, readwrite) UIView *contentView;
@property (weak, nonatomic, readwrite) NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation MADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:_scrollView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Movie Reviews";
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePressed:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    [self createContentView];
    [self createdImageView];
    [self createdHeadlineLabel];
    [self createdUpdatedDate];
    [self createdSummaryShort];
    [self createdLink];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollView setContentOffset:CGPointZero];
    [self configureView];
    
//    [_moviePlayerController play];
}

- (void)setDetailItem:(id)detailItem {
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
        [self configureView];
    }
}

- (void)createContentView {
    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor blueColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:view];
    self.contentView = view;
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1
                                                             constant:0]];
    
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1
                                                             constant:0]];
    
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:0]];
    
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1
                                                             constant:0]];
    
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1
                                                             constant:[UIScreen mainScreen].bounds.size.width]];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:0];
    
    [_scrollView addConstraint:heightConstraint];
    self.contentViewHeightConstraint = heightConstraint;
    self.contentViewHeightConstraint.constant = 2000;
}

- (void)configureView {
    if (_link) {
        _headline.text = _detailItem.headline;
        _image.image = _detailItem.image;
        _updatedDate.text = [NSString stringWithFormat:@"Updated: %@", _detailItem.updatedDate];
        _summaryShort.text = _detailItem.summaryShort;
    
        NSURL *URL = [NSURL URLWithString:_detailItem.link[@"url"]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_detailItem.link[@"suggested_link_text"]];
        [str addAttribute:NSLinkAttributeName value:URL range:NSMakeRange(0, str.length)];
        [_link setAttributedText:str];
    }
}

- (void)createdHeadlineLabel {
    _headline = [[UILabel alloc] init];
//    _headline.backgroundColor = [UIColor redColor];
    _headline.textAlignment = NSTextAlignmentLeft;
    _headline.translatesAutoresizingMaskIntoConstraints = NO;
    _headline.font = [UIFont boldSystemFontOfSize:16.0f];
    _headline.numberOfLines = 0;
    [_contentView addSubview:_headline];
    
    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_contentView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:-20];
    
    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_image
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:10];
    
    NSLayoutConstraint *headlineTop = [NSLayoutConstraint constraintWithItem:_headline
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_image
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *headlineCenterY = [NSLayoutConstraint constraintWithItem:_headline
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_image
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1
                                                                        constant:0];
    
    [_contentView addConstraints:@[headlineRightSide, headlineLeftSide, headlineTop, headlineCenterY]];
}

- (void)createdImageView {
    _image = [[UIImageView alloc] init];
    _image.translatesAutoresizingMaskIntoConstraints = NO;

    [_contentView addSubview:_image];
    
    NSLayoutConstraint *imageLeftSide = [NSLayoutConstraint constraintWithItem:_image
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1
                                                                      constant:20];
    
    NSLayoutConstraint *imageWidth = [NSLayoutConstraint constraintWithItem:_image
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:140];
    
    NSLayoutConstraint *imageHeight = [NSLayoutConstraint constraintWithItem:_image
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:100];

    NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:_image
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:20];
    
    [_contentView addConstraints:@[imageLeftSide, imageTop, imageHeight, imageWidth]];
}

- (void)createdUpdatedDate {
    _updatedDate = [[UILabel alloc] init];
//    _updatedDate.backgroundColor = [UIColor orangeColor];
    _updatedDate.textAlignment = NSTextAlignmentLeft;
    _updatedDate.translatesAutoresizingMaskIntoConstraints = NO;
    _updatedDate.font = [UIFont italicSystemFontOfSize:10.0f];
    _updatedDate.numberOfLines = 0;
    _updatedDate.textColor = [UIColor grayColor];
    [_contentView addSubview:_updatedDate];
    
    NSLayoutConstraint *updatedDateLeftSide = [NSLayoutConstraint constraintWithItem:_updatedDate
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_image
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1
                                                                            constant:0];
    
    NSLayoutConstraint *updatedDateTop = [NSLayoutConstraint constraintWithItem:_updatedDate
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:_image
                                                                          attribute:NSLayoutAttributeBaseline
                                                                         multiplier:1
                                                                           constant:10];
    
    NSLayoutConstraint *updatedDateRightSide = [NSLayoutConstraint constraintWithItem:_updatedDate
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_headline
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1
                                                                            constant:0];

    [_contentView addConstraints:@[updatedDateLeftSide, updatedDateTop, updatedDateRightSide]];
}

- (void)createdSummaryShort {
    _summaryShort = [[UILabel alloc] init];
    _summaryShort.textAlignment = NSTextAlignmentCenter;
    _summaryShort.translatesAutoresizingMaskIntoConstraints = NO;
    _summaryShort.font = [UIFont systemFontOfSize:15.0f];
    _summaryShort.numberOfLines = 0;
    _summaryShort.textColor = [UIColor blackColor];
//    _summaryShort.backgroundColor = [UIColor orangeColor];
    
    [_contentView addSubview:_summaryShort];
    
    NSLayoutConstraint *summaryShortLeftSide = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                            attribute:NSLayoutAttributeLeading
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:_contentView
                                                                            attribute:NSLayoutAttributeLeading
                                                                           multiplier:1
                                                                             constant:20];
    
    NSLayoutConstraint *summaryShortRightSide = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                             attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationLessThanOrEqual
                                                                                toItem:_contentView
                                                                             attribute:NSLayoutAttributeTrailing
                                                                            multiplier:1
                                                                              constant:-20];

    NSLayoutConstraint *summaryShortTop = [NSLayoutConstraint constraintWithItem:_summaryShort
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_updatedDate
                                                                       attribute:NSLayoutAttributeBaseline
                                                                      multiplier:1
                                                                        constant:20];
    
    [_contentView addConstraints:@[summaryShortLeftSide, summaryShortRightSide, summaryShortTop]];
}

- (void)createdLink {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkPressed:)];
    _link = [[UILabel alloc] init];
    _link.userInteractionEnabled = YES;
    _link.textColor = [UIColor blueColor];
    _link.textAlignment = NSTextAlignmentLeft;
    _link.translatesAutoresizingMaskIntoConstraints = NO;
    _link.font = [UIFont systemFontOfSize:15.0f];
    _link.numberOfLines = 0;
    [_contentView addSubview:_link];
    [_link addGestureRecognizer:tap];

    NSLayoutConstraint *linkRightSide = [NSLayoutConstraint constraintWithItem:_link
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_contentView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:-20];
    
    NSLayoutConstraint *linkLeftSide = [NSLayoutConstraint constraintWithItem:_link
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_contentView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:20];
    
    NSLayoutConstraint *linkTop = [NSLayoutConstraint constraintWithItem:_link
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_summaryShort
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:10];
    
    [_contentView addConstraints:@[linkRightSide, linkLeftSide, linkTop]];
}

- (IBAction)linkPressed:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:_detailItem.link[@"url"]];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)sharePressed:(UIButton *)sender {
    NSString *headline = _detailItem.link[@"suggested_link_text"];
    NSString *link = _detailItem.link[@"url"];
    NSArray *objectsToShare = @[headline, link];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:
                                            objectsToShare applicationActivities:nil];
    
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
