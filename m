Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3964E2349
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559847; cv=fail; b=mjfe9nBtjiPDmn53p6DVfggPUymVqslTAYoXBS/dJP3galuPDLmzQ94u8Ya09040x3OTl1/wjHcVeMgiuASS78K7VD7f+KA7FyUa0KZ/y7TK7hm8Wfoy+hemktNFIAf3bpGOrtp/C63TxkyxgYd3HtOFBoY/T79GnJiqygSu/XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559847; c=relaxed/simple;
	bh=VjK0GMQAKqtXEIvFd/jKrGw7oWmdob7px75YND3WH6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTCP27Eo0Dkbgrqy/xUMiee4HFnf44OHuWeDCW6HLq8M9BG1WeYiaPHSuSV06XJe8e8yBONcF/pjV2j9NVifSGpQmhwCWh3ES2Dg+Z0cklIjZhYvviB7MPHxjmOwbFPB7l5GsjPppkBgHgSNncYbdNzgGf/8qjYIxcbIT16x2B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ca8ghbFg; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ca8ghbFg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsB0ys1vEOz0TOsIH3IG8j+R5k+DX7IJz57yp5FexqGwG3FQ9b9uSU9XgNfk+kJ44Z7jgBgoQGTdmJF1j1tuyQZkSZQgavPeftWIl0PcjGHIrkRbO04jOHU7exAgofT4XPDtqVXLI5Q9pp1oXkvBIPh1IL8N7KfLEC6C+BDCMgoA2xJzHqXn9BxHv/A0rvhrGQBSfmCCrIkP3c+nWJmhzvxV8zgSUEGa2i29u1b7FgJbWdcGgBjInBkdHNeEV1gzxwv6EEOgBepFvCU4gtil4TBmf50M5IYbIcmJcWsZELRBKYtHgy+gSW5otJKf/9gpaLka0DxRfl27d7aBE20N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhCy0zC7KkrMpfmQzKCDKOb3cdSFmT2uuGaJMRRh+g=;
 b=k+WKylRCiCbOPaqhOaZT24xb/i71PXeSMw8SIHSPtqR5a/sTMvmlvOSlCgwhy9phIfrtobIRd8d9cn1O6oIi73STIVIm1bcDwtIjT1LFrcokGTFotQ/7unRaKHfX9uJ4MDMlzGyHNW7SjVu3SXHKQHuC7ktsc79U5ckMY+QHDnGOT7/D+wiCeHChdzDaMSE+uM5bMSMtmmQnXcCrkltAjQGOta2hYo1LtUXngzI1ou0o0PE8GuCZZZ5632VauuUWN4byapNvQQQcTPfqxvg+RcdN1a9Tx1jHEL+H+YUJ/Y525f62EcUH36eiAm62mrc9yxEQISDwlZqkP8gCvdi8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKhCy0zC7KkrMpfmQzKCDKOb3cdSFmT2uuGaJMRRh+g=;
 b=ca8ghbFgmku4OZfCWlOiTLVGHHWRi7yquS4ZlK9797vGAqmKsb9dewCIBDPsAjpASa5iW8ua8h5YRJT86qbapl1OsOEU61YPapvKkIZo9Pd+BfCg6V62wJQF1NPV0KMyXba8HeftqGEcDP3E6+h/zAl1aX/Po+7uLLjqcngkFEJhPa4niL1TwgvxOYHMbbzCLP++fH1o2a/4zoa3/YXJ2U8IcB//CstW2DTCYwsiV6zR5KC+MiI52noL7kGpYoDcST7PKyF0ykfoedq7tvtKV2HNNGHKf8DMLwK9lXaCQ/rpp3kH4/SWXS2EP1vDxyiJt8b5wuYTXMvJ4J2/MLnm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 11:57:16 +0000
Received: from SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c]) by SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 11:57:16 +0000
Message-ID: <db60087a-44e2-4017-ae68-9953f77f07f7@nvidia.com>
Date: Wed, 16 Sep 2026 14:57:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net/mlx5: Bridge, don't fail switchdev events
 of sibling eswitch ports
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>
References: <20260916104654.31901-1-bsoares.it@gmail.com>
 <20260916104654.31901-2-bsoares.it@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260916104654.31901-2-bsoares.it@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bbc3a1-58a8-49d6-4735-08df13e9a678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y+s2yi+L2CSBt62CkBqN46ET+8ioTBeFOc7n0xdEM8mY1CXl8hLPblw/o9nSpR5tf40ku8Y7FBltrQRgeFr5FMdxrL+9MwhRwh4nKeSrs65zCoa/F0qsX+UZiTZH56S3S2zJi2wAe8tsCUfhMq2VPX41Hp4idYNmAjbIIDcgkjETFKn/DVOx5CwYVysg7GN+wekUlZx1ux4LxZduekXcojV6281kCcNXNiGD6ZUXwExN5Y37rKHtEX7Jp2t3bqYQV4mrj5qyIkzL/9UIgsfdGitg9TOD1APwPKJ6wEY37VnmdxZEJHhW7X1aYchrdXwN+CMx2EPYEvFr09IzG36ETdCZynxvZ0g7pl5HdYU2H2Wq8b6n5aGERcZCHwHTy9ZrQ2sBm6mo2veNRnT2zxLy6pW4j9dA0PBqxdTQpBMZaVXhkGTsbq6IeutHiTuO+jbUpQs89ytcbG5YXPYaAX+SmxNBO7GBdHodu18hk360j9r0PhqOF+Z+x9Tn6lP9rPdqq+XFozjEcwrGbneMUbLzoyp5Mok0OSYLukWyqYND5nAhX94ntMOhtPSttsM7nClDr6ij022iB+VRnTx5TsBM9siPXiCn9/b82CBI+kQ18bPdXSUY3DnjBYo9GkfOGFVN97hOeaEBR+qDg7uMbE3L+Qt9LMMReRU6mjjtnQIxDUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4367.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkloRlNQdEw1REovK01XYTZja01VSWprdmhabWdmL0VueTlDZnRXVG1uaFNN?=
 =?utf-8?B?OVJZRFVMcS9CNTd3ZGJQeDhISDNXcWNhQlRPS0hPRXM0UzF6VFdxa0pTTHZl?=
 =?utf-8?B?Qk9oNjhreHFQcTNNREZwNVk5QWwwUXV4cXJuZVV2ZTRxRG1VT2J4di9hNTJr?=
 =?utf-8?B?SmZneDA0d0xTK29LTlhzbE9CVUNXSGxKS1JkZ2Z3cmFXdDkzcjVKZjN5RWVR?=
 =?utf-8?B?c2crSm1iY3B1dW5hU0ZaN0hPaFRKSGpUS2R5NnVuVGFFYVpkYmVmaTVlbFl5?=
 =?utf-8?B?WFFLZjRxL0Q1YzFpcFNrczk0RWpOUklTQVpBQzJTczBMN0pRYm5ZZ0VwclBP?=
 =?utf-8?B?aFVZakhXWWFUbmxwYTJJMlNnNXVxNlptQVBIWDhobU5Wd1M0SEtRY2hvSTly?=
 =?utf-8?B?RExZejVGY1hQMFBsNFVxelJQcmdYc1BQY2twQlAzUE1GSG9jZjhxVnlpamRw?=
 =?utf-8?B?cTRuN21vY3QxVDVVM3JXY1d1OTVxRWJOcHQ3U1dSdnJuc3k0RnFkbTRhczV6?=
 =?utf-8?B?SEN3RlY2ZHU1TlR3TlpCbEFYZ3d5UW9yWVNlQnh3dThTdVl2S2R2L3ZhVmRy?=
 =?utf-8?B?OWVISzNzYnVUT3dJbWkrQWg2U0xWNzczczdsMGhaZldsTWQvNjJVR2kyaUw1?=
 =?utf-8?B?U1I0bXU4bFV4dEtkbTJTRmIwZHR4RFQxTnF6bDZtakxKY1lSZHVNWXM5cXZ3?=
 =?utf-8?B?ZmFjTk1KTDJ3UnB1V3lQSjJncjJETHNsNytKTDlYMk1iSWtGejdjTTNBdmRL?=
 =?utf-8?B?V1hGZE9oS2FmdnBHNWJoU2VKVjRyRjRaeUpCTzZMdkI3blJRNEs2RDQ1TUxN?=
 =?utf-8?B?aXRldDY1REdzaHlBalFjUnZoRXhQMlNldlFUT09vL2I1N3FUVHZ1S3BqNHNY?=
 =?utf-8?B?RGpzZ2FteWdlV0ljVkFOd0UySVRUWkNNa2VGRkw2aER3bWtsQyt3cjFFUzV1?=
 =?utf-8?B?aktLR2JYTzUzeFRQUG1aVkNIUVVoUzZhM2dLRHZIckFmL2ZUQ3ZJaS91aHgv?=
 =?utf-8?B?ajBHSEptVkxOTkd4WVI4ZXFEQkZRL3Z2dllyYUh6QXVlaitwSnFSU21Ibmx0?=
 =?utf-8?B?Z1lGbkxOeFFIR0NhY2gxSVZMRW12WFphNFNMZWRMekExU0dqR0owZDRMQ2th?=
 =?utf-8?B?U3JvRDJGQ0hpR0Q5R2NMTVdiZWo0MWtzeGlDNDNqUFExM2o3bndlN1Z3YmN2?=
 =?utf-8?B?TFVGbyt4RmhQL3VVbUVycitoTlQwQkpDbWg2ZHZvMEZ3Q1hTa0Izd3pPK0dk?=
 =?utf-8?B?RTFpcDhxaHo4K2p3SFRCaE12NEtFczJFaWw1MG5SbHFrbFBRQWVPN2FnaS8w?=
 =?utf-8?B?NVM4V2x0UTYzaUFTVXJiZlUyZlBFd0ZCai84UCtGTTVITWtQK2R2aXVRQlpB?=
 =?utf-8?B?Y2pNV25tZHJodnZKQWpMc29OREJxZVhmMFFVNHhjUnV0KzNkZHU5Vjg5ZFdH?=
 =?utf-8?B?b0xsSXFkc0hQYWVkL0lFOHRVVGNYa0NFRmZJaEZBbk10MkQ0dDdrRXpYZlJo?=
 =?utf-8?B?elYzWXZ3bHVoTWMwcUZUWWt4NUllaWxzY1pINkg2Mnd6cGFONTF0RUYrclhi?=
 =?utf-8?B?eU5sWG8wTjJ2U25EUVBwUU41YXp0RFZMTEd1VnNndERESUhXa0wraEtKSy85?=
 =?utf-8?B?ZEYwWWtncWxBK2hxQ0lIQ0dnbXhQaVVFempuOGo5NnZ4WXRTZDVwdE5TZTRH?=
 =?utf-8?B?WkhmZTJOOHFJTzBRY0F4WGFHemJCRWQxUW8zNy9yVHgxZVRjM0VrS3ZuUlRJ?=
 =?utf-8?B?K3N0K21mQklkYlF3SkVra0Q4VVdpenkvM3J3MDJJV2hmVE5VWkRlY1BURTNW?=
 =?utf-8?B?RXI5QUpnQ0FuN0dsVkFta05tWnVjSU13ZmxqbVg1RlcxQThrcTd1bys0THgz?=
 =?utf-8?B?WjJoWWZjcEtDcGNqVWx4bmlROUVYbmxnOTJ4NzE4eUQvcGY1TCtwdXZoSXlx?=
 =?utf-8?B?aWljMmJ6ZVZQNVZVa3ZwWnZkNS8zeXE2T0lZTXJSZ3phUS91MGw0SnYwMUg1?=
 =?utf-8?B?dllyRHdtbG9udG56aEJxL2FYbks0eHh1QjZEbDdsdk50L0FIQkRadk53RGh5?=
 =?utf-8?B?U0traTR6MUkxWGZSNFF2WmZpdTdiUU55Vm9pRWpXeXgwa1BrU3ppQWpZRmpw?=
 =?utf-8?B?K25pa3VEaHc4KzFQUEJaaXlxb29aanRHRS9UZjZad2t0WWtYMENDcStVSjRx?=
 =?utf-8?B?QnNJd0MxNGMvSGlUMnRnNDhaSm5uMW5PWlgydWxCbEFPbWJZRGx5V3R1U0ph?=
 =?utf-8?B?U1lCbEJHRzNVM0VleHNxTkxvdWtKM21LYi83eW1lZjViV2d0OHErWENvU0dq?=
 =?utf-8?B?UkswOXJhQjBPRnpUNUZuOUJEd3EzV2JYenQ1UXVZV3JaazdiQVhMUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bbc3a1-58a8-49d6-4735-08df13e9a678
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:57:16.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCXh01FELI/HehPbVgvzr/ublFZy5ZHiB778NkbQsRr/n+GBwxW175r60L10nF9tp28IdHuGeO3tXfFkyiIv/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812



On 16/09/2026 13:46, Bernardo Soares wrote:
> mlx5 registers the bridge offload switchdev notifiers once per eswitch
> instance, but the notifier chains are global, so every instance sees
> every event and must filter out the ones that aren't its own. The
> existing filter, mlx5_esw_bridge_dev_same_hw(), only checks that the
> event netdevice sits on the same HCA - intentional for merged eswitch,
> where one bridge can span representors of several eswitches on one
> HCA - but same-HCA doesn't mean the instance actually has that port:
> peer ports are only created reactively from NETDEV_CHANGEUPPER, so an
> instance brought up after a sibling PF's port was already enslaved has
> none. The port object and attribute handlers claim the event anyway
> once same-HW passes, then fail the port lookup and return -EINVAL,
> which gets reported to user space even though the owning instance
> already handled it (e.g. "bridge vlan add ... RTNETLINK answers:
> Invalid argument"). Fix by filtering on the tracked port instead.
> 
> The same gap exists in the LAG bond lookup used by attribute changes
> on a bonded uplink: mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get()
> walks the bond's lower devices and returns the first rep that's
> structurally eligible (same HCA, is a rep), without checking it's
> tracked by the calling instance's br_offloads. Lower devices are
> appended in enslavement order (__netdev_adjacent_dev_insert() uses
> list_add_tail_rcu()), so on a merged-eswitch HCA where a bond spans
> reps of more than one eswitch instance, whichever rep was enslaved
> first wins the walk regardless of which instance's br_offloads is
> doing the lookup. If a sibling's rep was enslaved first, this returns
> that rep instead of continuing to the one this instance actually owns

This doesn't match the code. mlx5_esw_bridge_lag_rep_get() requires
same_esw, so it cannot select a sibling's rep based on enslavement order.
AFAICS this fixes the generic recursive lower-device walk instead.

code looks okay, lets just nail the commit messages.

> - reached via mlx5_esw_bridge_port_obj_attr_set(), so a bridge
> attribute change on a bonded uplink can silently no-op on the right
> instance depending on enslavement order. Fix the same way, by checking
> mlx5_esw_bridge_port_exists() at the point each rep is picked.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>
> Cc: Vlad Buslov <vladbu@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
>  .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  6 +++
>  .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
>  3 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index baac38bece14..4b7b0a0fc2b2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -85,9 +85,16 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	struct net_device *lower_dev;
>  	struct list_head *iter;
>  
> -	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev))
> -		return mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> -								 esw_owner_vhca_id);
> +	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev)) {
> +		struct net_device *rep;
> +
> +		rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> +								esw_owner_vhca_id);
> +		if (rep && !mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id,
> +							esw->br_offloads))
> +			return NULL;
> +		return rep;
> +	}
>  
>  	netdev_for_each_lower_dev(dev, lower_dev, iter) {
>  		struct net_device *rep;
> @@ -104,6 +111,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	return NULL;
>  }
>  
> +static bool mlx5_esw_bridge_rep_port_lookup(struct net_device *dev,
> +					    struct mlx5_esw_bridge_offloads *br_offloads,
> +					    u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +						       esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
> +static bool mlx5_esw_bridge_lower_rep_port_lookup(struct net_device *dev,
> +						  struct mlx5_esw_bridge_offloads *br_offloads,
> +						  u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +							     esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
>  static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *rep,
>  				     struct mlx5_eswitch *esw)
>  {
> @@ -218,8 +247,7 @@ mlx5_esw_bridge_port_obj_add(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -251,8 +279,7 @@ mlx5_esw_bridge_port_obj_del(struct net_device *dev,
>  	const struct switchdev_obj_port_mdb *mdb;
>  	u16 vport_num, esw_owner_vhca_id;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -283,8 +310,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err = 0;
>  
> -	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -							     &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_lower_rep_port_lookup(dev, br_offloads, &vport_num,
> +						   &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_attr_info->handled = true;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> index 87b5fd349594..ac90ccda1272 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> @@ -1686,6 +1686,12 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
>  					    extack);
>  }
>  
> +bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
> +				 struct mlx5_esw_bridge_offloads *br_offloads)
> +{
> +	return mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
> +}
> +
>  int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
>  				  struct mlx5_esw_bridge_offloads *br_offloads,
>  				  struct netlink_ext_ack *extack)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> index d6f539161993..a4e59cc21089 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> @@ -80,6 +80,8 @@ int mlx5_esw_bridge_vlan_proto_set(u16 vport_num, u16 esw_owner_vhca_id, u16 pro
>  				   struct mlx5_esw_bridge_offloads *br_offloads);
>  int mlx5_esw_bridge_mcast_set(u16 vport_num, u16 esw_owner_vhca_id, bool enable,
>  			      struct mlx5_esw_bridge_offloads *br_offloads);
> +bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
> +				 struct mlx5_esw_bridge_offloads *br_offloads);
>  int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
>  				  struct mlx5_esw_bridge_offloads *br_offloads,
>  				  struct netlink_ext_ack *extack);

