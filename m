Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547691DDF0
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340181; cv=fail; b=a2+GsUDx869NFSAxPHUowX2dXLS2qpq2F2tlFkqVDpHbrMdQjabGWAT96tiCgM2OIxCnlYG9eKl1OAUR04mBzk2d3IRXG9YhQC/LHUDao6bBJth5mDqFUKsQNiefanOM4fswqOdV6yLgRZL+sFClDKimdeM58INeACcFSqO3m8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340181; c=relaxed/simple;
	bh=OmBWK102qufipg7mD9r9tb+k8LUwpgWfoirV7vYz2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N51o32T0YANhcyrx9AypKKbSU+gp+4ae+oUcD+6ARhOgPmUz9Z2EP5csIj0Px4UoCEm52llPTYdxDLn2IvCEVAFllecqN+blDk5zwyPNeSCxGxu3gCZ/YIHuXXJlcizyIS6d/v7UIl/C7NiWn06jBA1F4WwvaJhs/V+J5u+tvB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehxDIZa/; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehxDIZa/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSqY7uiiY33Ea+MvQjvfrn+p0CYFHTG3Swh9b6Wllh1cl95j9elztcnjNfJO48k7C+3RCA8HDTF8JlASpPC6ps7Vhlk+NxmovgwM52t9moK/YHpZx0XGqoVA/xPtTowOBW2GHErEMUN0n7465tG+8dVAye/Kb76kKVwQEovIYSVpA0MBUpSJr0ODI1EXLDT7mAGSpEvtXtZn+65Hc8NBMLb4AXAq9Nw/KJEcQZwM7jdECpfauHT+My8zLE3ySwdRhxS/gZXTSWESkKTkYdZyO8sy8DINM2ET7Od4RH/XPxRHFEZRlVdigFFgOUQLE5fLCC8SheTJQ2YjoOok+Ioqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y4y2zmfoLA2haLvQeWWr1ma1W/+G1rhQqZYG4/kA+I=;
 b=RNzDcsU9REyTcV2cd66guaFu+2ztijBCrisDyaiEOxYujXHuE/Gqc5AvZbIsdkEqrf0LSEPuCR0Ut0d21P84qN+nkAe9PnhTxorpo2L0KPoda4X1kWiaWxcrtl+Wmrx/Now7/1EC9ZCmp2mi/Euj/0z8tANUIjgmxSPTt4KtFOa6Oi6SBA4K7xfecDjWDzVe3HS/0dN6qNoLcgZyckeRriOM8RpzveW7VD11Bl64hxTVMxEvZ1F11G9uGpX8YDxDA/RIkZjN0OkVIU60HxWe/jLR7bjRqJFaEp/gGeed5Y8PnHZxAO1xtzbyEJFAYSGuueeqyvhicpF4tjqUUzgPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y4y2zmfoLA2haLvQeWWr1ma1W/+G1rhQqZYG4/kA+I=;
 b=ehxDIZa/KY3xULOeZkg2lT3Nec2R8coIBc49XUfFpQ00Gw4hWQj7Ijx3blyZJP2G/oslfHSW23+K8zpXve2ZZdDwszIgwQrEckp2xHzgngqpXdgToxGXvreIJEhJG5vlTu71JKxIth1NBotisox1puED7CDH/hS7AYj0GwOH1+xbd54qUEMqiU55TQ762bFDlWiYE6LkMIawB20IgYNlmK2ZUMRRPgOidzOjQveXNKPOT6XJVcc/L73jS83+qnRCtwmWKExCJFgHtkk+grxRjwTjccizT+nolW6KVkhBphXUXUyHWvF37Cx2PXNU1TtOoTr4T6lFx9cXMT58DbrNvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:42:54 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:42:53 +0000
Date: Fri, 25 Sep 2026 15:42:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	kerneljasonxing@gmail.com, netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com, ja@ssi.bg
Subject: Re: [PATCH net] ipvs: fix infinite loop with ipvlan L3 from
 unconditional ipvs_property clear
Message-ID: <20260925124242.GA112355@shredder>
References: <20260924063312.1194019-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924063312.1194019-1-chenguang.zhao@linux.dev>
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e805202-b733-40af-a003-08df1b028479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	FTWA5FaxEOma5hHHQIziGg3emqbxrcngfW07Ka1L7i1WrwOjS+FOsA/JKFZYsiXa69RdWyweEMVNZQNic00s7ESHIsbmX5GUWeravnl3BYz9QEzR71czXJHlRKLtofHXx0SR4wdRZ5G92/DfHDoLGJEF9sZ6HgjsvwG25eX6c5ZPACyZmEnsoxrs1bDdBI9/mEhcGMQ1hlqNcpsFZ4docTAzyfwsppyMkzL6rnQuIkaq4MRJNYC9iny8Jkam3yV3eJyAs20fW9o3meMZMWGMfcbEQH9fVXZ8wq85IvYFeJbCj977w9V5joZ+0FoQarcwOZwywNvDHLcUgRYUioHD3+78SXqDZf7jprGSWkW7nEfNZZA6ZBudF5mr7i0M20wvEb6ryDHFXgCPiFhXc6k0NME/r123GPn4wFzPW3NlRSHTX/BlBM13/TaY5M9CoAm+2cY8IixBTkACKUa6H6+2Ah6zumuSnnaHCuMId5cRVZYfU/j1AGd1EMDsGcvAyvdiT44CY9d6F1n7VWUEOTOd5Z79Z5ZDlCQZQueNB2o+3sv2nwJC/ZQ8CEvLxxDwho7vG7lLx9xtoObFU+xSnUp0RmhHIKY+XGSgebYIbrzsQcPJlUTG6DIadxtSHHN3FVWKTeYEY3hnxWVeyvU4wzyaRFYPwF0fp/mkN6vtgaq6+ew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Vhpu2K8h6G+xyaNuOV1pb5WYw1qkFWKeYN7rQuf7BBRrPrZu6h4ipl4P0pT?=
 =?us-ascii?Q?sosWhwpiQyNKYWSZQGvlbGfUHBhOj2iVRKfJWjxlXxWoVPOGi7OEyyuWdS81?=
 =?us-ascii?Q?eGk9AMdbXMg72TeOjwNQ3AT11VjupCYNP812oPvQ/3b4yPTfqpn0sRYtQl8/?=
 =?us-ascii?Q?IgEHhlK6SVttRAZ5tiwOLs9n0YSOaAXkjjr9zQk+O6jaWQa6LOpVtQDKVbiV?=
 =?us-ascii?Q?ULFLJgCB0QjlbNxlOE1SaQOEOcWVeoKXFGLRqu3xHian6GPku+tokvcuBaft?=
 =?us-ascii?Q?/iTDZIiR57ugiZfk0go/h8sT0L42h8li/DQMDaMrV35JYA18DCEgiGSDDpYz?=
 =?us-ascii?Q?+cggWWifNoY3DYKoVcwUft1VFUgM6f4fkZLy998M4Wq8xgTiyOXC4OXaiSaz?=
 =?us-ascii?Q?sMNMoSsF9AXllR8TTtDCBDWSzTEBg/DkIK0hYb5zfB5U8DtE+Tkh4T7anIRu?=
 =?us-ascii?Q?Siy/1uoH7ZK+D5dBZmv8UGclnfiQclq9lPTZHe5ethfevC4zf/lsCKRUn9GY?=
 =?us-ascii?Q?orDp+DAyz7jy5mnT89havuxVfTBx3LRastPP4fPwB1DWLgBiUvzRbiar9W0y?=
 =?us-ascii?Q?3p/s4JUHq7jroAw5118blPKVCIV50RZU1BAf0DDEH6dnPY0rG2SjlyBFybmU?=
 =?us-ascii?Q?Qe9kFEMvrh5oREI2VMOrmhrLcwMqr89s7fieXeG624dBzL7dRPFHKr/OTCMu?=
 =?us-ascii?Q?PcCOsaIC6C/uuNAC6n9uzTIS2IghpRM/FXuohCNBbpxovI+b1sMh8Y3++EWc?=
 =?us-ascii?Q?DIsciAJx2+co4KuI2lqk6z5l1xndy+fzrqmiDtSIyRGGtSqFCXeKfOwHxRk6?=
 =?us-ascii?Q?07DnZ+8nk95kSURD5LAIRGwdtK0eDUys0nO1LCBG2gFXeGJdn02qWRFlOPKg?=
 =?us-ascii?Q?mxhSLEWTN1Tf5ctjcpyXQWl3BhlZRr5xcyBQYZVDwTgvrr4hmoxzAPIWJy07?=
 =?us-ascii?Q?G4vCK/rlW4k09yc5/dMUOHN2/ZOYYkbYBRFi+zL/M4LBNSWBpkQ6zjvoDpPH?=
 =?us-ascii?Q?/dGkjhek/0INbj1ygnhytnsFpAqZIR0PuVp9vIdqrT7Th209zPSgxDjewF6q?=
 =?us-ascii?Q?oc6fOKf+bqmGqEn/ecWzmNZ477XLmB5mWpmX8jjxqjdneplTCSmM+PMLMvvb?=
 =?us-ascii?Q?zYveBeIN2h56ym8EC8KrgdV3Zvmzv/Aovkh1QyxpZStJmFLCQJqRGZgxlms4?=
 =?us-ascii?Q?OnI5NE1250FdZahL65N0nitAV/qVnsZY6oSTNbW7v7WjKc9edGR7NO1GtIoV?=
 =?us-ascii?Q?aDFKUPWseG3Mt9sAdqFj2YF+lkjfobC55LpG5N04Jf0unYuYBpyEsBAJX5Xx?=
 =?us-ascii?Q?AFDaPtqkhhaPV8iBRrckYmuLJxtWYI6RBC8udmU2vDoVzlNeWmIsgs4tNl/j?=
 =?us-ascii?Q?v41D8ER2K47vyva5STw7KFq5DrXI2FMo4RJ9/uLemOgVwuhjxU4Zd8qspG6C?=
 =?us-ascii?Q?zppqaczpvPwi+lyIMzJIezpLUZz32t6JX+QSFoczwPus3XKKXJgTME38LS/5?=
 =?us-ascii?Q?VpOCDuHUy09s6QGIxeCrDy715Q3HvjHilXRCbSmnolxm7x7jluLq53tT4uL3?=
 =?us-ascii?Q?gyKQb6W7z8H5GvInhZEjNMb40ui/Gq+S70aQmbbFXi+S+dp38qBgjqIednAs?=
 =?us-ascii?Q?KLAk48jhdfCleBdqfpzZ3OPdx3gDG3MjTau+iG6atetRl9O6Yvy2ODpaX1xy?=
 =?us-ascii?Q?Hc5V7MXkIcdi+FmF0+DP1YQjMdzWGJMddMoABjKL9aDrBphVCqVFTqyCuqTa?=
 =?us-ascii?Q?CavSyaUyfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e805202-b733-40af-a003-08df1b028479
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:42:53.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPbdZ07GPaPWdTYWUtlbD2OJrMa1VQ1qYiwKRtWw2Qwn7lwB7F2+B4dflAqHkaYgE7CVC2O7zYLjq8MmoOjIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

On Thu, Sep 24, 2026 at 02:33:12PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Commit de2c211868b9 ("ipvs: Always clear ipvs_property flag in
> skb_scrub_packet()") moved ipvs_reset() before the xnet check, making
> the call unconditional. The intent was to fix a bpf_redirect case where
> stale ipvs_property on an skb re-entering the RX path caused the SNAT
> hook to be skipped. However the change is too broad: when IPVS NAT
> sits above an ipvlan L3 interface in the same netns, the following
> loop happens:
> 
>   LOCAL_OUT -> IPVS DNAT (sets ipvs_property=1) -> dst_output -> ipvlan
>     -> skb_scrub_packet() -> ipvs_reset() clears the flag
>     -> ipvlan_process_v4_outbound() -> ip_local_out() -> LOCAL_OUT
>     -> IPVS sees ipvs_property=0, processes again -> infinite recursion
> 
> syzbot reported this as a stack overflow on a KASAN kernel where each
> level burns ~3.3 KB of stack and XMIT_RECURSION_LIMIT falls short. On
> non-KASAN kernels the dead-loop detector catches it and prints "Dead
> loop on virtual device", but traffic is still broken.
> 
> Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> Reported-by: syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2b120190d9e54ad8c65d
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

1. You need to copy IPVS maintainers on patches related to IPVS. Added
Julian.

2. Does it reproduce with commit 7f1de03e3103 ("net: reduce
XMIT_RECURSION_LIMIT under KASAN") in net-next?
