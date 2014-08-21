//
//  GMRMovieRecorderViewController.m
//  GPUImageMovieRecorderSample
//
//  Created by Kohei Tabata on 8/20/14.
//  Copyright (c) 2014 Kohei Tabata. All rights reserved.
//

#import <GPUImage.h>

#import "GMRMoviePlayerViewController.h"
#import "GMRMovieRecorderViewController.h"

@interface GMRMovieRecorderViewController ()

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageFilter *filter;
@property (nonatomic, strong) GPUImageView *previewView;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, strong) UIButton *startRecordingButton;
@property (nonatomic, strong) UIButton *stopRecordingButton;

@end

@implementation GMRMovieRecorderViewController

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
    [self _setupVideoCamera];
    [self _setUpButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.videoCamera startCameraCapture];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.videoCamera stopCameraCapture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private
- (void)_setupVideoCamera
{
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    
    self.filter = [[GPUImageFilter alloc] init];
    [self.videoCamera addTarget:self.filter];
    
    self.previewView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, 480.f / 3.f * 2.f, 640.f / 3.f * 2.f)];
    [self.view addSubview:self.previewView];
    [self.filter addTarget:self.previewView];
    
    [self.videoCamera startCameraCapture];
}

- (void)_setUpButtons
{
    self.startRecordingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startRecordingButton.frame = CGRectMake(10, CGRectGetMaxY(self.previewView.frame), 140, 44);
    [self.startRecordingButton setTitle:@"start Recording" forState:UIControlStateNormal];
    [self.startRecordingButton addTarget:self action:@selector(_tapStartRecording:) forControlEvents:UIControlEventTouchUpInside];
    
    self.stopRecordingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.stopRecordingButton.frame = CGRectMake(CGRectGetMaxX(self.startRecordingButton.frame) + 20, CGRectGetMaxY(self.previewView.frame), 140, 44);
    [self.stopRecordingButton setTitle:@"stop Recording" forState:UIControlStateNormal];
    [self.stopRecordingButton addTarget:self action:@selector(_tapStopRecording:) forControlEvents:UIControlEventTouchUpInside];
    self.stopRecordingButton.enabled = NO;
    
    [self.view addSubview:self.startRecordingButton];
    [self.view addSubview:self.stopRecordingButton];
}

#pragma mark -
#pragma mark UIActions
- (void)_tapStartRecording:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = paths[0];
    NSString *sampleMoviePath = [documentsDirectoryPath stringByAppendingPathComponent:@"sample.mov"];
    NSURL *movieUrl = [NSURL fileURLWithPath:sampleMoviePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:sampleMoviePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:sampleMoviePath error:nil];
    }
    
    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieUrl size:self.previewView.frame.size];
    [self.filter addTarget:self.movieWriter];
    [self.movieWriter startRecording];
    
    self.startRecordingButton.enabled = NO;
    self.stopRecordingButton.enabled = YES;
}

- (void)_tapStopRecording:(id)sender
{
    [self.movieWriter finishRecording];
    [self.filter removeTarget:self.movieWriter];
    self.startRecordingButton.enabled = YES;
    self.stopRecordingButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PREVIEW" style:UIBarButtonItemStylePlain target:self action:@selector(_showMoviePreview)];
}

- (void)_showMoviePreview
{
    GMRMoviePlayerViewController *moviePlayerViewController = [[GMRMoviePlayerViewController alloc] init];
    [self.navigationController pushViewController:moviePlayerViewController animated:YES];
}

@end