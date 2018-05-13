#import "CSTModule.h"
#import "BluetoothManager/CSTBluetoothConnectionManager.h"

// CCModule
@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation CSTModule
- (UIImage *)iconGlyph {
    return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
    return [UIColor colorWithRed:0.00 green:0.48 blue:1.00 alpha:1.0];
}

- (BOOL)isSelected {
    return [self deviceConnected];
}

- (void)setSelected:(BOOL)selected {
    if ([self deviceConnected]) {
        [self disconnect];
    } else {
        [self connect];
    }
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:0.5];
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:1];
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:1.5];
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:2];
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:2.5];
    [super performSelector:@selector(refreshState) withObject:nil afterDelay:3];
}

- (void)disconnect {
    CSTBluetoothConnectionManager *manager = [CSTBluetoothConnectionManager sharedManager];
    [manager disconnectDevice:[manager pairedDeviceForName:self.deviceName]];
}

- (void)connect {
    CSTBluetoothConnectionManager *manager = [CSTBluetoothConnectionManager sharedManager];
    [manager connectDevice:[manager pairedDeviceForName:self.deviceName]];
}

- (void)toggle {
    CSTBluetoothConnectionManager *manager = [CSTBluetoothConnectionManager sharedManager];
    [manager toggleConnectionForDevice:[manager pairedDeviceForName:self.deviceName]];
}

- (NSString *)deviceName {
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.creaturecoding.control-center.toothmodule.plist"] ? : [NSMutableDictionary new];
    _deviceName = settings[@"kDeviceName"] ? : nil;
    return _deviceName;
}

- (BOOL)deviceConnected {
    CSTBluetoothConnectionManager *manager = [CSTBluetoothConnectionManager sharedManager];
    return [manager isDeviceConnected:[manager pairedDeviceForName:self.deviceName]];
}

@end

