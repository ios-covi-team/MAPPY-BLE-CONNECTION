//
//  Util.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (NSString*) stringForCStr:(const char *) cstr{
    if(cstr){
        return [NSString stringWithCString: cstr encoding: NSUTF8StringEncoding];
    }
    return @"";
}

+ (NSMutableDictionary*)dictionaryFromUrlParram:(NSString*)urlPararm{
    NSArray *components;
    NSURL *_tempUrl = [NSURL URLWithString:urlPararm];
    if ([_tempUrl isKindOfClass:[NSURL class]]) {
        components = [_tempUrl.query componentsSeparatedByString:@"&"];
    }
    else{
        NSString *parramString = urlPararm;
        NSArray *_arraySchemeRemoved = [urlPararm componentsSeparatedByString:@"?"];
        if (_arraySchemeRemoved.count>1) {
            parramString = [_arraySchemeRemoved objectAtIndex:1];
        }
        components = [parramString componentsSeparatedByString:@"&"];
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // parse parameters to dictionary
    for (NSString *param in components) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        // get key, value
        NSString* key   = [elts objectAtIndex:0];
        key = [key stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString* value = [elts objectAtIndex:1];
        
        ///Start Fix HTML Property issue
        if ([elts count]>2) {
            @try {
                value = [param substringFromIndex:([param rangeOfString:@"="].location+1)];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
        ///End HTML Property issue
        if(value){
            value = [self stringForCStr:[value UTF8String]];
        }
        
        //
        if(key.length && value.length){
            [params setObject:value forKey:key];
        }
    }
    return params;
}

+ (UInt16)sumCRCWithData:(NSData *)data
{
    unsigned char *bytePtr = ( unsigned char *)[data bytes];
    UInt16 sum = 0;
    for (int i = 0; i< data.length ; i++) {
        
        sum += bytePtr[i];
    }
    return sum;
}

+ (NSInteger)convertHour:(NSInteger)hour{
    if (hour > 12) {
        return hour - 12;
    }
    
    return hour;
}

#pragma mark - get Hour/Minute current time

+ (NSTimeInterval) timeStamp {
    return [[NSDate date] timeIntervalSince1970] * 1000.0;
}

+ (NSInteger)getMinutesTotal{
    NSInteger currentMinute = [self getMinuteTimeStamp];
    NSInteger currentHour = [self getHourCurrentTimeStamp];
    return (currentHour * 60)+ currentMinute;
}

+ (NSInteger )getHourCurrentTimeStamp
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitHour) fromDate:now];
    NSInteger hour = [components hour];
    return hour;
}
+ (NSInteger )getMinuteTimeStamp
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:now];
    NSInteger minute = [components minute];
    return minute;
}
+ (NSInteger )getSecondTimeStamp
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:( NSCalendarUnitSecond) fromDate:now];
    NSInteger second = [components  second];
    return second;
}

+ (NSTimeInterval)estimateTimeWithRemainTime:(NSInteger)second{
    return (NSTimeInterval)([self timeStamp] + [self getCurrentTimeZoneOffset])/1000.0 + second;
}

+ (NSTimeInterval)getCurrentTimeZoneOffset{
    NSLog(@"Current TimeZone Offset : %ld",(long)([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0) * 3600000);
    
    return (NSTimeInterval) ([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0) * 3600000;
}

+ (NSString *)getTimeFormatWithDate:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSLocale *hourFomrat = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormat.locale = hourFomrat; // format 12h
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSString *time = [dateFormat stringFromDate:date];
    return [time substringWithRange:NSMakeRange(6, 2)];
}

+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitYear|
                                                              NSCalendarUnitMonth|
                                                              NSCalendarUnitDay|
                                                              NSCalendarUnitHour  |
                                                              NSCalendarUnitMinute|
                                                              NSCalendarUnitSecond) fromDate:date];
    
    
    return dateComponents;
    
}
@end
