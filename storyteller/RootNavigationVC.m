//
//  RootNavigationVC.m
//  storyteller
//
//  Created by Bogdan Pavel on 07/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "RootNavigationVC.h"
#import "MenuViewController.h"

@interface RootNavigationVC ()
@property (nonatomic, strong) MenuViewController *menuController;
@property (nonatomic, strong) UIViewController *settingsController;

@property (strong, nonatomic) UIView *menuContainerView;
@property (strong, nonatomic) UIView *menuBackgroundView;
@property (strong, nonatomic) UIView *menuTriggerView;

@property (nonatomic) CGFloat iphoneHeight;
@property (nonatomic) CGFloat iphoneWidth;
@property (nonatomic) CGFloat menuPositionX;
@end

@implementation RootNavigationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib{
    self.menuController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsController"];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    CGFloat tW = [[UIScreen mainScreen] bounds].size.width;
    CGFloat tH = [[UIScreen mainScreen] bounds].size.height;
    self.iphoneWidth = (tW<tH)?tW:tH;
    self.iphoneHeight = (tW<tH)?tH:tW;
    
    self.menuBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.menuBackgroundView.backgroundColor = [UIColor blackColor];
    self.menuBackgroundView.alpha = 0.0;
    self.menuBackgroundView.opaque = NO;
    
    self.menuTriggerView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 15, self.view.frame.size.height-60)];
    self.menuTriggerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emptyPixel"]];
    //self.menuTriggerView.backgroundColor = [UIColor grayColor];
    self.menuTriggerView.opaque = NO;

    self.menuContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, self.view.frame.size.height)];
    self.menuContainerView.clipsToBounds = YES;
    self.menuContainerView.opaque = NO;
    self.menuContainerView.backgroundColor = [UIColor clearColor];
    [self.menuContainerView addSubview:self.menuController.view];
    
    CGRect settingsFrame = self.settingsController.view.frame;
    settingsFrame.origin.y = self.settingsController.view.frame.size.height;
    self.settingsController.view.frame = settingsFrame;
    self.settingsController.view.alpha=0;
    
    
    [self.view addSubview:self.menuTriggerView];
    [self.view addSubview:self.menuBackgroundView];
    [self.view addSubview:self.menuContainerView];
    [self.view addSubview:self.settingsController.view];
    
    CGRect frame = self.menuContainerView.frame;
    frame.origin.x = -self.menuContainerView.frame.size.width;
    self.menuContainerView.frame = frame;
    self.menuContainerView.alpha=0;
    self.menuPositionX = self.menuContainerView.frame.origin.x;
    
    UITapGestureRecognizer *tapOnBackgroundRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBackgroundRecognized:)];
    [self.menuBackgroundView addGestureRecognizer:tapOnBackgroundRecognizer];
    
    UISwipeGestureRecognizer *swipeOnBackgroundRecognizer =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeOnBackgroundRecognized:)];
    swipeOnBackgroundRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.menuBackgroundView addGestureRecognizer:swipeOnBackgroundRecognizer];
    
    UIPanGestureRecognizer *panOnMenuTriggerRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(panOnMenu:)];
    [self.menuTriggerView addGestureRecognizer:panOnMenuTriggerRecognizer];
    
    UIPanGestureRecognizer *panOnMenuRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(panOnMenu:)];
    [self.menuContainerView addGestureRecognizer:panOnMenuRecognizer];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMenuTriggered:)
                                                 name:@"openMenu"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeScene:)
                                                 name:@"changeScene"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideSettings:)
                                                 name:@"doneEditingSettings"
                                               object:nil];
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)tapOnBackgroundRecognized:(UITapGestureRecognizer *)sender{
    [self hideMenu];
}
-(void)swipeOnBackgroundRecognized:(UISwipeGestureRecognizer *)sender{
    [self hideMenu];
}
- (void)panOnMenu:(UIPanGestureRecognizer *)sender
{
    self.menuContainerView.alpha=1;
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [sender translationInView:self.menuContainerView];
        CGRect frame = self.menuContainerView.frame;
        frame.origin.x = point.x + self.menuPositionX;
        if (frame.origin.x > 0)
        {
            frame.origin.x =0;
        }
        self.menuContainerView.frame = frame;
        self.menuBackgroundView.alpha = frame.origin.x/500+0.5;
    }
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        self.menuPositionX = self.menuContainerView.frame.origin.x;
        CGPoint velocity = [sender velocityInView:self.menuContainerView];
        //CGFloat speed = fabs(velocity.x);
        if(velocity.x <= 0)
        {
            //moving left
            [self animateLayerToPoint:-self.menuContainerView.bounds.size.width];
            
        }
        else
        {
            //moving right
            [self animateLayerToPoint:0];
        }
    }
}
-(void)animateLayerToPoint:(CGFloat)x{
    self.menuContainerView.alpha=1;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.menuContainerView.frame;
                         frame.origin.x = x;
                         self.menuContainerView.frame = frame;
                         self.menuBackgroundView.alpha = x/500+0.50;
                         //NSLog(@"x=%f",x);
                         
                     }
                     completion:^(BOOL finished) {
                         self.menuPositionX = self.menuContainerView.frame.origin.x;
                         self.menuContainerView.alpha=(x<0)?0:1;
                         
                     }];
}
-(void)showMenu{
    [self animateLayerToPoint:0];
}
-(void)hideMenu{
    [self animateLayerToPoint:-self.menuContainerView.bounds.size.width];
}

-(void)showMenuTriggered:(NSNotification *)note{
    [self showMenu];
}
-(void)changeScene:(NSNotification *)note{
    [self hideMenu];
    NSDictionary *data = [note userInfo];
    if (data != nil) {
        NSString *newScene = [data objectForKey:@"scene"];
        NSLog(@"change scene to: %@", newScene);
        if ([newScene isEqualToString:@"Settings"]) {
            [self animateSettingsToPoint:0.0];
        }
    }
}
-(void)hideSettings:(NSNotification *)note{
    [self animateSettingsToPoint:self.settingsController.view.frame.size.height];
}

-(void)animateSettingsToPoint:(CGFloat)y{
    self.settingsController.view.alpha=1;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.settingsController.view.frame;
                         frame.origin.y = y;
                         self.settingsController.view.frame = frame;
                         //NSLog(@"x=%f",x);
                         
                     }
                     completion:^(BOOL finished) {
                         //self.menuPositionX = self.menuContainerView.frame.origin.x;
                         self.settingsController.view.alpha=(y==0)?1:0;

                     }];
}



-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation==UIInterfaceOrientationLandscapeRight ) {
        CGRect menuFrame = self.menuContainerView.frame;
        menuFrame.size.height = self.iphoneWidth;
        self.menuContainerView.frame = menuFrame;
        
        CGRect bgFrame = self.menuBackgroundView.frame;
        bgFrame.size.height = self.iphoneWidth;
        bgFrame.size.width = self.iphoneHeight;
        self.menuBackgroundView.frame = bgFrame;
        
        [self.menuController.heightConstraint setConstant:self.iphoneWidth-20];
    }else{
        CGRect frame = self.menuContainerView.frame;
        frame.size.height = self.iphoneHeight;
        self.menuContainerView.frame = frame;
        
        CGRect bgFrame = self.menuBackgroundView.frame;
        bgFrame.size.height = self.iphoneHeight;
        bgFrame.size.width = self.iphoneWidth;
        self.menuBackgroundView.frame = bgFrame;
        
        [self.menuController.heightConstraint setConstant:self.iphoneHeight-20];
    }
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
