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
//-(BOOL)isBatteryCharging;
-(BOOL)isOnAC;
-(int)batteryCapacityAsPercentage;
@end

%hook SpringBoard

- (void)batteryStatusDidChange:(id)batteryStatus{
	if([[objc_getClass("SBUIController") sharedInstance] isOnAC] == FALSE)
		if(batteryLevel > [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage]) //Checking to that the percent has moved since last check, stop repeat Activations
			LASendEventWithName([NSString stringWithFormat:@"batteryActivator.%i.percent.draining", [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage]]);
	else
		if(batteryLevel < [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage]) //Checking to that the percent has moved since last check, stop repeat Activations
			LASendEventWithName([NSString stringWithFormat:@"batteryActivator.%i.percent.charging", [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage]]);
	
	batteryLevel = [[objc_getClass("SBUIController") sharedInstance] batteryCapacityAsPercentage];
	%orig;
}

%end