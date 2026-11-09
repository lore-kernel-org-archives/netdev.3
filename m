Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794228303;
	b=1/QnrX8KWTeRfMvaP0jjzlwrIxfUI3imUQTlE0ZynMOJCXuQKLPtcZmWDvTY8ObNpd1i
	 mBj3EWdJbc/HfFgdiUY9adXnpscmABQs+IwmeUNQkD+qaWBxXaP6MVP/qAjsKXFP4d7N3
	 IjNBhHchstZB+xQXgK1wKSKjsP2c4KE0zDWybvUMwkruJZanmNotfJY0XBrjKiJHzRSfw
	 eIE2r1DHmgGvECuK2agR9Q/tgusqmbMu/y8PQ2RUKrVIL1y/bUbqaQfsa/gL4cK7LAe9o
	 Hjm2VspbPHEY4JZ407V4IuUH1VeR58JCgz4yYDG5k3k9hBSPG64zdDgNVMZ7moEGVnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228303;
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
	bh=FusHpUUrEAiXXoriypc9z+V+a3ThX68049mwL/qiLwc=;
	b=OBOsEFpU2+gcjGln4X9OBTRcS5KIu3YRUz/Pc10ievnD9cvxYiYtT5bx2NvquBMyrwQl
	 SGP9+I+HwRevnzAYhVHxjPISbgX8pVPuwm2ZjU9KUC0QjAbWWX+UvPzOA3C6TM2KEQD8o
	 XscJo2XoOoJhvsBGd213W/OwBMuw8o94BoVQGotS8LZKrclbiUWIMOodir5XD3k0uDHJZ
	 EQU7E5DuVPPfP5HBh9axwvMtVg6oBZAqUj+47qvbTvBho5/u9DnR7gC/ZWoMsofbmXTWS
	 JXc4SpgsFXwms8d9dZDwRIkrpx6Hh18CWb9wCuj+KsOR1zVuUEB+yEW+orE6uOx1K9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DRxKmUmf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.55
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E674606A31C;
	Mon,  9 Nov 2026 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E674606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DRxKmUmf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo3DK9NgB44yOOD1vLgQVg4hSdR9QYRnILCiZv4S3lJ7AoEw8ouT8IB43fk5xRVlkTUXmKtRxPUouIqJEUZGFK4OIRcC2b3OL5iDS/R6z650CmwFzhapIRl29VVX6w/q/4vp+A1Q1u02OJ8QJcpTjxYf7H1gNMTH9w4lBr3xd2dAQsQelDP8EOJl/75ZV7diuZAiNSyAkbe7GWDlufoonCWSQEPFl5ZichWp6JWNNoa9FbRniBIc7SFipMDOja6JZGBPpB+/Hj0qmTo6EpafqLXvEHrasmdrNmZlOujPKNNv97TA34JkQ5FaW9nPPkC3LTBqdyLfSDhZJxMd+G2caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FusHpUUrEAiXXoriypc9z+V+a3ThX68049mwL/qiLwc=;
 b=a6H2yEv5iAULHw4jlXd8fzrOPtRvxwIx5k8xNPKLy8OZKSU2/G1+74KnpDnGuLm48t5BkbmcxSL54qSm0J3NfSsCDKlA4CKTLqwfC8ZYh78IkVBdBIfiNMOh3MOmwDlEb9ZDntNEd8GRd7w+X2ui9QE8w93Ii6uBlA7ncIrqtAEu/ZOgBXavJsFhM57pLxSEkK7UAuZ5MlJD4hE21MOILzYFPoiezQo/PjcCSoJctLg/Q99ijn4v1VYOToEPryqnjagklLWwUFXjbwdNbMcIm6xIYSzu9GCeDtb/YUjLXp+HvaSaUNT98cBhwlC1fhNu9j3Ms7ID3YgwUixaIDItrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FusHpUUrEAiXXoriypc9z+V+a3ThX68049mwL/qiLwc=;
 b=DRxKmUmfTknXksu3s5drfcSGttJAevr8xhLJxcuj6WftTasvcXfXdlq1y4nJF8lG7AMggpdi9dDv9QlhQjFjen8rUYKMB5a1B8q7YYu05+oI/fy+c2twSmXHwFNx6HmU80VnfFpHXLKA4c4ifFehJFoJnKaCvy/Q9hdUcg0x5TZMl4WMzG1yuC92L0VHIxZfEUL4JIQfM72tqJ3ALGY/wW9r/hqwoolImhSvkfHPsUsZbHiVnzubLq0j8S+0ZcbB4VKzUBQhR5MTmTsVjYzUXEiRtv7LPO2Xa2Hpon8iChYtAOz4BXR3iLmK4UUxLj3UpaFQXuZ6HkbjW7JvakpsQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:44:58 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:44:57 +0000
Date: Mon, 9 Nov 2026 14:44:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: me@chasehil.tz, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, weiwan@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: route: don't blackhole in-use routes when
 retiring fnhe routes
Message-ID: <20261109124447.GA1641621@shredder>
References: <20261104182058.2673882-1-me@chasehil.tz>
 <179416334264.994134.10564853189016691004@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179416334264.994134.10564853189016691004@kernel.org>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1522527b-4a43-4dd7-7795-08df3e5f430b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|3023799007|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	y3lR2wudxnEbeXMGpyUCZGqFy052xjBN1RBd07dk37cqAQlq3tpKPTwgZCA67lxOVc5NwhJpJewPWw8cu7LQm+4tbtCKqiguajIdH1VsQngAdySD740utn5+Qwf2EujJcPph8Q3WA0e4i1Q563nXHZcakfjb2nlAEJj/PT4qFMV4/0yPf7Hu4L/vavNSqcXuBMq+XHUQGwCyHNFqw5FWOf5oiCiuC63VuWriuTGuHfiaO+rC8YV1i3kveVjR00UR4iERP1GSAwYXTn/G37KD35Iap5dAj26RbxqRbFJfws/agsYOChTRwi/30LNYuVpXxKtnmvdh5k6DODi0fjFd/wO10nyunD7fnbICzQADYHe2RYw8tgiCGzj+msnUcoqfntS4Io2K4L9bvuR4BTh54lv3CtJfpKeJcOZWSSEueVgq8O92BnpykjKT9RIcxGuPxjG7InYqTnlkZ1+U5kiDInUXVnLtmpRulJKmXRlACr0RmGGfHnZJu3qKviFkQ45zgvZGpdcGPA9n1/JyNqr0Oc0Vw3kL5CL/bhC6esSgYgXhhQi6ZGpe+3ExX0/Nm8k3dUEJqrOy7keklH6Rvuavj7a9Bl3dmnRC7WiObHj8esk8zK0mrFw7g9/LHc6Zs9qHjad/FgKOKdaoeyNRawodYuWOKquc2SIPw/CVyOqwEtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3023799007)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Vjn9f/hqEvYWxeY0x/+lhYUL8nlNghKKjxH8J/AlEHCKIODK0tkjften6YF?=
 =?us-ascii?Q?eiNM3dxDGPzL7UwqUXdbZcJuWnqez1K5BfYqKTTWRYhuD+sT2gmi1h4JAgSe?=
 =?us-ascii?Q?SNk+LiPMovbl0AUgut2uvNxqRCJbi+SGnqnoR9gWGugVWfJsYRkdtmYa7+bA?=
 =?us-ascii?Q?bjqkQlNJ4G8xXX7p+OVCnVfKPyhlNawqdk3iMlQhCHf6FTfzWDdsV8vbH/9e?=
 =?us-ascii?Q?V/hMMFOs0SDK14jCiCXXlZZGN5FRsAaw4eIuLgvI1zqGFjXpMKU15y6dDVmS?=
 =?us-ascii?Q?C5uHX+lrmclR4gz5VhtanUTIEZG1Bn9ZT19WRSAGiAH0JVhziPfc2u55gSny?=
 =?us-ascii?Q?2k2Hfl6jAaRpv49i7OiH0GNDNpqMOQXigqHM1snV1991uEDpz8zfnF1zK8sx?=
 =?us-ascii?Q?83zUIm0mr69axR0/whEEu+s2Bmo/ybb9AEDpxDq6F2X4rLK/J1JQzx01EvpF?=
 =?us-ascii?Q?Hn6QIEnXDXJnpyx0U+1Mo+v2nadxDW+bGkoKt1pFa1OF/kz07JqYpybykVun?=
 =?us-ascii?Q?EoPI0vL3tPtiNCQHMXxg1GS8+xV+HZX6mBhWkPJTsrOUkHWmTn9TAvZ2bGtN?=
 =?us-ascii?Q?jW2Uhzl2OYbnrH85OE+ztLut3Xfqnngw9Hmho+uhxUajB+NSoi24ejmZE4NC?=
 =?us-ascii?Q?fufXHr+M7cu6w2JzM6FIPQXimDBRLFJVA2IBirg04ByvU5ZvW2PlQ9gwac1v?=
 =?us-ascii?Q?HXvheUjCRgGwEPtXcyA67xXp/cPF83XAxguLAc+ufL4SQRKkUe4AdixNoBxw?=
 =?us-ascii?Q?dNdNLV6uuN4ZkV7JrYZivDIHlelTSO4FX8y7qeE4Fvx9xcBryCCpsfJJhnpv?=
 =?us-ascii?Q?zbRMBMqe+fX++bFnF8cykKFAtmyIc162S2XWrmi97rr+w8nLbjnSyGN5dmBd?=
 =?us-ascii?Q?DKPPL4Lf/YEawiPzUS5qiOYSmr+NXsnCYQ8yOvPx4lYXt96ZrhpWOTdjbXz3?=
 =?us-ascii?Q?88uWsd0pggyvrRqhpg+NHcMGq4dC631a5vrjWvdiBLNKGHbcOJ68jh4WIF38?=
 =?us-ascii?Q?Bzzrgg1JS+a3Pngy25ieqIQ0DPHnAruTCBUeq4mnPkCnpX8kZnZibmTm/SL3?=
 =?us-ascii?Q?I/pRxDcAkGJt+GIglDwxLm0VUWPNQqaj/QNwRR0R8hDwwJ8nLz0dbiEwvVPu?=
 =?us-ascii?Q?8dcE0ny87APsihUGezCbUpZDjZO5MAZNN1owH1lqQk/BcLyc3A4ie6FaVLVR?=
 =?us-ascii?Q?/zNPhJhW+0fzafE5lIzWpGoyNfcufFsc8pukJO8s2nZlu8Zn5ZaVcefQQYoh?=
 =?us-ascii?Q?1U+i6HmHJrzZj9YDiP56JIwHA99e3KxcnPrZQEAPn0kCD0SeFzFDlWdJSkrY?=
 =?us-ascii?Q?a0SDatrr2CmcSA1tVONZx9NCqnXZ3qSRJYQp1qEHwBb5eEcuMg+AxGXYOGDB?=
 =?us-ascii?Q?K1tU5IZFqnd92v9jah0G6t3A6IaNwcEnOOi5m4SZxqhpUdwRUSR3Jn0ER3kV?=
 =?us-ascii?Q?VW3pmX3Ovg+0ddHSVTywcoqGDrDzmzm1RdtFMSwXL6qeiKg0+71ItKO8aWB+?=
 =?us-ascii?Q?F1oo+iBz2NYuveeGijM4h0gI6yC147YcvVHu43AvNzWSITL4ODNE3Hgp4ZlX?=
 =?us-ascii?Q?CaE47nym4D0JB7dgad23hdx/Ox+mwwfAvJGgVuIRQM/fJYjetIB25NE60s8x?=
 =?us-ascii?Q?Ws6LCiHvfWWm9e3omXUNMHbfutmdk3wgcV7YVN6ahTCU98gjgUCI1aUmXUE7?=
 =?us-ascii?Q?9khYDVLAOicEUWDBkazssb8tysx0CSZhU335Qcg2cw1/tQBO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1522527b-4a43-4dd7-7795-08df3e5f430b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:44:57.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZfRlHgUpvJRGp3/vphJhFZN54dqoLQk3wboFjSxWtfYjzgzshfVIH1I7HIBTT/bz8IP2dep8i6Pj7dZIh/t7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

On Sun, Nov 08, 2026 at 06:42:22PM +0000, netdev-bot+sashiko@kernel.org wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 3a90c8d28b940..cd69242afab07 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -573,6 +573,17 @@ static void ip_rt_build_flow_key(struct flowi4 *fl4, const struct sock *sk,
> >  
> >  static DEFINE_SPINLOCK(fnhe_lock);
> >  
> > +/* Other CPUs may still be using @rt, so don't dst_dev_put() it.
> > + * rt_flush_dev() handles it if its device is unregistered.
> > + * Marking it dead makes ipv4_dst_check() fail for users that cached it.
> > + */
> > +static void fnhe_retire_route(struct rtable *rt)
> > +{
> > +	WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_DEAD);
> > +	rt_add_uncached_list(rt);
> > +	dst_release(&rt->dst);
> > +}
> 
> [Severity: Medium]
> Is there one more fnhe retirement path that still blackholes in-use
> routes? Commit 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly"), the
> Fixes target, also added dst_dev_put() to rt_fibinfo_free() in
> net/ipv4/fib_semantics.c. That function is used on fnhe routes when the
> owning fib_info or nexthop is freed:
> 
> free_fib_info()
>   call_rcu_hurry(free_fib_info_rcu)
>     fib_nh_release()
>       fib_nh_common_release()
>         free_nh_exceptions()
>           rt_fibinfo_free(&fnhe->fnhe_rth_input)
>           rt_fibinfo_free(&fnhe->fnhe_rth_output)
> 
> net/ipv4/fib_semantics.c:rt_fibinfo_free() {
>     ...
> 	dst_dev_put(&rt->dst);
> 	dst_release_immediate(&rt->dst);
> }
> 
> The RCU grace period before free_fib_info_rcu() covers noref users.
> However, __mkroute_output() hands out fnhe_rth_output with a reference:
> 
> 	rth = rcu_dereference(*prth);
> 	if (rt_cache_valid(rth) && dst_hold_safe(&rth->dst))
> 		return rth;
> 
> Also, __nf_queue() calls skb_dst_force() on queued skbs. Both of those
> holders can outlive the grace period.
> 
> For example, a UDP sender could get the dst and then sleep copying user
> data in ip_make_skb() while the route is deleted. Its later
> ip_send_skb()->dst_output() would then go to dst_discard_out().
> 
> Another case is a forwarded skb queued to NFQUEUE at POSTROUTING and
> reinjected after rt_fibinfo_free(). It goes through
> ip_finish_output()->__ip_finish_output()->ip_skb_dst_mtu(), sees the
> blackhole_netdev MTU of 68, and ip_fragment() can send ICMP_FRAG_NEEDED
> with mtu 68 to the remote source. That is the symptom described in the
> commit message.
> 
> The commit message says "Do the same for routes retired from an fnhe",
> and the comment above says not to dst_dev_put() routes other CPUs may
> still be using. Could rt_fibinfo_free() handle fnhe routes the same way:
> mark them DST_OBSOLETE_DEAD, add them with rt_add_uncached_list() and
> drop the reference?

No. If we are flushing this dst entry because the device is going away,
then putting the dst entry on the uncached list from the RCU callback
can block the unregistration completely. netdev_run_todo() flushes the
uncached list after an RCU barrier, but the free_fib_info_rcu() RCU
callback can queue the nexthop_free_rcu() RCU callback which will then
put a dst entry on the uncached list after the flush.

I think the patch is fine as-is.

> 
> Commit 5018c59607a5 also left the matching dst_dev_put() calls in
> rt_fibinfo_free_cpus() and for nhc_rth_input, which affect non-fnhe
> cached routes.
