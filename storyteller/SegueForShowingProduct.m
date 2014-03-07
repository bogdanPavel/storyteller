//
//  SegueForShowingProduct.m
//  storyteller
//
//  Created by Bogdan Pavel on 06/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "SegueForShowingProduct.h"

@implementation SegueForShowingProduct
-(void)perform{
    NSLog(@"perform segue");
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    //[src.navigationController presentModalViewController:dst animated:NO];
    [src.view addSubview:dst.view];
}
@end
