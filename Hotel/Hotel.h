//
//  Hotel.h
//  Hotel
//
//  Created by KVC on 15-4-17.
//  Copyright (c) 2015年 KVC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Hotel : NSObject

@property int roomNumber;
@property int userLevel;
@property int userRoom;
@property int roomNumberNew;
@property int userLevelNew;
@property int userRoomNew;

@property Person* person;
@property NSMutableArray* Hotel;
@property NSMutableArray* level1;
@property NSMutableArray* level2;
@property NSMutableArray* level3;
@property NSMutableArray* level4;
@property NSMutableArray* level5;
@property NSMutableArray* level6;
@property NSMutableArray* level7;
@property NSMutableArray* level8;
@property NSMutableArray* level9;
@property NSMutableArray* level10;

-(void)systemStart;

@end
