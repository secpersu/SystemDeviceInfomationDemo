//
//  ViewController.m
//  SystemDeviceInfomationDemo
//
//  Created by admin on 16/12/22.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "ViewController.h"
#include <sys/mount.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

//获取电池电量
-(CGFloat)getBatteryQuantity
{
    return [[UIDevice currentDevice] batteryLevel];
}

//获取电池状态
-(UIDeviceBatteryState)getBatteryStauts
{
    return [UIDevice currentDevice].batteryState;
}

//获取总内存大小
-(long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}

//获取当前可用内存
//-(long long)getAvailableMemorySize
//{
//    vm_statistics_data_t vmStats;
//    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
//    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
//    if (kernReturn != KERN_SUCCESS)
//    {
//        return NSNotFound;
//    }
//    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
//}

//获取已使用内存
//- (double)getUsedMemory {
//    task_basic_info_data_t taskInfo;
//    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
//    kern_return_t kernReturn = task_info(mach_task_self(),
//                                         TASK_BASIC_INFO,
//                                         (task_info_t)&taskInfo,
//                                         &infoCount);
//    
//    if (kernReturn != KERN_SUCCESS
//        ) {
//        return NSNotFound;
//    }
//    
//    return taskInfo.resident_size;
//}


//-(long long)getTotalDiskSize {
//    struct statfs buf;
//    unsigned long long freeSpace = -1;
//    if (statfs("/var", &buf) >= 0)
//    {
//        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
//    }
//    return freeSpace;
//}

//获取可用磁盘容量
//-(long long)getAvailableDiskSize
//{
//    struct statfs buf;
//    unsigned long long freeSpace = -1;
//    if (statfs("/var", &buf) >= 0)
//    {
//        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
//    }
//    return freeSpace;
//}

//容量转换
//-(NSString *)fileSizeToString:(unsigned long long)fileSize
//{
//    NSInteger KB = 1024;
//    NSInteger MB = KB*KB;
//    NSInteger GB = MB*KB;
//    
//    if (fileSize < 10)  {
//        return @"0 B";
//    }else if (fileSize < KB)    {
//        return @"< 1 KB";
//    }else if (fileSize < MB)    {
//        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
//    }else if (fileSize < GB)    {
//        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
//    }else   {
//        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
//    }
//}

//设备型号
//+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller {
//    int mib[2];
//    size_t len;
//    char *machine;
//    
//    mib[0] = CTL_HW;
//    mib[1] = HW_MACHINE;
//    sysctl(mib, 2, NULL, &len, NULL, 0);
//    machine = malloc(len);
//    sysctl(mib, 2, machine, &len, NULL, 0);
//    
//    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
//    free(machine);
//    
//    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
//    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
//    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
//    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s (A1387/A1431)";
//    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
//    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
//    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
//    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
//    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
//    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
//    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
//    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
//    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
//    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
//    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
//    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
//    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
//    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
//    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
//    
//    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
//    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
//    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
//    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
//    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
//    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
//    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
//    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
//    
//    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
//    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
//    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
//    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
//    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
//    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
//    
//    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
//    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
//    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
//    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
//    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
//    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
//    
//    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
//    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
//    return platform;
//}


//IP地址
//- (NSString *)deviceIPAdress {
//    NSString *address = @"an error occurred when obtaining ip address";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    
//    success = getifaddrs(&interfaces);
//    
//    if (success == 0) { // 0 表示获取成功
//        
//        temp_addr = interfaces;
//        while (temp_addr != NULL) {
//            if( temp_addr->ifa_addr->sa_family == AF_INET) {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    
//    freeifaddrs(interfaces);
//    return address;
//}

//当前手机连接的WIFI名称
- (NSString *)getWifiName {
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

#pragma mark - Handlers

- (IBAction)batteryQuantityButtonWasPressed:(UIButton *)sender {
    CGFloat battery = [self getBatteryQuantity];
    NSLog(@"获取电池电量:::::%@",@(battery));
    [sender setTitle:[NSString stringWithFormat:@"%@",@(battery)] forState:UIControlStateNormal];
}

- (IBAction)batteryStatusButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取电池状态");
}

- (IBAction)totalMemorySizeButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取内存大小");
}

- (IBAction)availableMemorySizeButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取可用内存");
}

- (IBAction)usedMemoryButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取已使用内存");
}

- (IBAction)totalDiskSizeButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取总磁盘容量");
}

- (IBAction)availableDiskSizeButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取可用磁盘容量");
}

- (IBAction)currentDeviceTypeButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取设备型号");
}

- (IBAction)deviceIdAddressButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取IP地址");
}

- (IBAction)phoneWifiNameButtonWasPressed:(UIButton *)sender {
    NSLog(@"获取手机WifI名称");
}


@end
