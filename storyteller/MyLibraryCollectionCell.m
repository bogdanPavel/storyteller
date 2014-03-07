//
//  MyLibraryCollectionCell.m
//  storyteller
//
//  Created by Bogdan Pavel on 06/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "MyLibraryCollectionCell.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"

@implementation MyLibraryCollectionCell

#define debug 0

- (id)initWithFrame:(CGRect)frame{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.titleLabel.text = self.audiobook.title;
    }
    return self;
}
- (void)setAudiobook:(Audiobook *)audiobook{
    _audiobook = audiobook;
    self.titleLabel.text = audiobook.title;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}
@end
