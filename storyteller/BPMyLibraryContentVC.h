//
//  BPMyLibraryContentVC.h
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@class BPMyLibraryContentVC;

@protocol BPMyLibraryContentDelegate
-(void)contentIsScrollingAt:(CGFloat)contentOffset;
-(void)contentScrollingEnded:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)contentScrollingStarted:(UIScrollView *)scrollView;
@end

@interface BPMyLibraryContentVC : UIViewController<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <BPMyLibraryContentDelegate> delegate;

- (void)configureFetchForSearch:(NSString*)searchString;

@end
