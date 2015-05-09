//
//  Hotel.m
//  Hotel
//
//  Created by KVC on 15-4-17.
//  Copyright (c) 2015年 KVC. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

- (id)init
{
    self = [super init];
    if (self) {

        _level1 = [[NSMutableArray alloc]init];
        _level2 = [[NSMutableArray alloc]init];
        _level3 = [[NSMutableArray alloc]init];
        _level4 = [[NSMutableArray alloc]init];
        _level5 = [[NSMutableArray alloc]init];
        _level6 = [[NSMutableArray alloc]init];
        _level7 = [[NSMutableArray alloc]init];
        _level8 = [[NSMutableArray alloc]init];
        _level9 = [[NSMutableArray alloc]init];
        _level10 = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < 11; i ++) {
            [_level1 addObject:[NSNumber numberWithInt:0]];
            [_level2 addObject:[NSNumber numberWithInt:0]];
            [_level3 addObject:[NSNumber numberWithInt:0]];
            [_level4 addObject:[NSNumber numberWithInt:0]];
            [_level5 addObject:[NSNumber numberWithInt:0]];
            [_level6 addObject:[NSNumber numberWithInt:0]];
            [_level7 addObject:[NSNumber numberWithInt:0]];
            [_level8 addObject:[NSNumber numberWithInt:0]];
            [_level9 addObject:[NSNumber numberWithInt:0]];
            [_level10 addObject:[NSNumber numberWithInt:0]];
        }
        
        _Hotel = [[NSMutableArray alloc] initWithObjects:_level1,_level2, _level3, _level4, _level5, _level6, _level7, _level8, _level9, _level10, nil];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reportCheckIN:) name:@"checkin" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reportCheckOUT:) name:@"checkout" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reportRoomChange:) name:@"roomchange" object:nil];
    }
    return self;
}
//===============================================================
//日志
//===============================================================
-(void)reportCheckIN:(NSNotification*)notification
{
    NSString* homePath = NSHomeDirectory();
    NSString* filePath = [homePath stringByAppendingPathComponent:@"reportHotel.txt"];
    
    NSDate* date = [[NSDate alloc]init];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM/yyyy hh:mm:ss";
    NSString* dateStr = [dateFormatter stringFromDate:date];
    
    NSString* report = [[NSString alloc]initWithFormat:@"%@ | name:%@,\n                      ID  :%@ was checked-in to %d\n",dateStr, _person.name,_person.ID, _roomNumber];
    NSData* data4Writing = [report dataUsingEncoding:NSUTF8StringEncoding];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }

    NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fh seekToEndOfFile];
    [fh writeData:data4Writing];
}

-(void)reportCheckOUT:(NSNotification*)notification
{
    NSString* homePath = NSHomeDirectory();
    NSString* filePath = [homePath stringByAppendingPathComponent:@"reportHotel.txt"];
    
    NSDate* date = [[NSDate alloc]init];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM/yyyy hh:mm:ss";
    NSString* dateStr = [dateFormatter stringFromDate:date];
    
    NSString* report = [[NSString alloc]initWithFormat:@"%@ | name:%@,\n                      ID  :%@ was checked-out from %d\n",dateStr, _person.name, _person.ID, _roomNumber];
    NSData* data4Writing = [report dataUsingEncoding:NSUTF8StringEncoding];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fh seekToEndOfFile];
    [fh writeData:data4Writing];
    
}

-(void)reportRoomChange:(NSNotification*)notification
{
    NSString* homePath = NSHomeDirectory();
    NSString* filePath = [homePath stringByAppendingPathComponent:@"reportHotel.txt"];
    
    NSDate* date = [[NSDate alloc]init];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM/yyyy hh:mm:ss";
    NSString* dateStr = [dateFormatter stringFromDate:date];
    
    NSString* report = [[NSString alloc]initWithFormat:@"%@ | name:%@,\n                      ID  :%@ was changed room from %d to %d\n",dateStr, _person.name,_person.ID, _roomNumber, _roomNumberNew];
    NSData* data4Writing = [report dataUsingEncoding:NSUTF8StringEncoding];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fh seekToEndOfFile];
    [fh writeData:data4Writing];
    
}
//===============================================================
//用户显示初始时对用户的操作界面
//===============================================================
-(void)systemStart
{
    [self userInterface];
}

-(void)userInterface
{
    while (1) {
        
        _person = [[Person alloc]init];
        
        NSLog(@"请选择需要的服务:");
        NSLog(@"1. 入住,");
        NSLog(@"2. 退房,");
        NSLog(@"3. 更换房间,");
        NSLog(@"4. 查看房间状态.");
        switch ([self userSelection]) {
            case 1:
                [self userCheckIN];
                break;
            case 2:
                [self userCheckOUT];
                break;
            case 3:
                [self userRoomChange];
                break;
            case 4:
                [self checkInfo];
                break;
                
            default:
                break;
        }
    }
}
//===============================================================
//用户初始界面的输入操作
//===============================================================
-(int)userSelection
{
    char temp[10] = {0};
    scanf("%s", temp);
    int userInput = [[NSString stringWithUTF8String:temp] intValue];
    
    if (userInput <= 4 && userInput >= 1) {
        return userInput;
    }
    else{
        NSLog(@"输入错误，请重新输入");
    }
    return 0;
}
//===============================================================
//用户对房间的选择操作
//===============================================================
-(int)userInput
{
    char temp[10] = {0};
    scanf("%s", temp);
    int userInput = [[NSString stringWithUTF8String:temp] intValue];
    
    _roomNumber = userInput;
    _userLevel = _roomNumber / 100;
    _userRoom = _roomNumber % 100;
    
    if (_roomNumber == 0) {
        return 0;   //返回到主界面
    }else if (_roomNumber <= 1010 && _roomNumber >= 101 && _userRoom < 11 && _userRoom > 0) {    //如果输入符合房间区间
        return 1;   //输入符合标准 继续执行
    }
    else {
        NSLog(@"输入错误，请重新输入");
        return 2;   //用户输入错误
    }
}
-(int)userInputNew
{
    char temp[10] = {0};
    scanf("%s", temp);
    int userInput = [[NSString stringWithUTF8String:temp] intValue];
    
    _roomNumberNew = userInput;
    _userLevelNew = _roomNumberNew / 100;
    _userRoomNew = _roomNumberNew % 100;
    
    if (_roomNumber == 0) {
        return 0;   //返回到主界面
    }else if (_roomNumberNew <= 1010 && _roomNumberNew >= 101 && _userRoomNew < 11 && _userRoomNew > 0) {    //如果输入符合房间区间
        return 1;   //输入符合标准 继续执行
    }
    else {
        NSLog(@"输入错误，请重新输入");
        return 2;   //用户输入错误
    }
}
//===============================================================
//CHECK IN
//===============================================================
-(int)userInputRightnRoomAvailable
{
    while (YES) {
        int result = [self userInput];
        if (result == 2) {
            result = [self userInput];
            continue;
        }
        if (result == 0) { //退出到主界面
            return 0;
        }
        
        int roomAvailable = [self roomAvailable];
        if (!roomAvailable) {
            NSLog(@"该房间正在被使用，请选择其他房间");
            NSLog(@"请输入房间号码");
            continue;
        }
        if (roomAvailable == 1 && result == 1) {
            return 1;
        }
    }
    return 0;
}

-(int)userCheckIN
{
    NSLog(@"请输入房间号码");
    NSLog(@"返回请按'0'");
    
    if ([self userInputRightnRoomAvailable] == 0) { //对用户输入进行判断
        return 0;
    }
    
    if ([self userInfoInput] == 0) {    //用户的个人信息输入 0为返回
        return 0;
    }
    
    NSMutableArray* tempUserLevel = [_Hotel objectAtIndex:_userLevel - 1];  //楼层号码
    [tempUserLevel replaceObjectAtIndex:_userRoom - 1 withObject:_person];   //将用户储存
    NSLog(@"入住成功");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"checkin" object:self userInfo:nil];
    
    return 1;
}
//===============================================================
//CHECK OUT
//===============================================================
-(int)userInputRightnRoomNotAvailable
{
    while (YES) {
        int result = [self userInput];
        if (result == 2) {
            result = [self userInput];
            continue;
        }
        if (result == 0) {      //退出到主界面
            return 0;
        }
        
        int roomAvailable = [self roomAvailable];
        if (roomAvailable) {   //如果是空房间
            NSLog(@"房间号码输入错误，请重新输入");
            NSLog(@"请输入房间号码");
            continue;
        }
        if (roomAvailable == 0 && result == 1) {
            return 1;
        }
    }
}

-(int)userCheckOUT
{
    NSLog(@"请输入房间号码");
    NSLog(@"返回请按'0'");
    
    if ([self userInputRightnRoomNotAvailable] == 0) {    //对用户输入进行判断
        return 0;
    }
    
    if ([self userInfoInput] == 0) {    //用户的个人信息输入 0为返回
        return 0;
    }
    
    NSMutableArray* tempUserLevel = [_Hotel objectAtIndex:_userLevel - 1];  //楼层号码
    Person* tempPerson = [tempUserLevel objectAtIndex:_userRoom - 1];  //房间号码
    
    if ([_person.name isEqualToString:tempPerson.name] && [_person.ID isEqualToString:tempPerson.ID]) { // 如果名字和ID 吻合
        [tempUserLevel replaceObjectAtIndex:_userRoom - 1 withObject:[NSNumber numberWithInt:0]];
        NSLog(@"退房成功");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"checkout" object:self userInfo:nil];
        return 1;
    }
    else{
        NSLog(@"信息不符合，退房失败");
        return 0;
    }
}
//===============================================================
//ROOM CHANGE
//===============================================================

-(int)userInputNewRightnRoomAvailableNew
{
    while (YES) {
        int result = [self userInputNew];
        if (result == 2) {
            result = [self userInputNew];
            continue;
        }
        if (result == 0) { //退出到主界面
            return 0;
        }
        
        int roomAvailable = [self roomAvailableNew];
        if (!roomAvailable) {
            NSLog(@"该房间正在被使用，请选择其他房间");
            NSLog(@"请输入房间号码");
            continue;
        }
        if (roomAvailable == 1 && result == 1) {
            return 1;
        }
    }
    return 0;
}


-(int)userRoomChange
{
    NSLog(@"请输入您现在的房间号码");
    NSLog(@"返回请按'0'");
    if ([self userInputRightnRoomNotAvailable] == 0) {    //对用户输入进行判断
        return 0;
    }
    NSLog(@"请输入新房间号码");
    NSLog(@"返回请按'0'");
    if ([self userInputNewRightnRoomAvailableNew] == 0) {    //对用户输入进行判断
        return 0;
    }
    
    if ([self userInfoInput] == 0) {
        return 0;
    }
    
    NSMutableArray* tempUserLevel = [_Hotel objectAtIndex:_userLevel - 1];  //楼层号码
    Person* tempPerson = [tempUserLevel objectAtIndex:_userRoom - 1];  //房间号码
    NSMutableArray* tempUserLevelNew = [_Hotel objectAtIndex:_userLevelNew - 1];  //楼层号码

    if ([tempPerson.name isEqualToString: _person.name] && [tempPerson.ID isEqualToString:_person.ID]) {
        [tempUserLevelNew replaceObjectAtIndex:_userRoomNew - 1 withObject:_person];
        [tempUserLevel replaceObjectAtIndex:_userRoom - 1 withObject:[NSNumber numberWithInt:0]];
        NSLog(@"换房成功");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"roomchange" object:self userInfo:nil];
    }else{
        NSLog(@"信息不匹配，换房失败");
    }

    return 0;
    
}//===============================================================
//CHECK
//===============================================================
-(int)checkInfo
{
    [self printHotel];
    NSLog(@"请输入您要查询的房间号码");
    NSLog(@"返回请按'0'");
    if ([self userInputRightnRoomNotAvailable]) {
        NSMutableArray* tempUserLevel = [_Hotel objectAtIndex:_userLevel - 1];  //楼层号码
        Person* tempPerson = [tempUserLevel objectAtIndex:_userRoom - 1];  //房间号码
        NSLog(@"Result:");
        
        NSLog(@"Name: %@",tempPerson.name);
        NSLog(@"ID  : %@",tempPerson.ID);
        
        NSLog(@"===酒店状态===");

    }
    
    return 0;
}
//===============================================================
//显示HOTEL
//===============================================================
-(void)printHotel
{
    for (int i = 0; i < 10; i++) {
        NSMutableArray* tempUserLevel = [_Hotel objectAtIndex:i];  //楼层号码
        for (int j = 0; j < 10; j++) {
            [tempUserLevel objectAtIndex:j];  //房间号码
            if ([tempUserLevel objectAtIndex:j] == [NSNumber numberWithInt:0]) {
                printf("0 ");
            }else{
                printf("1 ");
            }
        }
        printf("\n");
    }
}

//===============================================================
//用户对个人信息的输入
//===============================================================
-(int)userInfoInput
{
    NSLog(@"请输入您的姓名");
    [self userInputName];
    
    NSLog(@"请输入您的ID");
    [self userInputID];
    
    NSLog(@"您的信息是");
    NSLog(@"%@ | %@",  _person.name, _person.ID);
    
    NSLog(@"确认请按'1', 返回请按'0'");
    
    if (![self userConfirm]) {  //用户 输入的是 返回
        return 0;   //退回到主界面
    }
    return 1;
}


-(void)userInputName
{
    char temp[10] = {0};
    scanf("%s", temp);
    NSString* userInput = [NSString stringWithUTF8String:temp] ;
    _person.name = userInput;
}

-(void)userInputID
{
    char temp[10] = {0};
    scanf("%s", temp);
    NSString* userInput = [NSString stringWithUTF8String:temp] ;
    _person.ID = userInput;
}

-(int)userConfirm
{
    char temp[10] = {0};
    scanf("%s", temp);
    int userInput = [[NSString stringWithUTF8String:temp] intValue];

    if (userInput == 1) {
        return 1;
    }
    return 0;
}

//===============================================================
//查询房间的状态
//===============================================================

-(int)roomAvailable
{
    NSMutableArray* tempArray = [_Hotel objectAtIndex:_userLevel - 1];
    if ([tempArray objectAtIndex:_userRoom - 1] == [NSNumber numberWithInt:0]) {
        return 1;
    }
    return 0;
    
}-(int)roomAvailableNew
{
    NSMutableArray* tempArray = [_Hotel objectAtIndex:_userLevelNew - 1];
    if ([tempArray objectAtIndex:_userRoomNew - 1] == [NSNumber numberWithInt:0]) {
        return 1;
    }
    return 0;
}

@end
