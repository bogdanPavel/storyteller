//
//  BPSearchBar.m
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "BPSearchBarVC.h"

@interface BPSearchBarVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentedControlTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTrailingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) NSString *searchedText;
@end

@implementation BPSearchBarVC

#define debug 0

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewDidLoad];
    self.segmentedControl.selectedSegmentIndex=0;
    [self.segmentedControl addTarget:self
                               action:@selector(pickOne:)
                     forControlEvents:UIControlEventValueChanged];
    self.cancelButton.alpha=0;
}

//**************************************************************
#pragma mark - Segmented Control
-(void) pickOne:(id)sender{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    [self.delegate switchPresentationTo:(int)[segmentedControl selectedSegmentIndex]];
}

//**************************************************************
#pragma mark - Cancel
- (IBAction)cancelButtonClicked:(UIButton *)sender {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self.searchBar.text=nil;
    [self.delegate searchBarTextDidChange:@""];
    self.searchedText = @"";
    [self.searchBar resignFirstResponder];
}

//**************************************************************
#pragma mark - Search
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.view layoutIfNeeded];
    [self.delegate searchBarBeganEditing:searchBar];
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.searchBarTrailingConstraint setConstant:self.cancelButton.frame.size.width+8];
                         [self.segmentedControlTrailingConstraint setConstant:-self.segmentedControl.frame.size.width];
                         self.cancelButton.alpha=1;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                     }];
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.delegate searchBarEndedEditing:searchBar];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.cancelButton.alpha=0;
                         [self.segmentedControlTrailingConstraint setConstant:8];
                         [self.segmentedControl layoutIfNeeded];
                         [self.searchBarTrailingConstraint setConstant:self.segmentedControl.frame.size.width+8];
                         [self.searchBar layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {  
                     }];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if(![self.searchedText isEqualToString:searchText]){
        NSLog(@"searchDidChange");
        [self.delegate searchBarTextDidChange:searchText];
        self.searchedText = [[NSString alloc] initWithString:searchText];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [self.searchBar resignFirstResponder];
}

@end
