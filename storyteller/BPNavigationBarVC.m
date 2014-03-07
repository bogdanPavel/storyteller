//
//  BPNavigationBarVC.m
//  ttt
//
//  Created by Bogdan Pavel on 25/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "BPNavigationBarVC.h"
#import "Audiobook.h"
#import "AudiobookDetailVC.h"
#import "RootNavigationVC.h"
#import "MenuViewController.h"

@interface BPNavigationBarVC ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *headerName;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation BPNavigationBarVC

#define debug 0

- (IBAction)showMenu:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openMenu" object:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    if ([segue.identifier isEqualToString:@"addAudiobook"]) {
        //AudiobookDetailVC *aNew =(AudiobookDetailVC*)[segue destinationViewController];
        NSLog(@"create new book");
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor lightGrayColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    if (debug==1) { NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));}
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
