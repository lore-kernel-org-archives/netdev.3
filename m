Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AB29BDBF
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758835; cv=fail; b=c8z9y8tMhIHZ9XQ89LIr+XI+TN8tx+/6yRS/rNAHi8HOKF6L7pyEFuXjzFO0io/v5sIvM8BLGSz2RX1O0jozo2iH9T9mIv3qMBu2ypzn2ugS+WC9rTrCI1NCvmn51N2ayQJOsS4wfa7tHsjc+2MShzr27eNYDa8FhTP4FkdSSBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758835; c=relaxed/simple;
	bh=fV1LaEyuBwgwytgd8j/IWZcWBuY5WVJVDOw0qY8BJT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IRxuJdTXY69XL37LDj8blViXJpiFKqqUYPkcraO48jLJFY5pCHSaZ2hR8jwmECTkVA16sqSK/HXSgIvCkFCZ0uhYOIMnWuNN8TjCR2OFOmsujBkw/iDxPwFglpQ35ZZqqowP+JR/jbW9+supa2IUG7hRWmpIOm52f0XTrk1kWNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCIJdZ+K; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCIJdZ+K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJO2Ke63YAf+yFak44XvgCJ8pLI3XzeZYD7RYKBsWnvvKXqZkkYnjvvn4fUk7Mh5omu8Hwe57p8dlyQ7lSmdE6a6giE4dfVjo2EKtFB3UXsJApWsULeEVYvf1VQ89OiPsQ3V7C3d1od6OkS2DFVwvnweP3R+KaISp+z+BqEXmhsIIXWIdEYQUJwwMos+wbD4zf9IB02wsz1wj1JCSz4eRudXrIxgjSSHYfhA/F7AXEahVWy1BUSyYTwKcTsHe9WkBYHNCfmNJPmPfKD8lYvkfaTpD6lpvhpdvPjZmQkxy84DcrER1cuvp55ZH35XZa7ZdZa6PvZuvmX6VZF8Xql9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbMtGykyT9tff4tXwSPjx6WfqKSK5r+bu1snDTXMzvU=;
 b=DB1bYcT9uKSZMn/22TcsDejX9u+kSVtbkqfVuzWDiISlDdIb21LnX3I3w6yxIOtY3t2w/OC4eyDh/sRXcQW2BPpyjL+uETGo0XSjis0xHONsDvrC7o6zTlcZBjivDIEVisOWRBnu4eKfFbwUhodFvOXHuRUdy0HqTTxbvrloMIa5qjxt3otUCaDh18/Nf3JQX5ZXYXOUJtaPenTvLvDvTlV2SJLOC+Vkwe3IW6gsUD3Fh35OuDgJWb2BSVoFxziCfj0hTG0Jyn2cDaJTm1/1nnvilocPFSCngXnYw80gJjiocpVzp66XKjUiod2fCfAvYHPJ7ZlyOuBOHcetU5mnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbMtGykyT9tff4tXwSPjx6WfqKSK5r+bu1snDTXMzvU=;
 b=RCIJdZ+KMXJnZxZMrXi80b/2BkpCMP7iNobWgXBs/+ZMioBW7JTW7q9xeOTdBrG2cV1T1YyQRRgz/xLyLz/MYohbeNoLIfZu3XGVi8aor3FFwXsO+d/0zoFG821/h6N2oKcOnqBbO46/jvaXP7y1Qo0JPFtRx2QDkUGGazYC8wxG10ukcJM7Q0BtVaDxLyVWQ8FarYpSrHfAAqNLpqoha3dWHkjzE5q8N15nqG5HFsb8QjJFuFILvponUEOEoGnEiXTJ60QmcLe7N191pAyb0+DgsxJsCl5gAQnBjvIGajm+T8j5HCHAlxVW4qs/AjHmw8ayaGNZLilclwnutGgeww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 15:40:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 15:40:28 +0000
Date: Wed, 26 Aug 2026 18:40:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	herbert@gondor.apana.org.au, netdev@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v3] ipv4: icmp: reject RTN_UNREACHABLE input routes
 in icmp_route_lookup
Message-ID: <20260826154017.GA1834664@shredder>
References: <20260825094523.1461020-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825094523.1461020-1-dongchenchen2@huawei.com>
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f13a27-4066-4fe3-9778-08df03885ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nIRegnyZJxeY+VcUuxNjl3cv5/9ZZA9ATXuBP3KbKBjX3UZwsPrQS9gKTGbauERIxYkQcHyTOVb1sDdvn57Q8MHRY96iWTO7ILggGxDD+YEa54KBdfYnZlIYEDv6Bw2CgeQEt5SVYVyb7vRUV3DiD0856RB2ie3nbrNiiI9lDjoariJronJm6h7MHzpFZxFpGcL0N+wKSFv/BNCbE8wQB/uVUHwRu3z4NwvgeaCiTXqwTagAvCPBUaYJ4jnohY8azmEmLVoK0mVKSG5qPvAeFGz2YTGFeUIxwofyct+9m4Fj4hwOK6wTTvkeUZewzjREw8HhYSjISIGS1cWqk5DCFH+btOQq3q/GUmwy7O4xjfQvV7ObclP0GwzGttiSA+UFZAoyHBIGxa8JYHrt1b/6vgiARMSGP8SFtYQigAmn34q+eTkGwDc7knCiG43XjW+xW9Q0xEkvM/NyFz19PNhgKiO5a+8CkiZnPUva07+fGSK/r1v5LN3TxIB3DY9d73iTK5vFvL9U23VC60C+CPrs9kn9gX5pgkuRwzmS0POlvMFH+udlgmW45iUOYa+qw8tBS/BgFuklck9d2LH6DC6c0WpirBN6lmrhUYKUWotUoqZqaZlnWmt1MmVuh4vXHld9I2b2RHKaVNJgGtOxA0rjfvHQzbhftForQlYUe6T4w3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zp/v8JfQF+dSHNYde+nDNFJhETO1nu5rAruekpbgXhFwmTR67OeKxZYk+Q81?=
 =?us-ascii?Q?/ymAPWeHyUeFMnpKO+q/GdjvHLrKP5JauooVwaawYnPgGVaxQlWFOjtGNkTg?=
 =?us-ascii?Q?JIhZHuLVG7mlPfXPiYDw4kW7fFQK4c3jzJvoj5g04joCeW0O41cxU9rsdTY3?=
 =?us-ascii?Q?pITBF/OdY+al2RpYovZ2s+hWv0xrVbrT3IILHgHG4EV1UoGxml2zBA/7Ioo+?=
 =?us-ascii?Q?hd3/QFciA/MMcPjKYc0lmdP8TmC2lXK6EknF+BxaNx+++3fMGC8vHoYjxrFr?=
 =?us-ascii?Q?LHT4EN6QVSVTzQXVtcqGDCwEDcp9s80zUZqTXOyRRIyvOk0hAaVWAQxBFIA8?=
 =?us-ascii?Q?LOX0Jl7wQTObEw2yiozSxmqoe/fj6m8sv6Ljc/PjRXi9tD0SL6gMMsco5qPy?=
 =?us-ascii?Q?5kekPUgSbeHeiQB/zULnzmKihyqDoH65f0gMperwP9/GxabDG0lrkyZ7dM0V?=
 =?us-ascii?Q?AqyJX/q82p3wL2vwTamx5Nfz7GdJzoV1zk1rvugAODmXS8NCUaeMIZYnBO1e?=
 =?us-ascii?Q?iI26e/mvN530LR5WrK0RdlOKXXMxT5U55jmLWO9qFjMTLWZ5oj/gcBs9qhKK?=
 =?us-ascii?Q?u3VONCR5JjyLDicwJTqsfnOBZ8bqGNkXrt0LrIoj4Sir2H+ydXT/SPKbCdTF?=
 =?us-ascii?Q?QzWcUB+X9UDdz44HdMIC1DhtL4Ki7TFRSHaIPP/71MJpmdvGaw/1yaBfglYR?=
 =?us-ascii?Q?491g9TTSsRDK+MWDbX6wudDhXQqPUMayqw2n67rsjnx9lfPC04g+gsKb3Iyd?=
 =?us-ascii?Q?WhfvM1bFM+ehHVgoOIMb0+/Coii5RtejIwLP/dr48LP44628W7lfQ5rxauhN?=
 =?us-ascii?Q?93atGE6M3Ymt8W36W+WD384n0A2XPLwSdYwPjVCThbcKwbP6YwtAaGKqQyZp?=
 =?us-ascii?Q?VRZIgk/zWYVleFOVjBnxIw8PhtxmiiK3ICjQ0OPVR3gbNxGFQ8nduCSsaQlR?=
 =?us-ascii?Q?VTs1WOwUMQxyFBpJOGe97+gy3QAU//ipI/cE8U8Co6yYX3r0Ob51euWXOrOn?=
 =?us-ascii?Q?HtjKYH+hMlaFaxTayIK5cmY/TsX5K7s0VtpdgaU9iSu/AYTFP2I6TJgBgFva?=
 =?us-ascii?Q?iatiKxFJWMgm+HBoyM3wVMsMXA2HcwYxYn8lqsqZEayMtLTSjtnFigZUoTJw?=
 =?us-ascii?Q?vwDo8HrFWauxa1DbC/69fA3Fy4Z8DxWylsyd/510J/IuPd8lgU45TaOXXM0G?=
 =?us-ascii?Q?24hxS5ckaBEisLL9waU8Cqnloze1eR4BRvGH9npJFdfezzoMvCKROUuI7Cry?=
 =?us-ascii?Q?xO+FW7SE+gJIrlohfiCo3d7FnaHMXoBI58W0jjdNcGDhRz2UGEQDbfrTisxe?=
 =?us-ascii?Q?AMqeHCrksJBmbbDUROcyYdDQGoDJb3Rq4pC7o8G/lL+VKA3kah6dtDCG3VGs?=
 =?us-ascii?Q?fiJK4A19b2TlRszCGga6SD6W7S4fRRuDnK75erPsRaqznDXG67DKAufEhmhq?=
 =?us-ascii?Q?14h2pLjbwYaD4OYHII8HXkjxx+6vlIK2lUqIcjRH0V9dKwmtFGluDbBn+/YR?=
 =?us-ascii?Q?7RvMrVVzGsTKwgAewlC9rrVPVxnLO3k+0Njlff6DfKtFnvwTaZWGJfRSS7Vy?=
 =?us-ascii?Q?jmOAZMpJyM5lCZpZGPvcbcwvZZgNkNaRpKiTkj6xHq4eJqpHno4OLtUdgxyi?=
 =?us-ascii?Q?8uqJLxKZLxrgbYQi8b8JYK14HRamxaJkrUBSOjV9nBK5DR73ARQR3+Jd/eVI?=
 =?us-ascii?Q?o051bQHKp2LkRE45TewN/YirZXITHf2DBUF1nf3O4TNUFcZNs5pMcy34BgN0?=
 =?us-ascii?Q?ZHCO4bbw1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f13a27-4066-4fe3-9778-08df03885ac7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:40:28.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed1+xxmw/vUAsjjgmHj0gnLQI4ZIvy80Sr4Y9Ahpciu+HE2r4Y1qVFnmr3UgjoaGFYbfFQsnWV5pUR3ZOHs6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

On Tue, Aug 25, 2026 at 05:45:23PM +0800, Dong Chenchen wrote:
> When the forward output route cannot be used in icmp_route_lookup(),
> it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
> the original packet's source address.
> 
> ip_route_input() only returns an error for truly invalid packets. For
> unreachable addresses it will succeed and return an input route whose
> dst.output is set to ip_rt_bug(). The existing check only rejects
> RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
> and later used for output, syzkaller triggering a WARN_ON_ONCE()
> in ip_rt_bug() as bellow:
> 
>  ------------[ cut here ]------------
>  WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
>  RIP: 0010:ip_rt_bug+0x14/0x20
>  Call Trace:
>   ip_push_pending_frames+0xfa/0x100
>   __icmp_send+0x905/0xf10
>   ip_options_compile+0xc0/0xd0
>   ip_rcv_finish_core+0x321/0xae0
>   ip_rcv+0x1de/0x260
>   __netif_receive_skb_one_core+0x11a/0x130
>   netif_receive_skb+0x7b/0x260
>   tun_get_user+0x11bf/0x1c10
>  ------------[ cut here ]------------
> 
> Reject input route that is RTN_UNREACHABLE to fix it.

Nit: Also mention that the warning is only printed for RTN_LOCAL, as
RTN_UNREACHABLE is not the result of a race condition.

> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
> v2:
> - RTN_UNICAST judgement will reject bforward packet. Only reject RTN_UNREACHABLE
> v3:
> - Modify the comments to make them more accurate.
> - RTN_UNREACHABLE dont need warn log. 
> ---
>  net/ipv4/icmp.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 0caedfc7ca92..7350f0380be1 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -581,16 +581,15 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  		skb_dstref_restore(skb_in, orefdst);
>  
>  		/*
> -		 * At this point, fl4_dec.daddr should NOT be local (we
> -		 * checked fl4_dec.saddr above). However, a race condition
> -		 * may occur if the address is added to the interface
> -		 * concurrently. In that case, ip_route_input() returns a
> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
> -		 * be used for output.
> +		 * At this point, fl4_dec.daddr should NOT be local (the
> +		 * address can be added to the interface concurrently) or unroutable.
> +		 * In that case, ip_route_input() returns a LOCAL or UNREACHABLE
> +		 * route with dst.output=ip_rt_bug, which must not be used for output.
>  		 */

The code is fine, but the comment is a bit misleading (the "should NOT"
part is only correct for "local"). I find this clearer:

"
fl4_dec.daddr is not expected to be local here, but it can be added to
an interface concurrently, in which case ip_route_input() returns a
LOCAL route. It can also fail to build a forwarding route towards
fl4_dec.daddr, for example, when forwarding is disabled, and return an
UNREACHABLE route. Both cases will result in a route with
dst.output=ip_rt_bug, which must not be used for output.
"

Thanks!
