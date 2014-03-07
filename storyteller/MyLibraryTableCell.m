//
//  MyLibraryTableCell.m
//  storyteller
//
//  Created by Bogdan Pavel on 28/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "MyLibraryTableCell.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"

@interface MyLibraryTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation MyLibraryTableCell

#define debug 1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setAudiobook:(Audiobook *)audiobook{
    _audiobook = audiobook;
    self.titleLabel.text = audiobook.title;
}
- (IBAction)showOptions:(UIButton *)sender {
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    //UIActionSheet
}
- (IBAction)deleteAudiobook:(UIButton *)sender {
    if (debug==1) { NSLog(@"Running %@ '%@': %@", self.class,NSStringFromSelector(_cmd), self.audiobook.title);}
    [[self.audiobook managedObjectContext] deleteObject:self.audiobook];
    
    CoreDataHelper *cdh =[(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataHelper];
    [cdh saveContext];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    //if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super setSelected:selected animated:animated];
}

@end
