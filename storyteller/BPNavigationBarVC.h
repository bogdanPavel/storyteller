//
//  BPNavigationBarVC.h
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPNavigationBarVC;

@protocol BPNavigationBarDelegate

@end

@interface BPNavigationBarVC : UIViewController
@property (weak, nonatomic) id <BPNavigationBarDelegate> delegate;
@end
