//
//  CATextLayer+AutoSizing.m
//  Pods
//
//  Created by Patrick Gorospe on 5/24/17.
//
//
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CATextLayer+AutoSizing.h"

@implementation CATextLayer (AutoSizing)

- (void) adjustBoundsToFit {
    
    NSAttributedString *as;
    if([self.string isKindOfClass:[NSAttributedString class]]) {
        as = self.string;
    } else {
        
        UIFont *outfont;
        CFTypeRef layerfont = self.font;
        
        if(layerfont && [(__bridge id) layerfont isKindOfClass:[NSString class]]) {
            outfont = [UIFont fontWithName:(__bridge NSString*)layerfont size:self.fontSize];
        } else {
            CFTypeID ftypeid = CFGetTypeID(layerfont);
            if(ftypeid == CTFontGetTypeID()) {
                CFStringRef fname = CTFontCopyPostScriptName(layerfont);
                outfont = [UIFont fontWithName:(__bridge NSString*)fname size:self.fontSize];
                CFRelease(fname);
            }
            else if (ftypeid == CGFontGetTypeID()) {
                CFStringRef fname = CGFontCopyPostScriptName((CGFontRef)layerfont);
                outfont = [UIFont fontWithName:(__bridge NSString*)fname size:self.fontSize];
                CFRelease(fname);
                
            }
            else { // It's undefined, and defaults to Helvetica
                outfont = [UIFont systemFontOfSize:self.fontSize];
            }
        }
        
        as = [[NSAttributedString alloc] initWithString:self.string attributes:@{NSFontAttributeName: outfont}];
    }
    
    CGRect f = self.frame;
    f.size = [as size];
    self.frame = f;
}

@end
