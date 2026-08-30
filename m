Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD725228D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788083581; cv=fail; b=MCqooLbxDtyY3j0ugEcwRhKWmbuBWZl5eTwiti8FzbJIumNFfJ6MLHC+ICgxa4n4vA2DT2/Rpe/afLFGDidhjt1aqS9Nb9pC4IUU1wOakuiqk5OUZIlv/e79L8zua/DpoNmB11KnfX7F+SoUJ7m81mf11mHrvMw832XdHgy4Aww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788083581; c=relaxed/simple;
	bh=gKq1IMNHr/VWDC+sla91/l6QVBF2DIEYqllc8bHTqqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqJF7rPBLhpzl8T0343/OpEhx1AGmIS+IBt1LsZYiOPYfbnbrblBcReu4jT01DMGVepBJZlclcEC6FlZGBOcYUINbjehUiccOdJ7DmNOkoUvs86cTlzG7o7dAhpotiWVW7iVJxy2TRqXnalj81IaHPsw27rumOY6Nvl4QFsfy1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNqmiMTc; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNqmiMTc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOM9sZ6w+ZNo2d0WQ5UzVTceHfLK9kzeR+H4ddRTeXewPeMm5FXXyiyuhmKEVSP7BBug2yAPLzaHsyZVS+TAmBFZw5REK+HU4oIBurLpVLvNkmLwR6UsdFlxZ+W8y1wSDj++i88JeApBzid/5XfnDPB/WYHcXTwBPaZCCwoq9dsn2S0IJBp2ElBKVzb1gOOuIkod2zIEu2wDB9lx10PYp93lrTgEsCK8e3tXYg0FXCzJzCcsYDDKjbLoa2RNY4rckhFnmRByi5zpQ9ex4Fy7HjQoA0tvCXawW3VmnNMQzCQ/Hc2vPBF643ZLJhVOWn9LUkfQZ8l0XGhW/BypS/B08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzF1YdaCbH0lg8o2AOD9RqK6hEjUqiz4NMnaFwtY58E=;
 b=CZ5gqaFeeDSpAuvJyAMh6kyglBomWVxXTABnGSurSWeKWfT0FlW0+ChbTX0xHnLn6VaWvK0dKi5Ntv9HLbLWMZPrpHThjzWxkEYFKSJnfWsew03rLzsCUtafAqciWkHyM4rBKGYKbWYw1L6NO61AeZnpt/abgMarvhA5cAgols7EzjbHxSZAIirY02AOK+158PctCUfdgg/SJ1Z/kATkI7pi25dUuXKGfbilhgU4h0IA0fOY0pFZWD6K7pEFUBpW7IIJA5rz9amyOePFWTgcTnedguSJ7k4Kwz4wGRywuLcCdp4VLF8+fQEJtkJKPKXxC83TnODdVeXWIkxJfHCreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzF1YdaCbH0lg8o2AOD9RqK6hEjUqiz4NMnaFwtY58E=;
 b=JNqmiMTc/2IrRF0QaTCrePd/k/9gZnl5/boZ287pwG8qmmcZmsMtjZXrd4VVn5pnazSoUpeaJMrFpu2E/9ltR/JZgiEVi/iieM7tjPwpAYYnUQPh7UW1FNvrCT4PGs6eCvL9bYzAZIzHFgYArNHRSpdgsXLgmdDjHUiglRvLaVhepTJmzzrxM7rHUi/Q3nA5QCQKBrO7LXwRfcCoOlTRrNhLYNP+ecN1wYSm5eHBJHvIpGRYZ6YTENge60sPTe/QcdOSSvJs22hv4NVHlDb9e1RkKkyws7sdPuB7AEYSsQk8i80tvxMZ//moGAz6Sgn6KDVZC/2Mwfz6lEP7rXTSsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Sun, 30 Aug
 2026 09:52:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 09:52:55 +0000
Date: Sun, 30 Aug 2026 12:52:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+3d99fb01bcd740f2fc1e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] igmp: convert struct ip_sf_list to RCU
Message-ID: <20260830095246.GA2771259@shredder>
References: <20260827160656.903003-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827160656.903003-1-edumazet@google.com>
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae5517c-6cfa-4cf8-8b97-08df067c772e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DWXYvjXpTv/rQRoV5bOgres4yEpxvrJolffJk9b2Z+vxQmvjgpucdjDHlu/4+Mhv+aYjiujLU2xl6sFJF5q9ld4mOumGJt5h6dsRzd9arMsfYsjDew7MdOMfoiM4Y7kyDHZ1A8s3R9tr3W5Z99S/u6G4te3GGi7tqHmGPHvfxlzyu63QkCt+otAGrL+UCoRwH6lGot+MpBs3XNQTCQQH8N85rGVExU/qnCglOlnL++Dc4ozJJj6zFZqKvA/p1a14vhYbUtEWDOewYF2/loo3eHREWWqONadj6CsT2cnICXcEygqN9r+NNdevFHqMmpMtYK4LgQeTbfBEGCqAaP3E2VEhUs1olbTKtnAd9SC9XqUvF4wIZ/CDP5GpwRlgUls5N6DSpZWSzquZoVWZtNNge9gtXcE28bd8NQ32mo3bL8d8T3cRbHT9SGu85XONURTq4Hzj/IFfGxxPqbP9OftqH3uHfp5JdML6BEop8RTAfOCsjnAdri8+hn5VW83SXumFFGqAxQN9zYDRmCGS9eI4/78wsCSSGqudk7786JSxYQUxE9OoKwcjlYJDZ2l0k7rvmgFF8QnyS9mQP5gZNzAocWivp0z/aDaXKH7+3MtIQ0CCndvIjGXRHYTa17s/G/BmRCcD4HE9tRXYR+UyZi2NUhTgFxjZS//z2rZcA46PqIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D+TWlDrOpSwfreUd6jKFTj28vXXfLaWVcfwXE8GXL4BPCyGjBT/lyGIUrWL4?=
 =?us-ascii?Q?Z1LIrvZUgeI2TqGipWgvd+62ABKfxVZrRQV1pKVhFgPEU0T5w2m3KOe+bnzL?=
 =?us-ascii?Q?OKQE1v/5AsbibUTE/loWIyZRhH6TP73YnKgk1mEv6ZWrV08Ko70K/sD3Cvrx?=
 =?us-ascii?Q?Pq/Yd/lec4E5i713hFnrf8+xFDHm5uYE89klSKrjgAUGkEIpxKxPWkij+xc9?=
 =?us-ascii?Q?b3KvP5eHYGHBlIF5ezyMb2DNeh/Y2hZ97UMTX+4JR8IpVxTqfqFwf1KRa8Kz?=
 =?us-ascii?Q?0tMfGXo66U1NAixsxbSRDyDoZXhVoxWHyMHtzm2z9sgEnV5Jz6qs12fKjyiH?=
 =?us-ascii?Q?5dWLsJ0PBk9GxzR5QcW297zaf8y4Kt3qWfEuYr3RsqemwCypFj1XIaueOLTs?=
 =?us-ascii?Q?S+2QMp8k2gc3FficmpblSdxitEtDf0xbxYOHRo/LYzyL/dxxJcvfl5AKIVk1?=
 =?us-ascii?Q?XnJMw7c4lDzQC43tQwc6YgjF4ypNiplQflQv5GpbFeY2Bku6/d/yDwuQCqg4?=
 =?us-ascii?Q?vDjg01DiPgWw+oyMM6RvxhmG400xeeBhD0aP1VDwpuVQ6J0K1DEIDTREkwwl?=
 =?us-ascii?Q?hHXfpv65sRcTK/ft5U1bb1pDARpoHmfTnMfDAkoA/9pqq00m0Hg/yrFjDw12?=
 =?us-ascii?Q?iwhQZxscC/pEy26RrJSfLM9KrmoxfYxvF4nfWtjXI2EAWTh4SSA7j10+LbsC?=
 =?us-ascii?Q?e29lDkkgOixCvONq4i7GIUynUuOzcjUpG9UAMTa3zVmOeHnJZ3leYmiW3wFJ?=
 =?us-ascii?Q?grf9EcoqBsJfcJ5JE6svLb59ToxSyiR3Q1ft6XKG/ScsVSXtAeMZfF8Usxjl?=
 =?us-ascii?Q?psFhCx0w0U/wMEoT/4tPjevL2HnhXgqZhfIiXdYCRdqBVauW/nLZdPFSQYuW?=
 =?us-ascii?Q?807tPayzmUDcH+wiThxnGj0YZfvQDKlgpePR9J4F5Jjyx4/2bWdPc5kSENNu?=
 =?us-ascii?Q?jLykLWZ5LJRsY0bjt7yQd4G5+kNcq0S56v38WZ/suUA13Q3YxhPyU5nViI+e?=
 =?us-ascii?Q?gQnIwUqzINwY1M/wV4yH0rMMsBA/StZF+BrY+UAFhy1BwOh2D4U66UCUIt5I?=
 =?us-ascii?Q?IJWcdVQxH/rr/OhPuOMugdFw5CQ4Y+/XfJWSA/EX/QdckwUfLIm/5MsqNu/f?=
 =?us-ascii?Q?sDmkvq7HELxsLln0h9kdLzu1JwYi/8IGgPgXDHfVLUvVITOI1ns/2KbNy2zD?=
 =?us-ascii?Q?FtAZToN8NguRl8UZCXJ57RfIjRbOMK+Rqns2UytwvHO7p875wMEzKMj0j/2L?=
 =?us-ascii?Q?CIFITm2VLJ4QTARJ/lrv2Bs/zEBGKG8IZaPOrMCV3LQyFLVtqIvOYmjCXo0j?=
 =?us-ascii?Q?91A6keBW4bxvU5/qGNMYwNY+reTjvvd/tG60x4GXpethlYrASkL6ZKHl8c2x?=
 =?us-ascii?Q?COuaJt74RdD1qfWKrdy2MtTs4bnMJYXI3CAOUX5aMEC4Xve3tfcV/7WO3uLK?=
 =?us-ascii?Q?4JXrDW69dj7miC7XweRTWY946Srx2jNxI5DwMaWvCyzq3HbKUFw93vLuIm8J?=
 =?us-ascii?Q?r1R34Noe6AzrzLrnes/5Y1Tua3/9zGCHlOpC+b2qW2cZh3mK0ldd/g2OJ+ir?=
 =?us-ascii?Q?+XpaxsWMLa4fC5PABp6hmg1prJ8ir+nDp0QAwJif6ow03aJRJQnDdNu+69in?=
 =?us-ascii?Q?i9JREkC2yxbcpQme7CecyrYeffsVjBJPNyaaJqFg9gReQywAtjXyUvEaM0Mb?=
 =?us-ascii?Q?1CmGLwDdMJIvMjebtwSf/oC64GOWXzQiVaMJlyzUbYB1tU3w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae5517c-6cfa-4cf8-8b97-08df067c772e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 09:52:55.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jm/ObOK7sZIzdlB7U1LPOdoMch+nWhzcDMKtqmRZlH0rzgEj19VzYCfw3PLqlDuPSK2yw/nNdRzYboUirOcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

On Thu, Aug 27, 2026 at 04:06:56PM +0000, Eric Dumazet wrote:
> Commit 23d2b94043ca ("igmp: Add ip_mc_list lock in ip_check_mc_rcu")
> added spin_lock_bh(&im->lock) to ip_check_mc_rcu() to prevent a
> use-after-free while iterating im->sources during concurrent deletions.
> 
> However, ip_check_mc_rcu() is called from RCU read-side critical
> sections in packet receive and route lookup fast paths (e.g.
> __mkroute_output(), ip_route_input_rcu(), and __udp4_lib_rcv()).
> 
> When igmpv3_send_cr() or igmpv3_send_report() holds &pmc->lock and
> calls add_grec() -> igmpv3_newpack() -> ip_route_output_ports(),
> an XFRM policy matching a multicast destination triggers
> xfrm_tmpl_resolve_one() -> xfrm4_get_saddr() -> __mkroute_output() ->
> ip_check_mc_rcu(). This attempts to acquire &im->lock while &pmc->lock
> is already held on the same CPU, triggering a lockdep recursive locking
> warning / deadlock.
> 
> Fix this by converting IPv4 struct ip_sf_list to RCU, mirroring the
> IPv6 implementation in net/ipv6/mcast.c:
> 
> 1. Add struct rcu_head to struct ip_sf_list and annotate sf_next,
>    sources, and tomb as __rcu pointers.
> 2. Use rcu_assign_pointer() and kfree_rcu() for list updates and
>    deletions.
> 3. Remove spin_lock_bh(&im->lock) from ip_check_mc_rcu() and traverse
>    im->sources locklessly with for_each_psf_rcu(), reading and writing
>    counter fields with READ_ONCE() and WRITE_ONCE().
> 
> Note: RCU conversion of /proc/net/mcfilter will be done in a
> separate patch.
> 
> Fixes: 23d2b94043ca ("igmp: Add ip_mc_list lock in ip_check_mc_rcu")
> Reported-by: syzbot+3d99fb01bcd740f2fc1e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3d99fb01bcd740f2fc1e
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> @@ -1228,11 +1254,12 @@ static void igmpv3_add_delrec(struct in_device *in_dev, struct ip_mc_list *im,
>  	if (pmc->sfmode == MCAST_INCLUDE) {
>  		struct ip_sf_list *psf;
>  
> +		for_each_psf_mclock(im, psf)
> +			psf->sf_crcount = pmc->crcount;
>  		pmc->tomb = im->tomb;
>  		pmc->sources = im->sources;

In case you need another version:

RCU_INIT_POINTER(pmc->tomb, pmc_dereference(im->tomb, im));
RCU_INIT_POINTER(pmc->sources,
		 pmc_dereference(im->sources, im));

> -		im->tomb = im->sources = NULL;
> -		for (psf = pmc->sources; psf; psf = psf->sf_next)
> -			psf->sf_crcount = pmc->crcount;
> +		RCU_INIT_POINTER(im->tomb, NULL);
> +		RCU_INIT_POINTER(im->sources, NULL);
>  	}
>  	spin_unlock_bh(&im->lock);

[...]

> @@ -2011,19 +2047,28 @@ static int ip_mc_del1_src(struct ip_mc_list *pmc, int sfmode,
>  
>  		/* no more filters for this source */
>  		if (psf_prev)
> -			psf_prev->sf_next = psf->sf_next;
> +			rcu_assign_pointer(psf_prev->sf_next,
> +					   pmc_dereference(psf->sf_next, pmc));
>  		else
> -			pmc->sources = psf->sf_next;
> +			rcu_assign_pointer(pmc->sources,
> +					   pmc_dereference(psf->sf_next, pmc));
>  #ifdef CONFIG_IP_MULTICAST
>  		if (psf->sf_oldin &&
>  		    !IGMP_V1_SEEN(in_dev) && !IGMP_V2_SEEN(in_dev)) {
> -			psf->sf_crcount = in_dev->mr_qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
> -			psf->sf_next = pmc->tomb;
> -			pmc->tomb = psf;
> -			rv = 1;
> -		} else
> +			struct ip_sf_list *dpsf = kmalloc_obj(*dpsf, GFP_ATOMIC);
> +
> +			if (dpsf) {
> +				*dpsf = *psf;
> +				dpsf->sf_crcount = in_dev->mr_qrv ?:
> +					READ_ONCE(net->ipv4.sysctl_igmp_qrv);
> +				rcu_assign_pointer(dpsf->sf_next,
> +						   pmc_dereference(pmc->tomb, pmc));
> +				rcu_assign_pointer(pmc->tomb, dpsf);
> +				rv = 1;
> +			}
> +		}
>  #endif
> -			kfree(psf);
> +		kfree_rcu(psf, rcu);
>  	}
>  	return rv;
>  }

The allocation can fail, but I don't see a better fix. I assume it's
done in that way for the reason mentioned in [1].

[1] https://lore.kernel.org/netdev/20260828084531.1826790-2-edumazet@google.com/
