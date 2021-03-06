/*
Copyright (C) 2010 MoSync AB

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License, version 2, as published by
the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to the Free
Software Foundation, 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
*/

//
//  SearchScreenWidget.mm
//  nativeuitest
//
//  Created by Niklas Nummelin on 11/26/10.
//

#import "SearchBarWidget.h"

#ifndef NATIVE_TEST
#include "Platform.h"
#include <helpers/cpp_defs.h>
#include <helpers/CPP_IX_WIDGET.h>
#include <base/Syscall.h>
#endif


@implementation SearchBarWidget

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	
#ifndef NATIVE_TEST
	MAEvent event;
	event.type = EVENT_TYPE_WIDGET;
	MAWidgetEventData *eventData = new MAWidgetEventData;
	eventData->eventType = WIDGET_EVENT_CLICKED;
	eventData->widgetHandle = handle;
	eventData->searchBarButton = 0;
	event.data = eventData;
	Base::gEventQueue.put(event);
#endif	
}


- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	
#ifndef NATIVE_TEST
	MAEvent event;
	event.type = EVENT_TYPE_WIDGET;
	MAWidgetEventData *eventData = new MAWidgetEventData;
	eventData->eventType = WIDGET_EVENT_CLICKED;
	eventData->widgetHandle = handle;
	eventData->searchBarButton = 1;
	event.data = eventData;
	Base::gEventQueue.put(event);
#endif	
}


- (id)init {
	searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, 100, 30)] retain];
	searchBar.placeholder = @"Search";

	
	view = searchBar;			
	id ret = [super init];
	[searchBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	view.autoresizesSubviews = YES;
	searchBar.showsCancelButton = YES;
	searchBar.delegate = self;
	
	return ret;
}

- (void)addChild: (IWidget*)child {
	[super addChild:child];
}

- (void)removeChild: (IWidget*)child {
}

- (int)setPropertyWithKey: (NSString*)key toValue: (NSString*)value {
	if([key isEqualToString:@"text"]) {
		searchBar.text = value;
	}
	else if([key isEqualToString:@"placeholder"]) {
		searchBar.placeholder = value;
	}
	else if([key isEqualToString:@"showKeyboard"]) {
		if([value isEqualToString:@"true"]) {
			[searchBar becomeFirstResponder];
		} else {
			[searchBar resignFirstResponder];
		}
	}
	else {
		return [super setPropertyWithKey:key toValue:value];
	}
	return WIDGET_OK;
}

- (NSString*)getPropertyWithKey: (NSString*)key {
	if([key isEqualToString:@"text"]) {
		return searchBar.text;
	}	
	
	return [super getPropertyWithKey:key];
}

@end