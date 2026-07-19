Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B7153BE9;
	Sun, 19 Jul 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465723; cv=fail; b=GIwM3nVnuEx3RkUx4T0Kl1jax4rLPtMrVNDMNCyJ62OLPUmTNDazqeLyBMhGb3kiBjbwF2oufkLhRO1a3lSgxAUFrLcx7eAzVK6OW3Qe5Q3VZ0UAlgMuUFT85umzMmrEGpM1qtaRfPBQ1aAwAGDvsfPc47NR+qSC+PgTAHEIXqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465723; c=relaxed/simple;
	bh=CQ1z0vMS6aPkm26Y5bLMuz8sUoqN8fR/sbDmTl5lKiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/L2KzNUxk+WkL+pu08izKT48xtoniRCIp8C6bt6frmso8coZLAWBwhPMF211SuBigMgRaZPqeynydeN1sMB0WRgL/6M0SoKs9WNC7ksd7w6za6e84Xl0YlH2MNf1UqTwkfT3Em4Zt9KwfXpgkLx7Zk0SgaOXcDo57PdSLUDAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFG94xBb; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFG94xBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4n6XKG5XEuXW50PIK1136P1CtbnQB1EgroLMyqonpUZ/g5H5vhYpQ95pA8Yx/Clps6z7QeZGj9U9nmzNcxuniPyFrqYR6IjgPSW9c0SyQZAFAU1BvxnXDuafsobUDYnGrbM77s5uOHpCS6rICpl7k7iXcdHld+otHXivdkOnddI+GvnuYAnDxy0u43sZwJpZL6VDMHuqLdg8dRGbfE6ACKXCsGQovFrM5VA9Q0+y2tHkX89+ej5kfJD5V9x+W828F0FlP2vjtYp5kOgDsST9HCw8ZsK8AU/MULqb4TURzffVYn1byo5dHlmN2de0VMo4lc6AjbPWquE9w0oXMC3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iBGOSHofKkKlqMczsg5nflN73ZtJbV+rYbQ6lwrrk8=;
 b=om/x64ISL7DQ/Q2MT1kiS58XdEyHmHV9CjAnvY1dJbXsm5xiBuwV3zT2mQnVTXch07ofOo4dG6p8YTzk8PmGzE2BUYJWd0aEajHQgqUzIfkUZV2IQ9HnTqXCqPfTmYC2Alb0fkL+HWXLjVbhVp1yXGuQZrzWdynwDHuqdvFIR0KPA5UqHXD1L3pWnxK7C9BzK36ReyP64xCPhqhACzz2LMaJeYdtmBc3+K+pNdFFQTNaJ6XcYE27W5/XX3jStRXnP2QvVX8uc1kQj96rf3ZgGbmXYZpHogGXwksPZ5eUc5V/Apvxsuh0iyJdmQynGJkR5RmyLdUm8yWPuWOYNO05CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iBGOSHofKkKlqMczsg5nflN73ZtJbV+rYbQ6lwrrk8=;
 b=XFG94xBbWjgqzdpKqZgeYoRQWbQ2MZ3Uj16CKj/ArnDX/mfGt1OTXaF7i0UozOUDM8ZwLYDlMLGNEiNpOVmj25i0DKOL0/4V5/WpaCoHp51LoomCp4YvUkE4IdILp1mxBbjxOanyjBDwlZbKkH+HNagLXlCnndc/AzQtf72hCJigq1Dm0aJE3m50T2h2NNgt/zSy/PsrpGCKS/Yh4fB0d/TkDDOtK7D+lnZ4/XxagD0ttw+QFjVQ6PrxK0/ydL99fxoEESh0XHYIYd/MtxQEQZm/wFV8Yh9z8Uayl1cIkztaQirPn5JJpfxTB1f/GGNCFnOu7Ep4gupi7mx/Xt1HOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sun, 19 Jul
 2026 12:55:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 12:55:17 +0000
Date: Sun, 19 Jul 2026 15:55:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipv6: Change allocation flags to match rcu_read_lock
 section requirements
Message-ID: <20260719125507.GA2005035@shredder>
References: <20260719105759.558050-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719105759.558050-1-zlatistiv@gmail.com>
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a2c2f8-424d-48b4-bfad-08dee594fb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	U9VohrMiQDQ+vtTw/9MMUwAdf82Agmfdd3qOdwGHWWy9oeHWJunnYWFZrBsg0UNAko87vhFnrpxxmRJvQkRLyymjqRNJZKRbseFiFdS4hOlqZdLCUWgreuI4fuudpWnt6/HKy8xl+v+GQce3WjemEWXI6+xRjZD76w1n99c/T5cdPOm7VhIPwhqQCAVrYR030C5Q165wQGBo15BycYxUrWs2/IboRl4n2uv585IL240TAiKrV9B1roM/dy9w8uKwxf4mO1B8MDrs0v/TQl0973CsJhUKSL635p92dDSiIlQKNZB6+82Ygh5K/fTjUwP0djI+JTansXOXrVDtoJ4j7Qb7ba2YNJ6BGeJJBmONjTXOYCocegVtrxkFwASU4WCPgCikw38J/Gv8OTixuyq03FhO5CBut6cfvGXOGEsVcQBfFmSB0hjRJPBRCtQvVDMnt4qHVNafUgSh2hsM03sGF/iuItLdMwtUnRi/d8+27sy4V74Y4jx7X7EwwXcStRqaFP9tr3kfn7jzByIip0fTPmUMDNi1RDTNyOkvwhTPM0FxuMFveKsWxHC5pMuMuUlbxyFMTD8MTBrDK88/Sbr6HEtdQmfl8P429nlSDWt1cfFRCS/VDU4+A8LwAjHbzLnXntasN186A5B0pEbLD9Gy4OuuxymMOKRB+dJosNqU2OI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypBSXR1PM7eMVdA1aHibaXPDdoZJ2uqWmkDPatT+OBlbObyPJPm4CTjo0wg8?=
 =?us-ascii?Q?ihwaHB4iwKL1LROEyEClQno7Hf/Ft84hGc+4THNXHEVjUG8SziqBz+ozNTsg?=
 =?us-ascii?Q?JZqNsqJePYQ4l9EaaN/nBfxjOs+Koigd4zxTOKAcetSUKOh4gEFh6LutBWx8?=
 =?us-ascii?Q?vaS+fHiW1stwKOzSRADTdXKLGao95sGg8iuhPrG+ufxEMvds/1R6CQVZJHw1?=
 =?us-ascii?Q?/P4xAIWQOumnuGQ0xE2VyNI0vGwhsvEOjKEoAZQSc6WMBvJW0p3btjKSwZz7?=
 =?us-ascii?Q?c4vXcahswZjuCsqhxVmtYyQrLVBeqJk8IaIMKbpViarW3DhEHIZI2D2tNGv9?=
 =?us-ascii?Q?GMK6g4W/jFPXWhR9B5Vsu01AGTbUq2hKLLQKYEkl5lfbvDWBpn+1/b6n9SBx?=
 =?us-ascii?Q?3ppV78ZmKI7g83zZvOOzsTFyvUtyH1e2FgNSea4W4IR+nltq+FsDu2KN/fj8?=
 =?us-ascii?Q?KE9VO0DZSYG8qkbHVDohavop3Xrw/8llTLUUsGduwcF4cYnIGCslDsBt/1D1?=
 =?us-ascii?Q?I8V1C+ZFdfSgWSPEFDXttfdk2qJIgDOQNVMdioIs/dBXMa1539KfNiYoqlMG?=
 =?us-ascii?Q?s78IltWTHGYohL+k7PAE/kQ0okbJtkUZTc/rqCvaBF9DidNHG9IvgQaYpDQN?=
 =?us-ascii?Q?60NAWeVSTP+i+TNoV5YhWE4qC2aR7wXDZqW3HlBivLXndLyQwVNjY3CFkdA0?=
 =?us-ascii?Q?aJIyVcLTmNeYhg3EW9BV9KYw0aPqbRymwAqZK3gEV4SMwr/YzUxBSDP238XR?=
 =?us-ascii?Q?o/TTkUdAeUxvTHgFPe/iZNmjOjesflaalDJ3BFEBgePnELOsdf19yxz9fLVL?=
 =?us-ascii?Q?xAnS1+jPqULs+ogdJqWCMettTLf6AcGsdo5zSNoWZ/dDs9tcGprDndGWZ5hQ?=
 =?us-ascii?Q?8elII2XgfHNBgUJYRmFtefWIt6piDa4LparluHmrSRAR9vxfQakE+zy1CxO0?=
 =?us-ascii?Q?gOHSZiYilHAQjuoy3KPmSXCSU+muTJwLNaFdO4ofdL8AvFzzTKVwuIvMNydB?=
 =?us-ascii?Q?MGE0wH2o35UaVVtbgl/qLoqctI322qL45IWiqW2HbMOvfEaAbm+T7qgiiAqW?=
 =?us-ascii?Q?RFe2qX0oxQw5lBHd/wnFbIGQnl+8HdHGNR7DE3Rakhhp69P+CSotpUalLT4C?=
 =?us-ascii?Q?6768C73hcLbOuN6HOGFehq1GmOTBjjklojM52bV9gurlIRW4TxH/vPGEQXfm?=
 =?us-ascii?Q?k4exiZSSyqIqXxpXfL3lI82zRMpoPsiSKgjf4ASAcQ9r6syje0B4dGFrGkCq?=
 =?us-ascii?Q?Ehmc6tWoIIW5OJzWybtS2XGTdy91MJraJ+x5tg7WElzvbHMOdZ6msHuGO1w0?=
 =?us-ascii?Q?0eHc32Q6io5WcucNeav3tHpz0uyoEn7idp+DhbDkHgkfz0BHCD+zGm3QDs21?=
 =?us-ascii?Q?FEK3HwDMNBH+EBMHH15WoIv0nTGWbzxBoviZozmk45Ypq8+PiDq+QEIVtcQA?=
 =?us-ascii?Q?dlZt/E3bzAQEVCFbNihnhabVrDOACVqso0FNXM/7Wfwe6mvZQQ1WfSLH+IY3?=
 =?us-ascii?Q?PiqSQN9rgVxLMdGJDzNvFtfB5HYxENQrWsymPcrYRJvdJEaBbXfaMaAjsJiC?=
 =?us-ascii?Q?4QfaUoHMRMmpq8mD0cgZ/4nbo20rUhYf2qxn6Y91CExGmoVvVHMaZBBvwWD9?=
 =?us-ascii?Q?KJAlCt1bvrBqCGVguTkxuexqmgXwRV0m+gWezUkTHWDzyw66fMXSi4cEocgu?=
 =?us-ascii?Q?EZd6lCQ3dwrph1o9ofkXS+6jULCEb3nnubf0e35UF7wU1UnQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a2c2f8-424d-48b4-bfad-08dee594fb5f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:55:17.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8Wn6bM1jMyxhVMnq6J61OrzZC5IPpNmV2E//WyhQr7HAjQQcYiv2ibfrbereTExGr0+kL3/tfVbqU+5H8U4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670

On Sun, Jul 19, 2026 at 01:57:59PM +0300, Nikola Z. Ivanov wrote:
> Since the call to __ip6_del_rt_siblings has been converted under
> rcu read lock and it only has one call point
> we should no longer block or yield.
> 
> Our stack trace from the syzbot reproducer looks as follows:
> 
> __ip6_del_rt_siblings
>   rtnl_notify (Here we pass gfp_any() -> GFP_KERNEL)
>     nlmsg_notify
>       nlmsg_multicast
>         nlmsg_multicast_filtered
>           netlink_broadcast_filtered (GFP_KERNEL passed from earlier)
> 
> netlink_broadcast_filtered can yield if GFP_KERNEL
> is passed, which we do not want to happen.
> 
> Fix this by changing the allocation flag of rtnl_notify.
> 
> Also change the flag passed to nlmsg_new. Even though it
> is not related to the syzbot generated bug it still falls
> under the same requirements.

I believe that the nlmsg_new() change is a no-op given that gfp_any()
evaluates to GFP_ATOMIC under spin_lock_bh(), but it makes
__ip6_del_rt_siblings() consistent with inet6_rt_notify() which already
uses GFP_ATOMIC for both nlmsg_new() and rtnl_notify().

> 
> Reported-by: syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=84d4a405ed798b40c96d
> Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
