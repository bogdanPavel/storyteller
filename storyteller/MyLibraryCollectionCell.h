//
//  MyLibraryCollectionCell.h
//  storyteller
//
//  Created by Bogdan Pavel on 06/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Audiobook.h"

@interface MyLibraryCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) Audiobook * audiobook;

@end
