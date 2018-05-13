#include "CSTMPreferenceController.h"
#include "../BluetoothManager/Bluetooth.h"


@implementation CSTMPreferenceController


- (NSArray *)CSTM_deviceNames {
    NSMutableArray *names = [NSMutableArray new];

    for (BluetoothDevice *device in [[BluetoothManager sharedInstance] pairedDevices]) {
        [names addObject:device.name];
    }
    return names;
}

@end
