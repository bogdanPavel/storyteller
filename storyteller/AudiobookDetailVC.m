//
//  AudiobookDetailVC.m
//  storyteller
//
//  Created by Bogdan Pavel on 06/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "AudiobookDetailVC.h"

#import "AppDelegate.h"
@interface AudiobookDetailVC ()

@end

@implementation AudiobookDetailVC

- (IBAction)back:(UIButton *)sender {
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    [self.view endEditing:YES];
    if(!self.audiobook && ![self.audiobookTitle.text isEqual:@""]){//save the new audiobook
        NSLog(@"new item saved");
        CoreDataHelper *cdh =[(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataHelper];
        
        Audiobook *audiobook = [ NSEntityDescription insertNewObjectForEntityForName:@"Audiobook"
                                                              inManagedObjectContext:cdh.context];
        audiobook.title=self.audiobookTitle.text;
        [cdh saveContext];
    }else if (self.audiobook.title != self.audiobookTitle.text){
        self.audiobook.title=self.audiobookTitle.text;
        CoreDataHelper *cdh =[(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataHelper];
        [cdh saveContext];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewDidLayoutSubviews{
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    [super viewDidLayoutSubviews];
    self.audiobookTitle.text = self.audiobook.title;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
