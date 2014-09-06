//
//  MECaptureViewController.m
//  MEmoji
//
//  Created by Cameron Ehrlich on 8/13/14.
//  Copyright (c) 2014 Lucky Bunny LLC. All rights reserved.
//

#import "MECaptureViewController.h"

@implementation MECaptureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleTapRecognizer];
    
    self.longPressRecognier = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    self.longPressRecognier.allowableMovement = 20;
    [self.view addGestureRecognizer:self.longPressRecognier];
    
    [self initializePreviewLayer];
}

- (void)initializePreviewLayer
{
    CGRect layerFrame = CGRectMake(0, (self.view.height/2) - (self.view.width/2), self.view.width, self.view.width);
    [[MEModel sharedInstance] previewLayer].frame = layerFrame;
    [self.view.layer addSublayer:[[MEModel sharedInstance] previewLayer]];
}

#pragma mark -
#pragma mark UIGestureRecognizerHandlers

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self startRecording];
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(stepOfGIF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self finishRecording];
    });
}

-  (void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self startRecording];
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        [self finishRecording];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view setBackgroundColor:[UIColor colorWithHex:0xccfffc]];
}

#pragma mark -
#pragma mark AVCaptureMovieFileDelegate
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    NSLog(@"Started Recording");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"Finished Recording");
    if (error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Video could not be converted for some reason!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
    }else{
        [self captureGIF];
    }
}

- (void)startRecording
{
    NSString *path = [MEModel currentVideoPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSError *error = nil;
        [fileManager removeItemAtPath:path error:&error];
        if (error){ NSLog(@"Error: %@", error);}
    }
    
    NSURL *url = [NSURL fileURLWithPath:path];
    [[[MEModel sharedInstance] fileOutput] startRecordingToOutputFileURL:url recordingDelegate:self];
}

- (void)finishRecording
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[[MEModel sharedInstance] fileOutput] stopRecording];
}

- (void)captureGIF
{
    NSURL *url = [NSURL fileURLWithPath:[MEModel currentVideoPath]];
    
    [[MEModel sharedInstance] createEmojiFromMovieURL:url complete:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tabBarController setSelectedIndex:0];
    }];
}

@end
