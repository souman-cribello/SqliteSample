//
//  DBManager.h
//  SqliteSample
//
//  Created by Administrator on 6/26/15.
//  Copyright (c) 2015 Apcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject
//By using instancetype, you're saying that subclasses will return an object of the subclass.
-(instancetype)initWithDatabaseFilename:(NSString*)dbFilename;


////////////declaring public method to hold private result fordatabase//
@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;
////////use for running queries//
-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;
@end

