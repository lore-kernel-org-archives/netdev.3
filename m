Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93914490BFC
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559897; cv=fail; b=J8KnGz+j7MQfyS5w1o1siz7Sma7pYPBKz8+L/W0MJwYBzwCIuMpzcOJM7TaXqp7j63wArd9vL6jcPCKmZaRR8mzLhZqzmgDUjyTjbV+VMzFqZeMmccyxcW1gMh+V4etPnWMSO0+YHVY73cRSxiOJHScydI0Oq6e00hEXcCbcYGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559897; c=relaxed/simple;
	bh=HXq9b7THAu1kauxTFjNaYtAlutNfBrS31KwWGJ4OKuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDfyok9D270gIQnB/7rjHq0JYNvQmGH6QXUx3ChXsU5oJ9CHkasZCHeNsJS4KBkKJ9gMZ9o7Qn8sbGw9dfi0T3+6QHxQYJciK1s4PSXyyEXckYVXfp4mwJthSF6yrlspWHRics8vBcDpu08ms/sxnVOvcVBffe5efcvGt1d1coY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N9a4EjbU; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9a4EjbU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMabePUXIoECXGMpHD6qRsGG3pPJVVoiUazZ6HyHc3kpNV2Z0Om/MQCgZ2VMV0kA1tPG+lm5gLwVd/oN8MiD/ooIdwA7whjpsQTJn6x9xgv3sx1WiSyeRIx0mDrTjuRzDMX237pzz7RvCdBGnl2qm5lLjidxBKfxJ7xuh4YvOnzASZACWjSNVR22EfoLA97j7F/YvKJ0oPkC8xJmmuBkTARISzBrmK3anInDKbLQf3VqvY7TgR34+xPWZWNs8uH5C8zAWZehZbBJV7hyYoGFVHNZrrA2hMTxv75rFkbNU9deDyrncqNeD3KGYEGjkmwyUEcCtYSkkz1FIbG6lBMV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV62x2Dx2NecGt9Ee/rIG7C4m8C+jJIWdU8Wtn8kXHE=;
 b=TpxiSFEfIbVEAtw8rk6o2PmD6QQ3knVDNBzh1h1z39fb6KckrvLGM+xTO6tJSaH8L8IWWZt27pqn15mGFjXS8Gqs4RqagRlELESdR96eFD8zyRYjP2JyOs2r/qatCzDXkmdeo94t3WYwyIQnYNWwTPVbJOcKL4Al0pbEezJeH354SF/e3f7/SdM8AQaem0gHy5eZperWsd+cIfNEDtwU2vDGMB9xWDfRVacgUC1guTiHHWt0lRiLhU1+JQoh4Sf5IS92aq63VdIDcipQPMMxvNtVb1kFjOdqs/lhNCVL4+49Y7oHDBfRafIvvvdOs2bzfSNXrbmXvVpz14fmgdOvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV62x2Dx2NecGt9Ee/rIG7C4m8C+jJIWdU8Wtn8kXHE=;
 b=N9a4EjbUrfkkS8OgWZs0gEcKCne9pUAxvKft+7tgtKC+LoB7PCOkCtgY5wyNEXwm0cnWoHOBCKR8nAexcjik6oiR3qtDlUXFX30k3Qx6VMBiVmDGbyU14AhCxq0F0zP4gVUo234Spy7hYlGNQKXhBTp3pjq9BPtdl8QAcJdXbFhoyz9sadyeKhsRd3dxb0+pulP1DIGpRKAjQh39aNoRV48r85mHSxvMOtkzZcGsKCfMHDI3TI/BusHvK1TZZ0dOpEXaEU28daoIimmGc1vtK0P8AzvV1ipWjsuPipWKjGYn8kqlJWGohW5EZGjOMtq0BP0erdDEnaRfQipwlyCQig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 11:58:05 +0000
Received: from SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c]) by SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 11:58:05 +0000
Message-ID: <7146e0b3-fffd-4ae1-8da1-c1810cc8ede1@nvidia.com>
Date: Wed, 16 Sep 2026 14:58:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net/mlx5: Bridge, don't fail unlink of
 untracked/unsupported peer ports
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>
References: <20260916104654.31901-1-bsoares.it@gmail.com>
 <20260916104654.31901-3-bsoares.it@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260916104654.31901-3-bsoares.it@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: a56d5e63-d9ca-403d-9383-08df13e9c429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EFpfiWIqW9I7fimx9oNsydeWyS7SsHpe0knE6mtM8Z8Agm/T8lrIITKz/jJdFaIAygxw8AvmS7DguVhRP7FKs4Su7Le45F7HAOSf1U6N/gzeGsVPJGrNIrYoHrnQNObjSB9fJMEbFnP2XhYktFA+Nx4Mc0Dmn9tm3A0c9pxrMcm1Gk0p8Hr/6NwItmyzlO8UxMv6NGlswhsBdwlQVAMTbEG6VTbSdk2m56l/XdKQiLYVMm2eftR8fPsq/mxB/kO115S3Tur23gxIMdz+YCqdlj4QHcFxFJ3kNsRjy10l12C48uXEZ93WKEEDi7Zmm1BneTWuSg6KiCntu2suLp9bHb3PL3lc+EmHs96rgQC2hR/fbaVZHCjGYR/j1iJXVIdGFBdo1AQlJTqCn/AKQ6BvLZbkzx8+GQkn0rnuf3JbOHiNcuRSwc1WUWY6WDhqBygErQPdRpKNd8GKgGyV/RKgtMPlcXXZJX8bpxXlvsS7kE/L3F9q4ydgS/WX2SZHgPmzS/F8kjN552RbUYgfH4fxAMXki/3tsYUMppY6cDShitJF81jYrfGUyYtyiG/KfEELZTFBOV2+IF8HXi+5dfdFNrNigxYbCLsUwz1kjmalyE85bdkrvS4CJARaegpMII6N0uOKVNIVymeWVHXqhLggSY6RDiRbhQKQLYnJIduHKgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4367.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVRsQjJmTU9hZTROVzdoT0Z4emEwNllTalZpYjhaa0Z6TDUydWhmWVZjdFN0?=
 =?utf-8?B?bUZyL0g2MGw3ZFZVS2UwZUFEMEpwWjRIb3lDNmlGR2loOWFYOEpGT3JGZGFI?=
 =?utf-8?B?QURBUEZ2Q2xOeFNmbTNJT2FrT0s3ZC9pSXo0eTZHTThSYVZCZlFTRVZGTlNS?=
 =?utf-8?B?Ri9mTmJyL1VBQVZQYjZYZjd2VE9tT25BRXdDZktZazVaejlIU0xKSS9CU2ZB?=
 =?utf-8?B?dHNmMWNnUDhmZ3BrUkpRUDVPcUF1TEx0UEdIclZsNDBGb0IvZ1pteHVxdlVs?=
 =?utf-8?B?VFk5M3BUTUhoMFNmSC9qU0JtT3FpTVFmREthSndnNlRGWktXQmFpM0FUcFdO?=
 =?utf-8?B?eEw4bW1xbHhGdlMxZ0o3d2xDR1VmRmRqQ3F4VlVyemxJRS9jNkgzN2d3OTRx?=
 =?utf-8?B?Y0NwaHlJbUFjaDcyZ3RBSnNNcmRzaGJaekJ6ZHoxVDNQNk16SUtYL2NkakJl?=
 =?utf-8?B?Yjk3cmFuMHRTbXBuVXV1Mmg1emNBdUNldEZsZXI3WE9PeU9GVXBuSFZ5NDVj?=
 =?utf-8?B?Z3ZwYWsxV0lodVpmME15MzZ0N1lWazk5bk1UQlo3ZWtsamprUTh0VVRmWVVj?=
 =?utf-8?B?aVFaOVZ5N0ppV21NQnMvTGxLUFVlYU1lWnRZZU9ZdVdETG9xQ2NPNllzRXFT?=
 =?utf-8?B?R1BOanRqb0lUbUh3eXhacElUZ1NOby8vRXBORHdzUGtOMGlRK0FmMVlGSjlG?=
 =?utf-8?B?SlhUL0hhNG1Za0ZqcUpvelVaQzhpdVJWUnRtV1N2THc4Slh1VEdvdlN5UjBW?=
 =?utf-8?B?VVFYOXBkbEhxRlF0SDBheW5BOG1ocXl4bGdlTElzUCtLeVpxS0dhWmVvYURy?=
 =?utf-8?B?aWN2cjNneWQ0OEhJYjNpZFRmZzNZZURHc0M3cTZHcitSa0FPVTlsT3NrK0l6?=
 =?utf-8?B?YUh2ZlpValprdWJGa1Q3azJsaUFiTEZUSllLRm8xZmpvYU1XUDY2SVVWbHM0?=
 =?utf-8?B?VjNUWXhpVkpnaHdDU3lwNmNaWUVMSUZUOU1XNWJxU05KZU1OMXJkcjQ1aHRN?=
 =?utf-8?B?VnpJNGF0ODdNNlBLd0poNXBPNVVWQ2hwUjcxSENhQndoajZvem9xSXNRb1B3?=
 =?utf-8?B?OXg2dFF1YVA3MjJCK2I4WmkzUHRYdzlWOHhsakxVbHlWUHdMTHdOekplUzlz?=
 =?utf-8?B?NS9YekNpTi9JN0JBTW5iRk9kdHlVQzA1RXVhWnhDVjhvcFE4SDdtZUpBR0JT?=
 =?utf-8?B?SlBiUjJ0a3duMktTMEFCNVBBZUliY3dySDZUZmFxSmhHTzVVRFNaWTlDSXBl?=
 =?utf-8?B?R25EQ3B2SENMS1JrdGZ5M0NWMVBrVGpPRy93WmhQYi9SNWVPT0VxMlhka2l2?=
 =?utf-8?B?N1BzOG1zb1NsSDUzWGM2R254Q0tpaWFUMCt3Si9pLzFtVTh4elQrN2FFekNS?=
 =?utf-8?B?amw4Z3Z1WXVodDNYZ3lYVTVlZUovR3RaaWo3OXo0cVZjY3IrbUlCL3M1VkFM?=
 =?utf-8?B?SXdaNDF5UVFlOEplSkUrV2V4cnVqUzBpa2VpYitBcld3WC9xSFNhaS9UdnFE?=
 =?utf-8?B?MzQ2cmNnWGhFK3hRT051d0JJVWdvTy9sSXl6ZWx0Y092STl6Z3krVUdMSVdi?=
 =?utf-8?B?VmNvaXBJREkxb0ZMa2RRRFdYSC9sWTRUZTk2c0RjUHplUmVYNkFDY3p5TytR?=
 =?utf-8?B?VnlDVkNUVS9mNXBGaG1TeC9kT09lRjNsa3F4MXdudlZselNEZER2KzBRbjVp?=
 =?utf-8?B?SjAyVTc1TEJKTWk1bjRVTUJmdmIvMlF2TnBjZXhSUkhMSTFtM1hlMjFxR0tZ?=
 =?utf-8?B?UG1HQUFudm9OaWxkK2NWQWpNMWlqNTkvWFhFdVRRYUtTdzZ1a3BoZGFSWGZj?=
 =?utf-8?B?RjhNWURCNVpZa2tSQnZycFpydjRNbjRPZFBaaVpLbkF6bW9CWWd3MHBIOGI3?=
 =?utf-8?B?Zkx1T1ZEcDFYLzhlNzhiTlJuRFFkcS9wYkk5d0ZoU3ZYVnZSY3p3SnFyalhv?=
 =?utf-8?B?M2x3bU5NY0FzNHhnN2lVbmFoZTRmWHlVSnlPbGFIckNUOUVCeGlZV2pUQUps?=
 =?utf-8?B?QUI5cHhaWW40Nng5dHlkWFJFZ0dKeklPSkxDZ3JUWGVUenp6MVFtcW4yYWFi?=
 =?utf-8?B?cnZNZUR4MWtpVkxiU3k1T3hDVG1Gc3Q3bFh4Zmg4K2F1YVVMOHVFdXppVnFq?=
 =?utf-8?B?Z09MRmVvWFpUd01ZMitaN2JicjNxS0xySmx6V3l0K1FBRmczVmpHQnZkM3RD?=
 =?utf-8?B?Tm9pNVlqRHZLeUxwNzVrbWlwcmtlamY3cUIwMFg2TS9XNE9hZk1MQ2tQckFh?=
 =?utf-8?B?SHpXWFJBRkdtYzlVZlhDcWdwOFRIVVJqSE1QaUhTM2pYYkJJTXZIaEtQcCtW?=
 =?utf-8?B?VVJLNFgrc2Y1SHhjbkpFNnBKak1wTDZRTWhlejZZK2VUMG1kYmVQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d5e63-d9ca-403d-9383-08df13e9c429
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:58:05.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl2+s1DQGBhzHabY/Am6kn8ADN22CEedlu0FaQ2DnD3ntzHBnD95D63W/9YPIi/+Wxj7k7oL9Yk5x2Cv47FqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687



On 16/09/2026 13:46, Bernardo Soares wrote:
> mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
> tracked by this instance's br_offloads, which is reachable in two
> legitimate cases: a duplicate NETDEV_CHANGEUPPER unlink for a port
> already cleaned up, or a peer-port unlink for a vport whose link was
> never created because peer_link() skipped it. Return 0 instead in

Where does the duplicate NETDEV_CHANGEUPPER unlink come from? AFAICS the
concrete case is a late registered sibling which never saw the link event.

Mark

> both cases, and give mlx5_esw_bridge_vport_peer_unlink() the same
> merged_eswitch capability guard peer_link() already has.
> 
> This also matters beyond the -EINVAL itself:
> mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
> netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
> which call_netdevice_notifiers_info() checks to stop calling further
> listeners on that chain - so the old -EINVAL silently dropped the
> event for any listener registered later on the same chain, even
> though none of it was visible to user space since
> __netdev_upper_dev_unlink() discards the return value.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> index ac90ccda1272..b4cf3c5ac0dd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> @@ -1649,10 +1649,8 @@ int mlx5_esw_bridge_vport_unlink(struct net_device *br_netdev, u16 vport_num,
>  	int err;
>  
>  	port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
> -	if (!port) {
> -		NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
> -		return -EINVAL;
> -	}
> +	if (!port)
> +		return 0;
>  	if (port->bridge->ifindex != br_netdev->ifindex) {
>  		NL_SET_ERR_MSG_MOD(extack, "Port is attached to another bridge");
>  		return -EINVAL;
> @@ -1682,6 +1680,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
>  				      struct mlx5_esw_bridge_offloads *br_offloads,
>  				      struct netlink_ext_ack *extack)
>  {
> +	if (!MLX5_CAP_ESW(br_offloads->esw->dev, merged_eswitch))
> +		return 0;
> +
>  	return mlx5_esw_bridge_vport_unlink(br_netdev, vport_num, esw_owner_vhca_id, br_offloads,
>  					    extack);
>  }

