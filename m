Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400113;
	b=KPRP7koS8JiaHP8q2Mvcn8qI2v8HurV87rOuixBPtw7HuaghAQVMOfNmnnLVaedhOIP9
	 A1Sc4APSmTPOJ8Bx6/Ia6Wn3WiQ3/SG2+0MB8ujwFFlaxCKxW5IWLikjchh8kcgMC/Uce
	 JK1Y6oFRDkmNegqMs0KuirUSg05YU8+B63qX9xWCHEXBEiTIJWCTHvJmtdYgZmF6+/pDX
	 QW3SUxP6Jrk+WeRMv/sZRP0R3+vOjG0P9KTNmjK0ftJZIqCzHcV2c05lj2YUrNJp/aTvP
	 I+9fdfBVmdbla8FoiDgHpr0mlz/QfXBXSIJ/XQPZzGMfQ95so3GURLbs8Ow/o6pPqmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400113;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6XxI1lej/4bAZny7WvuLd3PNjUGIhnihuBTGy6MrEPs=;
	b=k4K6gU5Vjku+zcvdrvu53gmhfjQ3YFVJL9fdFogX/JyobWL0KKNsusw0J1FPA4u2JS6T
	 0wqi/To0i3IcvcLsDh4VOhssMBz+EH27/7g3D4QkkLcT+URjfK7x45qYLE0X4qBKshWT0
	 BXcBycxB2SbQBqLpewy5sbZJxNBdfVBNGDBf19+gtH1RG2HroDVLmKLvKAU8RH+2piLoX
	 iSH3bSfKtIN5nDNQllaCtF1yBAN19uKc9kUzaM+sN4xolYpTAy8Uu4i/GnAfTzXMqPqY+
	 RDo1JfGhtdagfELhNCkMNyGMdfzTWbqvi4NlDO8CELzTlaqwGg4czfDBmfkkkpeO5/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XdvBXUfV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.45
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D39606A333;
	Wed, 11 Nov 2026 12:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D39606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XdvBXUfV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnOCgYrQhK/SHvl7cZt1j1l+/424LWiWTrrqp5jZfQLe9AhYdxdL5Sdvv60pGWG8RJTExcz25FuuMH6KVchCBHW9U8khuo2oGdxkicutUkUHR4M+Jye0AbTd72oJdSYHmbHcDx/iMHUaPBbSfP1BgeuNvRiGwzXnbavpPLnGwYAiXt/7WjlHI32puv2yUBQA++CAxjBx4k2PMnthP9vJu1oybc+/sGRwsPMNPD7qtAkHLGau+gGDoUzfhnxJocdM2287cgYN3OVhf/6XOG2sPaOi2BGKZjOx27iokhcFv477WMp0okI1ZmR0RJc6csP9CB2MVMhnW79+UFtip2busg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XxI1lej/4bAZny7WvuLd3PNjUGIhnihuBTGy6MrEPs=;
 b=RPi1cMXzXzHl+lBSzvSF2qe1unAHKroXZet6Xdc8xIWu86lRwxm3rdZwj5c1xMgAeB9gjxx6gao+D8BwvLNCmozcbZR4BKI+fXFuKAsbQ+jHoQBe6PsB9iuIzFTU4gZj7/flVXU6kf/J1ZdPx0HKZOBSvIG/ofeeL9a5Hkj+f3NMnU8YHJKPyjvsFjFtI1A0Gz/4o+ZX3Ih+IzZP6XbVwlpg3SRvGG1BVbKso/P4fbkg6KoNQfmRQgfUslBzkRzcJaElgLFiUXrlngGpcif2vAQqM2GurJ0YnZIZ2PS1JpMjCiCUToRGCtojabkByTHkJQaFu5qfLLbvCI+1Kc5xuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XxI1lej/4bAZny7WvuLd3PNjUGIhnihuBTGy6MrEPs=;
 b=XdvBXUfV+8GTnJjgRVclDLq01BwfSOi6Xa0+Whm2+rlLJUjEnaPMvzy7pgtTxsvmQaN8qGkafCSXzfocauOUe1Yd9jBrTqLfmGkzlFAnNxyLHbJ17+BbYTimrratQZP6oG3U/fcTVw/BfPgg1IhkmKvu/aCh5Um/C+XDFQ9pflqMteYhg0Ftj6Slt8KYrtv8cmrlCGY8uuYRJGoXoy9KOC/jp8sErK1/Y5Pdbogi20WGFhHtS1Zk73bsklkm8IzYIbsLgetTpYqDfgJpqwMEaHAtbj3CcuLZwH/bZzaWRGhPtAGG3OAcZdlSq/XRc6SpbovVTxKijtTBQpkK4qlAIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 12:28:05 +0000
Date: Wed, 11 Nov 2026 14:27:56 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net v3] ipv6: reject routes without an inet6_dev
Message-ID: <20261111122756.GA2583712@shredder>
References: <tencent_91DA7FD8277B509C55906702D1E425FBC906@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_91DA7FD8277B509C55906702D1E425FBC906@qq.com>
X-ClientProxiedBy: MR1P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: f77b2736-f123-45df-6b3f-08df3fef3c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|261009223027099003|10067099003|261022115727099003|3023799007|261028144727099003|261026140227099003|261026121527099003|261021135927099003|261102123227099003|261022075727099003|261021121427099003|261022105027099003|56012099006|11063799006|6133799003|260925022911599003|260925021911599003|260925021311599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZRZOBTyCB4RNew3zY11J4wOQfYcbBsbOwxjA0R+PrZmBoS9RvS+A3TNqMgIGU/I8OxtufLH3BeHJXJ6N7HHSM68d9wyFqssOyj4SOFPWGVZXJV32dQpAcHRLF+N7sLY/8ek26Y43P4HQkIrw+yDAH/OTSjBnO/ZgUuh6ZhZssyUPgTCZPOZonWas7gpFMgwqwdsfO5b13kV/93L5Gl1frpMXAwJN08IE9R+OPmP7iHEwBv7vQuY86mnapnsc0M3taVUmGVohlBtkkjCS5k5By355uxyfIe3TZAICPXQuc4uXyH+EnBSyTpkGKWXVJw8WC6jP5ZEnvb/6RrMK/xfybsJ1s7hTdDw4lFFKCAcIQjy5aDw82Mc0syjo4gbzn8uiOFMiXObdATZTms5ROHaEkaxc+C04FKodndqkCboL+a0LC3vCaRkhPAoIyU5w0T3i9xLVAV8aRLoY/ge6YXgtxy716ldzRJojHA9gXVBq4zSV7FxY/+UMnuDuhpZxcmiGrMmRXs5cgpI8tkIpJSrEg5folDOaJ4wt7ZXh93NCKhxzk09sxZH1z+HIGAVM8L7hYKsK2ldDReWhjH2WXUbgBx0MbKObgYqtoybYPDQOIyPM6dLYcXtl/ydplskzE87rJtpq80LuZ5fg4dzxOzExSPI+FuC7LBRrWiXMmc3V4/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(261009223027099003)(10067099003)(261022115727099003)(3023799007)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261102123227099003)(261022075727099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(6133799003)(260925022911599003)(260925021911599003)(260925021311599003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PzKH0G5Cn4ZW7arAylg31He7K0vE2yUdtIkhW6Kz7cqeInlwouhb+eUYcAO7?=
 =?us-ascii?Q?ChCYMG+n/acW3Y8i0wF6P7VU+zNlYIzRAAW5jTg9SMFRdSVY5O7DZbRn8AZP?=
 =?us-ascii?Q?JEmutPR2FE1efHBVVAf6W55ZycEmNTYhOiVAsuBY/tqU2Br8LlnjB5ERnlaQ?=
 =?us-ascii?Q?XFHBSJxDxs64jYYR0+0enZ0m9ZmnFJpaL8HpRSoN67pVhtkVxiq05HYqmvml?=
 =?us-ascii?Q?Dne61//OonXfoyiXMiB4uT1VDYLi5zAEWofNfb8IzmvbgG35Isv2zwzckA3d?=
 =?us-ascii?Q?wLoxqeprhvE1l0S5o0bzXCeTc6qjnFnhrbqYdbOMRTJ98/ir9au2H6G79ry5?=
 =?us-ascii?Q?qRjvLMS6aSPg31X9n3p1H10IJPV8YraDJFh3uRbCxJgMhlDmMQ5cmpuufOr8?=
 =?us-ascii?Q?U46yqXJPJhyVnSpCatqw9Fm9dggRyLggF/yPwNdz8Ds3q+vhOpbZIKPgQyyO?=
 =?us-ascii?Q?CBHliQYFFBMlNZn1xVsgZlJ8ptVVymxuKnrUQTcb12LgYGBVc9uZQt4dlNsl?=
 =?us-ascii?Q?kRQZ6u2BVtzYLi71lpper3vTpBErVtaUJdH0JzQYHiioIUmyvq3cKuJq2sCk?=
 =?us-ascii?Q?X/GRwbvrk9S+Sgi+srL7/bLhefzlsgS0v922RS97o/4qZ2OuxjI0zCPhLETf?=
 =?us-ascii?Q?Ua8B6n8wBBVVjGoombCmDjCJ4IFj4aent7R5Q989NYN5dulBSRKQK8tizcsd?=
 =?us-ascii?Q?6ZrTDj4OpaH9iA9WpD5MpdFO04ZpFNYupkpwmDGK3wQtv2jvxiiQzE1q9Ga4?=
 =?us-ascii?Q?40SJaCIxD1GQJ9Y/1yMg4kV2hyXRUlxNUVTNN9lKwMjDycHzkTjtrmuV3egR?=
 =?us-ascii?Q?jMOCGvaPGYclMhFumLasj7/d3R93M77mia4Qf1wDxF1vCF+SSoClpBS0Soz8?=
 =?us-ascii?Q?kMALp32WHjYRmavO39DyydMe1Pqgv1smP7u5+Ka7DotnPXpaJ4k7NpceO8/v?=
 =?us-ascii?Q?J8lWG7nsFgNcMRV/bdPXNQxK3p2qcHIFXU8I3xkS3YUAL+dyGJTJHpbgml/j?=
 =?us-ascii?Q?49Z6sECJEyFs9i13r0MuKlSeaB896Xd9GxyqxSeuidIFc/Xb9cXAKY8YYgZ7?=
 =?us-ascii?Q?Fv2CR9+zUUOAfVJalKqgP054mQtBU0r31QiSwtEw7ttT1Wm1VztBOMTjCHDK?=
 =?us-ascii?Q?uPv78KTu8XJBgmAQcqsGFqbDOWwDhF9WQOr+mRcTgiAUnMR4cqFuuY5Emv1s?=
 =?us-ascii?Q?+xJ+MreLApbrtWLgVh7n2P6KUMMhLB88Tmzs6bpWZad/eaiT2ccEJ13eA+f+?=
 =?us-ascii?Q?BG8UycH3yRJsVjL2wu2yeL8m6g5TlvBtLAJIolDqdAMhacMCetXpLzE+zzLr?=
 =?us-ascii?Q?2tDziCWHawYudfQw0kwQg5di5SRr7kS5lcMGz8H5uccTvpBxrvk5Gvr5DMB0?=
 =?us-ascii?Q?Vssey52iFNRdmNom+WAzQOAyB8AltxTczbxWMTYEPH3f9bDdJP8mjwbBzH3f?=
 =?us-ascii?Q?V9an90hxvxf0sOMq6QQgP0Xovf7n+22dnXLYO8WTruYzpmDrVxaNCGh9NKeK?=
 =?us-ascii?Q?d2wHBhBlUwNxS4+AC1vVfsBbPPQ0WnX2Ih7rdBZWf6A4zOdTGPloyCDSZekQ?=
 =?us-ascii?Q?OD36eWO7/aHmCTlH6sNZXHlUa7SLiN88WQM1XZyf14dh0yI62FXgNedZ69+o?=
 =?us-ascii?Q?2Ipk52FzGrkbMMqWx4Vb2VCtFwwUIAyqlgOGPNY1ycuTP7Ys94kg0KhC0kCF?=
 =?us-ascii?Q?IatVYYMPIZCm5GpBxjRYmvyZYEJ2eGBQtmZ0OE/2uSIMnvIj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77b2736-f123-45df-6b3f-08df3fef3c51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:05.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/EYIHanSUH16I1+vWpJXGcyCTvcdN0RTDpy74uMZSTAEBacgZ8H4mgIs9TMQ+pOju0i9aClXPG9xQ6Y66bX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

On Mon, Nov 09, 2026 at 04:29:40PM +0800, Yingjie Wang wrote:
> ip6_route_output() and ip6_route_lookup() can return an error-free route
> whose rt6i_idev is NULL.  Lowering an external nexthop device's MTU below
> IPV6_MIN_MTU tears down its inet6_dev, while fib6_ifdown() leaves routes
> using nexthop objects in the FIB.
> 
> An unprivileged user with CAP_NET_ADMIN in a private user and network
> namespace can construct this state.  Consumers which treat a route without
> an error as usable can then dereference the NULL rt6i_idev.  This was
> reproduced as a KASAN NULL pointer dereference in ip6_tnl_xmit().
> 
> An audit of IPv6 route and tunnel users found this unchecked
> ip6_dst_idev() dereference.
> 
> A similar missing inet6_dev check was fixed in commit 1b9b5323725e
> ("netfilter: ip6t_rpfilter: reject routes without inet6_dev").  However,
> the route construction path still marks routes without an inet6_dev as
> successful, leaving every consumer responsible for the same check.
> 
> Acquire the inet6_dev reference before initializing the destination.  If a
> non-reject route has no inet6_dev, initialize it as RTN_UNREACHABLE instead
> of a successful route.  Explicit reject routes keep their original type and
> error.  This establishes that ordinary error-free IPv6 routes have an
> inet6_dev while retaining the existing defensive checks at callers.
> 
> The modified route object builds cleanly with W=1.  A full x86_64 KASAN
> bzImage build completes; it reports two pre-existing kernel-doc warnings
> outside this change.
> 
> Tests:
>   - `make W=1 net/ipv6/route.o`
>   - full x86_64 KASAN `bzImage` build with `W=1`
>   - KASAN QEMU with an unprivileged user and network namespace: after
>     lowering the MTU, the stale route returned `No route to host`, a normal
>     route still resolved, and the collect_md trigger completed without
>     KASAN, oops, or panic
>   - `tools/testing/selftests/net/ip6_tunnel.sh` in the same KASAN QEMU
> 
> Fixes: 5b98324ebe29 ("ipv6: Allow routes to use nexthop objects")
> Closes: https://lore.kernel.org/netdev/DMP4WRIOGMBX.3VW2KNLBGDZ0K@gmail.com/
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

It makes IPv6 consistent with IPv4 in that both now return an error when
hitting such a route [1]. The error code is different, but that's fine,
so:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[1]
ip link add name dummy1 up type dummy
ip -4 nexthop add id 1 dev dummy1
ip -6 nexthop add id 2 dev dummy1
ip -4 route add 192.0.2.0/24 nhid 1
ip -6 route add 2001:db8:1::/64 nhid 2
ip link set dev dummy1 mtu 60
ip -4 route get 192.0.2.1
RTNETLINK answers: Invalid argument
ip -6 route get 2001:db8:1::1
RTNETLINK answers: No route to host
