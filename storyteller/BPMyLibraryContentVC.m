//
//  BPMyLibraryContentVC.m
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "BPMyLibraryContentVC.h"
#import "MyLibraryTableCell.h"
#import "MyLibraryCollectionCell.h"
#import "AppDelegate.h"
#import "Audiobook.h"
#import "AudiobookDetailVC.h"

@interface BPMyLibraryContentVC ()
@property (nonatomic) BOOL isFiltered;
@property (strong, nonatomic) NSFetchedResultsController *frc;
@end

@implementation BPMyLibraryContentVC

#define debug 1

- (void)viewDidLoad{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self.collectionView.alwaysBounceVertical = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];//[self.tableView reloadData];
}

-(void)viewDidLayoutSubviews{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewDidLayoutSubviews];
}
-(void)viewWillAppear:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.collectionView reloadData];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([segue.identifier isEqualToString:@"editAudiobook"]) {
        
        AudiobookDetailVC *dest =(AudiobookDetailVC*)[segue destinationViewController];
        UIView *view = sender;
        while (view != nil && ![view isKindOfClass:[MyLibraryTableCell class]]&& ![view isKindOfClass:[MyLibraryCollectionCell class]]) {
            view = [view superview];
        }
        if ([view isKindOfClass:[MyLibraryTableCell class]]) {
            dest.audiobook = [(MyLibraryTableCell*)view audiobook];
        }else if ([view isKindOfClass:[MyLibraryCollectionCell class]]){
            dest.audiobook = [(MyLibraryCollectionCell*)view audiobook];
        }
    }
}

//**************************************************************
#pragma mark - FETCHING

-(void)configureFetchForSearch:(NSString*)searchString {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    CoreDataHelper *cdh =[(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataHelper];
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"Audiobook"];
    request.sortDescriptors =@[//[NSSortDescriptor sortDescriptorWithKey:@"locationAtHome.storedIn" ascending:YES],
                               [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    if(searchString)request.predicate = [NSPredicate predicateWithFormat:@"title CONTAINS %@",searchString];
    [request setFetchBatchSize:10];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:cdh.context
                                                     sectionNameKeyPath:nil//@"locationAtHome.storedIn"
                                                              cacheName:nil];
    self.frc.delegate = self;
    [self performFetch];
}
-(void)performFetch {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if (self.frc) {
        [self.frc.managedObjectContext performBlockAndWait:^{
            NSError *error = nil;
            if (![self.frc performFetch:&error]) {
                NSLog(@"Failed to perform fetch: %@", error);
            }
            [self.tableView reloadData];
            [self.collectionView reloadData];
        }];
    } else {
        NSLog(@"Failed to fetch, the fetched results controller is nil.");
    }
}

//**************************************************************
#pragma mark - Scrolling stuff

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.delegate contentIsScrollingAt:scrollView.contentOffset.y];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate contentScrollingEnded:scrollView willDecelerate:decelerate];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.delegate contentScrollingStarted:scrollView];
}

//**************************************************************
#pragma mark - CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (debug==1) { NSLog(@"Running %@ '%@':%lu", self.class,NSStringFromSelector(_cmd),(unsigned long)[[self.frc.sections objectAtIndex:section] numberOfObjects]);}
    return [[self.frc.sections objectAtIndex:section] numberOfObjects];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    static NSString *CellIdentifier = @"CollectionCell";
    MyLibraryTableCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                          forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    Audiobook *audiobook = [self.frc objectAtIndexPath:indexPath];
    //cell.titleLabel.text = audiobook.title;//[self.myAudiobooks objectAtIndex:indexPath.row];
    cell.audiobook = audiobook;
    return (UICollectionViewCell *)cell;
}

//**************************************************************
#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (debug==1) { NSLog(@"Running %@ '%@' %d", self.class,NSStringFromSelector(_cmd),indexPath.row);}
    if(indexPath.row==0){
        UITableViewCell *cell= nil;
        static NSString *CellIdentifier = @"TableCellTop";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
        cell.hidden=YES;
        return cell;
    }else{
        MyLibraryTableCell *cell= nil;
        static NSString *CellIdentifier = @"TableCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[MyLibraryTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row -1 inSection:indexPath.section];
        Audiobook *audiobook = [self.frc objectAtIndexPath:path];
        //cell.titleLabel.text = audiobook.title;//[self.myAudiobooks objectAtIndex:indexPath.row];
        cell.audiobook = audiobook;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger nr = [[self.frc.sections objectAtIndex:section] numberOfObjects];
    nr += (section==0)?1:0;
    //if (debug==1) { NSLog(@"Running %@ '%@' - returns %u", self.class,NSStringFromSelector(_cmd), nr);}
    return nr;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    return [[self.frc sections] count];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    return [self.frc sectionForSectionIndexTitle:title atIndex:index];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    return [[[self.frc sections] objectAtIndex:section] name];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    return nil;//return [self.frc sectionIndexTitles];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if(indexPath.row == 0){
        return 44;
    }else{
        return 80;
    }
    
}

//**************************************************************
#pragma mark - DELEGATE: NSFetchedResultsController

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.tableView endUpdates];
    //[self.collectionView reloadData];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    UITableView *tableView = self.tableView;
    NSIndexPath *oldPath = [NSIndexPath indexPathForRow:indexPath.row +1 inSection:indexPath.section];
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:newIndexPath.row +1 inSection:newIndexPath.section];

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:oldPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            if (!newPath) {
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:oldPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
            } else {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:oldPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:oldPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


@end
