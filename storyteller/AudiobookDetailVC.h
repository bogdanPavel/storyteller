//
//  AudiobookDetailVC.h
//  storyteller
//
//  Created by Bogdan Pavel on 06/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "Audiobook.h"

@interface AudiobookDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backButtonLabel;
@property (weak, nonatomic) IBOutlet UITextField *audiobookTitle;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property (strong, nonatomic) Audiobook * audiobook;

@end
