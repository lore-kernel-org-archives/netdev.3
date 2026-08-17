Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBF442110
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976151; cv=fail; b=a2GLOdCcuwyqLu/fDWrQi+lgw+7e7LkubDmfiyBX9otvre2rkjiK79DlCnB995Tzbd9Ous8dWt0g//+INpbMAtQox3JYh30ac4TYx2VFc8PGX1G9Nft0yWbiek+FYuN9lq8rEOpPDwpDobWUsMR2qqGEZ8Kxv5uREumiFwd3+fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976151; c=relaxed/simple;
	bh=oRNmrC0P4mI06eF8wX0sfg1yUzSkQoJ2skafEwwuJYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnDIHrtlxGM2FKpMGYPQOLL9qx4gZWV3ATK8124ze5/VM3P7SlBxF8fNeAUdXNfIlfvxEDi05bPCxgnN+YAoevCBR4Mw5kT1NGBdb3aDwzC+lDKcFJqp9bsuEANBrTq2FztpI9aq86UIIiRrNaE4rGlHcrB0MvLTEhYsAlNVIKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pmcezjpe; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pmcezjpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO+TcuCon4ydSSicKgleaiH+r70OGmoOW7ZFKo0qqKIb6F4PdpFDzi9HRb8u6h5d+qNqth3zV02hoJP7+eXLzHkFxlV2Y8ORxJfDgOuTPZRQ/4jh4ANuXnKV2Y69oxEF8DJlyCDO7Him0V9dBHDQkIDLkWcZmvQlxi/iiDo6CMbtUpBHhWp8bF9FbBGqScDXlwSYVKBgvcFOvzF7l/s4vJ6adO4FQljG96erl5VLkPsG7GV2QnD0+Rf+CYzXxxAtWXo3bjHPy7L+Iw8RygXPfFA0q6R+qYC7o2Xuhh31sFHAy/W3t0ydYS+vXTUdTtg0LmmDF2AkCTb3FRzouOjXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtYnNR7JnUv+78NvEvp0sf1RqWlM55s9vb9LtwxhOk0=;
 b=iJ0YpT/p19qbiZ/qVxM/V+EX49kGuCv4ibuuXs/P8JWpQAo+vnyIxZQd1r0cZ8aZ3+nTXLlxy2thnCAMcrifRG2027NALjJ+0IO23rR/GQlej5pMDptGhQ3kjhW9bStZjBTolK8vDpfToCsUev/Qyde2AKb6Yh5vYxZIfubYG9yAzeVzLBV07W5m3OjYMf2WcZZw9PZl5H96BQ5qHmITdvOEpahW21w12hHLSAmuwMQ1Ts14PkqzdaficHzlOf0kLvwtMQLcts4RUmYEJsYE5N7YHidqs03I0vx+kF/+CFhjn0ua3n7xDd7uJX1zvF0gptpQHZt+CYMftQ8JKdaXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtYnNR7JnUv+78NvEvp0sf1RqWlM55s9vb9LtwxhOk0=;
 b=PmcezjpeZnAn7krsevynMAgAjxEnLnTyGlk8lmUB5sw1CZV6JDjIonHhvT1wSaSxtL0ZvgV1k/azSHmvxboz69cZxPkeu0K1G3KN95ekYzLH7PIajifczkW2694G17MCFpn44PZZJ7NuwHlvems4ao6wi7nqTowRgMwqrSl23zYZ24g8zygzmn3lPBd1ciPdD+po8z1fRYEnVw/jaH906RivVgFk0yTYCz4zs0cIIIRag7oh6HwLzIdoxF9nF3GcmRr7YP4My1PAOfyRwqu6dOM6CDNmJXKcChdxa4wtWgGx9uNCFa50Fn+fCdU/Ziyk2mxdsDrsEr2XCyUprUOpmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:15:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:15:45 +0000
Date: Mon, 17 Aug 2026 17:15:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	herbert@gondor.apana.org.au, netdev@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2] ipv4: icmp: reject RTN_UNREACHABLE input routes
 in icmp_route_lookup
Message-ID: <20260817141535.GA432475@shredder>
References: <20260815075102.3426068-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815075102.3426068-1-dongchenchen2@huawei.com>
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 8242e47d-767f-4942-d624-08defc6a0702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3NaA3lFemI1k/Q9fR3l6bZfidnvmvhTC/FEKsvh72wwQlRbV7aRc+YuBzKYYY5OS2+EPSg/En3j3Xvty8WgCvrFMRR3OSmDTJfWjh/XGyawMiLDF+fsrpmipgQEUudOpOd93K8PT9hSPLU2liWCdyxz4g7xMPtWS8vIPJONrfT3dJo8bu/RRCGrv9xOGpqiNo2URzQUNei40ouR+QrJgK1fxQC2OqsgKBiv9u1xWGphI5PDnOj3EsnYGy5PGrMYmL6IW1YwxhyiX5H+Jfvf9hMv00H5F6+1Sy9jt8M4IQgMobNnVtoyW2r1VrbopWta6lXufSFujQi2scva+zGEGC7PMrYIB7O7aHFr9dC54h3L+Vu3sIagP2QlMKNwpoVmzUegN7yjYmbAtsEum2A9Vlo/rAerfccrWMEORXd9BqJwnfMyfvpTnQaz+tVWzjHTFV8hlSJkrUFrHHRIU06jY5p1kM6JcIgqapjhOU9mm8wvxUxEN90TrRoOuyuuUnzaEw7raPCyPQ2Xd1mEbaWfgcsolXo7tN7jg3lQBjfMGtLW93TNDu342Pk/vCP+kahWaKLCjgkG7RPt9fgqxVgHAVa/YAx96Ssx6EVYRlTHINI3qC715xJDvCcUxvr4zbilN6JIbDCNUVJVgzfsOO4VMJFCyyulYUbDMjSwRnN5eAg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQhFY+9YF1W1+Gp8+47YjHy9xot2y36SvmuADYYCasuknF/sG/ztaiWLQqMt?=
 =?us-ascii?Q?XI+BW73wAAo6LTUkwo554waqG94wX3B4mriQhYk05NMn4thX6G5RanSfPjkD?=
 =?us-ascii?Q?7gD5jqhfBhiAz9UUholF2tkXCwjjYanFDiyGzoXIS1L/t2P3fxg7Q09qeSSa?=
 =?us-ascii?Q?MAF3hRTgvZYFTceTbJYks0UzIOVCIcvEfTyNVzKBa43vCD6q7tVU1gWJ3+is?=
 =?us-ascii?Q?JuSo/UM1u3MxpMx7S3QlyhKpe/DxChJtm32wsadmm0wEi+QSHdMh7bTGunxq?=
 =?us-ascii?Q?7AwoHw5orw9KZni6a7zVakr6BNQ6l+b5j8ftgQfi/OYCj6qdO+xW+Un8SmKn?=
 =?us-ascii?Q?hSxl5qErGs1xTbnBm7AUkXumtYCJFaiTHOM6J3ks2gMf8ZlEb0WGIZhT49Qx?=
 =?us-ascii?Q?ql/VDncm/4XfDQCYiwwmRfRtekJzOtF3AT3QDmvZK0jKL0v0cFzYRcRdCdjO?=
 =?us-ascii?Q?CJmAGygjm2Q3Tx0pqd25zl8Le2uNKMHjr70F9UFVxNPx9ncxuwiQI9/BFj16?=
 =?us-ascii?Q?IraV88u2Tou8OOeKCczERNNSpytfD2CPkcbgLoEi9K1y3tSJapOrjE6jaPjx?=
 =?us-ascii?Q?97DRS0P+G63jlloh60SkI/B4JB9/fn9wnFk349B5++nT0BNl78wR88gbCDKQ?=
 =?us-ascii?Q?SxdppNJlMcgUAFr9xe+bSr17NaOcIMdCMfpnCx9dPHqSFN1lL9HTheBzZHAM?=
 =?us-ascii?Q?ORa6HXg0dcjaSCzUDTYVC4ERD8wDBZBXUOVAaJOEuaB19heiIzGHo682Eevb?=
 =?us-ascii?Q?Zm8M9wjLwg3i4I7DD9huW2TUjfVp2qWaLlHVnp0xJwBKt1IL2ZXEq74OZcHg?=
 =?us-ascii?Q?y2QeFlYAcP1kmpmEV58oetzBFBea8SaXQU9fkrgsZ9fv0sKab6Jm5HTt0NSU?=
 =?us-ascii?Q?kym8Qz8m9pa8Nckmg5dVfYZfYPgBkOHa5Muk9DkzK8BaK8RGeEdYnNEZZdN6?=
 =?us-ascii?Q?0RaKvHk4RDbyxAQIZPc8uBN2NlacsXh2oWc9V454+JaHfA8x82fpChgzTMrw?=
 =?us-ascii?Q?fikW7BZrtyUgGT9QdfBEDVLQ4W1tqdCKBP3FZ2VdLB5cflToLsTckvZAzQgu?=
 =?us-ascii?Q?AN0PEfnyi3Pzpm7zaFYyRxoYzx2Uz2jgYmbmkHOlTCVC6r6HwRjC7KuDz866?=
 =?us-ascii?Q?8490r/v7LD6BAzrAW0Ttmj5IyGMclrp4h3XgLwuLYIG/UnmsiGYLvm948uLt?=
 =?us-ascii?Q?2zAsbOLFOk4lv2oOTmLzPAv4rOk0SlBKaDSGDwspo3kfGvR90zDRpTFNsLEa?=
 =?us-ascii?Q?rz9FXNP0CPnB/Ar+yVKxiiWpvlk0RugTd5CMPx/a6Xh4UO8H3CLqaQksJP7d?=
 =?us-ascii?Q?eUG/Htd3e+Oy6S19hjpwn9uoRAYNVkCwmKoudjkeSww5aLJZU3rTPuDLT3rZ?=
 =?us-ascii?Q?RiTzRrr7ztoTG3MrHXHk4foy8PY2DbXNg+7AWhKjhJkw+gK8AzvCkoPqX0PL?=
 =?us-ascii?Q?lCXwkrZ4HcRTXhBFEqVjG3HMFtrXCSoI/QOwCbbmQHTJhYVvSMUh7ZkkH7YQ?=
 =?us-ascii?Q?rl4pS2wnjXC5bW3VwGyLPvHaZHS1vseb8cXyG/CxpBLjws7r5N/TeiU9bHrP?=
 =?us-ascii?Q?vVjuqU3wB/ny8qfVvFqBq6cjpmgYz3e60W6v1RzLi60QzttQXiYLkZdNDYRB?=
 =?us-ascii?Q?7iTZrqnEHZHmBf7I4Ksuz2EF/dR1P/+aTad3oXcXfsnQQjJIe9fSPY/O4Mmp?=
 =?us-ascii?Q?PsU5eDgcKE/H/k+MPbtH+W8V1hNIounZI9qkGeFSyNajf8aw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242e47d-767f-4942-d624-08defc6a0702
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:15:45.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N/yffcQ6zvVhOcuNkWqhxSqhJI0VRHtDg/fZLXgn/Hrm2qDS1tI9RN+IrOZMXtX4yVwuMrKq/sWXYBrzjJCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838

On Sat, Aug 15, 2026 at 03:51:02PM +0800, Dong Chenchen wrote:
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
> Reject any input route that is RTN_UNREACHABLE to fix it.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

FYI, there's a new policy regarding AI review:

"
Patch authors are expected to proactively look into the AI-generated
reviews and handle such feedback as any other kind of review: either
debate it or address it. In both cases a reply on the mailing list is
expected.
"

https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines

> ---
>  net/ipv4/icmp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 0caedfc7ca92..4703d8dd6b47 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -585,11 +585,11 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  		 * checked fl4_dec.saddr above). However, a race condition
>  		 * may occur if the address is added to the interface
>  		 * concurrently. In that case, ip_route_input() returns a
> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
> -		 * be used for output.
> +		 * LOCAL or UNREACHABLE route with dst.output=ip_rt_bug,
> +		 * which must not be used for output.
>  		 */

Why would the addition of an address lead to RTN_UNREACHABLE? This seems
to be true for RTN_LOCAL, but not for RTN_UNREACHABLE. Similarly, it
doesn't seem like RTN_UNREACHABLE is the result of a race condition.

The comment needs to be reworded to reflect that.

> -		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
> -			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
> +		if (!err && rt2 && (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {
> +			net_warn_ratelimited("detected unusable input route for %pI4 during ICMP sending, src %pI4\n",
>  					     &fl4_dec.daddr, &fl4_dec.saddr);

The check is fine, but if RTN_UNREACHABLE is not the result of a race
condition, then net_warn_ratelimited() should only be emitted for
RTN_LOCAL.

>  			dst_release(&rt2->dst);
>  			err = -EINVAL;
> -- 
> 2.25.1
> 
