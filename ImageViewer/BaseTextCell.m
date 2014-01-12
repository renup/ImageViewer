//
//  BaseTextCell.m
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "BaseTextCell.h"

@implementation BaseTextCell

@synthesize imageForCell, captionStr, mainView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self.contentView]
//        self.imageForCell = [[ImageManager alloc] init];
//        [self.imageForCell setBackgroundColor:[UIColor clearColor]];
//        [self.imageForCell setOpaque:YES];
//        [self.mainView addSubview:self.imageForCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
