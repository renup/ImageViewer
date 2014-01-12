//
//  BaseTextCell.h
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageManager.h"

@interface BaseTextCell : UITableViewCell

@property (nonatomic, strong) UIView            *mainView;
@property (nonatomic, strong) ImageManager      *imageForCell;
@property (nonatomic, strong) NSString          *captionStr;



@end
