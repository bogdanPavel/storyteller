//
//  Language.h
//  storyteller
//
//  Created by Bogdan Pavel on 05/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Audiobook;

@interface Language : NSManagedObject

@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSString * longName;
@property (nonatomic, retain) NSSet *audiobooks;
@end

@interface Language (CoreDataGeneratedAccessors)

- (void)addAudiobooksObject:(Audiobook *)value;
- (void)removeAudiobooksObject:(Audiobook *)value;
- (void)addAudiobooks:(NSSet *)values;
- (void)removeAudiobooks:(NSSet *)values;

@end
