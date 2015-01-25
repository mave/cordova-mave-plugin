//
//  MAVERemoteConfigurationClipboardShare.h
//  MaveSDK
//
//  Created by Danny Cosson on 1/11/15.
//
//

#import <Foundation/Foundation.h>
#import "MAVERemoteObjectBuilder.h"

@interface MAVERemoteConfigurationClipboardShare : NSObject<MAVEDictionaryInitializable>

@property (nonatomic, copy) NSString *templateID;
@property (nonatomic, copy) NSString *text;

+ (NSDictionary *)defaultJSONData;

@end
