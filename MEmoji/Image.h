//
//  Image.h
//  MEmoji
//
//  Created by Cameron Ehrlich on 7/28/14.
//  Copyright (c) 2014 Lucky Bunny LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * movieData;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSData * frameData;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * animated;

@end
