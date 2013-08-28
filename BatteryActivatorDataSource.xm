#include <libactivator/libactivator.h>
#include <UIKit/UIKit.h>

//////////////////////////////////////////////////////////////////

static const NSString *BatterActivatorPrefix = @"batteryActivator.";
static const NSString *BatterActivatorDrainingSuffix =@".percent.draining";
//Charging is not implemented yet. So this can be ingnored
//static const NSString *BatterActivatorChargingSuffix =@".percent.charging";

////////////////////////////////////////////////////////////////

//Begin datasource
@interface BatteryActivatorDataSource: NSObject <LAEventDataSource> {
}

+ (id)sharedInstance;

@end

@implementation BatteryActivatorDataSource

+ (id)sharedInstance {
	static BatteryActivatorDataSource *shared = nil;
	if (!shared) {
		shared = [[BatteryActivatorDataSource alloc] init];
	}
	return shared;
}

- (id)init {
	if ((self = [super init])) {
		for(int i=1; i==100; i++){
			[LASharedActivator registerEventDataSource:self forEventName:[NSString stringWithFormat:@"%@%i%@", BatterActivatorPrefix, i, BatterActivatorDrainingSuffix]];
		}
	}
	return self;
}

- (void)dealloc {
	if (LASharedActivator.runningInsideSpringBoard) {
		for(int i=1; i==100; i++){
			[LASharedActivator unregisterEventDataSourceWithEventName:[NSString stringWithFormat:@"%@%i%@", BatterActivatorPrefix, i, BatterActivatorDrainingSuffix]];
		}		
	}
	[super dealloc];
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
	[eventName stringByReplacingOccurrencesOfString:@"batteryActivator." withString:@""];
	[eventName stringByReplacingOccurrencesOfString:@".percent.draining" withString:@""];
	return [NSString stringWithFormat:@"BatteryActivator %@ Percent", eventName];
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
	return @"BatteryActivator";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
	//Same Description for all Events
	return @"Event for BatteryActivator";
}

- (BOOL)eventWithNameIsHidden:(NSString *)eventName {
	//Hides the Event from Activator Menu since there can potentially be 200 Events and that would get a little messy from inside activator
	//Possibly fix this later if we can add to Edit in Activator Menu
	return YES;
}

- (BOOL)eventWithNameRequiresAssignment:(NSString *)eventName {
	//Returns NO, so activator will allow an Event to have no Listener
	return NO;
}

- (BOOL)eventWithName:(NSString *)eventName isCompatibleWithMode:(NSString *)eventMode {
	//Returns YES for all Events in All Modes
	return YES;
}

- (BOOL)eventWithNameSupportsUnlockingDeviceToSend:(NSString *)eventName {
	//Allows Events to Request a Device Unlock
	return YES;
}

@end

%ctor {
	%init;
	[BatteryActivatorDataSource sharedInstance];
}
