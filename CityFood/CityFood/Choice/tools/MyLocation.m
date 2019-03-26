//
//  MyLocation.m
//  CityFood
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation

@synthesize updating = _updating;
@synthesize location = _location;
@synthesize heading = _heading;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

-(id)init{
    self=[super init];
    if (self) {
        _updating = NO;
        _location = nil;
        _heading = nil;
        _title = @"我的位置";
        _subtitle = nil;
    }
    return  self;
}

-(void)dealloc{
    if (_location) {
        _location=nil;
    }
    if (_title) {
        _title=nil;
    }
    if (_subtitle) {
        _subtitle=nil;
    }
    if (_heading) {
        _heading=nil;
    }
}
-(id)initWithLocation:(CLLocation *)loc whitHeading:(CLHeading *)head{
    self=[super init];
    if (self) {
        _updating=NO;
        _location=loc;
        _heading=head;
        _title=@"我的位置";
        _subtitle=nil;
    }
    return self;
}
















@end
