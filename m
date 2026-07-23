Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64843C108B;
	Thu, 23 Jul 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834421; cv=fail; b=ooRrgnVGu/V9Fy+6Z+PruTnFAgN+YZIQVn1IphmAUHaZwvCNLjWGUdnoTtA4+Wb7g02Tgj2j+poc5ELXCCEjikkiwP3tkZTNtaFrD51TIy0OHKuBcAiwNBt38wafGYOTugcMLFKJgqw2a/iJS+jXTX5bTwvoImfP79xLpkxMfUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834421; c=relaxed/simple;
	bh=xr/t9P+okppGEPTX8UM1QPPEp/fPnKOB6wpno0pjLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWzX6HK9g0I0nLEy5upwOUtTG4ADCXy1QbSggfnoMYcqA+MuyY2r76faZk8WNQSUPZBcryI/LXKTlJ7xkkSaW6KSLEfOPGJUKpvcejn/NPf8hF79+ndFRrK4S6ZLrBEYAeRihwxw9oG0yHaFyw3yztBDECZdMciRoypkq45+eSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbWPl32K; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbWPl32K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAG+u0MZmD1Hy2bXF/40C8X4qxMWbDACIZeiR2F9Oc8QRD5R1NWbjWW64U33VepWqiBe+LtV6aUdarIc9w3kHd3ByHVu+2W1wIcaMWYokYqUbrMQOrnPmQxALLmHdUc418SNqbSQT16eYodtCY5wsKcuMj/j8oTLxeOXXln0AUg/M8g1nvnCVSkMbe/DOVXMfmQdNaZaBwId+N8TQ1s8fgFVMGNM5+gDaUgCQ7lFruBtauWRAcZ4ObaGelnGhjAn/TMdc7XLaZTuBw8JaMshe/CtoWmfd+YuFp+p9CBgbnsy79qiUcYKq2hjf/+LpSJDWxdoEPXP7y57fRNPbKYhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfs+/59ET4Mka+4F5y47nMjQyyP4TvxgQwGRPcu4BlY=;
 b=JZ4RwIC4KF0jSyB7HmTNfvpWS/79np2+jCWxrlrigKtkYDB+AOzFHECf+He+mXF2AujgvgGY34S6PxDlfTS5LGvt9Xys9+f79SUXlqTpZsxiv6YaGAhl3C+wuOaDfb7jarZhO5brYhbxIwaU5ZU5sDUOwxHK6vYFE4KpYtQzrRUNgAhpqg62tIyLlsROjxw8QlYVvqHothF+guEn1yJpYuqgeKZGmppalNQCzY8Dr8dFy3LhnxQURlJVkL+8+d95TB0E9C8497l1k9gzh4dcrQGIvN4lQIhqgQWeeLYAgTlDHJufUZNPj4SV83wjzBSOh5k2rgC0sny/5BZ/85E4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfs+/59ET4Mka+4F5y47nMjQyyP4TvxgQwGRPcu4BlY=;
 b=XbWPl32KJmf7FN1pe0y5rRQ5UCGb+LlHOyaG8eAYa8kgEnbHmfvTwGHiqcOb6Kn829jwbwTbCgE2cX9R64MZc3B6tDkvDBEB0Un5FW1zp+Ceqlapail9L8t81W3ewT4W18bDEUa5cC2nj6sD1xtUf5Iyvos3rYQra83yuYKa+YJb2cOvHXmbY575r6bEFojuhfOMe1JE0IPLfn8y+9+GsnqnZhtjTw3X/D10b88a0UtgjJFY7qGvett21/BxjgRhB4Y9841MXH/BNFAFWzIovq0gqDRpjuYZe3HDmGCoQzjK9F+KWrxVhXY/gvHpVamEgfB9MFWmvjOz49g0CNsLiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 19:20:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 19:20:10 +0000
Date: Thu, 23 Jul 2026 22:19:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net 1/2] nexthop: take nh->lock for f6i_list walks in
 replace check and notify
Message-ID: <20260723191959.GA3531265@shredder>
References: <20260722002951.2614721-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722002951.2614721-1-xmei5@asu.edu>
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b7aa3b-cb45-431d-26b8-08dee8ef697a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	73paRACGX3TJnBKHVKf+bK6M+sJsRzKSmeC1xOctPGg1crK/wZL4/FRTVKUWjuQSnCOOTQetC+nm2VZuDNeB7NxoCuH9tmocPTQiREL8hh49XSArVr1nkO3Kw011p37HLoG1gnOgwkt6ijw8ALIBe4Q1JRmtXCouEM24ovV69xfy3yfwvxlmFq843zS6BwNvirnUu9vZlmUmtlMGKkhUbd4VbcvtO3CQqxR81CFkw/vPLJBZ0FRSrkXzcq1u91X7anuIEzvbmhvBXn6caIDIWdTtAiIcNTdepnNUZv9VRRWYzBhyZeMaFlz1ZHJ6zMVj8NH9K8TEzOucY5qpVfdd5QD82HzbvjIrPg7cjNmu+EytbQy1h6c6m0WixsQ83xHYc8tX0UOR9E71FTyAkmqnSwkyPJaJijx5Z7X7TNr1g0ND4IPe74dwXYblMcACcx2Spe8FyeirGBEML44lxVP0vhPDlQnEwLHxnZ/ppi15IxC6kOZfNbPNPv2asknqLXyLXsi0MmFiykut5oMcWShSS7GQ4YQkdza0QKZs8Fw4jwmP80kGbU3Sq1ltLQodZyfya0NJ3RXZ3+lQdLaq2zyltuEzbp+/eM0upa0/6GrB4EoYfBatdLVrT/c2FMB2A/ZaXkGT5/hLc0Cz3pUQy2NF/Ga74fWDoif7TovNuQLWh8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gSGqR7HQ5vAfq+4Axli71JgzsI2h6bV8Aqd3mv/YcazHVz2DZ4AD34uoPaia?=
 =?us-ascii?Q?IKgfuUPOgwZn/ADu5DPSNa1akqOxcqe28Q9eyEJy7+fheyiOKh1QodCKnyQc?=
 =?us-ascii?Q?2zAS5nORBYARqgxwv90qxhBXTuOEbiAO+hQr4uBFuxZg6HJTJgi4oZWwD2AA?=
 =?us-ascii?Q?W9Jd6nyMkvUuWXlEVoCflNeWvr2V3jzJO/NDD1Dt2RQWr8U9RcQS8iOXZX5B?=
 =?us-ascii?Q?dsgEy/iXkoUhDBENjbxTuBGL6tQLbzkb8YSI5QhjgmWMa0OF0SBwXOEH6pMV?=
 =?us-ascii?Q?mehgyWeWnIM0MzSbD0fRZ4PfoX7ZjolUiAd3RZmU8pOF2zoFSulvc0aORy2A?=
 =?us-ascii?Q?tRZ0vzwKLtr+TpOxFXgDfNeP7v/fcg2c485VRec26DCD7C1TXp5RqDccGarg?=
 =?us-ascii?Q?Mu6toDjV+6293zc6ZOrMU6cGtaskRpH06QlC6ehgdlUKNa2qibvybZ+BsBqF?=
 =?us-ascii?Q?E+T+GcNx6tXYi3zaSn2tDqfM52/964W13BSyOs1ML8slVbtWRq8CZ9bZ+e4M?=
 =?us-ascii?Q?KrbWfaZN+fwU+5PxM/6AgGvOG27+G06cDIeUejgYKfDZVaut08Gu/hr6A1Nm?=
 =?us-ascii?Q?4JotXsOnhSvRF9TCWZG3jQFe6yaThdmEnif0qZaLu4BZmvnDTNumy9/UoBAF?=
 =?us-ascii?Q?CUb5EqLWteAQaJeG0idMF8eYEnT520TiYTJo6sg8kBa3/0C+mHPRfCixjx4X?=
 =?us-ascii?Q?mCDB52lGUqI2fypHu5x35kjLYzQCV01+8MytFa/c7U+n8HxPjkr+NL6xL3f3?=
 =?us-ascii?Q?62jBObkz2Z1BUT5va0q/5pHbg6SYmWPAxi1PZS65/61dncuawmQBHjlGjXxf?=
 =?us-ascii?Q?OXKgdaRrOsceyUkWgoAsXbr9FTNiGKsFNuJtgXph1tAWBbosPao/L8f8rjAj?=
 =?us-ascii?Q?szTzCVj4p12/yPxYvm91ii9BuOVzzqOMIeOjh6znrwAAotduMN0LQHB+Gu9V?=
 =?us-ascii?Q?aQWU+ar2It+zT5Et3b7skmd5foKqcCUeOu2Qu2XNq7C61IAj1xv/Z2tAj3qu?=
 =?us-ascii?Q?3XeNoH0VOWE7vseWaL68vzlEJpBWeKlPFdlaQGdpIRYx75/q/nss6lqMw7YZ?=
 =?us-ascii?Q?1c86XIi5DTULWh94XDPeNYAUjelsIhR8eyGRTFzrFEc3M60GSIbnz54Jw8UN?=
 =?us-ascii?Q?uPH3FLeFX7drL+Rizfu/Wvo1skn9C1oXmhcy4CLzlw8AYRnl7d2+7CaaocVt?=
 =?us-ascii?Q?0cIyi3gtQ9+kdEq7TyOgGLpGXamKL3jV7AXF6kekq8w+aj3n2hI6q1thKM/Y?=
 =?us-ascii?Q?+/Eo8IqKlecwfCap9+3+yoN5gnUjlNw33weluVu0XIrw0Fp35VLXi6wl5iQG?=
 =?us-ascii?Q?3AAfyRdbXe/N3AMHFi1VWseLUBpu2AD/mO4LFq9gH4X8hy/Pznp90vymScED?=
 =?us-ascii?Q?1PYjm8yEx6VGp51jwnc6i8FPP2KhaLnSbwoWFVDMaY6eGTWV1jysmRCVey70?=
 =?us-ascii?Q?i8/XhusSTCqbh6WJEpfaWGTcl1NWOcEtLQG+EwsNonPgbNtaU/qUJO73dgXa?=
 =?us-ascii?Q?Uy3vgE3bpZse5jaBkITkRrUuj+ruXVbK9lSAHu2IT6dm+97tHpoUqB7Ijhch?=
 =?us-ascii?Q?H6JYidlzAWoHPT5ElsXI4xwz+bMObwiAQv63w0+y4RAN+ZFQCscAmOe3TGhD?=
 =?us-ascii?Q?36yNMoa1kl7toJ9kGDxt3RrIhjoHMvEi0JeYQPQOMHtC1DHKIVkUbui6uqoK?=
 =?us-ascii?Q?96Y6gkkn4xCicw+JJJ75HodTreVOEWA7SgoSuBJJW/Kk+MRIAsfZ3kPbWjL0?=
 =?us-ascii?Q?7sAac8HMeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7aa3b-cb45-431d-26b8-08dee8ef697a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:20:09.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8NfkKUs+Fp8TedDjiMPPYyFhWAvOqAsUfoYEtTYBPS81h8LtyspMjLT3prweiFnzTVdKMjDgl6n8AeCjBHScg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

On Wed, Jul 22, 2026 at 12:29:50AM +0000, Xiang Mei (Microsoft) wrote:
> fib6_check_nh_list() and __nexthop_replace_notify() walk nh->f6i_list
> during an RTNL-serialized nexthop replace without holding nh->lock. IPv6
> RTM_NEWROUTE/RTM_DELROUTE run without RTNL and mutate that list under
> nh->lock (fib6_add_rt2node_nh(), fib6_purge_rt()), so both walks race a
> concurrent route delete that unlinks and frees a fib6_info:
> 
>   BUG: KASAN: slab-use-after-free in rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
>   Read of size 4 at addr ffff888014607e64 by task exploit/143
>    rt6_fill_node.isra.0 (net/ipv6/route.c:5799)
>    fib6_rt_update (net/ipv6/route.c:6412)
>    __nexthop_replace_notify (net/ipv4/nexthop.c:2542)
>    rtm_new_nexthop (net/ipv4/nexthop.c:2554)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
> 
>   BUG: KASAN: slab-use-after-free in fib6_check_nh_list (net/ipv4/nexthop.c:1605)
>   Read of size 8 at addr ffff888014a7d068 by task exploit/142
>    fib6_check_nh_list (net/ipv4/nexthop.c:1605)
>    rtm_new_nexthop (net/ipv4/nexthop.c:2575)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
> 
> Both walks only read the entries and take no tb6_lock, so protect them
> with nh->lock; fib6_rt_update() uses gfp_any(), which returns GFP_ATOMIC
> under the lock.
> 
> Fixes: 081efd18326e ("ipv6: Protect nh->f6i_list with spinlock and flag.")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/ipv4/nexthop.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 6205bd57aa85..c1d3b7d7100d 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -1597,14 +1597,21 @@ static int fib6_check_nh_list(struct nexthop *old, struct nexthop *new,
>  			      struct netlink_ext_ack *extack)
>  {
>  	struct fib6_info *f6i;
> +	int err = 0;
>  
>  	if (list_empty(&old->f6i_list))
>  		return 0;
>  
> +	spin_lock_bh(&old->lock);
>  	list_for_each_entry(f6i, &old->f6i_list, nh_list) {
> -		if (check_src_addr(&f6i->fib6_src.addr, extack) < 0)
> -			return -EINVAL;
> +		err = check_src_addr(&f6i->fib6_src.addr, extack);
> +		if (err)
> +			break;
>  	}
> +	spin_unlock_bh(&old->lock);
> +
> +	if (err)
> +		return err;
>  
>  	return fib6_check_nexthop(new, NULL, extack);
>  }
> @@ -2538,8 +2545,10 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
>  			fi->nh_updated = false;
>  	}
>  
> +	spin_lock_bh(&nh->lock);
>  	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
>  		fib6_rt_update(net, f6i, info);
> +	spin_unlock_bh(&nh->lock);

I read the feedback from Sashiko, but even if we convert this list to
RCU we would need GFP_ATOMIC. I don't find __nexthop_replace_notify()
too interesting given that modern systems unset
net.ipv4.nexthop_compat_mode, which means that this function is never
called.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

>  }
>  
>  /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
> -- 
> 2.43.0
> 
