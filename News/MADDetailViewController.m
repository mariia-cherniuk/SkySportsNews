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
@property (strong, nonatomic, readwrite) UILabel *summaryShort;
@property (strong, nonatomic, readwrite) UILabel *link;
@property (strong, nonatomic, readwrite) UIScrollView *scrollView;
@property (weak, nonatomic, readwrite) UIView *contentView;
@property (weak, nonatomic, readwrite) NSLayoutConstraint *contentViewHeightConstraint;

@end

@implementation MADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    [self configureNavigationItem];
    [self createContentView];
    [self createdImageView];
    [self createdHeadlineLabel];
    [self createdSummaryShort];
    [self createdLink];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollView setContentOffset:CGPointZero];
    [self configureView];
}

- (void)setDetailItem:(id)detailItem {
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
        [self configureView];
    }
}

- (void)configureNavigationItem {
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePressed:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)configureView {
    if (_link) {
        _headline.text = _detailItem.title;
        _image.image = [UIImage imageWithData:_detailItem.image];
        _summaryShort.text = _detailItem.summaryShort;
        
        NSURL *URL = [NSURL URLWithString:_detailItem.link];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:
                                          [NSString stringWithFormat:@"Look \"%@\" at the official website.", _detailItem.title]];
        [str addAttribute:NSLinkAttributeName value:URL range:NSMakeRange(0, str.length)];
        [_link setAttributedText:str];
        self.navigationItem.title = [_detailItem.category uppercaseString];
        [_contentView layoutIfNeeded];
        _contentViewHeightConstraint.constant = CGRectGetMaxY(_link.frame);
    }
}

#pragma mark - Create Views

- (void)createContentView {
    UIView *view = [[UIView alloc] init];
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
//        self.contentViewHeightConstraint.constant = 1000;
}

- (void)createScrollView {
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
}

- (void)createdHeadlineLabel {
    _headline = [[UILabel alloc] init];
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
                                                                           toItem:_contentView
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:20];
    
    NSLayoutConstraint *headlineTop = [NSLayoutConstraint constraintWithItem:_headline
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_image
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:10];
    
    [_contentView addConstraints:@[headlineRightSide, headlineLeftSide, headlineTop]];
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
                                                                      constant:0];
    
    NSLayoutConstraint *imageRigthSide = [NSLayoutConstraint constraintWithItem:_image
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_contentView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1
                                                                      constant:0];

    NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:_image
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    
    [_contentView addConstraints:@[imageLeftSide, imageTop, imageRigthSide]];
}

- (void)createdSummaryShort {
    _summaryShort = [[UILabel alloc] init];
    _summaryShort.textAlignment = NSTextAlignmentCenter;
    _summaryShort.translatesAutoresizingMaskIntoConstraints = NO;
    _summaryShort.font = [UIFont italicSystemFontOfSize:15.0f];
    _summaryShort.numberOfLines = 0;
    _summaryShort.textColor = [UIColor blackColor];
    
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
                                                                          toItem:_headline
                                                                       attribute:NSLayoutAttributeBaseline
                                                                      multiplier:1
                                                                        constant:20];
    
    [_contentView addConstraints:@[summaryShortLeftSide, summaryShortRightSide, summaryShortTop]];
}

- (void)createdLink {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(linkPressed:)];
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

#pragma mark - Button Pressed

- (IBAction)linkPressed:(UILabel *)sender {
    NSURL *url = [NSURL URLWithString:_detailItem.link];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)sharePressed:(UIButton *)sender {
    NSString *link = _detailItem.link;
    NSArray *objectsToShare = @[link];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:
                                            objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
