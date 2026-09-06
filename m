Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67538472
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707669; cv=fail; b=oHod8S3w38zMVuzLFKKRWnr+omCLe6OxfBlXfvvCJr1eIcXRZAh/9CTR/PF5YHzL6qBVcDbdGJfDLaQEPRT4O55oQE5CJ2wONv7kwKWXjbfz3roe11vctrexbwT1EBKKYyxdVu+yrkPd+lqc8fMXAjMbdB/GWn0Ue7lJgSd//m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707669; c=relaxed/simple;
	bh=nZYhR+16XFSt5iaiAVGTx4N64KhyLaQoRKuz1nSvRN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NUv9imfAJT4y1AN5ayUN6b7p6hCy3GKxOo7RrftjMBuj68XR7z9MX9Hy2ZvBzhHSMY7bnugsR+/z7DezNhw1OYm2Ldz7+8Nxm5VkKxrsEA3335ZSdkO35Utr1/pf1mASL6vZQeSdaAksCjAukFs14RC5wkceCWDm7AIan5gCP6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxExttsm; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxExttsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK102F94tOW277VoU9VLgejd0ZL+YPgSPB/Z8seGJwCstmCaJOzYSrBEr66ItOekKkyWvQlXmPnWllDHP944oKVnNn+ZW8mpuCJJuG0zl9MqoBRIgTXxTgar24CfN/z69Hbwi+Ag8yPrbRFOj5l6uFCx2C1c0T2pQxmgAdMp2XC3r5CLM8gzajVSGy3gfclf4l9e7ybmE1lyQbHmiz+7bEi1A0ZxA0n6T7HYBnk30YgAkHPhTJsGMh0nU80a8o/8xxBTfmVaf/2bmu25HOpsEmYyUKJjrj4dlAtY5o3cyIrfriEi9wKyQSHqRSoZEffNrNY4BawaImcwYxxT3m0qmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBDhupQ6Xo0ab2lwukIPhP72ryA7NEA9Xctn3I1ccFk=;
 b=q8u4aER0uuCNtWijNcyR5xoUaA+5rs7XmgdyfMvy3FOaQceJEVhxuu3dV46lTc+Yt6ZTx71rgpJP5xb7mn0BrATYFH4fTJyOM/VRZLWb+fulwlEMCnjOJnfQNLrhX5KZAZEmdpCfbFBtizzDn2oZP1c0PrpzInLRKyXymBW9NRMUFDojE1gk7QW0XOw4ZchOlG/k5ceMR6UsYgpCiTBdnbOr7VVpoPbNA63uB1TNKLDmplWdUBrB3mkmBuS0BbFakYTNjMeXTuLBIY8qjBSOpztznzMWqhNleTjRM+dMZAyJGzgzNx38IJSU5oRiQ1yFtJpx8MJos9YN1YjevVz+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBDhupQ6Xo0ab2lwukIPhP72ryA7NEA9Xctn3I1ccFk=;
 b=ZxExttsmgvGjj6UN3mUsM+gEGz9yaFM4of7fIPRCGDbYmwqk7YnPSz5zIhU3rWwng6xeibkCw8e4z+UgK41kkWztlOzTHuvGw10DxZTcWzAePgTDPMLzXSJBH5PESw7hCEuae68W5O84HQrqfi34ZcVSD/QCajJKx75ZlUQ/LrgsKJoJ6OZOD9jesPLWAc2cRC8BxrRaX1OoaqrUosT+iiD1L8lIRGy/m5CfJ8NucUDp8EpJ/3uaQgWowgYDVKEcPHHaK1l/sCLV5ZCVHgv+6HjA4O0pqtfYFv5CHaHIHkp1WzQFzUpVgty8vI33saOJeJ3iQ9HfLq8nlLOYvhgC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sun, 6 Sep
 2026 15:14:21 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 15:14:21 +0000
Date: Sun, 6 Sep 2026 18:14:10 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, iprintercanon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, tom@herbertland.com,
	vega@nebusec.ai, petalzu987@gmail.com
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <20260906151410.GA323313@shredder>
References: <cover.1788262122.git.petalzu987@gmail.com>
 <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 701a7f0e-5571-4c80-fdee-08df0c298777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jcvE/iV+FznNk1eNjKF3CKx3fW0KEy3HjzzaT5B825dfx8YmBK+5qcIkMNInPaarQF57xNs8WCGmHFuLlqBY+C36O/xMzFMliM1Q1s3OqYtBhXHsQqwhYzryDaKoh3obGm5hrB3g7eMa545UG5cmn+lysTYx+4ZOY0WmDuZBQJyd6EGUeltRx1F+tkTPYiC0DjHKzplrlu91MBgReGN6DEF6JWN2eXHmm92mbdBKdKVY/EifOiyfKZv9P/SEqZ6bU728nFyAljP3oHVyLWsYJm3EjiHIjuRIezftE35fXORDZwKVyrjttAx/NrQJ3KO47PASHTB52vJvIoi1mJ0LHMRyhZKvndFzeH8wblBsaJxe9QiDN/9Y0GcUsrjThHTayC5Bdy6c/BgrRVsZmwNNyVYz0YTmi749A0Z3UIK82HaJPT9AL5GQ17KCHNjGKpKugGZWfve1fnWbML9Ulk/p4WFz7P2uDN++ky8OWaaeu7udaP+H+t4sMBwzQbRrgSs62OKccGSi4bd5SmPOjyYA5NebCNcdpW0pBsF4q+PkFrSHvfvjQpRUZBZYBzIXCQ4Dv0hAWQxT4h5fbjL6nSgUF3SIect9tSQ6WMLyrNX7O3OGiYsQlctUJQhp3/9hswNHyOvC7h23YJy8TJXKwHPHI+oQBz6LTb9msVxBeQabxNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NcT/r0goJKIs17fgeknxcUk5hoBB3KsAFJFwGmcG8hCV5SRpA9mlhfEk9fwP?=
 =?us-ascii?Q?6GktDJsmt5V7oVyWEC/hV6sd+9OX32O4eztgenErr6y8jreZLRKCcG8ljZUc?=
 =?us-ascii?Q?wlEow4WnIA7CxK10k8yGd9hwQ06QyefvSSQe4eH2v7mESNMi8sHN7JQ2Aqgc?=
 =?us-ascii?Q?5ujqhWQKiAfNIi0cOGZYWB7kQbEv+U3hUstlp4yOXogVG7wfZgJWzMGbYqto?=
 =?us-ascii?Q?gJWWsJtDe6MVIsITvtKG4tx5S0LFKF4oILq4Jc+bS6nU0I+Gjo3rBFqrpSsJ?=
 =?us-ascii?Q?cpDDveAjbPFYlGsDZDzHEbvtbQJu2fLJKhO+KJYTT1ijOsk7+ikdL7zoeseQ?=
 =?us-ascii?Q?BNTThu1Yf5OEC6lx58en4eLWJYxnQ0ADK1eM6omxcvWK8NhLGn+TM2scrEj0?=
 =?us-ascii?Q?4pak3eIZAHtRhShmP48HlAHfg9vQBZS9ZwoZ4vmCYi9hsVKm43miHGJP0DLN?=
 =?us-ascii?Q?plTZRVIRJeECI6P3M1xZufjhQtH/+/Oyf0cOKZlHHappB9T05Wh/+rUaL5p6?=
 =?us-ascii?Q?7/0jLMsvbrRy58OPR3VZHB6heLhLgW8/k/RfpLOHpxKBq96Q5PVEmdV/253m?=
 =?us-ascii?Q?LaHmiebEfTYl4jRLkmBwuSV/8gyVesHIWRpxu9DCy3CUEAnewemPv6iWUtLo?=
 =?us-ascii?Q?2uVIXM0D5I9T8rsLozybhro5FTtuCnVQa0urG7q3HAGeCxw6mZkWcp1LHdtn?=
 =?us-ascii?Q?U9BB1s3gKWiiAusgYA9KHLfgb5+os/xpKOmkiM2ukj42BvF8hKP/009MUrSW?=
 =?us-ascii?Q?YZLfFrD3Wmhz6LJCEKmcLCW+7GafXHQ+YkCVUWNhRNuWhwQI52bpSgBsPTfi?=
 =?us-ascii?Q?T1Vj2zCNKoRc6dki7ygTqPhL74tZwz+b14E2htiqqgDiMXOf3Tkathruma2t?=
 =?us-ascii?Q?r9kBBYMAMQbshwOzr1/DAtZW1bpt+75LjoZSt/Y3MbZpWDtvP29ccNjML+uZ?=
 =?us-ascii?Q?2VXrLRmX/dupi1mDW32pCo1V6eoEBkSe9C365YMc+2sgSkRhsjYpEWgheBHI?=
 =?us-ascii?Q?H1dXHMW2yJFvEU2JpjXOd3w5WpiwCWKNl1dsWGSIMIoip2MvDfj3LtMCvkY8?=
 =?us-ascii?Q?328w2gkmWWihzS76wPu39CeZtxbBW1BV5ycCnAToHLAKVzEPc4xlc/6+ROko?=
 =?us-ascii?Q?PLYgnxP4vSMzEr4usurQTvdnfGocM73Ltd+IgMaPkZ6rIoi66q+stn0eykxi?=
 =?us-ascii?Q?/bHJtNmYBn0to3OLaqHe/OjNSrFibEdgqqbDu1svlsHUImjl3sjhyCNO6P5B?=
 =?us-ascii?Q?PfVijVd6DL0OqIVlFctF+ldxX8YkYdWKoTymWGZnRk0rFpa4+DO4T03O5z72?=
 =?us-ascii?Q?FLZKaZWAgU4EuvDVVhc3pgGeQM0Bn14BLvx65IjERAhprFu8skWIcvcLMFEJ?=
 =?us-ascii?Q?nz/tMDzwrOmDtCGunCBWa80qBgRFUUt1GVhRDmQy/Y880xk/7Y9LmAReNiIo?=
 =?us-ascii?Q?DIWxJveY4ecQa/0oEXz0e/wjK0RopA2CXfi1t1RhAyXCkqfAkou0I6pKhRmz?=
 =?us-ascii?Q?1q6ICRwJ04Zv66D+HKod9pbs4hoN2HeLgFOGfsxlndi4JDRttdZ5LXGef393?=
 =?us-ascii?Q?sGiGU0Ro3MF9Fj8mjhqWOo7wvLLHr3lLstR70vlxAdaUFyb38KG736J1LgoR?=
 =?us-ascii?Q?Iq5PoSj8yE7Bhz6es3knzlsHKIdYqGSy2OTJZtIHkLhi1IbsWAcNeX9CR+ZI?=
 =?us-ascii?Q?O4foplhmPWHPkqFH8URJRwnoZgiayXPHoeM+lB3iZh4tBDNK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701a7f0e-5571-4c80-fdee-08df0c298777
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 15:14:21.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJg89ti2Fx2y75t5hSiWp/oNsWknaZK6GMT7mU++5oulKRacle0wO/yQkqmuHvfJjjVIjnBtZ/8SS8Ge8RX3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

On Sat, Sep 05, 2026 at 06:01:36PM +0800, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> ip6_tnl_changelink() can update encapsulation parameters while the
> netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> headroom with t->encap_hlen and later build an encapsulation header from
> the live t->encap. A concurrent update can change the encapsulation
> header between these accesses and make skb_push() underflow the skb head.
> 
> Take a local snapshot of t->encap before calculating the encapsulation
> header length. Use that same snapshot for headroom accounting, metadata
> validation, and build_header(). This keeps all encapsulation decisions
> for an skb consistent even if changelink updates the live configuration.
> 
> Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

tl;dr - Some changes are needed for v5.

> ---
>  include/net/ip6_tunnel.h | 10 +++++-----
>  include/net/ip_tunnels.h | 10 ++++++++++
>  net/ipv6/ip6_tunnel.c    | 18 ++++++++++++++----
>  3 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
> index b99805ee2fd1..6e76e50a4406 100644
> --- a/include/net/ip6_tunnel.h
> +++ b/include/net/ip6_tunnel.h
> @@ -106,22 +106,22 @@ static inline int ip6_encap_hlen(struct ip_tunnel_encap *e)
>  	return hlen;
>  }
>  
> -static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip6_tnl *t,
> +static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip_tunnel_encap *e,
>  				u8 *protocol, struct flowi6 *fl6)
>  {
>  	const struct ip6_tnl_encap_ops *ops;
>  	int ret = -EINVAL;
>  
> -	if (t->encap.type == TUNNEL_ENCAP_NONE)
> +	if (e->type == TUNNEL_ENCAP_NONE)
>  		return 0;
>  
> -	if (t->encap.type >= MAX_IPTUN_ENCAP_OPS)
> +	if (e->type >= MAX_IPTUN_ENCAP_OPS)
>  		return -EINVAL;
>  
>  	rcu_read_lock();
> -	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
> +	ops = rcu_dereference(ip6tun_encaps[e->type]);
>  	if (likely(ops && ops->build_header))
> -		ret = ops->build_header(skb, &t->encap, protocol, fl6);
> +		ret = ops->build_header(skb, e, protocol, fl6);
>  	rcu_read_unlock();
>  
>  	return ret;
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7c9aadfe8fe3..ab217ddbeb20 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -522,6 +522,16 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
>  	return SKB_NOT_DROPPED_YET;
>  }
>  
> +static inline void
> +ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
> +			 const struct ip_tunnel_encap *src)
> +{
> +	dst->type = READ_ONCE(src->type);
> +	dst->flags = READ_ONCE(src->flags);
> +	dst->sport = READ_ONCE(src->sport);
> +	dst->dport = READ_ONCE(src->dport);
> +}

From Clashiko:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987%40gmail.com

"
The four READ_ONCE() loads set up a lockless read protocol for t->encap,
but the writer side stays unannotated.  Is the snapshot actually atomic
across the four fields?
"

Zixuan Chai, please drop the memset() from ip6_tnl_encap_setup() and add
WRITE_ONCE() annotations there to avoid KCSAN splats. Also, make it
clear in the commit message that the snapshot is not atomic and only
meant to make sure that there's enough headroom in the skb for the
headers that ip6_tnl_encap() is going to push.

"
The helper is added to the shared IPv4 tunnel header, but grep shows
only two files reference it: include/net/ip_tunnels.h (the definition)
and net/ipv6/ip6_tunnel.c (the sole caller). Should it live in
include/net/ip6_tunnel.h instead, next to its only user?
"

Mention in the commit message that the intention is to later use this
helper in the IPv4 code.

> +
>  static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
>  {
>  	const struct ip_tunnel_encap_ops *ops;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac01..6ca373d6205a 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1102,6 +1102,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  		 __u8 proto)
>  {
>  	struct ip6_tnl *t = netdev_priv(dev);
> +	struct ip_tunnel_encap ipencap;
>  	struct net *net = t->net;
>  	struct ipv6hdr *ipv6h;
>  	struct ipv6_tel_txoption opt;
> @@ -1109,10 +1110,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	struct net_device *tdev;
>  	int err_count, mtu;
>  	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
> -	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
> -	unsigned int max_headroom = psh_hlen;
> +	unsigned int max_headroom;
>  	__be16 payload_protocol;
>  	bool use_cache = false;
> +	unsigned int psh_hlen;
> +	int encap_hlen;
>  	u8 hop_limit;
>  	int err = -1;
>  
> @@ -1202,6 +1204,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  				     t->parms.name);
>  		goto tx_err_dst_release;
>  	}
> +
> +	ip_tunnel_encap_snapshot(&ipencap, &t->encap);
> +	encap_hlen = ip6_encap_hlen(&ipencap);
> +	if (unlikely(encap_hlen < 0))
> +		goto tx_err_dst_release;
> +	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
> +	max_headroom = psh_hlen;
> +
>  	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
>  	if (encap_limit >= 0) {
>  		max_headroom += 8;
> @@ -1240,7 +1250,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  		goto tx_err_dst_release;
>  
>  	if (t->parms.collect_md) {
> -		if (t->encap.type != TUNNEL_ENCAP_NONE)
> +		if (ipencap.type != TUNNEL_ENCAP_NONE)
>  			goto tx_err_dst_release;
>  	} else {
>  		if (use_cache && ndst)
> @@ -1264,7 +1274,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  			+ dst->header_len + t->hlen;
>  	ip_tunnel_adj_headroom(dev, max_headroom);

"
t->hlen is still read live here, and it is written with a plain store in
ip6_tnl_encap_setup() as t->hlen = t->encap_hlen + t->tun_hlen.  So
dev->needed_headroom is adjusted from a possibly half-updated value
while the encap length that sized skb_cow_head() came from the snapshot.
Should this read be covered by the same snapshot protocol the patch
introduces?
"

No. The snapshot is meant to make sure that we have enough headroom for
the headers that we are about to push and the patch achieves it.
