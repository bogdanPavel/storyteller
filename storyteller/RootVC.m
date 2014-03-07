//
//  RootVC.m
//  storyteller
//
//  Created by Bogdan Pavel on 07/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()

@end

@implementation RootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self performSegueWithIdentifier:@"My Library" sender:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeScene:)
                                                 name:@"changeScene"
                                               object:nil];
}

-(void)changeScene:(NSNotification *)note{
    NSDictionary *data = [note userInfo];
    if (data != nil) {
        NSString *newScene = [data objectForKey:@"scene"];
        //NSLog(@"change scene to: %@", newScene);
        if (![newScene isEqualToString:@"Settings"]) {
            @try {
                [self performSegueWithIdentifier:newScene sender:self];
            }
            @catch (NSException *exception) {
                NSLog(@"Segue not found: %@", exception);
            }
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
