//
//  CATextLayer+AutoSizing.h
//  Pods
//
//  Created by Patrick Gorospe on 5/24/17.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CATextLayer (AutoSizing)
- (void)adjustBoundsToFit;
@end
