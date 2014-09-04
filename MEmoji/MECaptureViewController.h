//
//  MECaptureViewController.h
//  MEmoji
//
//  Created by Cameron Ehrlich on 8/13/14.
//  Copyright (c) 2014 Lucky Bunny LLC. All rights reserved.
//

#import <MBProgressHUD.h>
#import <UIView+Positioning.h>

@import AVFoundation;
@import MediaPlayer;
@import ImageIO;
@import MobileCoreServices;

@interface MECaptureViewController : UIViewController<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureDevice *frontCamera;
@property (nonatomic, strong) AVCaptureDevice *backCamera;
@property (nonatomic, strong) AVCaptureDeviceInput *inputDevice;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureMovieFileOutput *fileOutput;

@property (nonatomic, strong) UILabel *instructionLabel;

@property (nonatomic, strong) UITapGestureRecognizer *singleTapRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressRecognier;

@end