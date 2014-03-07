//
//  MyLibraryVC.m
//  ttt
//
//  Created by Bogdan Pavel on 26/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "MyLibraryVC.h"
#import "AudiobookDetailVC.h"

@interface MyLibraryVC ()

@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIView *search;
@property (weak, nonatomic) IBOutlet UIView *content;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLeftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTopConstraint;

@property (strong, nonatomic) BPSearchBarVC *searchController;
@property (strong, nonatomic) BPNavigationBarVC *headerController;
@property (strong, nonatomic) BPMyLibraryContentVC *contentController;

@property (nonatomic) CGFloat iphoneHeight;
@property (nonatomic) CGFloat iphoneWidth;
@property (nonatomic) CGFloat keyboardHeight;

@property (nonatomic) BOOL tableIsShown;
@property (nonatomic) BOOL contentIsDragged;
@property (nonatomic) BOOL searchIsShown;
@property (nonatomic) BOOL keyboardIsShown;

@property (nonatomic) BOOL isFiltering;

@property (strong, nonatomic) NSFetchedResultsController *frc;

@end

@implementation MyLibraryVC

#define debug 1

- (void)dealloc {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super didReceiveMemoryWarning];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([segue.identifier isEqualToString:@"headerEmbeded"]) {
        self.headerController=(BPNavigationBarVC*)[segue destinationViewController];
        self.headerController.delegate=self;
    }
    if ([segue.identifier isEqualToString:@"contentEmbeded"]) {
        self.contentController=(BPMyLibraryContentVC*)[segue destinationViewController];
        self.contentController.delegate=self;
    }
    if ([segue.identifier isEqualToString:@"searchEmbeded"]) {
        self.searchController=(BPSearchBarVC*)[segue destinationViewController];
        self.searchController.delegate=self;
    }
}
- (void)viewDidLoad{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewDidLoad];
	CGFloat tW = [[UIScreen mainScreen] bounds].size.width;
    CGFloat tH = [[UIScreen mainScreen] bounds].size.height;
    self.iphoneWidth = (tW<tH)?tW:tH;
    self.iphoneHeight = (tW<tH)?tH:tW;
    
    
    
    //self.search.alpha=0.5;
    //self.header.alpha=0.5;
    self.view.backgroundColor = [UIColor redColor];
    [self.contentController configureFetchForSearch:nil];
    
    [self.searchTopConstraint setConstant:60-44];
    [self.contentTopConstraint setConstant:60-44];
    [self showCollectionWithSize:[self currentWidth]  animated:NO];
    
}
-(void)viewDidAppear:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.contentController.tableView reloadData];
    [self.contentController.collectionView reloadData];
    [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(keyboardWillShow:)
               name:UIKeyboardWillShowNotification
             object:nil];
    [nc addObserver:self
           selector:@selector(keyboardWillHide:)
               name:UIKeyboardWillHideNotification
             object:nil];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.searchController.searchBar resignFirstResponder];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewWillDisappear:animated];

}

//*************************************************
#pragma mark - Scrolling

-(void)contentIsScrollingAt:(CGFloat)contentOffset{
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([self.contentBottomConstraint constant]>0) {
        return;
    }
    CGFloat y = contentOffset;
    CGFloat c = self.searchIsShown?60:60-44;
    if (self.contentIsDragged) {
        if (self.searchIsShown) {
            if (y < 0){
                y =0;
            }else if (y > 44){
                y = 44;
            }
        }else{
            if (y < -44){
                y =-44;
            }else if (y > 0){
                y =0;
            }
        }
        [self.searchTopConstraint setConstant:c-y];
        [self.view layoutIfNeeded];
    }
}
-(void)contentScrollingEnded:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([self.contentBottomConstraint constant]>0) {
        return;
    }
    self.contentIsDragged=NO;
    if (self.searchIsShown) {
        if (scrollView.contentOffset.y>24) {
            self.searchIsShown = NO;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [self.searchTopConstraint setConstant:60-44];
                                 if (scrollView.contentOffset.y<44){
                                     NSLog(@"make contentoffset 0");
                                     scrollView.contentOffset=CGPointMake(0, 0);
                                 }else{
                                     NSLog(@"make contentoffset creazzzy !!!!!!!");
                                     scrollView.contentOffset=CGPointMake(0, -44+scrollView.contentOffset.y);
                                 }
                                 [self.contentTopConstraint setConstant:60-44];
                                 [self.view layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {}];
        }else if (scrollView.contentOffset.y >0){
            self.searchIsShown = YES;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [self.searchTopConstraint setConstant:60];
                                 [self.contentTopConstraint setConstant:60];
                                 scrollView.contentOffset=CGPointMake(0, 0);
                                 [self.view layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {}];
        }
    }else{
        if (scrollView.contentOffset.y<=-24) {
            self.searchIsShown = YES;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [self.searchTopConstraint setConstant:60];
                                 [self.contentTopConstraint setConstant:60];
                                 [self.view layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {}];
        }else if (scrollView.contentOffset.y <0){
            self.searchIsShown = NO;
            [UIView animateWithDuration:0.2
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 [self.searchTopConstraint setConstant:60-44];
                                 [self.contentTopConstraint setConstant:60-44];
                                 [self.view layoutIfNeeded];
                             }
                             completion:^(BOOL finished) {}];
        }

    }
}
-(void)contentScrollingStarted:(UIScrollView *)scrollView{
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([self.contentBottomConstraint constant]>0) {
        return;
    }
    self.contentIsDragged=YES;
}

//*************************************************
#pragma mark - Switch content

-(void)switchPresentationTo:(int)viewID{
    //BOOL isInPortrait = UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]);
    if (debug==1) { NSLog(@"Running %@ '%@' , isPortrait: %i", self.class,NSStringFromSelector(_cmd), self.isPortrait);}
    
    if (viewID==1) {
        [self.contentController.tableView reloadData];
        [self showTableWithSize:self.currentWidth animated:YES];
    }else{
        [self.contentController.collectionView reloadData];
        [self showCollectionWithSize:self.currentWidth animated:YES];
    }
}

//*************************************************
#pragma mark - Content view management

-(void)showTableWithSize:(CGFloat)width animated:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self.tableIsShown=YES;
    [self.view layoutIfNeeded];
    self.contentController.tableView.contentOffset=CGPointZero;
    self.contentController.tableView.alpha=1;
    
    if (animated) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.contentLeftConstraint setConstant:-width];
                             [self.contentRightConstraint setConstant:0];
                             [self.contentBottomConstraint setConstant:self.keyboardHeight];
                             [self.view layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             self.contentController.collectionView.alpha=0;
                         }];
    }else{
        [self.contentLeftConstraint setConstant:-width];
        [self.contentRightConstraint setConstant:0];
        [self.contentBottomConstraint setConstant:self.keyboardHeight];
        [self.view layoutIfNeeded];
    }
}
-(void)showCollectionWithSize:(CGFloat)width animated:(BOOL)animated{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self.tableIsShown=NO;
    [self.view layoutIfNeeded];
    //[self.contentController.collectionView reloadData];
    self.contentController.collectionView.alpha=1;
    self.contentController.collectionView.contentOffset=CGPointZero;
    if (animated) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.contentLeftConstraint setConstant:0];
                             [self.contentRightConstraint setConstant:-width];
                             [self.contentBottomConstraint setConstant:self.keyboardHeight];
                             [self.view layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             self.contentController.tableView.alpha=0;
                         }];
    }else{
        [self.contentLeftConstraint setConstant:0];
        [self.contentRightConstraint setConstant:-width];
        [self.contentBottomConstraint setConstant:self.keyboardHeight];
        [self.view layoutIfNeeded];
    }
}

//*************************************************
#pragma mark - Rotation
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation==UIInterfaceOrientationLandscapeRight ) {
        if (self.tableIsShown) {
            [self showTableWithSize:self.iphoneHeight animated:YES];
        }else{
            [self showCollectionWithSize:self.iphoneHeight animated:YES];
        }
    }else{
        if (self.tableIsShown) {
            [self showTableWithSize:self.iphoneWidth animated:YES];
        }else{
            [self showCollectionWithSize:self.iphoneWidth animated:YES];
        }
    }
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)searchBarBeganEditing:(BPSearchBarVC *)searchBar{
    
}
- (void)searchBarEndedEditing:(BPSearchBarVC *)searchBar{
    
}
//*************************************************
#pragma mark - Keyboard
-(void)keyboardWillShow:(NSNotification *)note {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    NSDictionary *userInfo = [note userInfo];
    CGSize kSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardHeight = self.isPortrait ? kSize.height : kSize.width;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.headerTopConstraint setConstant:-40];
                         [self.searchTopConstraint setConstant:20];
                         [self.contentTopConstraint setConstant:20];
                         [self.contentBottomConstraint setConstant:self.keyboardHeight];
                         self.header.alpha=0;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {}];
}
-(void)keyboardWillHide:(NSNotification *)note {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self.keyboardHeight = 0;
    self.searchIsShown=self.isFiltering?YES: NO;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.headerTopConstraint setConstant:0];
                         [self.searchTopConstraint setConstant:self.isFiltering?60:60-44];
                         [self.contentTopConstraint setConstant:self.isFiltering?60:60-44];
                         [self.contentBottomConstraint setConstant:0];
                         if(self.tableIsShown){
                             NSLog(@"fffffff");
                             //self.contentController.tableView.contentOffset=CGPointMake(0, -444);
                         }
                         self.header.alpha=1;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {}];
}

- (void)searchBarTextDidChange:(NSString *)searchText{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([searchText isEqualToString:@""]) {
        self.isFiltering=NO;
        [self.contentController configureFetchForSearch:nil];
        return;
    }
    self.isFiltering=YES;
    [self.contentController configureFetchForSearch:searchText];
}

//************************************************************
#pragma mark - helpers
-(BOOL)isPortrait{
    return UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
}
-(CGFloat)currentWidth{
    return self.isPortrait?self.iphoneWidth:self.iphoneHeight;
}
@end
