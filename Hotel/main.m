//
//  main.m
//  Hotel
//
//  Created by KVC on 15-4-17.
//  Copyright (c) 2015年 KVC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotel.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Hotel* hotel = [[Hotel alloc]init];
        // insert code here...
        NSLog(@"Hello, World!");
        
        [hotel systemStart];
        
    }
    return 0;
}

