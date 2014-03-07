//
//  CoreDataTableViewController.m
//  storyteller
//
//  Created by Bogdan Pavel on 02/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface CoreDataTableViewController ()

@end

@implementation CoreDataTableViewController

#pragma mark - Fetching
-(void)performFetch{
    if(self.fetchResultsController){
        if (self.fetchResultsController.fetchRequest.predicate) {
            if (self.debug) {
                NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchResultsController.fetchRequest.entityName, self.fetchResultsController.fetchRequest.predicate);
            }else{
                if (self.debug) {
                    NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchResultsController.fetchRequest.entityName);
                }
            }
            NSError *error;
            BOOL success = [self.fetchResultsController performFetch:&error];
            if (!success) {
                NSLog(@"[%@ %@] perform fetch: failed", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            if (error){
                NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
            }
            NSLog(@"fetchedResultsController found %d objects", (int) [self.fetchResultsController.fetchedObjects count]);
        }else{
            if (self.debug) {
                NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
        }
    }
    [self.tableView reloadData];
}
-(void)setFetchResultsController:(NSFetchedResultsController *)newfrc{
    NSFetchedResultsController *oldfrc = _fetchResultsController;
    if(newfrc != oldfrc){
        _fetchResultsController = newfrc;
        newfrc.delegate=self;
        if ((!self.title || [self.title isEqualToString:oldfrc.fetchRequest.entity.name])&&(!self.navigationController || !self.navigationController.title)) {
            self.title=newfrc.fetchRequest.entity.name;
        }
        if (newfrc) {
            if (self.debug) {
                NSLog(@"[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), oldfrc ? @"updated":@"set");
            }
            [self performFetch];
        }else{
            if (self.debug) {
                NSLog(@"[%@ %@] reset to nil", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
            }
            [self.tableView reloadData];
        }
    }
}

#pragma mark - UITableViewSataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [[self.fetchResultsController sections] count];
    return sections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if ([[self.fetchResultsController sections] count]>0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultsController sections] objectAtIndex:section];
        rows=[sectionInfo numberOfObjects];
    }
    return rows;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[[self.fetchResultsController sections] objectAtIndex:section] name];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [self.fetchResultsController sectionForSectionIndexTitle:title atIndex:index];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.fetchResultsController sectionIndexTitles];
}


#pragma mark - NSFetchedResultsControllerDelegate

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
@end
