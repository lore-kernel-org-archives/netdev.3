Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792927750;
	b=3dS7VRhXOBq66z54hGnI0p2LM4VazM3jS4snw/TSmayoozSbQvp4BdQcLh02c590hpJ6
	 5IMI8pf66CQO6vYvqtznxD5mLobiYLRHXUs/ucw2DzywT9wAXv5gQzJV7tkkMXvXGKyKT
	 MDQDahM3z9ANczxYVCt8Ob7ygCZcKIG25ZmmcxKMMB118a41ny61Z7fp8AUfD1hg0U8v2
	 RJWo7/DB8h2INdGjYDA4IjHUJy+tgmmyhhvHpix2vA8XTduKbdntg81KxQLxI3DMA866a
	 nv3vlm7T6B1xNr2Ogztsly3h3SHPzK26ErQzms+xsdsYTigD2RDP+aidd2cKnBhA9RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792927750;
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
	bh=tlpOO3LEG8DXfhm0aYwPMvHluVY6fofrnp4M14Dl8yA=;
	b=UAiEXTDlNRs6Z+zoteFUSHvZRnszccZl1R2/j198RR+fyxwJSPZJvWgpq8V7YJyS7PJW
	 Typ/lHaYL7+SH3HWvmfCzXEfP8wWgADSoJXLMZeui4Fieymv7ABVfXOcV+/9yqt6SYIGV
	 2k8GcDTROqQAmAmUtvU7sJkcbWUUcDgZMqb0OiHz+SNcD6oJY2xiPPEf3gE8ZUBwJ84EA
	 W11gMZ+Z+thgrf7yPJcvSALwzqiw4CFJCGcFHrdy4IC6cNdsotBBMV0mB1mvJKg3bJ6o/
	 sjBXxR5fqa4kZ/jnrugh/tROQ8bkW1KZknO5QOHzx+hyPnws7/08Lz8nmAFTqVtph7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CIyelOSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70013606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70013606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CIyelOSd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZRzNsikH6bfokmUMz47SotEplDiJjWqEMDRGA3aUVUMDku4xW2HkAlYVFkqLN3NE4M5cxlNkZLr8R5aBJCiwOcQirlNdJLdKXnKZFe56uPfXIZAYxsVwNbRFjPcuspirPfsz5SD0a/AnmCLXAh7fe1GuzIU65PwgZGPPwgB6GfO2H03hNTx9QfXWiSJ034W7U+JXFfz/pyW1aUywS/iCsWKn8bm4ePYvAdDq6x0jicvKrHGkQUL5uwZVkoeAGKchRX9RCxKnQ67cRpzUcqFz3noPezNkk4W2lX++dTP6eCSrD71U8J0klbTGz4hO5ToDP79IGwHuyEFVbsle7H1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlpOO3LEG8DXfhm0aYwPMvHluVY6fofrnp4M14Dl8yA=;
 b=CKFZvmaDl/1rgUI2+N6qK3tjO9ZYqHT2b+paADjHJGvptOMmZ3bF8NI6fBiYlboBUsDB1Jf2ayeK7BIjFbHKP+Loz39D9sKoCu+xi6g/T8zY6Ihq9xQ2aU0sGaU9m11r4HfqTpMkv5n8CvyIEh5k9ZBzb9xGJRo4cH+r0vov2qEVc8HywIBrB1xkAMN/vBiYlD2dHsTchavzICXtFWtiv7w7l4YujU95igmETQMU+QGT0wl09MYbhprV7fGkdfa/jU2WjLCv/Y4HNPv9dhZrAl1NIx5uofyBTa4yDd0ZWkjbAzNFrgWAeL65M7FOAvnvomGoHnYmbuhfWyWdWtvWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlpOO3LEG8DXfhm0aYwPMvHluVY6fofrnp4M14Dl8yA=;
 b=CIyelOSd/c01ziEUypqw4Dkla+19RLMUKVFE3lY1pW/MtM0Udhnnj4bwSqWeqR9RFzPoywOP4sRN9XZWibkv06KEzJXhE+jznzomFd2B2HTxsjvkDVGeDJnMoskBlfPMNP66Sn1XJcSsvboOTqHf4FDF2NT8d7iuMlPrKiv6uSZSQAqQ3kguJwD/YF6OnWtbZW2NlwOseCGujcg7xdlJzVzmVg/C/ggtDbjhcmtkJhBVMhPs3QzJBmjQdW084NYR0mxvpN0kDetZ+xGEbxmOBKCvu/fX5AG1L+gKkl9YL7yypT9m/8K3397X7OuV3Iw8JKwehcHXUuAcmwMsP6AfVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 11:29:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 11:29:07 +0000
Date: Sun, 25 Oct 2026 13:28:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] ipmr: clear skb->cb[] in reg_vif_xmit()
Message-ID: <20261025112857.GA140329@shredder>
References: <20261025111337.142787-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025111337.142787-1-edumazet@kernel.org>
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ba1941-03ad-4949-ce4b-08df328b2eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261022075727099003|261021121427099003|10067099003|56012099006|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	kGNsbIKEXtUbDHXhjGgqw/XuxW2RbE5dfhj+zrR5gcxGzRjOu3ghjtnDACjVbsDwfPp6Xe4L6uD8stKtLYHWrl61IqYMBwALBcrHcrwJrQ2Xm/nAL9Obzo/Pb1M5/NJqLaEAK1k3AhAXvdDVHlK7gIGnLywVOawm5HeZR8VyITMinYvB0UY1XNF+uPTAk55Jsiv19dCW7UdE6td9w0o3jmT8F1vzcmdhRfLosf+pNlbygwCfUjx7fZDRE0FeAMi7uV5kRhYFLXWMKwvsoTB6wDujj11wJz9IJob0Zj1N/VgaCaJ6XY2IIDCnKz9ogeWKw7BdfJXedGMwRh4hzNnMgbfp5+JwechqF6hxA2105bYZachE0AnIVpdl1+NtfCpxcvIAv2slje7C39wyCJDkL+HY/W4jQ819FonPOz9oRhaT2SVC+nJ7YJFhl+94Pq+/NTMu2NTLlGnr5rswfx9KfVP2Fbn2PMdOsr2UEqTyXGg9PdH/O/14mQZz9JBLRXpUoTLMnPFEZZl48Xsq/vIGnQxYB8C0wiIAs+VwHhwNtPKp0IEvrhJCCYjVlENrS3EzHif2FPAnQYQSyQv2a66KciVOABqR4vGZu/7vgYNQ25XPb5RMSgudKlNA/bxoO8Vi7D38jmsRDdMUjqxuisWTZYjCZMPoTA7GJ+A4STg/aXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qylw8hqJ2BF5RQuqsFMRMUI5Csb1QY/kEo4KKrRHjRi51yf4EVIDOkoDmCRE?=
 =?us-ascii?Q?rD+V3AjaexYdHL1S8hbZYaV0px0PVyy5D+QPgDn538Ivt8II2jxp2zfQyt8L?=
 =?us-ascii?Q?5iTvIqt1GCjlWptaiFuULSHKWMM3cteLrcBHbzXoMNQ2bSFF3W/RVWbi02ew?=
 =?us-ascii?Q?7hihc5FOwY05D0YP6DmBinzT1Bm6FM5twYFMqjj9HUYOvFD9QLzHOeNwymPD?=
 =?us-ascii?Q?1Gqjt3sxyjy3MUu9x2Om2axHABH4aPZ2cepEs5ss8ghGhSRtak2w0G8eH0fJ?=
 =?us-ascii?Q?1sU6nTY1dGOlwIqBmjoyc72pUVm8KbeU7+epqi8p1Oi8gpb+T2O2ShDEYf6s?=
 =?us-ascii?Q?YFMfaVubHEBvzCl4xbfloyxWZVnqA5QrMBlbEhpjf3p/o3A0ERnbUHepvRVE?=
 =?us-ascii?Q?C5+F4s1EdyY0djtO0EWbbgSmn67fJgZc5iwee3GkDAurt90hhrBJU63JuepC?=
 =?us-ascii?Q?au+O0BFuOc/HZdhjyEfxFhHUu7XMhrD9i9JrXDtsYAQQWnFJQgLbmaGhJXaG?=
 =?us-ascii?Q?ny0lYTOmI8jaKsXkqPDLRjdUXYTBe4a0EJfVKyKLf/PpUKkS3bFUNODOGML0?=
 =?us-ascii?Q?+PtDz2bVzOlUaiGZyqk2Qh3VMHUZUZTgQc769JXmeMCprYfC1hloXtbORe+U?=
 =?us-ascii?Q?47YjXLrejOPH3JR4fFBh9j3WmHCAtqsyT8IATHrLxCMabWgMC2R2M35JhJvb?=
 =?us-ascii?Q?KKuqGtyBtUY1iNyWK180PbUDi6f5CSPb8aMK6eUC46d/KMjOyiyigO8QQvQB?=
 =?us-ascii?Q?AEHuD8YbpeT/VSg6QsoSj/92LvJxYqWf3YFZXPy5alUwu8pGqUH9qMPWFEIN?=
 =?us-ascii?Q?t9sSERRejxv7f+u9kVpbfNTGF1R/I3xLuRv8gawJtj8R1gTL2o7VbJRJxGDO?=
 =?us-ascii?Q?7yn5f9XYLLHiot/ljPTZcmRImYEgNeA/+5vZC1N5P3t8G/4Eyv0mm0SqMusl?=
 =?us-ascii?Q?5uRHtyTh0g08k1/cNYix5/KQ+G6O4IU3j3JiHr1W2hc4Pb1N+8SdAcTLWScG?=
 =?us-ascii?Q?rh4J6m+Lv3OpO7MYwwu0e+4Ow0EYoJVmLXzQKgS8fZPi7kb8qnHEGJafvdQJ?=
 =?us-ascii?Q?/MZXO+HRvXP6a0GbwwiCWp6Lrm74LoOiJw2Poi6p08YD0PjhxNSuqvDSNsLC?=
 =?us-ascii?Q?7GxotI5P3ncN2I3+Ix+SFMsORUU5HuauyrD1OZq3erHEpdGm0migN5zy3UGw?=
 =?us-ascii?Q?5hzf6KRXo7eAHQqzfWZZCf40YpsCcsJHfNbJkAoFn4so8b9pYII+I5KH29Vy?=
 =?us-ascii?Q?fmev9PgdP+d1v113Kvmkw9rlDb2umADHCp8tgkQZ41+tgFCD4ycfXRnAOgcd?=
 =?us-ascii?Q?LxK0JLvYWsu3hI2UAtvch92zG0k1i5iYDoe9510QJXGQWqWbftj6xY5+Jfl4?=
 =?us-ascii?Q?mte99wqVKQGW8MzHHwVQGWmUNTh/DUEQRx8Bx5RCLliyGOUCZCpXkTo20rU7?=
 =?us-ascii?Q?72m7XLtF7fQx/YXRISjQrHrF/8qcU4HgGg6b8+9irBO3krBuOjM5x/VkjUXp?=
 =?us-ascii?Q?lahoFoaWXKv1jhhNxLf3+CXmcZc13vlqefo7g2TyYGH8gUEb7g4GY3WewB6U?=
 =?us-ascii?Q?oQqIkg9uoVzmz+HFMcZ+5NUyVZUc8fvKDglsB2AqGnC1P/R75KCaIuVb+Ss3?=
 =?us-ascii?Q?wEsMEN4SJbHPeB4Rd9cT/P0jDnxd4mxrhghF5qXc4nn5/raOHyqdLaV9z2JV?=
 =?us-ascii?Q?mnW4XFnhGkUCkhmKffamsxGEL69Nbu0IoACcQOdccZx+x+uv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ba1941-03ad-4949-ce4b-08df328b2eb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 11:29:07.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0C3kfs2s2VnD6yfZ2rsMGtsAbCaR/gkqq5oSlCuDWJ6VynF1l6mysBcMS6whjvIxveGkT76KIDOQDeCD8bmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

On Sun, Oct 25, 2026 at 12:13:37PM +0100, Eric Dumazet wrote:
> reg_vif_xmit() hands the skb to ipmr_cache_report() as an
> IGMPMSG_WHOLEPKT report. When the mroute socket has IP_PKTINFO
> enabled, ipmr_cache_report() calls ipv4_pktinfo_prepare() on the
> original skb, which reads skb->cb[] as IPCB.
> 
> By the time the pimreg device transmits the packet, skb->cb[] is not
> IPCB anymore: qdisc_pkt_len_init() overwrites IPCB(skb)->iif with
> qdisc_skb_cb(skb)->pkt_len, and any qdisc installed on the device or a
> tc BPF program writing skb->cb[] fills the area holding the IP options
> and IPCB(skb)->flags.
> 
> For locally generated packets routed out pimreg (they carry an rtable
> dst), the mroute socket can therefore receive a bogus ipi_ifindex
> (the packet length), and the l3mdev slave test in
> ipv4_pktinfo_prepare() is driven by stale qdisc data.
> 
> Clear IPCB before building the report, as done for IPv6 in
> commit 238164201431 ("ip6mr: clear skb->cb[] in reg_vif_xmit()").
> The skb is freed right after, so nothing else depends on its control
> block.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
