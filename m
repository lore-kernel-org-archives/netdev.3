Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4EE3AB27F
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105714; cv=fail; b=s2nTIGb0cMkorcde72nbhBFivtsZMwnWZFR7MjVbZJfKWNXSOaDM37QhrBiMcd3R1XobyDaCqHGVy94vOk1sDjdbKjXdyWtbMaJKR919ag2gTLxdOZIh8Wg0A4eiu4v4Ws85gDQCHM2TsCauPeHyED+rgJbYhxCcDy+qRMLVzEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105714; c=relaxed/simple;
	bh=QFiEeFp5FZbui+IXGoU9CqfBn/bVLeIPTyiSxSjbTCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9Pd3TwQWsIMfx8/u2lUMRUP0triG43RM8NjpsAiZZZA65Tb9iEv/iBWCJxQWnmkwwOoEPnm68DldOFBhMh+D+rr2HbzuXzRHqKN+7uqXgqx9EgUcyJN43IO4WCwBVdbrWVJaq0HV9uIO1J8YjgNUJOuWJLRIOWkyRooWjSSZHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4NXt6w4; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4NXt6w4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Re9jFrePzjMhvaOSpWPLuTqJke3ZNMMCiNl/Xb73ONrnXEZcK4w3FseNz5UJkMGS2x8RCS68y4NwM1AHmknCthvDzc3nZ0U4pDasO42/mOkYym4ZqMViJRvbm8KUZMWsJGz90RHNeDGzwaWTqM5JyUeEPlzHaZIXPrCj54/CNPRbv6vUFPf8frHigOmGP/xSz2/qtVdq5MR1ruBUvlTeJtLbMksEiZV+8PGb+DUE4edluqlNKWGqmwZdP6j/WJQTayTxxMz2ciwQ7JDwMxm+uuMCIv1MZUsSlET17pvm9LMp85D5p/qWoK6Tqz3suhcEuYqRJakPuE8+QmVKxIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyoKIiNuyDRmA7VLum/0bNSrEEG1MGsxvBTao6jPmug=;
 b=yGXIBvRk/+XaixbsFvDMgraUg03xA6B5WgR8mu9zKNTz4rKpSqvrl/mMBIfTJH6HHMjss/QLotzA6JIxA61wug9NRjtvHaNqy+DIx5E/hWmFg4dJBpnRBRBerR8wTYGFXeYP1VdOLLUrwW5Jrzh7MvJEuJPEYkarsjzmMP0s8JcUDNp46s6kieZAOcwjWV9f1QDXLP9vq/Fuzj3F5ANzX86BxCU8jET8ya2IQ2cUy4AICecRkExy+44KyExkuc12qWeuCVgHwVwENCwQfb3db7jz1062DPcSfnzdVSeqsriXFo4C1iBwuTjDKZ7OxkvE1+7s+WSTmlpSWGQ3dNE0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyoKIiNuyDRmA7VLum/0bNSrEEG1MGsxvBTao6jPmug=;
 b=n4NXt6w4P/BYYxTz9DBDxod6Zn9a2g4CXBVQc5JXFE5Q5xp8dIGr86ZUh/HpRHeFJ2sxqlAV4osgJSQG9YABVhOtR0hoiDQl31cJI9qxAtEmg9ZB9Nxe8RP3uMQukjMTRdVwoDZDNdJDWszOmRzYte1/nwDcQgUi5YoO5TZqk+opQmYbhJdVaEyf+GCC0BetXOOgaFw0UFkMExHxeuZPchRLVh3s+YPzmIEghqdePDsh9nI+fPBtipq7h/ykKJ4slUEzVFM7O9SvSJl8es1W6NOy9kCMp+F5oFqGWn+AnWSQnM4x88wVaZU367lBtVv4YD4+OtTVKRJTElBi2c9PMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 16:01:47 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 16:01:46 +0000
Date: Sun, 30 Aug 2026 19:01:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	herbert@gondor.apana.org.au, jiayuan.chen@linux.dev,
	netdev@vger.kernel.org, zhangchangzhong@huawei.com
Subject: Re: [PATCH net v4] ipv4: icmp: reject RTN_UNREACHABLE input routes
 in icmp_route_lookup
Message-ID: <20260830160137.GA3005591@shredder>
References: <20260829093400.1531398-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829093400.1531398-1-dongchenchen2@huawei.com>
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fa4c27-df6e-40e3-1eb9-08df06affe55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AJvLuyFkEzQfrdFxcM65bJjwLZI9sqCUxzPmNBJVfp+oIQ2OnUveUKKa2rVaYKefL64x3Qt0DveNfLChf/M+xv86J4RCNyKeGLkh7vBwtH6VK05mruVGGaidt9ESr2CjagV6sMmmFpy617jUQsElL2QfX3nMTfje9yorYR5cAgxso/c+sR3jhV6JUXiQMgS74ySOM0Nm4HCzXb44JsrvI+OwRoO04jcLTVdk0/0bZ1Hp9frsHCPC1oPaJpaguTiN1mN9JiahJkxEldVydc8af1pYL9hlRBssRKjODxjfk2huFXK50+sh+u4be6Xygi3la35Xf++2JJB5dJ2hEEHdv7ZeDZxawwVal6Me1Lo3abA19GLCjrwByIu+Zhp6FSG+GIgBB88TPJszjsNcHGwEA/5Y+bV+gcjOOR70CngsGBo3dLd5RJ8Ih5zOPmAhr6H2ESei6r3wTjplfWMqwLY8aDgcOywVyjvAVj3iLS+rVYTX7WMaNwkNSEdiHS0526UnBPINPNeWPhVZ/uoGEZD+Xl2TKdTvVJ2MDjUelECHaOB+uZyTQVDONdVCnl57Inek4mD0ZD4mIrnUYJF7zjLhZDzPZ6ynHFzZP/+8LUUcr5Kpb3gXftmhWylisrEN6PlJ6FWP0+2aY06dhL4SS4eD5VOo0R0ED+RKXAoy3KsYpQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EL6j+gqtdpHAeQt8qaFeZ/Ke7l4lIWFnEeJtORAm9FZ3SIzbd36Atr3p/5yf?=
 =?us-ascii?Q?cEfNnkoN+gx2V8sAirMUMAuLttV+Du48U9a9csQV+guKxKyzg2fE+cxR1Z0u?=
 =?us-ascii?Q?pbu+EJL8OKUnVyB+UAFm5iqV5eMsyIIMal1vBW5wRV6w+u8jSUTy7EhYpJhh?=
 =?us-ascii?Q?0e/MowQ/PXzuMd7mg2mxCkgMxTZo++Sy4w/u4ELC08HiV3eCq3/of9VvogiY?=
 =?us-ascii?Q?6WRIcOwcXmeMK1zFW4NWYMFrWM5uBVTAdNJbqDyw/Q/9J1FT3bQVG+E8Hd4a?=
 =?us-ascii?Q?miBR6MN5/IASI/RcoWibaXU3xTjjkZk2fpsfWcQEbBC6FEKXafEQpUaL4UFh?=
 =?us-ascii?Q?vhQ4mJbjgzlzS+NHzrDEFFVygAD0VAVgh8fgjyFyuPBoYaIS0kUjNIl5IzRp?=
 =?us-ascii?Q?OCqHGOBXQ0e4PbqXHo2KNX/OgFo2kctoilnWI0whJoLp6ugJoCZzjocgMBPp?=
 =?us-ascii?Q?iS5zzt/dHBeNGABWCsmnSAMRR+hsR3EdykNQjqhUt5U4zkz4tNBlEGSD2Dqv?=
 =?us-ascii?Q?Xw8OaHBXyBRwC66mHz4F7IRFWaLSd30zNqClLKsMrvmvuyPXNTs0LKDF6HLz?=
 =?us-ascii?Q?eWm6OECVihlkJevd950Cl7Pn0oJkyBjZh4Q4G/IcOb+ohzsX5GIiGb4x6bZN?=
 =?us-ascii?Q?m5yhhAXWcsNjX3wy7M/3ocsSL/DCJhK4viTp8k/3pkWljLkp5Ol96qK6yBQv?=
 =?us-ascii?Q?2Ugf8ZtIe9WD4Sidjq85nNqaK5u3bCCR2LK4Zt0LvbyDUWOzf2nfkbtsBS7a?=
 =?us-ascii?Q?TebMC1xSKlikTZoDSizKATnIFkblFjhOs536I6SoCkDjatB7IjALJkyWxWOa?=
 =?us-ascii?Q?wNdqWKU6/EvSwvQXB12Q7a0HT95T/n3UKBZ/dtPfRdwM1bbfCGpczJ1LbKzm?=
 =?us-ascii?Q?e1tjfJgrHCkLQBUtkQUbRx4YrEhOXD6S5YgkPMwY37Ktu/GMCLO+TDbjQrfQ?=
 =?us-ascii?Q?MFGt6yzp3neBRfPlc67/QImwAmiFFan2KJXjuyEYammTYYFCNFVE0OSGn5r2?=
 =?us-ascii?Q?14FB3TU73eeBWx5Ibj4TcOm2UjFz2YwF+x7ryHry2H1V8lFTlOq1aGn/S67t?=
 =?us-ascii?Q?bPd+d4/FYEnBKuV3xbB9Z2eRCdI/GVuCjBuGM29QHBhTO+tlJlQ+R5V/o5hB?=
 =?us-ascii?Q?OZKExVJ9iuJXqOujeJY3Ifpz/PRJxkQai0qRim8jabzlvqQGE+z0rPPIyIbT?=
 =?us-ascii?Q?hQQy7Yt7ws1qzD2zhB0lYu4nryV9movUDttgojYm+hk30KaJ/+KOqOozQ84H?=
 =?us-ascii?Q?J1uVJFzMaMaxzrrNxtNYuMfooexR8/Z7QB9+YbpEo4FNLVz5qHOenY8XYSdG?=
 =?us-ascii?Q?SwNRkK7nDpl8ZT65ryj6PqFOlPWYt/ffS5EsQ+6VI45tMPNif6AX+b+Wha6r?=
 =?us-ascii?Q?V/EWGpRjcGSBndH8gSkZp45lCoQPrTR29NoTv5F5zslBwf/j0E7Ax1N5Weub?=
 =?us-ascii?Q?xfoUwjHvV2zS4ufQi2yMTT5dbDtqx5ErRz4LzL+Kw9xrRv9kdpm2OuotBivr?=
 =?us-ascii?Q?tzwpMnZuSC1JCc7R2jr2so2/2guDu5FeBonRAORlRNmiSCDtPAsXQOy+sPnS?=
 =?us-ascii?Q?N2smOR0u6zXEuIVahx6y3UY9EkIyEKtJRV3MY09a8r5wNxHz0qs0GtATsBGg?=
 =?us-ascii?Q?Z0PskaV8HjRw0OLqz6hjcNA3ZHXCrMO2WJz+jlxl6oK47uuqBg3Sq/XkKYLp?=
 =?us-ascii?Q?PW1ZIeSZ7/OxSpeUpyifpCgpDWCY8VNr4awsHm/JCUInYrI+bA6aST844b/o?=
 =?us-ascii?Q?rWEeAdwxVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fa4c27-df6e-40e3-1eb9-08df06affe55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 16:01:46.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TpZVG/IC3/wUQmnpFcDUWc1KW45MgJJBIQJ+Y7m0w0g+nm5E4m5Gn611j1XfrgKHyxtJZQuUgbivHw0Fu5TIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087

On Sat, Aug 29, 2026 at 05:34:00PM +0800, Dong Chenchen wrote:
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
> Reject input route that is RTN_UNREACHABLE to fix it. The net warning
> is only printed for RTN_LOCAL, as RTN_UNREACHABLE is not the result of
> a race condition.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Regarding [1], no need to filter for RTN_BROADCAST because it is handled
later on:

	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
			       inet_dsfield_to_dscp(tos), mark, type, code,
			       icmp_param);
	if (IS_ERR(rt))
		goto out_unlock;

	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
		goto ende;

[1] https://sashiko.dev/#/patchset/20260829093400.1531398-1-dongchenchen2%40huawei.com

> ---
> v2:
> - RTN_UNICAST judgement will reject bforward packet. Only reject RTN_UNREACHABLE
> v3:
> - RTN_UNREACHABLE dont need warn log. 
> v4:
> - Modify the comments and commit msg to make them more accurate.
> ---
>  net/ipv4/icmp.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 0caedfc7ca92..288da11c5de8 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -581,16 +581,17 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  		skb_dstref_restore(skb_in, orefdst);
>  
>  		/*
> -		 * At this point, fl4_dec.daddr should NOT be local (we
> -		 * checked fl4_dec.saddr above). However, a race condition
> -		 * may occur if the address is added to the interface
> -		 * concurrently. In that case, ip_route_input() returns a
> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
> -		 * be used for output.
> +		 * fl4_dec.daddr is not expected to be local here, but it can be added to
> +		 * an interface concurrently, in which case ip_route_input() returns a
> +		 * LOCAL route. It can also fail to build a forwarding route towards
> +		 * fl4_dec.daddr, for example, when forwarding is disabled, and return an
> +		 * UNREACHABLE route. Both cases will result in a route with
> +		 * dst.output=ip_rt_bug, which must not be used for output.

You should have wrapped it to avoid going over 80 chars.

>  		 */
> -		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
> -			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
> -					     &fl4_dec.daddr, &fl4_dec.saddr);
> +		if (!err && rt2 && (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {

Same.

NIPA is using --max-line-length=80:

https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch/checkpatch.sh#L21
https://github.com/linux-netdev/nipa/tree/main#running-locally

> +			if (rt2->rt_type == RTN_LOCAL)
> +				net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
> +						     &fl4_dec.daddr, &fl4_dec.saddr);

Also here. No need to split the format string itself.

>  			dst_release(&rt2->dst);
>  			err = -EINVAL;
>  		}
> -- 
> 2.25.1
> 
