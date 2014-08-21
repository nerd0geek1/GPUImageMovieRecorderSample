//
//  GMRMoviePlayerViewController.m
//  GPUImageMovieRecorderSample
//
//  Created by Kohei Tabata on 8/21/14.
//  Copyright (c) 2014 Kohei Tabata. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "GMRMoviePlayerViewController.h"

@interface GMRMoviePlayerViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation GMRMoviePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setUpMoviePlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private
- (void)_setUpMoviePlayer
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = paths[0];
    NSString *sampleMoviePath = [documentsDirectoryPath stringByAppendingPathComponent:@"sample.mov"];
    NSURL *movieUrl = [NSURL fileURLWithPath:sampleMoviePath];
    
    self.player = [[AVPlayer alloc] initWithURL:movieUrl];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.backgroundColor = [UIColor whiteColor].CGColor;
    playerLayer.frame = CGRectMake(0, 0, 480.f / 3.f * 2.f, 640.f / 3.f * 2.f);
    [self.view.layer addSublayer:playerLayer];
    [self.player play];
}

@end