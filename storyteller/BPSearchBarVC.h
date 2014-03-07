//
//  BPSearchBar.h
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPSearchBarVC;

@protocol BPSearchBarDelegate
- (void)searchBarBeganEditing:(UISearchBar *)searchBar;
- (void)searchBarEndedEditing:(UISearchBar *)searchBar;
- (void)searchBarTextDidChange:(NSString *)searchText;

- (void)switchPresentationTo:(int) viewID;
@end

@interface BPSearchBarVC : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) id <BPSearchBarDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
