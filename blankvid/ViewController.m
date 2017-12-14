//
//  ViewController.m
//  blankvid
//
//  Created by Eric.Cruz on 12/13/17.
//  Copyright © 2017 Eric.Cruz. All rights reserved.
//

#import "ViewController.h"

@interface SMTVastAdViewController ()<SOMAAdViewDelegate>

@end

@implementation SMTVastAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SOMAInterstitialVideoAdView* adview = [[SOMAInterstitialVideoAdView alloc] init];
    self.adView = adview;
    self.adView.delegate = self;
    
    self.adView.adSettings.autoReloadEnabled = NO;
    self.adView.adSettings.publisherId = 0;
    self.adView.adSettings.adSpaceId = 3090;
    self.showFullScreenButton.hidden = YES;
    [self.adView load];
}

#pragma mark - IBActions
- (IBAction)onLoadAd:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showFullScreenButton.hidden = YES;
        self.loadAdButton.enabled = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.adView load];
        });
    });
    
}

- (IBAction)onShowAd:(id)sender{
    if (self.adView.isLoaded) {
        [self.adView show];
    }
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
    NSLog(@"Ad View Will Load");
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    NSLog(@"Ad View Loaded");
    
    [self.loadAdButton setTitle:@"Ad loaded!" forState:UIControlStateDisabled];
    self.showFullScreenButton.hidden = NO;
    [self.adView show];
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
    BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
    int reloadInterval = adview.adSettings.autoReloadInterval;
    NSString* reloadTimeMessage = @"";
    if (reloadEnabled) {
        reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
    }
    NSLog(@"AdView failed to load: %@", [error localizedDescription]);
    
    self.loadAdButton.enabled = YES;
    [self.loadAdButton setTitle:@"Failed to load, retry" forState:UIControlStateNormal];
    self.showFullScreenButton.hidden = YES;
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView*)adview{
    NSLog(@"Ad Clicked, will go fullscreen");
    return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
    NSLog(@"Exited full screen");
}
- (void)somaAdViewWillHide:(SOMAAdView*)adview{
    NSLog(@"Ad view will hide");
    self.loadAdButton.enabled = YES;
    self.showFullScreenButton.hidden = YES;
    [self.loadAdButton setTitle:@"Reload Ad" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
