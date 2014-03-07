//
//  MenuViewController.m
//  storyteller
//
//  Created by Bogdan Pavel on 07/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *items;



@end

@implementation MenuViewController
- (IBAction)showSetting:(UIButton *)sender {
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:@"Settings"
                                                         forKey:@"scene"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScene"
                                                        object:self
                                                      userInfo:dataDict];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //switch to different controller
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:[self.items objectAtIndex:indexPath.row]
                                                         forKey:@"scene"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScene" object:self userInfo:dataDict];
    //[self hide];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
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
    
    self.items = @[@"My Library", @"My Playlists", @"Item No. 3", @"Item No. 4", @"Item No.5", @"Item No. 6"];
    
    self.view.opaque=NO;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
