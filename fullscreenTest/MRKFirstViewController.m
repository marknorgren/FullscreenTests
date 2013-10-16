//
//  MRKFirstViewController.m
//  fullscreenTest
//
//  Created by Mark Norgren on 10/16/13.
//  Copyright (c) 2013 Mark Norgren. All rights reserved.
//

#import "MRKFirstViewController.h"
#import "MRKAppDelegate.h"

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


//
// Follow code based on: http://stackoverflow.com/a/13125557/406
//
BOOL isAnimating = NO;
BOOL isTabBarAndNavBarHidden = NO;
- (IBAction)testButton2Touched:(UIButton *)sender {
    
    if(!isAnimating){
        if(isTabBarAndNavBarHidden){
            
            [UIView transitionWithView:self.view
                              duration:0.5
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:^
             {
                 isAnimating=YES;
                 
                 CGFloat statusBar_height=[[UIApplication sharedApplication] statusBarFrame].size.height;
                 CGFloat screen_height=[UIScreen mainScreen].bounds.size.height;
                 
                 [self.tabBarController.view setFrame:CGRectMake(self.tabBarController.view.frame.origin.x,
                                                                 0,
                                                                 self.tabBarController.view.frame.size.width,
                                                                 screen_height)];
                 [self.navigationController.navigationBar setFrame:CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                              statusBar_height,
                                                                              self.navigationController.navigationBar.frame.size.width,
                                                                              self.navigationController.navigationBar.frame.size.height)];
             }
                            completion:^(BOOL finished)
             {
                 isTabBarAndNavBarHidden=NO;
                 isAnimating=NO;
             }];
            
        }else{
            
            [UIView transitionWithView:self.view
                              duration:0.5
                               options:UIViewAnimationOptionCurveEaseInOut
                            animations:^
             {
                 isAnimating=YES;
                 
                 CGFloat statusBar_height=[[UIApplication sharedApplication]
                                           statusBarFrame].size.height;
                 CGFloat screen_height=[UIScreen mainScreen].bounds.size.height;
                 
                 [self.tabBarController.view setFrame:CGRectMake(self.tabBarController.view.frame.origin.x,
                                                                 statusBar_height-self.navigationController.navigationBar.frame.size.height,
                                                                 self.tabBarController.view.frame.size.width,
                                                                 screen_height+self.navigationController.navigationBar.frame.size.height+self.tabBarController.tabBar.frame.size.height-statusBar_height)];
                 [self.navigationController.navigationBar setFrame:CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                                              0,
                                                                              self.navigationController.navigationBar.frame.size.width,
                                                                              self.navigationController.navigationBar.frame.size.height)];
                 
                 
             }
                            completion:^(BOOL finished)
             {
                 isTabBarAndNavBarHidden=YES;
                 isAnimating=NO;
             }];
            
        }
    }
}

@end
