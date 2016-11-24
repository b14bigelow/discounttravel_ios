//
//  MyTableViewController.m
//  TableView
//
//  Created by yuriy sych on 11/4/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "ToursListViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "NetworkManager.h"

@interface ToursListViewController ()
@property(nonatomic, retain)NSOperationQueue *imagesDownloadingOperationQueue;
@property(nonatomic, retain)NSMutableDictionary *operationDictionary;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end

@implementation ToursListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imagesDownloadingOperationQueue = [[NSOperationQueue alloc] init];
    _operationDictionary = [[NSMutableDictionary alloc] init];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
//    [getAppDelegate().model setDelegate:self];
}

//ModelDelegate
- (void)dataUpdated{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[getAppDelegate().model toursList] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    NSBlockOperation *loadImageOperation = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation *weakOperation = loadImageOperation;
    
//    Item *item = [getAppDelegate().model.toursList objectAtIndex:indexPath.row];
//    NSURL *url = [NSURL URLWithString:item.media];
//
//    [loadImageOperation addExecutionBlock:^(void){
//        [NetworkManager sendRequest:item.media
//                  complitionHandler:^(NSData *data) {
//                      UIImage *image = [UIImage imageWithData:data];
//                      [[NSOperationQueue mainQueue] addOperationWithBlock:^(void) {
//                          if (!weakOperation.isCancelled)
//                          {
//                              UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//                              cell.imageView.image = image;
//                              [cell layoutSubviews];
//                              [self.operationDictionary removeObjectForKey:indexPath];
//                          }
//                      }];
//                  }
//                       showErrors:NO];
//    }];
//    
//    if(url){
//        [self.operationDictionary setObject:loadImageOperation forKey:indexPath];
//    }
//    
//    if(loadImageOperation){
//        [self.imagesDownloadingOperationQueue addOperation:loadImageOperation];
//    }
//    
//    cell.imageView.image = [UIImage imageNamed:@"feed_placeholder"];
//    cell.textLabel.text = item.title;
//    cell.detailTextLabel.text = item.pub_date;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSBlockOperation *outgoingDownloadOperation = [self.operationDictionary objectForKey:indexPath];
    if(outgoingDownloadOperation){
        [outgoingDownloadOperation cancel];
        [self.operationDictionary removeObjectForKey:indexPath];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSInteger clickedRow;
    if([segue.identifier isEqualToString:@"detail"]){
        clickedRow = [self.tableView indexPathForSelectedRow].row;
    }
//    getAppDelegate().model.currentItemIndex = clickedRow;
}

@end
