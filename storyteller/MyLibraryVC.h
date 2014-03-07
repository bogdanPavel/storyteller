//
//  MyLibraryVC.h
//  ttt
//
//  Created by Bogdan Pavel on 26/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPSearchBarVC.h"
#import "BPNavigationBarVC.h"
#import "BPMyLibraryContentVC.h"
#import "CoreDataHelper.h"

@interface MyLibraryVC : UIViewController <BPSearchBarDelegate, BPMyLibraryContentDelegate, BPNavigationBarDelegate, NSFetchedResultsControllerDelegate>

@end
