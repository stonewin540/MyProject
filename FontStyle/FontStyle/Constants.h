//
//  Header.h
//  FontStyle
//
//  Created by stone win on 12/26/12.
//  Copyright (c) 2012 stone win. All rights reserved.
//

#define APPFRAME    [[UIScreen mainScreen] applicationFrame]
#define APPORIGIN   APPFRAME.origin
#define APPSIZE     APPFRAME.size

#define DURATION_SYSTEM .25f

#define RGBCOLOR(r, g, b) [UIColor colorWithRed:((r) / 255.f) green:((g) / 255.f) blue:((b) / 255.f) alpha:1]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:((r) / 255.f) green:((g) / 255.f) blue:((b) / 255.f) alpha:(a)]
