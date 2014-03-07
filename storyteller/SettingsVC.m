//
//  SettingsVC.m
//  storyteller
//
//  Created by Bogdan Pavel on 07/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC
- (IBAction)doneEditing:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"doneEditingSettings" object:self];
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
