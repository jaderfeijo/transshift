//
//  TorrentListController.h
//  TransmissionRPCClient
//
//  Created by Alexey Chechetkin on 26.06.15.
//  Copyright (c) 2015 Alexey Chechetkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRInfos.h"
#import "CommonTableController.h"
#import "GlobalConsts.h"

// section titles

#define STATUS_ROW_ALL              @"All"
#define STATUS_ROW_DOWNLOAD         @"Downloading"
#define STATUS_ROW_SEED             @"Seeding"
#define STATUS_ROW_STOP             @"Stopped"
#define STATUS_ROW_CHECK            @"Checking"
#define STATUS_ROW_ACTIVE           @"Active"

// options for our titles
typedef NS_OPTIONS(NSUInteger, TRStatusOptions)
{
    TRStatusOptionsDownload         = 1 << 0,
    TRStatusOptionsSeed             = 1 << 1,
    TRStatusOptionsStop             = 1 << 2,
    TRStatusOptionsCheck            = 1 << 3,
    TRStatusOptionsActive           = 1 << 4,
    TRStatusOptionsAll              = 15
};

#define CONTROLLER_ID_TORRENTLIST   @"torrentListController"

// delegate protocol
@protocol TorrentListControllerDelegate <NSObject>

// when torrent selected this method signals what torrent
// should be shown with detail info
@optional - (void)showDetailedInfoForTorrentWithId:(int)torrentId;
@optional - (void)torrentListRemoveTorrentWithId:(int)torrentId removeWithData:(BOOL)removeWithData;

@end


@interface TorrentListController : CommonTableController <UISplitViewControllerDelegate>

@property(weak) id<TorrentListControllerDelegate> delegate;

@property(nonatomic) NSString *popoverButtonTitle;

// hold current torrents
@property(nonatomic) TRInfos *torrents;
@property(nonatomic) TRStatusOptions filterOptions;

@end