//
//  ViewController.h
//  blankvid
//
//  Created by Eric.Cruz on 12/13/17.
//  Copyright © 2017 Eric.Cruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iSoma/iSoma.h>

@interface SMTVastAdViewController : UIViewController
@property(nonatomic, weak) IBOutlet UIButton* loadAdButton;
@property(nonatomic, weak) IBOutlet UIButton* showFullScreenButton;
@property(nonatomic, strong) SOMAInterstitialVideoAdView* adView;
@end
