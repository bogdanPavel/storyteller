//
//  MyLibraryTableCell.h
//  storyteller
//
//  Created by Bogdan Pavel on 28/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Audiobook.h"

@interface MyLibraryTableCell : UITableViewCell

@property (strong, nonatomic) Audiobook * audiobook;
@end
