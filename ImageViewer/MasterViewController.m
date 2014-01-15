//
//  MasterViewController.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MasterViewController.h"
#import "FileDownloadManager.h"
#import "ImageContent.h"
#import "DetailViewController.h"


@interface MasterViewController () {
    NSMutableArray * _imageContentObjectsArr;
    ImageContent *imageContentobj;
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
    
    // Reload issues button
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = button;
         
    [FileDownloadManager downloadAndGetJSONForURL:kJSON_URL block:^(BOOL succeeded, NSArray* jsonArr, NSError *error) {
        if (!error) {
            
            _imageContentObjectsArr = [NSMutableArray array];
            for(NSDictionary *imageDict in jsonArr){
                if (([imageDict objectForKey:kCaptionKey] != [NSNull null]) && ([imageDict objectForKey:kThumbImageKey] != [NSNull null]) && ([imageDict objectForKey:kOriginalImageKey]!= [NSNull null])) {
                    ImageContent *imageContentObject = [[ImageContent alloc]
                                                        initImageContentWithCaption:[imageDict objectForKey:kCaptionKey]
                                                        thumbString:[imageDict objectForKey:kThumbImageKey]
                                                        andOriginalImageString:[imageDict objectForKey:kOriginalImageKey]];
                    
                    [_imageContentObjectsArr addObject:imageContentObject];
                }
            }
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)refresh:(id)sender {
    [self.tableView reloadData];
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
    return _imageContentObjectsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.numberOfLines = 0;
    
    cell.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.imageView.layer.cornerRadius=10;
    cell.imageView.layer.borderWidth=1.50;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor=[[UIColor blackColor] CGColor];
    
    imageContentobj = _imageContentObjectsArr[indexPath.row];

    UIImage *thumbPic = [[AppCache sharedAppCache] getImageForKey:imageContentobj.thumbImageStr];
    if (thumbPic) {
        cell.imageView.image = thumbPic;
        
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        
        [FileDownloadManager downloadAndGetImageForURL:imageContentobj.thumbImageStr
                                             andResize:YES
                                                 block:^(BOOL succeeded, UIImage *image, NSError *error) {
            if (succeeded)
                cell.imageView.image = image;
            else
                cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }];
    }
    
        cell.textLabel.text = imageContentobj.caption;
    return cell;
}

#pragma mark - UITableViewDelegate methods

//source: http://stackoverflow.com/questions/8831664/how-to-calculate-heightforrowatindexpath-for-cells-which-setup-via-switch-in-cel/8832778#8832778

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    imageContentobj = [_imageContentObjectsArr objectAtIndex:indexPath.row];
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:imageContentobj.caption attributes:
                                             @{ NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    
    //its not possible to get the cell label width since this method is called before cellForRow so best we can do
    //is get the table width and subtract the default extra space on either side of the label.
    CGSize constraintSize = CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT);
    
    CGRect rect = [attributedString boundingRectWithSize:constraintSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    //Add back in the extra padding above and below label on table cell.
    rect.size.height = rect.size.height + 43;
    
    //if height is smaller than a normal row set it to the normal cell height, otherwise return the bigger dynamic height.
    return (rect.size.height < 44 ? 44 : rect.size.height);
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_imageContentObjectsArr removeObjectAtIndex:indexPath.row];
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
        
        imageContentobj = _imageContentObjectsArr[indexPath.row];
        [[segue destinationViewController] setOriginalImageString:imageContentobj.originalImageStr];
    }
}

@end
