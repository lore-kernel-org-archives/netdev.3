Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A593F54D2;
	Thu,  3 Sep 2026 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421233; cv=fail; b=c43QhuPYlraqhk9/iNYHy/WJGbu3qod5BbuOGwCgHjVOjuX9YrYRC9oWsbtKz9wscqK1adYp2hAP39gN/r+th15FZgnjDk2O6YJmUUz2y+WoFt7XhxdRZne5+cbaB0AMjUrE6VWu+ap+lbA3So7yOnbGvSMMwkRp7x1QP2qOopQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421233; c=relaxed/simple;
	bh=+ZCu/HgS5mhsvUsWrVSfB+utZlBDUgYo8Gl+mVgF4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUDSmYvyVlzbcSMXe+jsTT7y4WUN9ptX91RT1tAGreQC94IHfCo7D1E/3cNr+xtqEfxwNqDzhF5xiJif3uiJw3CxeFxfgBTe6yfPlwa+/h46E7sRvm5BBT6O6yGvEaKT6nAvLcKm4OQx/YRhPXa+Nn9HEs7iiVERbyDRvG4yexk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lBkS5ZiC; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBkS5ZiC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbeDtczdWRBRJLPFRfwgg9EvqiZ3fyQUK64/rhJ7EVBy9yK1gyHcMpIHVY7oETpq/8YTJvRCtPxQUYofJNFCqy30hCx2/H4L1p5Zv/BwY2MbBPIjJDMc9OdNYgg96y/5hHiWkK/HlMqAmpmCrKaM+TBiOUdktipEom6R3ikOE4CCFFU2FbG0NJCWllMAioiJxVxdS7+QtdGsACJioEj5qiFFJGvkBmmVGbFq0f3vQuV8+PTcDzql2hOX/jciiYr1U04tlvTdtqAy/oo1A78h23tRoZRtLN9smOkUeE30hZibMEkpzCkCnR2r2wVGC01VAiZifRTw60xChZh+M1uKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGTudcmA3E7IVnTtq6422NFiKk3aBW2llk/+m3/cYwE=;
 b=GDAUGamq1x+ndOKptZ1P7YHFqvOxUbl3GYGaSNhljrmf+RFgH65F2dwC4j67BoZIkgO1FMbXBnoDwtzJV0mJ8uTea+mWh/oa+rzVoL4go6S2PADZAdMGs1gNMxxujCJEHpKTirKhI+rLwef9Yzg3tYccZti2ROzbX8MfBNwDsv+QwUCaOcRtJQQvbN2Q06+AOk8UgWlWShnCIijw7Uokixcyq6q2JsPZjGYeImm3GgAh0ERT1a+HVgt/+14GcUAqeuaeCe5sB4eVOZs1yhr06BUduMNaKxZbEl8T72DH6suqAK6Z1tbvKhirRNFeDgcrQxHc/9WMHdYB4JW48Ivk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGTudcmA3E7IVnTtq6422NFiKk3aBW2llk/+m3/cYwE=;
 b=lBkS5ZiCLmRp18kFG8LdBMfQ8hjFxZb9UHhcCfyRIZKtguGYR7faY7Rrimmp/T1wiJflKPzNbAU3ANvbgIBlvVyLCvkG+b9LUnI7ucfKlYzPgoILvtbh5YNLlA+EXzJkYPNknmqIVPiWLALi53ZXVLNS8zrRaYakrXiRvJP9eqnqbhLKkj8YHrK3viW7Pvwk513rVNk3rbjLtmmcmCk+1LVcD7EA8Oq8ziGrMp6PcYk0IpCqdz8+HVN5jiQgUNbCEIekJksr01L/cYhqOE2C1tm+IecjYJZlJnhjtjXNtsc4v7cfy8Oxzgvu3LH/M2RYHyKnsY2/YFhC5Q9sXVA6vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:40:26 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:40:26 +0000
Date: Thu, 3 Sep 2026 10:40:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: AutonomousCodeSecurity@microsoft.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, kys@microsoft.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com,
	tgopinath@linux.microsoft.com, xmei5@asu.edu, janak@mpiric.us,
	shardul.b@mpiricsoftware.com, kalpanjani009@gmail.com
Subject: Re: [PATCH net] nexthop: initialize extack in nh_res_bucket_migrate()
Message-ID: <20260903074017.GA4171618@shredder>
References: <20260714104428.GA838500@shredder>
 <20260901094827.1236039-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901094827.1236039-1-kalpan.jani@mpiricsoftware.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 52374735-6093-490f-7dfc-08df098e9e9c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KZ1dDqTZr2wgByqw9hVwaHXjA8oviDX2vFUqOfvZY4WD2UsXqTXijIUyx2yL1/tmn2g0kFXIY3u0nq1wQ8XBRY1c8E2N5rdDFCW9GpvStSuhzz3st/dqv1rOvDgOjYTYLeIXzv2QDlgOOyP3s9bYTzcqveXsDLSxpFpJ00hhOcLVgF4W5YK2B7Z9C3l+xbXomsSbjCGDmMJ428CT0zcE4XVJ2f6X/UGN3y/Mwcekc6BG/2q/8MI4dqegsqQHeo8NgI7IDLTzW8G7VE6EzG4tjiRnzA3zQcCtsHILIV9F5EOTyG9hl9tC1BoqujNE+GJ+35VnP6k0RE0ZXJNgsZqWla8VWAW8Ed2WF080QIHNrlvmtf078UJL7x0p9usN47jq73fFLsgFM3DxNOrHBV5ajuIZet6rQ6BdmKmOrYkBStITbgMrnqQ8C/dGsQV0SqTfum7/3fnTeqUKBekfsa2OaZDqpt4hTn68ecvjSF/da4/5ZPl7pq2ymf+2x6kS1C1rrDMHKMInr1dC2q/YhYJI0x9L35a6bbVfAc4GsM2OZVlb0g7YMuExZ5V9X92O0lWtUJG3ZioU4SqRwrFwIFxWekUy95OhSifPNYL6XloJtmpTG99SPSCYbwdGqoOJl+1Z29bH1ow4LvaWChGe+WLB5GulEdYQFL1VcHzFOQtRp9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aM78mch6SMZrtcOCKefLVN/mRTDvy3PdVZ4liEdxrz1AtQHWNhbS1zyGSGAo?=
 =?us-ascii?Q?N+1LNA7Wcg+AV5s8dgzDrn3PRT9B8gYh4sqjhSDQ/vySjAGiEA1e48iEkGQI?=
 =?us-ascii?Q?7kI+/CP/RQiw1nWaIFHXIC7VNdbDkxdxeMcSMPgoeOcjS+Rur1XAyPKYicwl?=
 =?us-ascii?Q?uoxvZu5puv4vL37M/7Yc6rQ3ltKU5s+ZOjmj8GHwxuK22g0ZTAOHDcy69ish?=
 =?us-ascii?Q?S8SyWvN/TqTyiEeSN8pwoRUu6ebk4P+A7pJ9y1Gxyb2tEkCM2AGdF/NZiiST?=
 =?us-ascii?Q?CUHWjcFxYR/G/8kwzFbZhY6Dspjtea/W+qBxy19EtcVkp7HEQF/usRqNkoT0?=
 =?us-ascii?Q?3FYm3yL/AxOvD2l358IcQLHQ8YUjqipG+MzX+YsAr4Z9MkOnJs0yiGngZY9/?=
 =?us-ascii?Q?tEKHVVp8x00E+sFn0QA+HhZDyN8aTT26X+amh/MK125TBEFCWRuqrgMj2yrc?=
 =?us-ascii?Q?JeExHKvLu5M8ZdRkJYTN6QM5X2+jyVDwo1x5ebsJwqCYAxrsFVJoA9MRZrQz?=
 =?us-ascii?Q?dpytY1pTjZro61BK7IzSLAsPcJEencqUjQISYqqYWM37nX1YFzjyatWdgiHh?=
 =?us-ascii?Q?KvlirD71Da5emQ+7Rhrtl5gQcjGkrMjOhpmAmy0M4nHMEnotm57iTgtYOLIE?=
 =?us-ascii?Q?38pR9wfrkUxC43NC3RvG+WNlEXxNRFvN0VbsR96SXQk0mlboo1lPXrwZj3Hp?=
 =?us-ascii?Q?Q8iN0CRXCs6CmDZaAYXH4SuzCY/IJv0GoiLXxK8ORY1Vuz2QhoalnEUp/ZA9?=
 =?us-ascii?Q?mFcuhfShwdoK8r0ANxrohrJvdbfTU+bHoAIOoHMdHtYMGT3fqOkx0zTNjzVw?=
 =?us-ascii?Q?uwvQK4pzo6mMWDvyXRuUi1tfjjYxkZCxYdfZs/gdvi7x1fFlf7bs+SFlfrRO?=
 =?us-ascii?Q?gTK6pI0Goj0G1wpLSitxh8uUGEdOzt7M1Vm7snaINnK6t6dJSppYne4mEnpz?=
 =?us-ascii?Q?HmaLr0wxCHvmVP689T+b/xAMpWC+ggO8euHLHyg7iVHeEdFzoEo+a8BFIj1J?=
 =?us-ascii?Q?fg5uwCGlKBtnccs8KNWgTLE5LUUagg4UsIRQt8mNrqqIsMAL18t4cw6Ug014?=
 =?us-ascii?Q?MubxspQOcknjN5SrhlrXxTNaA38OTyQmdHvH44KC6UGgziikLirqSANClCl+?=
 =?us-ascii?Q?TOeEQHE/7rInFQBy1HQIJgHZ42sMJ9x2b56LaNijPUN7qLzFmLC92Qt9flK8?=
 =?us-ascii?Q?qGYuJxFxFjB2tzm+svaiM/nTDBvhK0YqQHiWQ/E5H/lX82BBT0NLXVaiNN+B?=
 =?us-ascii?Q?2m6Js6FNzVRJcobK45xfwwQEmBamcEPyaxa4oLQzOqrQvkdNu0EOuE6EbduM?=
 =?us-ascii?Q?9ccofuOhe8p7MOZgmRC/DMP9Ds5OEVKSdnctzzvl+GNe8zRENFnr+Zyf+Sby?=
 =?us-ascii?Q?xyhoxH9zYj2W1DAw4Zt41AzLKrE3Bo26wz11KSF2HhzskDgaNn41J/142EBq?=
 =?us-ascii?Q?uUo5uwI2K6PIRwP8uLQLmBBgxieP0k9W/kQuYd5ynPPa8dxcMjNAq7EHrCcX?=
 =?us-ascii?Q?dmkylqr1nGzryQC9qu5raXUTzJLrnTJ1NS9FEU6ULOvyDiFzITvzyncrZ7QA?=
 =?us-ascii?Q?IebnaOPuYLX6okU/iYoToNT2Uk68jBDuCUeD01zB0eCat54O7wRKfXkRodna?=
 =?us-ascii?Q?t9qt/qYJSLre4ppm/BBVaOzGlZCvly/oT6CdrIMJTwV+5+v4CkMzz5O+oOGZ?=
 =?us-ascii?Q?lCeTFnWjeWgyOSzcP914D0elgzmHzI3XjMQEBWmeO32wSPA8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52374735-6093-490f-7dfc-08df098e9e9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:40:26.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPcSKkByiy5WGtD6hWRfiiRRuMAv7aEscmtPBcZDUxamyGpwz6GomXEQRqcBaBV/Mu5JTXaQ6NclkpnKX3wW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

On Tue, Sep 01, 2026 at 03:18:27PM +0530, Kalpan Jani wrote:
> On Tue, Jul 14, 2026 at 01:44:28PM +0300, Ido Schimmel wrote:
> > remove_nh_grp_entry() also doesn't initialize extack, but
> > call_nexthop_notifiers() is using NL_SET_ERR_MSG(). Still, the same
> > problem can happen if a listener is returning an error without setting
> > extack. Please send a separate patch (targeted at net-next, no Fixes
> > tag) to make remove_nh_grp_entry() consistent with
> > nh_res_bucket_migrate().
> 
> Hi Ido,
> 
> Noticed this hasn't been picked up yet - happy to send that patch if
> nobody else is already on it. Will target net-next, no Fixes tag, and
> keep it consistent with your fix above.

I checked and this does need a Fixes tag. I will send a patch later
today.

Thanks
