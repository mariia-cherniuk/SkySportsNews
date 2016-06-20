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
        [self createdImageView];
        [self createdHeadlineLabel];
        [self createdCategoryLabel];
    }
    
    return self;
}

- (void)createdHeadlineLabel {
    _headlineLabel = [[UILabel alloc] init];
    _headlineLabel.textAlignment = NSTextAlignmentLeft;
    _headlineLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _headlineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _headlineLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _headlineLabel.numberOfLines = 3;
    _headlineLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_headlineLabel];
    
    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_headlineLabel
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_headlineLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_articleCellImageView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:5];

    NSLayoutConstraint *headlineCenterY = [NSLayoutConstraint constraintWithItem:_headlineLabel
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1
                                                                        constant:0];

    
    [self.contentView addConstraints:@[headlineRightSide, headlineLeftSide, headlineCenterY]];
}

- (void)createdCategoryLabel {
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.textAlignment = NSTextAlignmentLeft;
    _categoryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _categoryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _categoryLabel.font = [UIFont systemFontOfSize:12.0f];
    _categoryLabel.numberOfLines = 1;
    _categoryLabel.textColor = [UIColor grayColor];

    [self.contentView addSubview:_categoryLabel];
    
    NSLayoutConstraint *categoryRightSide = [NSLayoutConstraint constraintWithItem:_categoryLabel
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_headlineLabel
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1
                                                                        constant:0];
    
    NSLayoutConstraint *categoryLeftSide = [NSLayoutConstraint constraintWithItem:_categoryLabel
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:_headlineLabel
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *categoryBottom = [NSLayoutConstraint constraintWithItem:_categoryLabel
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:0];
    
    [self.contentView addConstraints:@[categoryLeftSide, categoryRightSide, categoryBottom]];
}

- (void)createdImageView {
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
    
    [self.contentView addConstraints:@[imageLeftSide, imageTop, imageHeight, imageWidth]];
}

@end
