//
//  mybudgetFiltered.h
//  myBudget2
//
//  Created by Maciek Caputa on 10.06.2014.
//  Copyright (c) 2014 Maciej Caputa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol mybudgetFiltered <NSObject>

@property (strong,nonatomic) NSPredicate *predicate;
@property (nonatomic) BOOL reloadData;

@end
