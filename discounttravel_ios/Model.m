//
//  Model.m
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import "Model.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Version+CoreDataClass.h"
#import "Category+CoreDataClass.h"
#import "Tour+CoreDataClass.h"
#import "NetworkManager.h"

@interface Model () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *context;
@property(nonatomic, retain)NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain)id<ModelDelegate> modelDelegate;
@property(nonatomic, assign)int currentDBVersion;
@end
@implementation Model
- (instancetype)init
{
    self = [super init];
    if (self) {
        _countriesList = [[NSMutableArray alloc] initWithObjects:@"Title 1", nil];
        _toursList = [[NSArray alloc] init];
        _context = getAppDelegate().persistentContainer.viewContext;
        [self getCategoriesFromServer];
//        [self fetchCategoriesFromDB];
        [self fetchToursFromDB];

    }
    return self;
}

//NSFetchedResultsControllerDelegate
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    self.toursList = controller.fetchedObjects;
    [self.modelDelegate dataUpdated];
}

- (void)getToursFromServer{
    self.currentDBVersion = [self fetchCurrentVersionFromDB];
    NSMutableString *toursRequestWithVersion = [NSMutableString stringWithFormat:@"http://www.discount-travel.com.ua/index.php?option=com_jsoncontent&view=jsoncontent&version=%d", self.currentDBVersion];
    [NetworkManager sendRequest:toursRequestWithVersion
              complitionHandler:^(NSData *data) {
                  [self uploadAndProcessTours:data];
              }
                     showErrors:YES];
}

- (void)getCategoriesFromServer{
    [NetworkManager sendRequest:@"http://www.discount-travel.com.ua/index.php?option=com_jsoncontent&view=jsoncontent&id_content=1"
              complitionHandler:^(NSData *data) {
                  [self processDownloadedCategories:data];
              }
                     showErrors:YES];
}

- (int)fetchCurrentVersionFromDB{
    int result = 0;
    NSError *error = nil;
    NSFetchRequest *currentVersionRequest = [[NSFetchRequest alloc] initWithEntityName:@"Version"];
    NSArray *verionArray = [self.context executeFetchRequest:currentVersionRequest error:&error];
    if([verionArray count] == 1){
        Version *currentVerison = (Version *) verionArray[0];
        result = currentVerison.versionCode;
    }
    return result;
}

- (void)processDownloadedCategories:(NSData *)data{
    NSError *error = nil;
    NSArray *response = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
    if(response && [response count] > 0){

        //deleting all old categories
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Category"];
        NSBatchDeleteRequest *deleteCategories = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        [self.context executeRequest:deleteCategories error:&error];
        [self.context reset];
        
        //saving new categories
        for(NSDictionary *categoriesDictionary in response){
            Category *category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.context];
            category.category_id = [[categoriesDictionary valueForKey:@"id"] intValue];
            category.alias = [categoriesDictionary valueForKey:@"alias"];
            category.title = [categoriesDictionary valueForKey:@"title"];
            category.published = [categoriesDictionary valueForKey:@"published"];
        }
        
        NSLog(@"Updating categories %@", [self.context save:&error] ? @"completed" : @"failed");
        
        //start fetching tours from server
        [self getToursFromServer];
    }
}

- (void)uploadAndProcessTours:(NSData *)data{
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
    int dataVersionFromServer = [[response valueForKey:@"version"] intValue];
    if(dataVersionFromServer > self.currentDBVersion){
        
        [self updateVersionInDB:dataVersionFromServer];
        
        NSArray *toursFromServer = [response valueForKey:@"tours"];
        if(toursFromServer && [toursFromServer count] > 0){
            for(NSDictionary *tourDictionary in toursFromServer){
                int state = [[tourDictionary valueForKey:@"state"] intValue];
                int tour_id = [[tourDictionary valueForKey:@"id"] intValue];
                if(state == 1){
                    NSFetchRequest *toursRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tour"];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tour_id == %d", tour_id];
                    [toursRequest setPredicate:predicate];
                    NSArray *tourFromDB = [self.context executeFetchRequest:toursRequest error:&error];
                    if([tourFromDB count] == 1){
                        Tour *tourForDeletion = (Tour *) tourFromDB[0];
                        [self.context deleteObject:tourForDeletion];
                    }
                    Tour *tour = [NSEntityDescription insertNewObjectForEntityForName:@"Tour" inManagedObjectContext:self.context];
                    tour.tour_id = [[tourDictionary valueForKey:@"id"] intValue];
                    tour.images = [tourDictionary valueForKey:@"images"];
                    tour.introtext = [tourDictionary valueForKey:@"introtext"];
                    tour.title = [tourDictionary valueForKey:@"title"];
                    tour.gallery = [tourDictionary valueForKey:@"gallery"];
                    tour.catid = [tourDictionary valueForKey:@"catid"];
                    tour.created = [tourDictionary valueForKey:@"created"];
                    tour.modified = [tourDictionary valueForKey:@"modified"];
                    tour.state = [[tourDictionary valueForKey:@"state"] intValue];
                    tour.type = [tourDictionary valueForKey:@"type"];
                } else if (state == 0) {
                    NSFetchRequest *toursRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tour"];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tour_id == %d", tour_id];
                    [toursRequest setPredicate:predicate];
                     NSArray *tourFromDB = [self.context executeFetchRequest:toursRequest error:&error];
                    if([tourFromDB count] == 1){
                        Tour *tourForDeletion = (Tour *) tourFromDB[0];
                        [self.context deleteObject:tourForDeletion];
                    }

                }
            }
            NSLog(@"Updating tours %@", [self.context save:&error] ? @"completed" : @"failed");
        }
    }
}

- (void)updateVersionInDB:(int)newVersionValue{
    NSError *error;
    Version *version = [NSEntityDescription insertNewObjectForEntityForName:@"Version" inManagedObjectContext:self.context];
    version.versionCode = newVersionValue;
    NSLog(@"Updating version %@", [self.context save:&error] ? @"completed" : @"failed");
}

- (void)fetchToursFromDB{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tour" inManagedObjectContext:self.context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:self.context
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
    [self.fetchedResultsController setDelegate:self];
    NSError *error;
    if([self.fetchedResultsController performFetch:&error]){
        self.toursList = self.fetchedResultsController.fetchedObjects;
        [self.modelDelegate dataUpdated];
    };
}

- (void)setDelegate:(id<ModelDelegate>)delegate{
    _modelDelegate = delegate;
}

- (void)removeDelegate:(id<ModelDelegate>)delegate{
    _modelDelegate = nil;
}
@end
