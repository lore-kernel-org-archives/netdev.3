Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B61A9F85
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435071; cv=fail; b=stMpfTTDF8RxvG1D+jncch7t846Dymxc5RsqZ98fL+oXA0veHDR8zqScdrWvVy4n5VAHZ61kXM5Z4A5SaGzuJ0fzP0oNZzpJ+5q3T8r9Ra5z3VX8yRX+VJmQTNpGQiRV/APbX17t5XpLuV7+pOYiIgwfwvb/QYgWazx96Glh6Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435071; c=relaxed/simple;
	bh=PJiNsqlMFM3XKwu3SpyOSnYjBytUcbMxNkWJ0li31OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQqsnJl2qOJem3BuArmwvbp4Bcokk65azumpl6iGVTmTChfCbDTX2g18xbEWCYKVW/Qsc4o1uCN7IWbIJ9zxxltn807Gm5I4/kt/2IqU9SIXpsxoB3k8Rei8jRf2tbGLs6yZIpICB7henSTSNDpWuFkSiGTxxzTINNp7jA50pXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PO7E1bOp; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PO7E1bOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceu0aVV3spF/fMF1rgNmUZzgUemEcN6eNVIGHHtiBgoUCg15hwHkxJpFdw3Eb+d/Xmn1c6Ucoyy4uTM3NJMX27qXkQTByWNmasOwUspGxVQEqNz+L4EmzdDZ7noqNczOFWiFtVNcsvhkGJ3NoV7O2NqlEzeoGD6AYdUriMlNttZxYnXL6DXo3v1zEqGzzzrO5qKXvL/ckHls0aZSWtmxDwna/zr2nSwz5ZERg0socfRHbWa6Cu76SSXnEqR4ahe+stzw4Bx4DYGi3DH7j0OT5udku7pvKaw2ppwikn12m0syHTZmk1iEK68L/X8WOElZP9cKpnyOxYqh4J3JGaX7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fCC6rXILvRSwdGfSESJscpcTiz6Zfkz4/W9oMuQLyc=;
 b=G7Y4qj53LTlkrumslBLxclL+Hj8J/kyipMlR269s2yZps9avms6Qo0k7dvo7/Ns5p7tJggec14Kyme2vVrgkfWCevc8mYbl6hYturfyTCTAZC9c04IKit2UHjqnWZB8tJuZrTD4sb7b9pvVC2tAuQO17V7+ISFEvvtEsxVUF8PscKaq7gUI5HZqWZf621D4FD+hIIcDqDDp3wewPYmuasfOSP+7x6X9qpSfDOfKcWELe511yj2l72MUSzejzGsDxH2mxlIgVPqP4gtQIfxaGKJjA4+ghLlBQ2GL5X8K8qbYec0WYlxIzaFvrxIq6VV7NEEAYojeLXmNWbbMrW2Qgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fCC6rXILvRSwdGfSESJscpcTiz6Zfkz4/W9oMuQLyc=;
 b=PO7E1bOp+YifGUZfX+ldIZQykBuxGBYBh9dc7i7kJ03MhtkaxDTTEOlDU8o7d60JpXYHNlVOQK+N0YIoAv2O+hbxqkFhXTHgV40/y73PiInOFORSggXHHAK+6VnXVd/QhbHkI1bB1RzXtDHxYPkUzl5lnFCW4yO6wdEyBGvOlWEr4T9INDk789CGiVp52/uuf1i//tUbScCSitfPUtwKSaqjLCi71eWLLPEcBTW7pg8bmTW1O4jhHPsqzDfLRan5NLQgjZSHVAu3GPzECvT27H9G04YaADJLwzBfdClgmUl/g7TwwKMK4xsJyYSX5krveP/UhTddY+wcfG/8x9LYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 11:31:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:31:05 +0000
Date: Thu, 3 Sep 2026 14:30:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v4 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260903113055.GA90787@shredder>
References: <cover.1788417128.git.zhilinz@nebusec.ai>
 <d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a36c317f6216d20f9cfd7e49f1888f62c35f7c.1788417128.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 850bcfb2-b399-46a5-6e64-08df09aed72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oUlBfGEzHHkjPUeURaMWS3d0aZY/P3UfQw48khO112gMFhMt+TyreSchO5Of5CHTdYLngCGeviGPOKtVW60LhNFtyFgXBaWX9S2R5d7Na+PTRAEOSz3L1QroPKrHmLh7gn43CkFGkwB9sp20bW8aPe/W7bwxknrMcwfV6uJaLyGE+NuWd+snJ/KoW/IZsSGHL3/fJ3sbAbN4kAh+aialbzt9gvMAsH4aWKb8T7YpxYTFkdeQpuuM6QXJPLyo3kaHb4jTG1Y8Vtb5C1Y/AGngM4YrZAJeBnlKQTODCNKpLChZbOvTGCsdlsNu/Wg6WOUAqfQlzLb7e7TMPon+DyZ7KVLmFVLJnV6vg1tBoozeKK2a1DX+FYdpugFhND/B6OHWFrf4ZNqn304qQcSkptXsxwaSioVcojTAcTHtRvltk5/+kprRderVusMS6qImL+Y30WWHevcY6gI80mhhM8frScHCwT+sOyUZ2O72oljKJkjYXcwrTTJqNU5dqKNxR+YKA1UM+P8lzK1w/f0SU/TGDOcjw9639zYrBinT64a0Jspal6X/+O9/4cXbTR5lmazouXrzha6sbsOD6nYXBEyESY3O30rhcuJePlE+Rp0Bxak290Q52FgxXmy3lAOAwUo680l6igECdXS3FoSAth8lVGpNxjUb9A0ncNgV9hqb4ac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xh78xzBYLC6q8NeNh3Z/Qr7PW2/IVb630lXq+yenYeVBcR2BDSeu9Dly+I5L?=
 =?us-ascii?Q?lLy5fqyZG8so17oqT/wLKYsHJQO+Y5txkOll50Uhi8B3bXh1GpveKg5+Bzk/?=
 =?us-ascii?Q?p9tXiSAOz2yfieIKA/jlAuEtM5KY2DsMdcOTb3wTAK84up72TIED5QxbkBI6?=
 =?us-ascii?Q?vxPEuCBUhkDyio8RTQRBGJA3LwPYH3d35kdih5s8xI9STAm5dI4PrywzyyU9?=
 =?us-ascii?Q?bGXvf74HiBHf3RNptNygf71Um9hEL9BtDGgS+YtjUM6NDhuFR5DwGVa72kuP?=
 =?us-ascii?Q?b+SXZMKKJOoBEC1rvttDApKHE/oQADhHUnDZoVPZ+zgLEEtHzhuYzdJ9i36M?=
 =?us-ascii?Q?qnwnC43NRd9FFW+TBOF+DqFM7SWIO4s8e+I8CSHxrfrdUDdWaSg9S9u77NI1?=
 =?us-ascii?Q?+BvqNL0yZzBn2+/UmuZEILMaoz5d30Xa5Tds3gTzqt+25Plubum/w9QQ6YAf?=
 =?us-ascii?Q?1dxd4xQR+/fZFD0hQPTt90wSlT0XpxaeAnGWDiY79N2N/KyQrQgeTRzPViE0?=
 =?us-ascii?Q?Neueyc31xhpf27kvrrmUlQEC3JF6C89i/uPPQpyfRR4VXibMV76Yi4pUN+OG?=
 =?us-ascii?Q?QBpqX0LMgYC/xelDdqLom1+ZZ48Yj4lAl3kenU72DBrhLCOtgnrqeBNZb56K?=
 =?us-ascii?Q?iaWr0mzGhN4Roh2J0OpI1OTK9fUJDG/8SlPvQ9cAC0tKAslZS5SIwmVVnaOV?=
 =?us-ascii?Q?telH4G6/x0L5aLG2t+VmXaXfL69MeofJ5I7yMnao0qnsSvBm3TFtuSP9dP/H?=
 =?us-ascii?Q?Z+dl2bunuzsjMdvK97DY4hM5IqcA5uFeVJYUjN9QT43rDNJn0tMygdrrBxAU?=
 =?us-ascii?Q?TxEpgXeNYQq9/9rcgnSax793qBuea7jfQLb01PbIZttYMmgWEluPySjhYY0V?=
 =?us-ascii?Q?m9H8yP6Zu76cQCQIfRZxYH4GZS89MCvCu2LeFtyy+5EgeQpRghon7Hozvyi1?=
 =?us-ascii?Q?0Ra9v8qp84WQovv5ffaR+itApq9dt8toqmHOX5kc5h9VUODJxpcBSu4LoSmv?=
 =?us-ascii?Q?h9rj4GhGM5AjkdtPyJam9u6X6aMrGSRqgOC1r851Gv8fspxfuV/jP2dPj5F1?=
 =?us-ascii?Q?bv8SwfXvJ96pskgVrhIdgpONUOq+5jP3qgjxKIDXQbHcelgKjfBY/NZqBNvW?=
 =?us-ascii?Q?Xl2Afnepyownlc2XZLKu4qVbAbHwzyjlY/RU5qwnSdS8Qe+G64WY/uKYhEQB?=
 =?us-ascii?Q?/fU++ud0mFgBx4cZEEEBo7fUqqIZDu5qgDZvbV+FHjbeNp/RUlGG4w+DJrxq?=
 =?us-ascii?Q?4nOH2JHxDF9XAAd+0CxVKXhwOYNAciNSDSMAClzR8WfsguO9oMRAilpVe4Q0?=
 =?us-ascii?Q?VR3X5brmFXsHBIMWnGuQh+2Jgqc6vvgtvy1sPgGGAhbVzO8lMJYtZ0GM1RRd?=
 =?us-ascii?Q?QwLNQmTjjIu3/cqs1k7CZoRFGkBZH1XzZKa0+ckYiOM52LzArx0eOEHHSy//?=
 =?us-ascii?Q?5YE/OumAq1Z1aSGSk59vfp5XJWna2v4+rYKgI2KzFQIztziIv6GwHQX/Nk1i?=
 =?us-ascii?Q?IJyjO4j2UzHUxtC0DYhAoshG43nDMK0SxRzJAq7EoaAlUeq4aXFeMAZBO69c?=
 =?us-ascii?Q?/ugLp4ikC6lHgamSMn0KId+GpTKe8fRblSl5zhCSjP1WBDveHV9eCGDZ9o/k?=
 =?us-ascii?Q?Eu1SJzYiLxjoZl7t6TBKJNjWZRjhMHrsqSIrb4WqHdlezpG44Tk2t7NV7jVq?=
 =?us-ascii?Q?xV8hA9e4D1zq+DpAQTrzlHIXti+JCMKctcxPc9g/MAvzHzu3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850bcfb2-b399-46a5-6e64-08df09aed72a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:31:05.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1qtU94gooxfHDUeCdGy2WHtrxwLl6/ppAjudwhh8xvBT9ej0C0M/JYDRBJNTyF8eF8A8Qx3jBGAxeGSzsD+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

On Thu, Sep 03, 2026 at 02:38:16PM +0800, Zhiling Zou wrote:
> ipmr_cache_report() builds short IGMP reports for mrouted from a packet
> that may be a synthetic RTM_GETROUTE query. That query skb stores the
> netlink requester portid in NETLINK_CB(), but the report is delivered to
> a raw IPv4 socket, whose receive path interprets skb->cb as IPCB().
> 
> Commit bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP
> msg") added IP_PKTINFO support by calling ipv4_pktinfo_prepare() on the
> original packet and then copying the entire 48-byte skb control block to
> the report skb. For synthetic route-query packets, this copies
> NETLINK_CB() bytes into IPCB() and lets a controlled portid corrupt
> IPCB(skb)->opt. With IP_RECVOPTS or IP_RETOPTS enabled, the raw socket
> receive path can then copy past the short report packet or overflow the
> stack option buffer.
> 
> Keep the IP_PKTINFO support, but copy only the pktinfo fields prepared
> by ipv4_pktinfo_prepare().
> 
> The WHOLEPKT/WRVIFWHOLE path is a related leak: skb_realloc_headroom()
> inherits the original IPCB, then a 20-byte header with ihl = 5 is
> prepended. Stale IPCB(skb)->opt offsets then make ip_cmsg_recv_opts()
> copy bytes from after that header as IP_RECVOPTS. Clear the inherited
> IP options when that header is prepended.
> 
> This changes the accidental IP_RECVOPTS/IP_RETOPTS behavior for these
> cache reports, but that behavior was only a side effect of copying or
> inheriting the entire control block and was never intended to work.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")

The bug in the IGMPMSG_WHOLEPKT/IGMPMSG_WRVIFWHOLE path is older:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v4:
> - Clear IPCB(skb)->opt when prepending the 20-byte WHOLEPKT/WRVIFWHOLE
>   header, so stale option offsets are not inherited from the original
>   packet.
> - v3 Link: https://lore.kernel.org/all/e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai/
> 
> changes in v3:
> - go back to the v1 scope and stop changing the common path
> - remove memset(), since alloc_skb() already clears the control block
> - v2 Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701fe5a4b6.1785379072.git.zhilinz@nebusec.ai/
> 
> changes in v2:
> - reword the commit message to say the entire 48-byte skb control block is copied
> - mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was never intended
> - move the pktinfo copy to the common path so both report branches are covered
> - v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa663c08.1784894076.git.zhilinz@nebusec.ai/
> 
>  net/ipv4/ipmr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index e5f2b1c6150d2..a4d82a1bfe80f 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1058,6 +1058,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  			     struct sk_buff *pkt, vifi_t vifi, int assert)
>  {
>  	const int ihl = ip_hdrlen(pkt);
> +	struct in_pktinfo *info;
>  	struct sock *mroute_sk;
>  	struct igmphdr *igmp;
>  	struct igmpmsg *msg;
> @@ -1102,6 +1103,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  		ip_hdr(skb)->ihl = sizeof(struct iphdr) >> 2;
>  		ip_hdr(skb)->tot_len = htons(ntohs(ip_hdr(pkt)->tot_len) +
>  					     sizeof(struct iphdr));
> +		memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
>  	} else {
>  		/* Copy the IP header */
>  		skb_set_network_header(skb, skb->len);
> @@ -1113,7 +1115,9 @@ static int ipmr_cache_report(const struct mr_table *mrt,
>  		msg->im_vif = vifi;
>  		msg->im_vif_hi = vifi >> 8;
>  		ipv4_pktinfo_prepare(mroute_sk, pkt, false);

pkt can continue in the data path and ipv4_pktinfo_prepare() will
overwrite IPCB(pkt)->iif with 0 if PKTINFO is disabled on the mroute
socket.

That's why I asked to try the following diff [1]. It also makes sure
that the PKTINFO reported for IGMPMSG_WHOLEPKT/IGMPMSG_WRVIFWHOLE
asserts is prepared with ipv4_pktinfo_prepare(), like in the other path.

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fce..cdc84eb05c79 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1057,6 +1057,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
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
 
+	memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+	ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+	memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */

[1] https://lore.kernel.org/netdev/20260805081737.GA1284302@shredder/

> -		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
> +		info = PKTINFO_SKB_CB(skb);
> +		info->ipi_ifindex = PKTINFO_SKB_CB(pkt)->ipi_ifindex;
> +		info->ipi_spec_dst = PKTINFO_SKB_CB(pkt)->ipi_spec_dst;
>  		/* Add our header.
>  		 * Note that code, csum and group fields are cleared.
>  		 */
> -- 
> 2.43.0
> 
