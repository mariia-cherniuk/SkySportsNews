//
//  MADCustomTableViewCell.m
//  News
//
//  Created by Mariia Cherniuk on 04.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCustomTableViewCell.h"

@implementation MADCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self createdImage];
        [self createdHeadline];
        [self createdCategory];
    }
    
    return self;
}

- (void)createdHeadline {
    _headline = [[UILabel alloc] init];
    _headline.textAlignment = NSTextAlignmentLeft;
    _headline.lineBreakMode = NSLineBreakByTruncatingTail;
    _headline.translatesAutoresizingMaskIntoConstraints = NO;
    _headline.font = [UIFont boldSystemFontOfSize:14.0f];
    _headline.numberOfLines = 3;
    _headline.textColor = [UIColor blackColor];
    [self.contentView addSubview:_headline];
    
    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_articleCellImageView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:5];

    NSLayoutConstraint *headlineCenterY = [NSLayoutConstraint constraintWithItem:_headline
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1
                                                                        constant:0];

    
    [self addConstraints:@[headlineRightSide, headlineLeftSide, headlineCenterY]];
}

- (void)createdCategory {
    _category = [[UILabel alloc] init];
    _category.textAlignment = NSTextAlignmentLeft;
    _category.lineBreakMode = NSLineBreakByTruncatingTail;
    _category.translatesAutoresizingMaskIntoConstraints = NO;
    _category.font = [UIFont systemFontOfSize:12.0f];
    _category.numberOfLines = 1;
    _category.textColor = [UIColor grayColor];

    [self.contentView addSubview:_category];
    
    NSLayoutConstraint *categoryRightSide = [NSLayoutConstraint constraintWithItem:_category
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_headline
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1
                                                                        constant:0];
    
    NSLayoutConstraint *categoryLeftSide = [NSLayoutConstraint constraintWithItem:_category
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:_headline
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *categoryBottom = [NSLayoutConstraint constraintWithItem:_category
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
    
    [self addConstraints:@[categoryLeftSide, categoryRightSide, categoryBottom]];
}

- (void)createdImage {
    _articleCellImageView = [[UIImageView alloc] init];
    _articleCellImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _articleCellImageView.clipsToBounds = YES;
    
    [self.contentView addSubview:_articleCellImageView];
    
    NSLayoutConstraint *imageLeftSide = [NSLayoutConstraint constraintWithItem:_articleCellImageView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *imageWidth = [NSLayoutConstraint constraintWithItem:_articleCellImageView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:120];
    
    NSLayoutConstraint *imageHeight = [NSLayoutConstraint constraintWithItem:_articleCellImageView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *imageTop = [NSLayoutConstraint constraintWithItem:_articleCellImageView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    
    [self addConstraints:@[imageLeftSide, imageTop, imageHeight, imageWidth]];
}

@end
