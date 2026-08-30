Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E4377541
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088898; cv=fail; b=cfgi4YpyCZuQD+ZB7dKf1ezoFe1HxvpY5mrklk4an15B186ulLr7zkI4Y0+diFRzt17VfrSlp/Q33LbNacc5m4l1wpCwalnj07rWLkPbGIUXtcS8mOT9MZ5LJMAYHwVfBFmDOSK8VC2YPhSieZsioJ3Uz0Mp77DQQRYIwB0qB8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088898; c=relaxed/simple;
	bh=Ti+4oe2VtTtWOL6DRVMSMYWcmARijRua+UnBsNOxTHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=panCxAZnxo9cHENxh3CZGLRC8hrl4+7OM+yIFbfi1L3WVovzr+c0Lhv0XfswPJVEwVsOyESzARLKgh5L5hUGByYRInxUkNP74TBVPFdIpzB32FqfswuCpXEVgRmjOZn028nAGnRLW956PkOjOlIY3s1+I+Y9+IGac5SCSX9eBuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WmERJLW4; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WmERJLW4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYs6YZESTDnnXejzpD2Gpf7294/6PZLi4wy15qyF6VUjzlHpgcpPlJIOp96sJKDBnTJHxAo3/1IQPH1ls/+JmKwjbzrznEMMeRJSzW8mteYm3ZbMNwKbCozQvk3w5QZRwJ3Xp+THyqs3vK5NY8Cr4am5lNKXUf/FE4kT3eeMwc0hHezY1VQ5uTnxlfeYepnULp6p8yjyhoYT0HTX8tApgQAR5Q+sR+BHF9Hhts0oAd1PArrAUNQOWBAuHG9pZUyrq4to9BhRhfwD6kx0ySeewbOYeeJkwJArhlbXjeN//3q4An9otYKvHYeL32tjxiWnJJAXa3emW/py/uIxeJ2+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8YixJxOmELNR1V9YMPWCjgCrp3ZVzkoARaRIsAkcVM=;
 b=Qvq83AXomfHou+kg3NVZhxEBEf5TKOwFE35zz/MEUXBmDO/rLRcfKMwjGEXXkoaLt9rA5xVHw+Mpf6X0PAuBls94va4gbOSCwPUV+NvMCY+dN8PGb8LqnFaB7DgSOmLD1A3Rz7gdmaWB+1seJ995o3frlWM1w/8PL0d6GJAQXpzm/+mOs3Ou0HyBF+TNZPReMLYe6Uxu/PWo8u75RQpIC8bR1Bc7BGCbgvXYeTfgyyoPYCps+bmBDjyiWQrSvF4MxmoCUVg0ejQrOx94RLtxBK0uh2W/yOkNN/eAilmB6+5+hJmxxRJSutJEzMHvZgiXFSCVfwedTnK9aVjWNYkl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8YixJxOmELNR1V9YMPWCjgCrp3ZVzkoARaRIsAkcVM=;
 b=WmERJLW4T2CsJ2PXPMUOleJ+gPClmO2FVkMp9QXvFJssNDWyhTPLXs89RBffMeIS2A2eA7zB6YaAXFW8lZEQPPV52Hxn/FgO/4PnBfFz9rBKn/vGjkpcTUchhNg1pDHlsl+/I0k9YPaROI3Dw9na3IJovtpLIIGR50dF8wIFnJlVFFGNeoJz00l5XM0x1FaC8EodbbGziCBTopv73fvM4tL0v9wbMH25wXJtPlsPbhvHsztd8WxmSq6iHImNrHWbGfAVMdwu4cRFfHMoOENZrDBlLeHIuPyNOCmDjmFGMUDRv3BdnnCgswS4X/5kSkhT7i7tMlKCZa5l4A2HyvWr/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 11:21:33 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 11:21:27 +0000
Date: Sun, 30 Aug 2026 14:21:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	TencentOS Corvus AI <corvus@tencent.com>,
	Jun Yang <junvyyang@tencent.com>,
	Fourie Zhang <fouriezhang@tencent.com>
Subject: Re: [PATCH net] ipv6: sr: restore network header before routing and
 forwarding
Message-ID: <20260830112118.GA2870495@shredder>
References: <20260828141727.2372570-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828141727.2372570-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 221a1ae6-425a-41db-c44e-08df0688d543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|5023799004|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gTQQV3GOS2kNlGaIsyMW/N4H4tqhHRqiExkFuNMInBZ3E8dK7WPdTQcqRD9vmLx1t635v1YzfckCJBwgTPf7e1CFJvJxVP3AEtn3FCoeXwkFxOENXbGLtPiMjePaG57xVB8t6ZM5S11JfH/azM5hgS5kMOKYs6bT6KSADh8vP/WX1+SH9JxRm5kotWrCa8Z1LmxScq9am7a0uCVZ9NLwJlz00OxlLB22anrLnvnJBw4UwyZhd0r+4YUK9vNUAIhN2F3Nku9yUaIl074qQnsubxhv1UgxZyGrqCQaPDNnhym4tjmb0yxPwZYAZeoDsQazmfQsdAMKWlFHSO9TmaqzzT5dYaiX8QKZbn7baiRAbY2fAuhttUoMpJMb+xIThpzkRQef9wXMPlTAIRv7Ad41QCJnphlIw7lfJzFJwrtb31AvesZPEZnF6lwfD8/7ynBFofVOfFVeu3htASpzc3OVwxU0PJ+pZUFdwtEOiab7kz7QJAc4y7rfC/UNl0WvzRxXzc9o1VQi+FNR6NUHrapR4gE3jO4jMxdQTb7QTw8sFWWqg1csFJU2UBqbY9uzIxny9+x9DgWe5qOE4BgnYcrihft5cZ9pgTCtLfxPfASUOWpLca98o9rI4NkpGep2caOc2AK8fLpyffepFoYcoOcg8GKPbRnG2AHqE54RRRoMYfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiLApCtE+uLMlMAKcetDYU/ZDKYvcW9/+hfdGyC/qlwhireMp+QwwzlHxRcB?=
 =?us-ascii?Q?Z9PUOhDEzZd5algWbsq+z3ppxT6Jo56JE8wdRXHE6PxZL1YSMSpkNz/nwfu7?=
 =?us-ascii?Q?xKYAC1U7ndohnT1+tXmB8lh8a9gX+Y+GRGcjtMK9TvTdXpFaa+TnwutD2/ap?=
 =?us-ascii?Q?9M5jY1S2e5yoeutXmXoEo/aekX6Vyrddi/DnjkO5L2kQFW+Cia5GeU/RBhKS?=
 =?us-ascii?Q?dbozOooQkJVWQnETbh9v1ndRXbUO6Fz8bsJ72HUlPYMyZxu33y3V8s3apR9h?=
 =?us-ascii?Q?PNBOPd7FQTxJ8xbgVUoE8snWjUfFIniw5FI1TuoSaqWEXj+xK6sQLltIvMVB?=
 =?us-ascii?Q?kNuNUTc2OhhM6F1J8At3VPUndEHtBJuKIPyKuZNRSev3Swyws5dVXEDozJO4?=
 =?us-ascii?Q?FDMF7+HOA5zO5eLU+NBum99Hijj9136TltVGki3XgAqSa9l7Hd5RF/LPibQN?=
 =?us-ascii?Q?jBFrU6W1VkotpprNJaZDPn7gbutG+ksM5AYOqFz1UAKtmprshQhUSHs5KnV0?=
 =?us-ascii?Q?f9nMvDYM5PifdlSqUva47ETbIlS+CID8Br2Bkx7HbB+2dlxDMDD7CHQFKMFI?=
 =?us-ascii?Q?1yNmNnuQGyqHX+pqS4To3l1EMNRMjftjfLtl0n2PtRUr5iuqhbBSLWeeo5gc?=
 =?us-ascii?Q?ibQ1V75F/249fwvJ3tyOgnW0AXYYIst1R/YW5/WtIWtx1rbY03q1E4nmXnBS?=
 =?us-ascii?Q?KFs1Wozd2olHdE3OP1wGpDXgs9MrLRMUiqpebcBk+fkMOe45kn3BR6NTMH2c?=
 =?us-ascii?Q?ayqwyt8tU8abfcyliKwPNQC1JRNHpyI6dRMNX/qgJF1sDF6nb7p1sWKNsikO?=
 =?us-ascii?Q?4Bjp7mf8OcFnWKujbnUKYOewPcurGkMaT94CAtB8QMOSgYeVBQrnM8o/aNpi?=
 =?us-ascii?Q?68EO/isvUryb77uwazjDaevaP1auMS/UM/pvfU3FD3zhOWFuHGx7zonH+FcF?=
 =?us-ascii?Q?psCNciWDj5jewT5TEjxKxRrxbsjPYAKRfrpq6kD5IOyuyHImrq0kqT0szObl?=
 =?us-ascii?Q?k41/Bx7QyhGzS5WfwteMSjgM9353vGRrzxgU5eKm6h+7GkyXxiei+Eq8BTvy?=
 =?us-ascii?Q?kQY4aVCoNK1qG8cYpJjEdlhnx/EBF0dLQNAT44kPDJWvBix7AVcYVw00gm8m?=
 =?us-ascii?Q?xK45PcAZxpjjEcESt0uHEq/ex4iZHWPxltWwXAlW9ugeE4NXAOeC8QXk2PWw?=
 =?us-ascii?Q?6ArMg1Q7FsjxNVRbmFYrdHx66TyiPM1KaTsMTfiWzbmwX1xEwrISym+IEfK3?=
 =?us-ascii?Q?cuysuAwUAp98Q7ZBe0MCPtgsij0WPa5mlM4SxUbCthfFlvcesbLZPj1X6Ewr?=
 =?us-ascii?Q?QGwdwrWCWUmV8FsQPncnHWHGmZTGWj6UMbRIAfHk4BeMt6mkbRZffl395N18?=
 =?us-ascii?Q?5aaDf336OFAadnFuikN85gypPO7hVot/2tTr8OTFrTdW3G2uDI6PamC+kWj1?=
 =?us-ascii?Q?0BWgOHIeVIC0V2p6a7Bt8lybmJWxnbzT8Gv/fPAtmJNcxwLzVu95CEdnXk5T?=
 =?us-ascii?Q?Zf7a1z0o5e6WACoTQfNHS5vi+IG/Sv22Azgi1wfrJmaNEI9EIrLkj3wkf2Iw?=
 =?us-ascii?Q?7G09HX+2jeGPcV1kFebV0Q9J2WfDhoCEQF4osCvMF61jH7L5FVArlnJ+RrFl?=
 =?us-ascii?Q?b8GRsG1ITAx1NqRMIPA3AN8nj42SbLW3dFE/ocqlWgtGa5AeZiYlDyYwcKJi?=
 =?us-ascii?Q?na7XEiqrQwSMG6pW+B+EI7qePwtYZ1ZFNmiRqdNPs2dUGkBx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221a1ae6-425a-41db-c44e-08df0688d543
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 11:21:27.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lghNglB5JI1ps0h8AO1uHKm1fToLTzI8GneeYwQkC4YfmycFwFITbi56owZzNAvYqaMCBmNacAPN94MNNXxRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

On Fri, Aug 28, 2026 at 02:17:27PM +0000, Eric Dumazet wrote:
> ipv6_srh_rcv() runs with skb->data at the Segment Routing Header (SRH)
> while skb_network_header() points at the IPv6 header.
> 
> When segments_left > 0, ipv6_srh_rcv() previously restored the skb->data
> position by pushing sizeof(struct ipv6hdr), assuming the SRH immediately
> followed the fixed IPv6 header. If another extension header (such as a
> Hop-by-Hop options header) precedes the SRH, skb_network_offset()
> remained negative.
> 
> This led to two problems:
> 1. During ip6_route_input(), fib6_rules_early_flow_dissect() invokes
>    __skb_flow_dissect() which passes the negative skb_network_offset()
>    to flow dissection, breaking BPF and C flow dissector logic.
> 2. If forwarded via ip6_forward() or redirected via act_mirred, downstream
>    handlers (like sch_fragment() or neighbour output) pass the negative
>    offset as an unsigned length, triggering OOB memcpy or buffer overflows.
> 
> Fix this by pushing -skb_network_offset(skb) before routing, ensuring
> skb_network_offset(skb) is 0 for route lookup / flow dissection as well as
> downstream forwarding. On the loopback path, pull skb_transport_offset(skb)
> to restore skb->data to the SRH before looping back.
> 
> Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Reported-by: Jun Yang <junvyyang@tencent.com>
> Reported-by: Fourie Zhang <fouriezhang@tencent.com>
> Closes: https://lore.kernel.org/netdev/20260817104128.22681-1-juny24602@gmail.com/
> Closes: https://lore.kernel.org/netdev/20260827092345.2301937-1-fouriezhang@tencent.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
