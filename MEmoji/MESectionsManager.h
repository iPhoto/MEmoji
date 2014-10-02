//
//  MECollectionViewController.h
//  MEmoji
//
//  Created by Cameron Ehrlich on 9/25/14.
//  Copyright (c) 2014 Lucky Bunny LLC. All rights reserved.
//


#import "MEMEmojiCell.h"
#import "MEOverlayCell.h"
#import "MESectionHeaderView.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>

@import Foundation;

typedef NS_ENUM(NSUInteger, MEHeaderButtonType) {
    MEHeaderButtonTypeRightArrow,
    MEHeaderButtonTypeLeftArrow,
    MEHeaderButtonTypeDelete,
    MEHeaderButtonTypePurchaseHipHopPack,
};

@protocol MESectionsManagerDelegate <NSObject>

- (void)collectionView:(UICollectionView *)collectionView didSelectOverlay:(MEOverlayImage *)overlay;
- (void)collectionView:(UICollectionView *)collectionView didDeselctOverlay:(MEOverlayImage *)overlay;

- (void)collectionView:(UICollectionView *)collectionView didSelectImage:(Image *)image;
- (void)presentShareView;
- (void)tappedSettingsButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface MESectionsManager : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) id <MESectionsManagerDelegate> delegate;

@property (nonatomic, strong) MESectionHeaderView *libraryHeader;
@property (nonatomic, strong) UICollectionView *libraryCollectionView;

@property (nonatomic, strong) MESectionHeaderView *freeHeader;
@property (nonatomic, strong) UICollectionView *freeCollectionView;

@property (nonatomic, strong) MESectionHeaderView *hipHopHeader;
@property (nonatomic, strong) UICollectionView *hipHopCollectionView;

@property (nonatomic, strong) MESectionHeaderView *settingsHeader;
@property (nonatomic, strong) UITableView *settingsTableView;

@property (strong, nonatomic) NSMutableDictionary *imageCache;
@property (strong, nonatomic) NSMutableDictionary *loadingOperations;
@property (strong, nonatomic) NSOperationQueue *loadingQueue;

@end
