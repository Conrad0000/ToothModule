#include "CSTMRootListController.h"
#include "CSPHeaderView.h"

@implementation CSTMRootListController

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTintEnabled:YES];
    self.table.tableHeaderView = [[CSPHeaderView alloc] initWithSpecifier:self.specifier tableWidth:self.table.bounds.size.width];
}

// remove tint wen leaving the view
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setTintEnabled:NO];
}

// sets the tint colors for the view
- (void)setTintEnabled:(BOOL)enabled {
    if (enabled) {
        // Color the navbar
        self.navigationController.navigationController.navigationBar.tintColor = _accentTintColor;
        self.navigationController.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : _accentTintColor};

        // set specific cell colors
        [UISwitch appearanceWhenContainedInInstancesOfClasses:@[[self.class class]]].onTintColor = _accentTintColor;
        [UITableView appearanceWhenContainedInInstancesOfClasses:@[[self.class class]]].tintColor = _accentTintColor;
        [UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[[self.class class]]].tintColor = _accentTintColor;

        // set the view tint
        self.view.tintColor = _accentTintColor;
    } else {
        // Un-Color the navbar when leaving the view
        self.navigationController.navigationController.navigationBar.tintColor = nil;
        self.navigationController.navigationController.navigationBar.titleTextAttributes = nil;

    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:NO];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.textColor = _accentTintColor;
    return cell;
}

// make sure that the control for the cell is enabled/disabled when the cell is enabled/disabled
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled {
    UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];
    if (cell) {
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;

        if ([cell isKindOfClass:[PSControlTableCell class]]) {
            PSControlTableCell *controlCell = (PSControlTableCell *)cell;
            if (controlCell.control) {
                controlCell.control.enabled = enabled;
            }
        }
    }
}

#pragma mark - PSListController

- (id)init {
    if ((self = [super init]) != nil) {
        _settings = [NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ? : [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
    }
    return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    NSString *key = [specifier propertyForKey:@"key"];
    _settings = [NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ? : [NSMutableDictionary dictionary];
    [_settings setObject:value forKey:key];
    [_settings writeToFile:_plistfile atomically:YES];

    NSString *post = [specifier propertyForKey:@"PostNotification"];
    if (post) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)post, NULL, NULL, TRUE);
    }
}

- (id)readPreferenceValue:(PSSpecifier *)specifier {
    _settings = ([NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ? : [NSMutableDictionary dictionary]);
    id value = _settings[[specifier propertyForKey:@"key"]] ? : [specifier propertyForKey:@"default"];
    return value;
}

#pragma mark - Extentions

- (NSArray *)deviceNames {
    NSMutableArray *names = [NSMutableArray new];

    for (BluetoothDevice *device in [[BluetoothManager sharedInstance] pairedDevices]) {
        [names addObject:device.name];
    }
    return names;
}

// email action
- (void)contact {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:support@creaturecoding.com?subject=ToothModule%20v1.0.0b"] options:@{} completionHandler:nil];
}

// launch github
- (void)github {
    [self openURLInBrowser:@"https://github.com/CreatureSurvive/"];
}

// launch paypal
- (void)paypal {
    [self openURLInBrowser:@"https://paypal.me/creaturecoding"];
}

// launch twitter
- (void)twitter {
    [self openURLInBrowser:@"https://mobile.twitter.com/creaturesurvive"];
}

#pragma mark Utility

// opens the specified url in SFSafariViewController
- (void)openURLInBrowser:(NSString *)url {
    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
    [self presentViewController:safari animated:YES completion:nil];
}

@end
