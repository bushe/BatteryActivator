#import <Preferences/Preferences.h>
#import <libactivator/libactivator.h>

@interface BatteryActivatorSettingsListController: PSListController {
}
- (void)viewDidAppear:(BOOL)animated;
@end

@implementation BatteryActivatorSettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"BatteryActivatorSettings" target:self] retain];
	}
	return _specifiers;
}

- (NSString *)getActivatorAction:(id)specifier{
	if ([[specifier propertyForKey:@"activatorEvent"] rangeOfString:@"charging"].location != NSNotFound)
		return [LASharedActivator localizedTitleForListenerName:[LASharedActivator assignedListenerNameForEvent:[LAEvent eventWithName:[NSString stringWithFormat:@"batteryActivator.%@.percent.charging", [specifier propertyForKey:@"batteryPercent"]] mode:LAEventModeLockScreen]]];
	else
		return [LASharedActivator localizedTitleForListenerName:[LASharedActivator assignedListenerNameForEvent:[LAEvent eventWithName:[NSString stringWithFormat:@"batteryActivator.%@.percent.draining", [specifier propertyForKey:@"batteryPercent"]] mode:LAEventModeLockScreen]]];
}

- (void)viewDidAppear:(BOOL)animated{
	[self reload];
	[super viewDidAppear:animated];
}
@end

// vim:ft=objc
