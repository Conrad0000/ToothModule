#import <Preferences/PSListController.h>
#import <Preferences/PSControlTableCell.h>
#import <SafariServices/SafariServices.h>

#define _plistfile (@"/User/Library/Preferences/com.creaturecoding.control-center.toothmodule.plist")
#define _deviceChanged (@"com.creaturecoding.control-center.toothmodule.device-changed")
#define _accentTintColor [UIColor colorWithRed:0.22 green:0.64 blue:0.95 alpha:1.0]

@interface BluetoothDevice : NSObject
- (NSString *)description;
- (NSString *)name;
- (NSString *)address;
- (void)disconnect;
- (bool)connected;
@end

@interface BluetoothManager : NSObject
+ (id)sharedInstance;
- (NSMutableArray *)connectedDevices;
- (NSMutableArray *)pairedDevices;
- (void)connectDevice:(id)device;
- (void)disconnectDevice:(id)device;
@end

@interface CSTMRootListController : PSListController {
    NSMutableDictionary *_settings;
}
@end
