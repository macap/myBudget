//
//  mybudgetAppDelegate.h
//  myBudget2
//
//  Created by Maciek Caputa on 31.05.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mybudgetAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
