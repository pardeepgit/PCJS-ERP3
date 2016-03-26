//
//  ApiServicesModel.m
//  OpenKey
//
//  Created by DebutMac3 on 24/11/15.
//  Copyright © 2015 Debut infotech pvt ltd. All rights reserved.
//

#import "ApiServicesModel.h"
#import <sys/utsname.h>

#define IMAGEURL @""
#define WEBURL @""

@implementation ApiServicesModel

+ (ApiServicesModel *)sharedManager{
    static ApiServicesModel *sharedMobileKeysController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMobileKeysController = [[self alloc] init];
    });
    return sharedMobileKeysController;
}

- (id) init{
    
    self = [super init];
    if (self){
    }
    
    return self;
}


#pragma mark - postMethodApiWithRequestParamDictionary Method. 
- (void) postMethodApiWithRequestParamDictionary:(NSMutableDictionary *)requestDictionary withApiRequestUrl:(NSString *)requestUrl{
    
    NSString *apiRequestUrlString = [NSString stringWithFormat:@"%@%@", WEBURL, requestUrl];
    apiRequestUrlString = [apiRequestUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:apiRequestUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error = NULL;
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    
    NSString *requestJsonString = [[NSString alloc] initWithData:dataFromDict encoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:dataFromDict];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {

                                      if (!error)
                                      {
                                          NSMutableArray *responseArray = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                               error:&error];
                                          //NSLog(@"Response array is :%@", responseArray);
                                          
                                          // Code to call delegate method
                                          [self.delegate postMethodApiResponseDelegate:responseArray];
                                      }
                                      else
                                      {
                                          NSLog(@"Error is:%@", error);
                                          
                                          NSMutableArray *respArray = [[NSMutableArray alloc] init];
                                          // Code to call delegate method
                                          [self.delegate postMethodApiResponseDelegate:respArray];
                                      }
                                  }];
    [task resume];
}

#pragma mark - requestGetApiMethodWithRequestDictionary with AndApendUrl 
- (void) requestGetApiMethodWithRequestDictionary: (NSMutableDictionary *)reqDict WithApendUrl:(NSString *)appendUrl AndApiIdentifier:(NSString *) identifier
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", WEBURL, appendUrl];
    NSLog(@"%@ Api Url is: %@",identifier, strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSError *error = NULL;
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:reqDict
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    
    NSString *reqString = [[NSString alloc] initWithData:dataFromDict encoding:NSUTF8StringEncoding];
    NSLog(@"%@ api request string is: %@", identifier, reqString);
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:dataFromDict];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      
                                      if (!error)
                                      {
                                          //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                          //NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                                          
                                          //NSString *respString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          //NSLog(@"%@", respString);
                                          
                                          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                               error:&error];
                                          
                                          // Code to call delegate method
                                          [self.delegate apiResponseDelegate:[responseDictionary mutableCopy] apiIdentifier:identifier];
                                          //NSLog(@"%@ api Response is: %@", identifier, responseDictionary);
                                      }
                                      else
                                      {
                                          NSLog(@"Error is:%@", error);
                                      }
                                  }];
    [task resume];    
}


#pragma mark - getDeviceName method 
- (NSString*) getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",      // (Original)
                              @"iPod2,1"   :@"iPod Touch",      // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",      // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",      // (Fourth Generation)
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone",          // (3G)
                              @"iPhone2,1" :@"iPhone",          // (3GS)
                              @"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad 2",          //
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",        // (GSM)
                              @"iPhone3,3" :@"iPhone 4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",       //
                              @"iPhone5,1" :@"iPhone 5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",        // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",       // (Original)
                              @"iPhone5,3" :@"iPhone 5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",   //
                              @"iPhone7,2" :@"iPhone 6",        //
                              @"iPad4,1"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",       // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini"        // (2nd Generation iPad Mini - Cellular)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
    }
    
    return deviceName;
}



@end
