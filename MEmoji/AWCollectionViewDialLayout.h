//
//  AWCollectionViewDialLayout.h
//  
//
//  Created by Antoine Wette on 30.10.13.
//  Copyright (c) 2013 Antoine Wette. All rights reserved.
//
//  info@antoinewette.com
//  www.antoinewette.com
//

#import <UIKit/UIKit.h>

@interface AWCollectionViewDialLayout : UICollectionViewLayout

typedef enum WheelAlignmentType : NSInteger WheelAlignmentType;

enum WheelAlignmentType : NSInteger
{
    WHEELALIGNMENTLEFT,
    WHEELALIGNMENTCENTER
};

@property (readwrite, nonatomic, assign) NSInteger cellCount;
@property (readwrite, nonatomic, assign) NSInteger wheelType;
@property (readwrite, nonatomic, assign) CGPoint center;
@property (readwrite, nonatomic, assign) CGFloat offset;
@property (readwrite, nonatomic, assign) CGFloat itemHeight;
@property (readwrite, nonatomic, assign) CGFloat xOffset;
@property (readwrite, nonatomic, assign) CGSize cellSize;
@property (readwrite, nonatomic, assign) CGFloat AngularSpacing;
@property (readwrite, nonatomic, assign) CGFloat dialRadius;
@property (readonly, nonatomic, strong) NSIndexPath *currentIndexPath;

- (instancetype)initWithRadius:(CGFloat)radius andAngularSpacing:(CGFloat)spacing andCellSize:(CGSize)cell andAlignment:(WheelAlignmentType)alignment andItemHeight:(CGFloat)height andXOffset:(CGFloat)xOffset;

@end