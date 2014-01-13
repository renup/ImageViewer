//
//  JsonManager.h
//  ImageViewer
//
//  Created by Renu P on 1/10/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageContent.h"

@interface JSONManager : NSObject

@property (nonatomic, strong) NSMutableArray *imagesArray;

//-(JsonManager *)init;

//- (void)writeJsonToDocumentsDirectory;
//- (NSArray *)fetchedData;

-(void)parseJSONAndCreateImageContentObjects;

@end
