//
//  MasterViewController.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MasterViewController.h"
#import "JSONManager.h"
#import "FileDownloadManager.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSArray *_objects;
    JSONManager *jsonManagerObj;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [FileDownloadManager downloadAndSaveJSON:kJSON_URL block:^(BOOL succeeded, NSError *error) {
        if (!error) {
            jsonManagerObj = [[JSONManager alloc] init];
            [jsonManagerObj parseJSONAndCreateImageContentObjects];
            _objects = jsonManagerObj.imagesArray;
            [self.tableView reloadData];
        }
    }];
    
//    imageManagerObj = [[ImageManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }else{
        NSLog(@"Reused cell");
    }
    
    cell.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.imageView.layer.cornerRadius=10;
    cell.imageView.layer.borderWidth=1.50;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor=[[UIColor blackColor] CGColor];
    
    ImageContent *imageContentobj = _objects[indexPath.row];

    UIImage *thumbPic = [[AppCache sharedAppCache] getImageForString:imageContentobj.thumbImageStr];
    if (thumbPic) {
        
        cell.imageView.image = thumbPic;
        
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        
        [FileDownloadManager dowloadAndGetImageForImageString:imageContentobj.thumbImageStr andResize:YES block:^(BOOL succeeded, UIImage *image, NSError *error) {
            if (!error)
                cell.imageView.image = image;
            else
                cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }];
    }
    
        cell.textLabel.text = imageContentobj.caption;
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ImageContent *imageContentobj = _objects[indexPath.row];
        [[segue destinationViewController] setOriginalImageString:imageContentobj.originalImageStr];
    }
}

@end
