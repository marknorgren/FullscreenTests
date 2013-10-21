//
//  MRKFirstViewController.m
//  fullscreenTest
//
//  Created by Mark Norgren on 10/16/13.
//  Copyright (c) 2013 Mark Norgren. All rights reserved.
//

#import "MRKFirstViewController.h"
#import "MRKAppDelegate.h"

#define CGRectCopy(rect) {rect.origin, rect.size}

@interface MRKFirstViewController ()
@end

@implementation MRKFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButton1Touched:(id)sender {
    CATransition *animation = [CATransition animation];

    if (self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [animation setType:kCATransitionFade];
        [[self.view.window layer] addAnimation:animation forKey:@"layerAnimation"];
        [self.tabBarController.tabBar setHidden:NO];
        
    }
    else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [animation setType:kCATransitionFade];
        [[self.view.window layer] addAnimation:animation forKey:@"layerAnimation"];
        [self.tabBarController.tabBar setHidden:YES];
        //AppDelegateFileName *appDelegate = (AppDelegateFileName *) [[UIApplication sharedApplication] delegate];
    }
    
}

- (IBAction)swipeUp:(id)sender {
	NSLog(@"SwipeUp");
	
	CGRect tabBarFrame = CGRectCopy(self.tabBarController.view.frame);
	if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
	{
		tabBarFrame.origin.y -= 10;
	}
	else
	{
		tabBarFrame.origin.x += 10;
	}
	[self.tabBarController.view setFrame:tabBarFrame];
}

- (IBAction)swipeDown:(id)sender {
	NSLog(@"SwipeDown");
	CGRect tabBarFrame = CGRectCopy(self.tabBarController.view.frame);
	if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
	{
		tabBarFrame.origin.y += 10;
	}
	else
	{
		tabBarFrame.origin.x -= 10;
	}
	[self.tabBarController.view setFrame:tabBarFrame];
}

//
// Follow code based on: http://stackoverflow.com/a/13125557/406
//
BOOL isAnimating = NO;
BOOL isTabBarAndNavBarHidden = NO;

- (IBAction)testButton2Touched:(UIButton *)sender {
    
    if (!isAnimating) {
        if (isTabBarAndNavBarHidden) {
            
            [UIView transitionWithView:self.view
                              duration:0.5
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:^
             {
                 isAnimating = YES;
                 
                 CGFloat statusBarHeight = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? [[UIApplication sharedApplication] statusBarFrame].size.height : [[UIApplication sharedApplication] statusBarFrame].size.width;
				 CGFloat screenHeight = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;

                 
//				 NSLog(@"<< tabBarFrame = %@", NSStringFromCGRect(self.tabBarController.view.frame));
 				 CGRect tabBarFrame = CGRectCopy(self.tabBarController.view.frame);
				 if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
				 {
					 tabBarFrame.origin.y = 0;
					 tabBarFrame.size.height = screenHeight;
				 }
				 else
				 {
					 tabBarFrame.origin.x = 0;
					 tabBarFrame.size.width = screenHeight;
				 }
				 [self.tabBarController.view setFrame:tabBarFrame];
//				 NSLog(@">> tabBarFrame = %@", NSStringFromCGRect(self.tabBarController.view.frame));

//				 NSLog(@"<< navigationBar.frame = %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
				 CGRect navBarFrame = CGRectCopy(self.navigationController.navigationBar.frame);
				 navBarFrame.origin.y = statusBarHeight;
				 [self.navigationController.navigationBar setFrame:navBarFrame];
//				 NSLog(@">> navigationBar.frame = %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
             }
                            completion:^(BOOL finished)
             {
                 isTabBarAndNavBarHidden = NO;
                 isAnimating = NO;
             }];
            
        } else {
            
            [UIView transitionWithView:self.view
                              duration:0.5
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:^
             {
                 isAnimating = YES;
                 
                 CGFloat statusBarHeight = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? [[UIApplication sharedApplication] statusBarFrame].size.height : [[UIApplication sharedApplication] statusBarFrame].size.width;
                 CGFloat screenHeight = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;

//				 NSLog(@"<< tabBarFrame = %@", NSStringFromCGRect(self.tabBarController.view.frame));
				 CGRect tabBarFrame = CGRectCopy(self.tabBarController.view.frame);
				 if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
				 {
					 tabBarFrame.origin.y = statusBarHeight - self.navigationController.navigationBar.frame.size.height;
					 tabBarFrame.size.height = screenHeight + self.navigationController.navigationBar.frame.size.height + self.tabBarController.tabBar.frame.size.height - statusBarHeight;
				 }
				 else
				 {
					 tabBarFrame.origin.x = -self.tabBarController.tabBar.frame.size.height;
					 tabBarFrame.size.width = screenHeight + self.navigationController.navigationBar.frame.size.height + self.tabBarController.tabBar.frame.size.height - statusBarHeight;
				 }
                 [self.tabBarController.view setFrame:tabBarFrame];
//				 NSLog(@">> tabBarFrame = %@", NSStringFromCGRect(self.tabBarController.view.frame));

//				 NSLog(@"<< navigationBar.frame = %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
				 CGRect navBarFrame = CGRectCopy(self.navigationController.navigationBar.frame);
				 navBarFrame.origin.y = 0;
				 [self.navigationController.navigationBar setFrame:navBarFrame];
//				 NSLog(@">> navigationBar.frame = %@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
             }
                            completion:^(BOOL finished)
             {
                 isTabBarAndNavBarHidden = YES;
                 isAnimating = NO;
             }];
            
        }
    }
}

@end
