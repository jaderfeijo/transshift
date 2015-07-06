//
//  ChooseServerToAddTorrentController.m
//  TransmissionRPCClient
//
//  Created by Alexey Chechetkin on 29.06.15.
//  Copyright (c) 2015 Alexey Chechetkin. All rights reserved.
//

#import "ChooseServerToAddTorrentController.h"
#import "RPCServerConfigDB.h"
#import "ChooseServerCell.h"
#import "BandwidthPriorityCell.h"
#import "StartImmidiatelyCell.h"

@interface ChooseServerToAddTorrentController ()
@end

@implementation ChooseServerToAddTorrentController

{
    NSArray *_sectionTitles;
    int     _selectedRow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add torrent";
    
    _sectionTitles = @[ @"Chooser server to add torrent", @"Additional parameters"  ];
    _selectedRow = 0;
    
    _bandwidthPriority = 1;
    _startImmidiately = YES;
    _rpcConfig = [RPCServerConfigDB sharedDB].db[0];
}

- (void)swithValueChanged:(UISwitch*)sender
{
    _startImmidiately = sender.on;
}

- (void)priorityChanged:(UISegmentedControl*)sender
{
    _bandwidthPriority = sender.selectedSegmentIndex;
}

- (int)bandwidthPriority
{
    return _bandwidthPriority - 1;
}

#pragma mark - TableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0 )
        return [RPCServerConfigDB sharedDB].db.count;

    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 )
    {
        _selectedRow = indexPath.row;
        _rpcConfig = [RPCServerConfigDB sharedDB].db[indexPath.row];
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 )
    {
        ChooseServerCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_CHOOSESERVER forIndexPath:indexPath];
        RPCServerConfig *config = [RPCServerConfigDB sharedDB].db[indexPath.row];
       
        cell.labelServerName.text = config.name;
        cell.labelServerUrl.text = config.urlString;
        //cell.iconServer.image = [cell.iconServer.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        if( _selectedRow == indexPath.row )
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    
    if( indexPath.section == 1)
    {
        if( indexPath.row == 0)
        {
            BandwidthPriorityCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_BANDWIDTHPRIORITY forIndexPath:indexPath];
            cell.segment.selectedSegmentIndex = _bandwidthPriority;
            [cell.segment addTarget:self action:@selector(priorityChanged:) forControlEvents:UIControlEventValueChanged];
            return cell;
        }
        else
        {
            StartImmidiatelyCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_STARTIMMIDIATELY forIndexPath:indexPath];
            cell.swith.on = _startImmidiately;
            [cell.swith addTarget:self action:@selector(swithValueChanged:) forControlEvents:UIControlEventValueChanged];
            return cell;
        }
    }
    
    return nil;
}

@end