Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F839EB47
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316360; cv=fail; b=PL8iS+HJJufGVrS19qk+Qn1LCdShYE+oqOuwve5elXhOulMDh6cbwzkUiS76l6PpSFTipJczHy3jgYHMDhCuVVFygL9lY/16vntp9JNfVCHxsv1yD1WVM9GbAtwUWYFTe3CVI85TitoK5mYQ8PYWgQgtpO+ITo2JqWASf76h4+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316360; c=relaxed/simple;
	bh=SwmP3gZde3lAqQjcWl1ZoPsLTyyjuJtM9sdAuehATmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XVyEsVwEL1SOAScgFQ+nRSUVy6aRXQGhrlY28QTqXEd2+RWvfBSfeChCtLMKksipr9jM2nfWN3blUPlAeoNO/jsDrYljBDF7eS7mCzTvntUFqjG5gYWNkgd5Vcg5btE9+HM1SQ6ToIx6CfNwJaUHWJWzgT5TFvYqfd/2qLv20aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ng8Z3+95; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ng8Z3+95"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXe1RQSTGf3QbM/auyOluwkn5lcBL3q72SlJNrntr6KEiRVAX7fYAZ0PFnef4fGlpV35UF1XS6cTi/3Y3442qNnPhXSELK+SYGUJv+IR8gaNt5prsx8DO8AyRuvIiiaq7hxj3XnFm/X7RBXw4dg8pmOTZFl/dwrVS/JADuUSqPj5vZEnvYuY8FyFsOeKWDoq64OqgD/e5ODJ/e8L4BHjZjUbEBOnDSr/Aa/6kwcKfFBA3WGaLIDOm9w/KWtWEeZZGAQ+EWMeK1dWui6KkQITXInDbUx8d/p3bqtegWjXFIK8MriUFGkpPr4fFFPOrVFdXfitBgSi5Wy2pJA9809zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C3LtNLVNJVoJ5AKQCWQtKmbRHD6UjmujOwipeAuoyI=;
 b=yLIgpuJiqbZ1hg4eciq822eUHN8BQMqTG9X1l6IHnkxnwRQRGvdSZEkN9k/bD9hArA/7le8U7CA0Vj/cK7v7Am+rX4jI/WVpzk49MLC3HKpTq3QogBOoLEysrfPIuTuzq3Nqnsi86lGlTcGHJjo8P2gJNKIMkCyVu0dbkx51IVhdeiM4RDPWzSM2CUVqjv6IINLDzDZcUQuSEvcLKn0UEhDMpTBqPJrA8csQmRLXP1pDZiddOYKnQUrbCot7R57U6kOcIWPleFbeG/3EtdZe6869sDG/p62f+xJU8uAsHLFXVnXzS9NlwjCCREnqSH94BfivdpcELYuYxSmcoBgdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C3LtNLVNJVoJ5AKQCWQtKmbRHD6UjmujOwipeAuoyI=;
 b=Ng8Z3+95HRVSuqWC1wH91KhkNrzCJmzaKmlLO5DiIpkfXZ0u52OLhC1Sezuq/zievXsjppPZ8u0kiM4PVm2xC9T3odPGGPTPfa5nwsweslwkgdnK55+bDmzRa8P9Y1hBMyMqcLCOizF2I7n2Rybv1jUT0zYisIOjksLD8l3vsQxOfJHCdm2Vyk4SAECGq783GHmiuJ1h6yag4Sk1hpIb5zlhdxhjUcfKwM5phz7Ep6N60Nv+tlK29xE5Xb0jmnBNWguvfCLUrAzjm91YH6BAs/F5lULSSmlZmyR31mYJC/TnKkLKrTJ89mjqezO1WkcOFbddRZ59Wj0UjqB6FwGGpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:12:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:12:35 +0000
Date: Wed, 29 Jul 2026 12:12:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	leone4fernando@gmail.com, vega@nebusec.ai, zhilinz@nebusec.ai
Subject: Re: [PATCH net 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260729091227.GA1258429@shredder>
References: <cover.1784894076.git.zhilinz@nebusec.ai>
 <5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0957ed-78ae-467a-13d2-08deed51876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	INd0u+JVB1FFgjLkK3my+L1d8Fgl/2g0b3YYiKnVTwLijjgaKiDu/7+B7wgeybTK7ESLrRfyTfzbaapH5zmvMZYxIXB++ef8JqVdgNXFQ43aXapO+KlCdCx6RejPjAXzZ8qs5pO5iuQMBaGEobHy6oiUVbtznNCgZ6yxLXdT/rnSYmXIO3ylLCwxFa1wLbOwXF9Lo9+D6I7aniP6vs/Qi17Qrjeppj24aPxnaarAjiTX1kyDoNX9kOYIvQUKfR5KRCMDBjD3aLruKFrtOY5PQRyfI/tU0XXF9OKlF94i+o8TEcmRyJXDyEb0g7KiEwIN6Vg1OMW165MRLSVNw4oKyHYrgTA0dre577anfwDUEEzsJMi8ZaoAhjy9aVnnJtaz+jPec4n7qgQlPpn/tEAmM4t2+CMbAUKXVJkKmuzw2bdU8CZqLIgvGzH7UWNm1PI5jATNWx8F5gAYtBeeTULy0Y8c/SBO94t3z53IYUPaIQGIc7/lkur7YQcx4KfncW8k4RQMz7bgcijSwa0RVU1GJ7fA2UPzyAZnhoxR68c3MSENPYOvxBZpbYHvTTLQcxjmosyaHPKyy5lfvcESv1cEqIjEo67g0WkHlnh40vv0STUKWnFlDK6nInU1mxlXerax0HALvfTiA5fWujS/rhfff+Kp25234nrqV8b31UKt1AE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WmMjfOzICcUU7bYvkQAHibggT0onTsCRecxpNWrcPLkQ6/VAN+LTuy9wAcq?=
 =?us-ascii?Q?QJUZhGJQKrv7wPqacCfbORSBsxdwOKpRBexoNYcvz384bLlAtPy9VblgDHZR?=
 =?us-ascii?Q?OSdGF3n4bwRn4n7M54XJJGPvT4J6jhgRM4Jp0ZY948b+mxeLFcj6VQUKOpUO?=
 =?us-ascii?Q?SDfMj52Z9XXqRd4Hy/xT1lAWij5wdwb42UP5PrRg4PSZRCAzXwZMPCWF5HJp?=
 =?us-ascii?Q?a120tqqdcM0ZzisM7SACxuM963lfzxk5Mem3RO52l/1v4E0EasDaEKwr8g/H?=
 =?us-ascii?Q?39zTSCTEgbsx15IeNv1xDj0MxmzQnThizfGK7Zis/T4yLTpRdSFijWNers8m?=
 =?us-ascii?Q?ZCdIfgvUjKxrCAS0VmjsOEHRFZWyJWXBEes5F4qBqmep9LjHbR9Z9EdC2beG?=
 =?us-ascii?Q?Qz16X9WWoBtd9knRqvd9ib4YCDrTH35k0cVRNu+QKlyUh1kZf4effsFI1RlI?=
 =?us-ascii?Q?KMbVtlCDnOOPiSAPj/8XPw8z4PCluFdNLts8Gckjrh7wcZ3YdzYZofrPU12X?=
 =?us-ascii?Q?Lb6xvijXvZJwrJhBONW6t3h5b9Am7h8ybjPWhVz+6/UwXll9QFFx6OfFtd1W?=
 =?us-ascii?Q?UipTQyqgeMzi3AyYoWikT3/e8g14tckHhw1piwcjjmi/pqjlZy/PXqEKtQiY?=
 =?us-ascii?Q?+iaSD4sCAYRGNnbzMC8HVZoJQ0EjCAtA57bKaTNr27yWY2aU+3aYurDcyH9V?=
 =?us-ascii?Q?RqPmhaf+8I3wfD3I5QAlEl6430bXVM1ODp9onB/XjilpsgSnIJ2cUUIE6QCF?=
 =?us-ascii?Q?FQluJlOIHliKas2XQuEZzvHYLt8mHW8W9Y1dRq+OgAlmThduAM2NJgdVKwH/?=
 =?us-ascii?Q?1qtW0+lrCbhQtMQe+QXFfZLaLr4hahXDb5uoXfrKHfWhOJh9V9nse2JWbZwq?=
 =?us-ascii?Q?P20ByhzRmZvQJu7xntdFVOGLm0Dvr+madHmBjdR4Ri3U1vl60EfePp46gX2m?=
 =?us-ascii?Q?WGEvdppIaHRK705V2sswgLa4LFVy2vdydirAxIHCAWBTdFUuSi2+muudiTu3?=
 =?us-ascii?Q?UMUyonTSSn8cm/y9G5amMv2khduBnJtnZdhvrEkA4h45ka0Q2cRN6l5Il7ZF?=
 =?us-ascii?Q?L05s190VolLVPN2aVLcVYLbz+XM9SXjnMDJk/BuFf9PS5cOolDG5/qMj2iqy?=
 =?us-ascii?Q?GXGF/cjxyNtsZA5UlhEd0Ygdkm0llI5aTFmQ2v2Ez8dRsFUwLLI1SBSGP2lw?=
 =?us-ascii?Q?9d7ja6rJKR1zOWBmMiZNmnb8xm8rwcPXOJOw/4A+x83asq9kLklKOtQgmJQO?=
 =?us-ascii?Q?cUkG2vNkoiAf0ehpGR1h5oACK5luRuK+ekbKwvniVZNpMuBi4KhEc+k5xhrS?=
 =?us-ascii?Q?9e8EpxVVJ/k/eUXaQxeakhvedebxvjib46Bl69HI2ox/FGNWc9CRRCzky5yF?=
 =?us-ascii?Q?AeLFoU5ENnm74z+s6rOQbsxdl5fjBnkgAA5EYVX7HIrQ8QbEM7tycrf8Yfqo?=
 =?us-ascii?Q?r1Zrlvm3il/nV0kSERKUQcK1qS7GA1ZXscetH72JuruqW4JADMGYOc2OA2Jn?=
 =?us-ascii?Q?/MPXgC+OOl2CDDCZY5GGndAENQitoki+yIzYSkW6Y8N6BZuplFYQ4hRvVBfV?=
 =?us-ascii?Q?TOTJTkXmUa2Tilq1tELCHZDnPPd9S3UkHuFf/wr1Hv4M/WKTneGRg+axxepU?=
 =?us-ascii?Q?eCZqcaOH7QxGYLMhLOYhZidKUXM1is8WqFOZfv30ROOXIuz5QB3vqPN6vN3W?=
 =?us-ascii?Q?21+59X0hmhmFW11h/pg0aEkhJhM7meJa7/Q4DGf6Iwo2YwsT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0957ed-78ae-467a-13d2-08deed51876e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:12:35.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEk+KW8KOANughIm3Ww6tBK3WVuB4RRrF+/zOCgD+o/8fvPkXCihGgM7ASXwrCrIglKGXme4yfvslXuX72nUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

On Tue, Jul 28, 2026 at 12:44:49AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> ipmr_cache_report() builds short IGMP reports for mrouted from a packet
> that may be a synthetic RTM_GETROUTE query. That query skb stores the
> netlink requester portid in NETLINK_CB(), but the report is delivered to
> a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().
> 
> Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
> msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
> original packet and then copying the whole control buffer to the report
> skb. For synthetic route-query packets, this copies NETLINK_CB bytes

It's copying 48 bytes, which is the size of the control block. Please reword.

> into IPCB and lets a controlled portid corrupt IPCB(skb)->opt. With
> IP_RECVOPTS or IP_RETOPTS enabled, the raw socket receive path can then
> copy past the short report packet or overflow the stack option buffer.
> 
> Keep the IP_PKTINFO support, but initialize the report skb control buffer
> and copy only the pktinfo fields prepared by ipv4_pktinfo_prepare().

This can break IP_RECVOPTS and IP_RETOPTS on the mrouted socket, but
this was never meant to work (side effect of bb7403655b3c) and therefore
unlikely to cause any regressions. Please mention this in the commit
message.

> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.6-terra
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/ipv4/ipmr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 1d9a4ac14fcef..783de5de02ddd 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1061,6 +1061,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
> +	struct in_pktinfo *info;
>  	struct sock *mroute_sk;
>  	struct igmphdr *igmp;
>  	struct igmpmsg *msg;
>  	struct sk_buff *skb;
>  	int ret;
>  
> @@ -1113,7 +1114,10 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  		msg->im_vif = vifi;
>  		msg->im_vif_hi = vifi >> 8;
>  		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> -		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
> +		info = PKTINFO_SKB_CB(skb);
> +		memset(skb->cb, 0, sizeof(skb->cb));
> +		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
> +		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
>  		/* Add our header.
>  		 * Note that code, csum and group fields are cleared.
>  		 */

I believe that Sashiko is correct and there is a similar problem with
the other branch:

https://sashiko.dev/#/patchset/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz%40nebusec.ai

This should fix both:

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fce..4827973c6f9c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
 	const int ihl = ip_hdrlen(pkt);
+	struct in_pktinfo *info;
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
@@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	info = PKTINFO_SKB_CB(skb);
+	info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
+	info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
