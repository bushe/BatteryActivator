#import <libactivator/libactivator.h>
//#import <SpringBoard/SpringBoard.h>

__attribute__((always_inline))
static inline LAEvent *LASendEventWithName(NSString *eventName) {
	LAEvent *event = [[[LAEvent alloc] initWithName:eventName mode:[LASharedActivator currentEventMode]] autorelease];
	[LASharedActivator sendEventToListener:event];
	return event;
}

int batteryLevel=100;

@interface SBUIController : NSObject {   }
+(id)sharedInstance;
-(BOOL)isBatteryCharging;
-(int)batteryCapacityAsPercentage;
@end

%hook SpringBoard

- (void)batteryStatusDidChange:(id)batteryStatus{
	if([[objc_getClass("SBUIController") sharedInstance] isBatteryCharging] == FALSE)
		if(batteryLevel > (int)[[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage])
			LASendEventWithName([NSString stringWithFormat:@"batteryActivator.%i.percent.draining", [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage]]);
	
	batteryLevel = (int)[[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage];
	%orig;
}

%end