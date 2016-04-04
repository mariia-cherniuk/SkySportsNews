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
        [self createdAuthor];
    }
    
    return self;
}

- (void)createdHeadline {
    _headline = [[UILabel alloc] init];
    _headline.textAlignment = NSTextAlignmentLeft;
    _headline.lineBreakMode = NSLineBreakByTruncatingTail;
    _headline.translatesAutoresizingMaskIntoConstraints = NO;
    _headline.font = [UIFont systemFontOfSize:14.0f];
    _headline.numberOfLines = 3;
    _headline.textColor = [UIColor blackColor];
    [self.contentView addSubview:_headline];
    
    NSLayoutConstraint *headlineRightSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *headlineLeftSide = [NSLayoutConstraint constraintWithItem:_headline
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_image
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *headlineTop = [NSLayoutConstraint constraintWithItem:_headline
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1
                                                                    constant:0];
    
    [self addConstraints:@[headlineRightSide, headlineLeftSide, headlineTop]];
}

- (void)createdAuthor {
    _author = [[UILabel alloc] init];
    _author.textAlignment = NSTextAlignmentLeft;
    _author.lineBreakMode = NSLineBreakByTruncatingTail;
    _author.translatesAutoresizingMaskIntoConstraints = NO;
    _author.font = [UIFont systemFontOfSize:10.0f];
    _author.numberOfLines = 1;
    _author.textColor = [UIColor grayColor];
    [self.contentView addSubview:_author];
    
    NSLayoutConstraint *authorRightSide = [NSLayoutConstraint constraintWithItem:_author
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_headline
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *authorLeftSide = [NSLayoutConstraint constraintWithItem:_author
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_headline
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *authorTop = [NSLayoutConstraint constraintWithItem:_author
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_headline
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *authorBottom = [NSLayoutConstraint constraintWithItem:_author
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:0];
    
    [self addConstraints:@[authorRightSide, authorLeftSide, authorTop, authorBottom]];
}

- (void)createdImage {
    _image = [[UIImageView alloc] init];
    _image.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_image];
    
    NSLayoutConstraint *imageLeftSide = [NSLayoutConstraint constraintWithItem:_image
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1
                                                                      constant:0];
    
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
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    
    [self addConstraints:@[imageLeftSide, imageTop, imageHeight, imageWidth]];
}

@end
