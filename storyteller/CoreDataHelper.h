//
//  CoreDataHelper.h
//  storyteller
//
//  Created by Bogdan Pavel on 05/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MigrationVC.h"

@interface CoreDataHelper : NSObject

@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

@property (nonatomic, retain) MigrationVC *migrationVC;

- (void)setupCoreData;
- (void)saveContext;

@end
