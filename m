Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793619480;
	b=aYXaDWaiXqlJT8TTXY24Vd2tGlNC9Vwmu6OirSD0SDGPV754gnmHtd/RVZL+LD88X6st
	 FxIcIAwYsucZXWUpcgDjmdcFVFiGx9LY+IOrkJxlWoarPxb4+w/cueJOt82aJfDAV1BBz
	 6rZ5FtmPbShH+cHAH+XgaMoogaNffZwQc2Lnw8FlTY/Cy6w+8ljxpdguMDyGmexkf6FGy
	 iFn9wxTSWyarM/HJ/C+6OaBCI5905U6ihG1dobwGr6EEOHcWMCwSnxb1IIeTtV+6o2loz
	 KV+W1v5yZxLM86POFgdBBvwsqsCl2sMZZdajJ1qZGFpyAbt61OfbeCBpGXq5K/neB1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619480;
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
	bh=O24J+LYjPjSB/6xkc/sQLdMicN/CeLEGnBp7AMAWcXM=;
	b=qO9Oa5lk7O/Wdph753/1fvmPTELnPD+sxOLTt6QfvTQ8zA9I5kfQ++HI2brhKiICrfNZ
	 BnDKI0vgSYICtT6c4QcMQGD3EEqHNOsSpUvmqr8sl7dT6auItHxzSpeUzLMIz7ZxckbyQ
	 WObjirFJPwxRWtPdEeZ+gLmfNaHrM5dR4HdI5W2xfJklNgvTVlPKES7GCpPRBndAXzzMW
	 qnB6LH+jAOoUuzJv9oqQ4d5sEM/Pi0/DvuGN9G1ibyH5cwlaHkr+0yFLBvikWIQU6MN+1
	 PTT1g4U7ARzXhFBkY1Rer1lPzJ5A8ibFcX6dREjb7yE7AXmLgmixjhLaN5IQb3bH47A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p5bKQutn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.29
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7E606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA7E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p5bKQutn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwu8YR5BzCAudOhXWY0Z0mutZ9ei1xbVHA7tqX70nXNcTTF1f5uAMW1EIhQOTfNMzxLguzxYti/FRLNpoSt6WIz5nZJy0m/u97UZSCbaxdXVN94huhgBfrUBUbHd9XIvdDoPIhrNvyfDypKy9XASBX4wtkMaIo2lnQDOUvGNafy019Ah15tS/XnYYh15V97s269TtNo4sqkc/EQ+gxKVRVpPWzhGVW84cvncz/ICaDSoCNx+OkKtiu6ogV9uVC4Jqt9gLwzy/S7jx7UCLJiz2Wfb+GYhsmNrf56NoyQhzvwEwotffCLHcs3COJzZmei5Dk3vvrmnRQWa28vxzBnv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O24J+LYjPjSB/6xkc/sQLdMicN/CeLEGnBp7AMAWcXM=;
 b=IyLKxd1GuXkg1eOySwH0rwbKMMAOYdkVV0jVHSrMhHEfSpt260+U4A5yBXkYlA5PtjjiokNkYCX01ynpUKoqjHRG7AvcMk0YuXD5o+Rir1gAkdTcMsvHsezNWQaB6WTvi+d9Pkl/7kBtMsgI5cWioCfJCJtvMaIVm2zNnIiJsN3qNYY5W3A+76WerAoVztN3E7gqKf2Z55sXZdQY4ZqbAEmkNcgJ0FUTCQRHFht/61zAsemictJznzH9CE6qkjBOvJwhlFRhCuT2O5hSnjsLH9go/k9TsS8gdUGzNx2X5XHGrWTmAIbIoHSPMkbuSJKRXoVJkXXgg/hSEO0EGjUu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O24J+LYjPjSB/6xkc/sQLdMicN/CeLEGnBp7AMAWcXM=;
 b=p5bKQutne29VxzJ1vaWEMdbPElYeORRm0jTXJ1mQkeFqDkt/rN/ObdcSGXOtZUqCGV1KOZ1tWtCnNTXrNKaFrkDXCuvx/MEwrX8RqD4ao6LPYlASqG6Bl7paCn3vFo22xbafhHmINVppHD5wY/739wKnP9mSbgyL5NAvgfMnF/W6WftH+LltpF8apKCtEh9sjiqbUiFFJeOBt0D1/j/ICOJn+uh+VH4fB4ZjaewqCGIya4xu305ElEMmDApzlHp2gtq62+tF7/cTXFmTiQSX1DjbwVYt6shjX8MMwjxYqlMF34d1ItlbA2eguBZWOudWyHTTbG6jopgZsCkdb6DHHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:37:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 11:37:55 +0000
Date: Mon, 2 Nov 2026 13:37:45 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Katherine Leaver <kleaver@janestreet.com>
Subject: Re: [PATCH net] ipmr, ip6mr: queue netlink route queries out of band
Message-ID: <20261102113745.GA868468@shredder>
References: <20261030092303.2749386-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030092303.2749386-1-edumazet@kernel.org>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 00de4495-6ed7-4bce-4e2e-08df38d5bc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261028144727099003|261021135927099003|261021123027099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LGlyptRkukULARqDk/8pFsZdsNGsDj2eCP7n/7Ssa576RhlAxzSZuL1LHFjWQvSFFvFmM1tZmBY8xHUOQLH5Bonnb8c80KnzXrPgVNErEfoKNyI1fFOSn/EeyZPVlwnU2jv/LjU+z96045qocthZHPgV8YMCHhn6qZTbr8q2EmWxFBmlSVR2Oee8+opGWCu6wRs3puUmD5mQO5n2xOlNHBMXAkDnd8svNBYy7qqtCowKeW34+OCOM8gyGPoUv2ENS0/8XcdxBYVH/8iduJbylP+IMEwDqW4DWYdqQIXz1lM0PSRfx8uhldHP6st6fYdwhD4c+3fqfIdTtNoAo7Zq2rQt2ZOapzm0RnSqegPgOHdUV3tzZGCeT5IVZKBKhsR7TkEYj05V7P5JjMS1iUH0OFeED8HDaSCOYRD9kg0oHS/3muA9JIw/nCGKkmB7lykKij1NoO1qSv+WMylWmD7p/zIbQ5z/yafYJLXO92UyZ/GLykXCkPfLBaj3maPONoGMhP9pt5EsW9aCzqhkpWciaH/N9aB1gmGzUIewxDL9SdLHBaZgQpj4rGdTrIzgeyPD0tz1KmqPw6aoZk62LRNiKw7mCTLHghcg1G78lyc0WzvFNWIlLpzjfl0pYd/nLbxBQf8r7ktmx+2/ra4shcOqXrlUjL1/iUy4MIrzDaqse08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261028144727099003)(261021135927099003)(261021123027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrBN6fiaMTOaGjAuy4DKddnVbELKr5gpFExCcwjRzRDAIKzaixcQP5eWwncp?=
 =?us-ascii?Q?8eC7TOhjw0OSP0whnxKj2FEc7eEFSEGrt7mE/91tsgM8LnN+pLJFR5JIzOQ5?=
 =?us-ascii?Q?qTxB2Q5CEWD15f3gg4EogbqFzOt4IHglrVpVxF0CHzBeN7JVwvckaEPHlL38?=
 =?us-ascii?Q?GyjYNFCUtBB/rTQ4iG+0p8rWH9F8S2VY8sqIfc+9U1xF2GRjMVyhjXto3D56?=
 =?us-ascii?Q?ovIwW5uvfhX3to92xvJU7J9o0+2nqrME8ORcjVfemmK4JA6POcUWSe+KO5Uy?=
 =?us-ascii?Q?ud7PqDlO8QCM7NcDQyY4STopD/kNvgwfOteQi0e236zyVddNJ5/6Tv8co1yV?=
 =?us-ascii?Q?BCI2HknHrQP3irbFW1S0ALsvtW0sHryiVYQvG7pgFGvIKgMpPHT86Aghzo5m?=
 =?us-ascii?Q?NsgGlsrJRSJcGPmHc/JzJexRttbbXsKkrGGJQxtDywl0bL2mB1FZR1il5Df+?=
 =?us-ascii?Q?ehrWrXqWwc9oSD1jlXNYb3MT1qdMnwVXOM1uja624SJb4axd3Qx07Izufu/O?=
 =?us-ascii?Q?tZK4oDp0jyCBJQt2FAqyX4dbCAs1gqkEpPCGOH3lydHye0WFwcLE8oc5w6Tq?=
 =?us-ascii?Q?LnJsSkgpM9LR2bpKfg/O7AfqQjk8EqWqd4+zEyLnHtZ/reuPeT9jpLUKYP+g?=
 =?us-ascii?Q?WPWxTQIXsF5QTfJV9sEgHRbt+iaAc+Ah0hZQ3pkB7U+POnoQK1TyKfxzE4Kq?=
 =?us-ascii?Q?09WENHa2MCNGo8FCxK266R15sAqt6OfVfURFPyhQIGJnVcCLjQAH8iOzViPe?=
 =?us-ascii?Q?Ytol1FzlDO3hoG428dyfGm9tiM1rcGTshs++oxf8nPGI4rcvXgKvCDqGCgZE?=
 =?us-ascii?Q?Xm76xmopMZMJusqMz2b4o69X5rfNvw/DCNrZxTlMa7e19ykFxGvfjsIg56lh?=
 =?us-ascii?Q?C6Jp+g25pNSVjB/TwZy853TfNiw7Vhgp+SqYYr8oYUF4RswTvUnkWRNhV6hI?=
 =?us-ascii?Q?mTeUisMDXg2auIoLkb6x0E39NuFtqUCgxBvIxcsYVuCi9zJnUmfPwWgyEyd+?=
 =?us-ascii?Q?dHachMbx1hNOnBVmVFS5hA9dPPn1cNFX9ck2wekWHrU8l5GL4Yy0KV/SR+D3?=
 =?us-ascii?Q?3ufcU2MQLD22HHZm0hhgNxaceQzfks9rZf/4gr3kyDYmPB8z4Skwllj0xZvu?=
 =?us-ascii?Q?WENIse8W2HNh8yGI/avlcPcZ667cBuSPk4WS53em2Py9p9UpSXE2yOT06SS1?=
 =?us-ascii?Q?xgxd09nYU8D9deTmfPRa4vW7M7UEI+urhfjWuOleO+Kw+aIHA5DvFQs8zqML?=
 =?us-ascii?Q?YTG9Pm3jF8it26Z5Z/jO/nqMZEEEpniYjB5+xKyFagzYNX8dLKUoro2zguf1?=
 =?us-ascii?Q?4mAfznXODlGcNqcz/4CcVexwgaGvuqIQsGvfhe/8fRUeZ4f0wmrMWjZhrOqA?=
 =?us-ascii?Q?DiQYq+ojQZFaFoiEsIBDKO8+AmVCoDKwkVVMV2gJ/8vjPCyKTzuGFrGV0Re9?=
 =?us-ascii?Q?s6069dJH65gN5wXrzXFBttAkbmTYCifZT2b0ytM8ZSr3cSfztanyvv8w+/YJ?=
 =?us-ascii?Q?4fr0XtibjORM3XUYQYcBwDiMTq6w1j74f1rxCXdtxoXHKplORkSPSMkJN4HF?=
 =?us-ascii?Q?fbPWcnJ3zlwySCtaUvs/6WkhKgWowXcfs52SGyi18spt2zNSbrElvqZ7atN4?=
 =?us-ascii?Q?Dh8Fa0RpCwgOB4voZw87UoR3NpvH4pUSrRrotkEiZfnFoIK4WP/4gCa3hsNq?=
 =?us-ascii?Q?boFZqkUxlBtS6CpDmF3JfEHkvP1LRz0pNCXnPVPVHaDTGM9z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00de4495-6ed7-4bce-4e2e-08df38d5bc61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:37:55.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeuUl3LlCJM26AOPIj5wR6dACtgh0ZchiqlcRqQH0ilN+iQnbVLU4qzdTaxQjMQEWzTKu1ABNgYHXLD5NWrsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607

On Fri, Oct 30, 2026 at 10:23:03AM +0100, Eric Dumazet wrote:
> ipmr_get_route() and ip6mr_get_route() queue synthetic skbs on the
> unresolved MFC entry to answer RTM_GETROUTE requests once the route
> is resolved. These skbs carry a fake IP header with version 0, and
> ipmr_cache_resolve(), ipmr_destroy_unres(), ip6mr_cache_resolve()
> and ip6mr_destroy_unres() rely on this in-band tag to tell them
> apart from regular packets queued by the input and output paths.
> 
> The IP version is only validated once, in ip_rcv_core() and
> ip6_rcv_core(). A netfilter hook running later, for instance an
> nftables payload statement in a PREROUTING chain owned by an
> unprivileged user namespace, can rewrite the first header byte to
> zero. The SRv6 End.DX6 action also passes the decapsulated packet
> to ip6_mr_input() without checking that the inner header version
> is 6. If no MFC entry exists, the packet is queued and later handled
> as a netlink request: its payload is treated as an nlmsghdr and
> written to, mr_fill_mroute() may call skb_put() on a nonlinear skb
> (hitting SKB_LINEAR_ASSERT()), and the skb is unicast to a netlink
> portid taken from stale IPCB/IP6CB bytes in skb->cb[].

FWIW, unprivileged users cannot mangle the IP version using nftables
since commit 968cc2c96390 ("netfilter: disable payload mangling in
userns") in v7.1.

> 
> ipmr_cache_report() also relies on the same tag since
> commit 94a6736bb5ab ("ipmr: only copy pktinfo to cache reports").
> 
> Stop trusting packet contents: queue route queries on a dedicated
> nl_queries list in the unresolved MFC entry, and pass an explicit
> nl_query flag from the callers.
> 
> The per-entry limit of four queued skbs now applies to both lists
> combined, as before. The synthetic header keeps version 0, since it
> is copied into the NOCACHE report delivered to the mroute socket.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
> Reported-by: Katherine Leaver <kleaver@janestreet.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks for taking care of that!
