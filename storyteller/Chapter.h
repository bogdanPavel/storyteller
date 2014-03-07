//
//  Chapter.h
//  storyteller
//
//  Created by Bogdan Pavel on 05/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Audiobook;

@interface Chapter : NSManagedObject

@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSData * audio;
@property (nonatomic, retain) NSDate * dateLastModified;
@property (nonatomic, retain) Audiobook *audiobook;

@end
