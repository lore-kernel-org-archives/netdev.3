Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BF376BE0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949013; cv=fail; b=cjP9Ky+Tp6ja2WCaK55IsTB7g71VIgkGRlIPCfNsxYaRpuZw9XALk5QMA4Sx0/+1nkO7P+L6YgSi3r6kLCpbNdSQ60m6XrZEigz9LbN83zFblFn2+8d8KkpjAlWLmMovd7kDoPdXIVK0/eTdRfdAzfAuengG6T6ux97Lw3yD574=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949013; c=relaxed/simple;
	bh=DBeIh5Np1bfRs6TPwxC0QtSKObiTWU5qYag/HEP+hnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X7NS6yUGMNDl2ipK/A4XEZsUV+rQ9WlNRnNb0BJcv9cGDqJ1OTS1Wglq1drDeoZkuBjxjjkFWWk6Q1Cy3bMCAFE/Fp83T9fvFXlZpQDw+bFCsyHKPPoxiDxyyGV5I4o/l5m+kJ5VEfzsBBkV8sFKzPSdGhGktz6nvFQoRZP2CcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sprFqB40; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sprFqB40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMPq44+NvptmQvqXeYGhqs0AQhIpKl2J12Dm6pbw5T6NpmJErTtGJVRmsg5aPjh51M4X8Js+U9ujcU+PDEnBFT9KupElrNc2QUt8/Q2or4mwE96GaATnkL+1rMqKwxMKVJDr/jVzecBGChrLWGoOl28KArmK8WiDRH5OWnLJVktLAJIcBtIHqdl8j0snR8uvHgedas6vU93OYLj98I4AIy75lNJdOwGIXE4oEcGavv5PJNyvZnmIzvAnkBM1OCZ9+PtNqEv7vSxiB0AuKHaByz8B3PbM+a789WCagjePWRqD4ouZCglt+3N+h0pIvHfYd6VtsL+IrEaJZtRUL+e5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av3Z8uO/SLZpYgrBUHCoj+p+cPkQYXFU71mADo4gUTI=;
 b=IoQrizM+E5S80e5dHG32Ru18NxZrBc+FhiAv6tYJSXretnTIpFviFUWryLhQNZ62L/rCEI5CLoAvimxRf7TLXQ69nXDfiMFRCV/+LUfuCXUYzd0iP7WNTFi/4p5ayrMCBGX8lk1FNt5YCdgvE68u0FrM946QUAoZkhiyyWR/54mO91cI2lVfBJTvQ/72lo1V+MeWFNW55uJ5C9h0qugAyJqorPwwhvjYQ2lQhKKQPqZkgXRqEl/L1v7JfESoIWFtTiz+ll6mLlfHSzOf60M20CH2uE6UfNqA3EUZeclUO0VjEfDYkiDacnNaEDNM4GO5zSuT2jMH9ocEhV4lIMyIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av3Z8uO/SLZpYgrBUHCoj+p+cPkQYXFU71mADo4gUTI=;
 b=sprFqB40lE/GceHZQ6skcfWkRVsaqbBlB2nr3GQB5Q+YnADFZ6cWSRHH9AvwhRGchm63zL+ntZhtGeoauVp90YAVmPesUQd3DpbwGTTgKgt89r0yd/NF1BWM69lS49N/Tr4o2g+7QWXbp4BGLVEjL9lJu1GgdeTrv6kj9owF1F6gpNd58gZ3aCNAIO/lEmKdEYSuLz4YhlC5fpw6AhsUrMTNFsvjw1Ws+POFahGDqytkk6OeNXJ+Qkf48KXXGSBWA+1Nz4xHgvUlE9aqpzifqSOaBAO8MtyqFrEjJ8SN03B6vXw6U0fkuP0dQOnBLw+2KZuqJQqrYEaFf6L7SzT/Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:43:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:43:27 +0000
Date: Mon, 17 Aug 2026 09:43:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, atenart@kernel.org, yuehaibing@huawei.com,
	kuniyu@google.com, kees@kernel.org, kylebot@openai.com,
	thorsten.blum@linux.dev, maoyixie.tju@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v4 2/2] net: cap advertised IP tunnel headroom
Message-ID: <20260817064319.GB196908@shredder>
References: <cover.1786542637.git.zhilinz@nebusec.ai>
 <ba04a1fd6bfae2377607fad5d8f80f7eb80fd4c4.1786542637.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba04a1fd6bfae2377607fad5d8f80f7eb80fd4c4.1786542637.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0da018-5f88-4734-d1da-08defc2ad7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ymiig0v+TMzW5yKqyFvIboHaiZFU4Y1zE0XrwwGErihVjYhGBOWk03Gp7xFXFBmAtqQaQ6Jt3v//x/48QxQ1I5nl3Ux+K0VT7EeCV6WK4ysNDVN3Rj/vdBFgBYUhU0m2xFObdXS6VffU6S6JJuoBXIfCyPCinzBdwRvPs3IUSd5qUIRr7G4jMVzaWOSRB2nTRwGzemKozr+dMqq6XXfeI3LtCmoQPoB1kwmhf2wSjavkhx79KQ2EVqi89MijiKTJwcS0yGz4QX1lU7JVifDcgBQYfRamOVROKO/F1rqIcqqspTjqqrVMhIFni75Iz/VhfskMsn7KQc7V95yCybtBJTMn8hPF/k6z3TFNxAMChkza7IHQwHuMO142lDmTg0HXl6zbT1XTk02+EBoZxMYVOZPwHfsVjKydRbLuvyAJvfHH6UQpx3ypItmswBFByRfj96UqdgUXZqabaW8YGw0+cRTYWw+ShqmxnRFa687tnPwTkJJCSqyQndjSs2m3eljPvAYUfhfQTkxlUpJqFfzF1QGEM00nO9bTFVP8NYhXNcyA9BQOo4cLZ9zj/sp2Zj3QJ0bOGUmbEARSlmJqja0LEDuvcKp188Xjz4DUQXHhBNX3Qp0lLcNFJ1JbsrcLfeG0yQVnY9J/leBHa7oGcX5F6uEJEk3XbtZ7MPeixc2qWjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5ZKPPOGou3ebf4l9atW6JJW7uF/aDW+y6NW2fAsQRORh+hNRFtl+x5eOYni?=
 =?us-ascii?Q?pL78KyK+/N6RrPygeRDHhnDwZuWgOedZbem3SM9+Bs0bnszAvb5/9U9yYsSw?=
 =?us-ascii?Q?XdO4Y8Msb0pGC9qXflKjz8T+0kYYou66uhKJHNSFjTNTu3Wp+bwnBL3W2Liz?=
 =?us-ascii?Q?Rs3cuoGLod/85aA/ji64NdLNClSEWgVIQCQLdPWEnb48h5lGzlA7QiuJwtu8?=
 =?us-ascii?Q?zgyi0TQOcw/DHQ66XB9JkdYkSSRlbXnpY5ntY1vLcpj+mwSJmK7CjuiXrre1?=
 =?us-ascii?Q?/oOcFN80HH5GkomO3yjtI2ahlSyU+VWrtF+f0I0ZXBONlwTEwceIqFM3TGLm?=
 =?us-ascii?Q?rc6DcXvR+vsqGiC8CF7U1HPKebutbjqq//tAlN0fNX1k7upUddmK0H4hHT47?=
 =?us-ascii?Q?BTfARTeJUVJLcdFvUayb96SKXZ7uOOf0kLqKk3v8cTx7h0+2OUpiOLvGuTyr?=
 =?us-ascii?Q?yU6vebln6leRHDN7c5sPW34/1755t9setwh40I+mjBV/tnlgkjgGq0lV4nvv?=
 =?us-ascii?Q?zKUUZXY2NtFvaJ+PC2n8MYMoa2l9Fvgr5/oPG9huufN57hRAqAIptTLiA9fn?=
 =?us-ascii?Q?9Iw6lvzw17YUGekZTRPr1IT/3WdpWfSGXm15CF/vBuN2GI0cQMK6pq5LgpFp?=
 =?us-ascii?Q?UED7qOYlahU/GUwQVVhvEH2XlbMVsz9GXqercyOwhxnpz21Qa2L1csAf5d5A?=
 =?us-ascii?Q?fJ4avWwrQYqBYQz9rhyLRvYdVJlUuZ72/q97L5mv6oiDvCMkf5OBTr+YCq0d?=
 =?us-ascii?Q?d9Q4V8PRtNRebLKQrAXtj3LRtbiBTsfqhyZAiIujZ/nY9+UEHDIC4pM1VMnf?=
 =?us-ascii?Q?cWAx/ODrXsBx4H+ZsnPlTME///0i4ly6fcAVkB2z8+3Q3wXmKCgb3hOBNzMd?=
 =?us-ascii?Q?7ekNjrrU7x3uNyLcl9cfpb2jlL1mreR4Ypp6e12n8F5doIjO1xAu5rpxeRNt?=
 =?us-ascii?Q?orT+sf7qb+8DStk5TGpSAHSNxN5WvTCX/luS92NadWFdZrjGlS/enS0CmU69?=
 =?us-ascii?Q?TUNVOQJWpW6woORVBJie+idpjLEwGULXarVWwnVoF5mTQBZ1Tr30R+8lP/qO?=
 =?us-ascii?Q?lnipSqY7yDgSigUhusAneKVY+z/43Ia/fo1zp0j3aijE/SF5b3l81WBNhOoM?=
 =?us-ascii?Q?ZMuHK4SJjMidH83xJa43pQ5a7KLgWWABs4MELDzCBpmj+fDCLiAZUc3U7k69?=
 =?us-ascii?Q?04pfOO0vLWR4yYQ1KSscwUzYJQvt4BaANYH3b7b0Dk62muWHxQOZ/DoUssGZ?=
 =?us-ascii?Q?lG0YDqEbmF3lGGwvB4P662142C5LoMf9+0ETujAN8A12DWhryHRfEUjov3DU?=
 =?us-ascii?Q?3MZPhlbLGlfDSbUHbzx4WVdAzHxkZIm9psmMGMlYElN+ewRiF8poV+FzKg0d?=
 =?us-ascii?Q?b/poNSBeB1NB3eBpXC7Aqh6NoA+xVDZUrtABuNUqzIBBZXOyihRv2JaJSbc0?=
 =?us-ascii?Q?EEJeGMP9d8hdANsDaWq9AvzoQl/IaazQbWC0sAEEqrB7IOb7xpqmcbpfRiGV?=
 =?us-ascii?Q?j/YWzCW1G2zoJzs4S6oBF7/Gyz1XQsz6ossZqQx+963RszSKvMbwrjUQtX4k?=
 =?us-ascii?Q?6J0YTRys7OYZymab72/gFknC8BJ74nm+uAj3DdGOw+WbmRJgNVcQUpxrnVlC?=
 =?us-ascii?Q?uQhYvdkOP6fdpLvF4tkGSVlv8Vk468Ubsqfszvnh6UjylEeKG4v/pgX1r0iu?=
 =?us-ascii?Q?0balYNjHNIqKCJMZApsQFPwXj/Ow9K/nm7NcKac7DVfjfHBI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0da018-5f88-4734-d1da-08defc2ad7d2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:43:27.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqW5i+yv/JGAP6D13V5wh1eX4oeDSTQ8Be0J8IOIiL3EzLWHk1qRdA7SFjTK0z/T+MvBWRU3XoOxOsMtI/6T7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

On Thu, Aug 13, 2026 at 12:22:35AM +0800, Zhiling Zou wrote:
> IP tunnel devices derive their advertised needed_headroom from lower
> output devices. A stack of user-created devices can make the derived
> value larger than the 16-bit skb header offsets can represent. Once IP
> output reserves it, skb head expansion can wrap those offsets.
> 
> The runtime transmit path already caps a growing needed_headroom at 512.
> Apply the same cap when tunnel configuration publishes needed_headroom
> derived from a lower output device.
> 
> Capping the advertised value is safe: IP tunnel transmit still expands
> the skb when a packet needs more headroom. A nonsensical stacked
> configuration can therefore incur an extra reallocation, but it cannot
> publish an unbounded reservation to upper layers.
> 
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 70c1710910203..200d0ba1a40e7 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1137,8 +1137,11 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
>  			return;
>  
>  		if (rt->dst.dev) {
> -			dev->needed_headroom = rt->dst.dev->hard_header_len +
> -					       t_hlen;
> +			unsigned int headroom;
> +
> +			headroom = rt->dst.dev->hard_header_len + t_hlen;
> +			headroom = ip_tunnel_limit_headroom(headroom);
> +			dev->needed_headroom = headroom;

"
Can this clamp in ip6gre_tnl_link_config_route() ever fire?

[...]

So rt->dst.dev->hard_header_len + t_hlen stays in the tens of bytes and
never reaches 512, which would make the new call here dead code.
"

In patch #1 we fixed a bug where hard_header_len was summed across
multiple devices. If this bug ever reappears, ip_tunnel_limit_headroom()
will cap the headroom and it costs us nothing to include it here.

"
This isn't a bug introduced by this patch, the missing needed_headroom term
in ip6gre_tnl_link_config_route() predates it, but the patch adds a clamp on
top of it and makes the four sites look uniform while they compute different
quantities. Would it be clearer to either leave the ip6gre site alone or
mention in the changelog that ip6gre derives a different value?
"

See above.
