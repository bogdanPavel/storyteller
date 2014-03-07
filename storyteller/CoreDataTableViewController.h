//
//  CoreDataTableViewController.h
//  storyteller
//
//  Created by Bogdan Pavel on 02/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchResultsController;
-(void)performFetch;
@property BOOL debug;

@end
