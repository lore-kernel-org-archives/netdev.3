Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E15304B0;
	Thu,  1 Oct 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866450; cv=fail; b=qLlZT19gl8kY2QXd7hLyqGcYMMWce7G9C/hfLvGUEvw9M/0bTi9O/yScJ/C5Ma1uIdA0+v3B00lbxOhYejPzjdHwLMYfUGjh6iqgAsDnkSrUY1r5jEGqeoY+Ft0FPdXBOCd+mLyXiFC8D395rfoFg1SL0jLRpADaLVgQx3vQ6fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866450; c=relaxed/simple;
	bh=mha01ZvPFLlMtmhAf7WqoYRSzaRfpEZpmFYTqRTWlf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZxF3wdPFBL/UbgTrWwgSxjOKdam08VclbyzVcW+n6O+6Cfl4FodcaPpAiUjugv1kiPlYzf5TYcPtxnRhGNWHhoUfLQr8wO9Ce57ubK7mH8CrGpfxZrVCytHfI8RLB+swkppTayMLr6RR5MIMdEIMrETNzKYvfiQGAkmuXDhHvYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PRdCIvQi; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PRdCIvQi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQm+Prr5Ar7THSMJalRF2ZNcUiY7MYGWejkjlI1b3HV9fN9nnLZRPgyHutA66AwvM1zOuqYtqO5mw0aDV/SMwmAqcohYLutjeSJptV6nV/tvWKjGgonH9ecF7wArMsnPI212Y/gBdBVql4bwqtfubXsvhI+IbkCCaUvjZC/ulMSolm/7Fqm+tRYu5m/vQbH4li8UTPopvBA48FwIl4Wg/T22g3okdO7+VJy5fI1XN8SvEzPTXPyQjLtnsVGXGv4xFuPCYB4bjayyMnktsuU3tZAlddUe1gyxrjbpZjXw9l4xkC/4wfdUwMxGIeV611m6jp8KFFXiqrD/PTzdTFLQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtLat0ka8UXnDB8UnLdAwgctQ7naWow+/4TfpU3158o=;
 b=UEZP8Oxm47CxIJUv81UT0KpvYYwqW/6NhdpMJ068AXsPcEs2eLvrNROsLGV8mG60j+UqtgtJmXtDxwhZgMqcW3xTEpcb1ubGcrAQNnzX0F5elYe1IjpijFazczKfTG2xECIVbqhGmGDFfyHuxsDRnnLBULSez2dP37aMfe3Xjtw6MrD73FBCf907LpCNxYOlPZ1hDJ45LnJtfmS08MnURgufkQyD2/LF7tzMGEmLqQv05q7+vfg7pxY8HHbGyQcLt9OEv/Jf4a98dcpfNg+4FvkXvJNJPBVDN7OZQjN2OQkcx09ZVEisW6GFED8BxZ15TVJMk81chimn/MiNdvQH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtLat0ka8UXnDB8UnLdAwgctQ7naWow+/4TfpU3158o=;
 b=PRdCIvQiWE8RWdvEN0BbOVCdETrxMGUjg8UMfyAmnOAOfMMlaeyxfpOsPBNoiXgz1r2RcI6krWiweWMoFRUnar59WbC+SWOlK4+NP1p7PzRMAwzreVWH4GvgEm100LZfSbECaRNOGZ/c0MCfRlznkYMDtpLUzHKUiaEqZVxHgGChOmjyFuoou4svyvLeowiazxWaBZKOdq0+LmS/W1t2KluxGEJ3aD4exVGMPeZyIr5Yfhymyfc6LhU1pgV4PORh7+1P9kkwe7r3N0E1yCDw8OkoieowhXIaSNOUXQrO0AahBRjHC4Gi9cf6E1nI7wO2EBUsU9rJPGOKW73Gpf6Zjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:54:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 14:54:04 +0000
Date: Thu, 1 Oct 2026 17:53:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ip6_gre: validate ERSPAN skb dst before PMTU update
Message-ID: <20261001145353.GA1580038@shredder>
References: <20260930075320.760328-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930075320.760328-1-4ncienth@gmail.com>
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: fd249bfb-0747-4473-4fc1-08df1fcbd660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|3023799007|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fD4JUsC7I1aLLxXb4jOYiWUEBu2jYOhuQptvc7sfZ3tTjoEBNzh0dr3krlS+sUirYYokWIU7j+dMNocaWiL3gXf2L7MrQb5NitjDfYv0VXyuj8E8JNCVVn2mIe2kRny4js43lV5USHuiw90STTOsZeaKt3VWTsj73Ne4BTwSzfnEEukIuR9bvRmgCyoCXEuq4wGMITBs5uuMJ1KR4cYGVBoFPpZn4cRtFMkUamJYpsqM6Qjyoc1CYB2d7cJlDEKcGzZFwqBL2G/gTlKrQKmnirjJOSV9Kmy4Ck/VtK35EpPpDlPDR64VbW0FjiYg89UkWDPEa8sLH4k1YM2ibzc8nBMJHTDrg+pa/roJ7tNMsKLGco6VXnENH4H3RukfPkJJRxU9qAYWp78s6RUyJO394FJBnRsQWKMYDWkLSSetm0w1tnjb2614hpdcIeOBuquWmE4ert5PCn6nhpIl3Nc+67hZNhJLvj41cUKWIgwQe7m8hdtlovNllFJS0xFal6YPq/QMXnZMYNqCz0x+7feOYyFR6wlLCD4iMmf6PcMfpGu2CsQsqRWH1zKc6251jTWq05G0yO0XmgGMTsWqhFHy1ARRACEr/MYhrkSMhYUJEqVWC4kCrGczwvJgnDYh9sa+8CrVhLaB1r/0oXmGW1ZpA4VdxyyiWoLNLPYu4ceMNPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqlVWxp0QKb9zwSB6mtiCl7ccLJXER1ppTUEBMRRyMSJvt6dYJoVzBd+MgJx?=
 =?us-ascii?Q?kYtyuo6sQMg1uWnF+llHr5iSVs+cqjMWnqBUgP+3joEkBPwQ8BuiRgc6eHBd?=
 =?us-ascii?Q?DSDoP9oOJXvC5LtXEuZIReFjOmQfRWdyyCGmmMbWTwHO1pwmH+bde4U7zOc3?=
 =?us-ascii?Q?aedYevRsEO01ct1BsbkLYAqVqpMFw5Sb3mCd7P5MKKggxOE0yAlooaPX22L5?=
 =?us-ascii?Q?3K3J43leCJaW1Q9AP9fP+z4dZbXiA/v5F6LA8SpqgebBmpnZdO/bB8tNyIO2?=
 =?us-ascii?Q?tXwq4cW4a8fxZprRxAxsXDLLlN+VYblZripLoTI1yjZj6glhZ77PT99U8hwg?=
 =?us-ascii?Q?HDoqc957Hp8uMxcaMWxtCGrrosYXP4ypEdWXwZhtBmZ+mn+AN3LUicx9ag1l?=
 =?us-ascii?Q?iUzbtthI0zZBPfyP5yy4w0MwifvQLE92c4REtDznbcpGOSFg7NA0gBNodWcn?=
 =?us-ascii?Q?jRoPke8XcEb79CE+KqQRqTW0TajbgT2mGFOFkmySXUgE93RBOqvxj3LedqCV?=
 =?us-ascii?Q?KBvURvgG11QIwiE02to22/Po7vnYxp3wkwJ9h8jG5I3hg6vNmUB47Y/sg6Qz?=
 =?us-ascii?Q?L4GbdHpx8RWbU212Htehfhl8edTpjgIQeu84nYh+vQdlgC2He53tTqy/9KAt?=
 =?us-ascii?Q?5TE/qhR7RiLVkm5yLZeJiY7lmSadP9XfwsN17lMXU3FIdP6SZ+YizQaggoiX?=
 =?us-ascii?Q?OJ9WwnLxBaeOkxz6QGrYUajUQ1EdgJo5nl7ARBcQsdhSYG27Zv0LxFOvJZGG?=
 =?us-ascii?Q?x4raXOgObNr6hYb37dlSQu+8Jx0CzIoZlZgkPTlMixvpmal879a2AUEPALk1?=
 =?us-ascii?Q?ufYP2xH8sOUpsnmLOpPMypEKUGvh34UqDy46mwW0/0hWKSbUICYt0kMNSO53?=
 =?us-ascii?Q?a9dD3XIXHjzJDeC1gtYjNBMU9TNmXaz4GRJ1VNU4I7oMSihu7kaCK9S4MGwC?=
 =?us-ascii?Q?QrkwZAr+4cs/93eYD5US4x1UZvTaNqs+80tOPAqy8uvht6ZzHMGlFUZ5huiF?=
 =?us-ascii?Q?EnRW8vVJy3v+AomMXsd9T2sdvzVW/1UDH/x4eqEhbyFLswdz/APvuVmaxpA6?=
 =?us-ascii?Q?S+lf9zw/Y0P1T8Fw7kR5qaX08LOBjyNtNqFFtD2Sv4t3d+4rCv6gnQOv8RO6?=
 =?us-ascii?Q?mzg0zhfYB0M2KZtiSMpCfZzANEamQLKfBO2d7ispWkZ//FkXr/zYNYvfOCLA?=
 =?us-ascii?Q?VnUeuK49nwDZZzVGt/ylpYTu9MHU1uC/GQ1TblpJJicKOLtOLbsWnUND5D3p?=
 =?us-ascii?Q?q2ccz2kbOVSY1TJJljoFF7KpZRN7Ks1jGxBuKXeIoyhIF2I4e19PtISEwcdl?=
 =?us-ascii?Q?N4tHw+0rq2A1qGHN314laWKJHvpurnoDMsWfG/FEkb09vWQUtX/jMsjgFgLC?=
 =?us-ascii?Q?cWgJXPkYf49YWR7ycBFzzEt2NG7V3HqjmaD+AE9XXfS+xkyCnSRbWRPLKGdE?=
 =?us-ascii?Q?mMZwN/dMOCWfSYPxmBFGOSnppMdo5hfES3n0lRAbOMf/yBFktAD7IMNifvv5?=
 =?us-ascii?Q?tWBbDbYUkvwpTQoMpuyO6Mjy89zsGaSEeCiEPrajK6ldEVN1pg+FpSKCut1W?=
 =?us-ascii?Q?RJKGhID4Co7MNukf2Fj/aXq3vCkKnET7Jxrs5Kb2xrc4QGhnx6yJw1Rj9tx9?=
 =?us-ascii?Q?mlpZgiHGyfwgrOySj7srzwEeDmfQ+6EBqfcuNl6RsObxadehxIuVhp5T1VXg?=
 =?us-ascii?Q?N05KR05XPFfYIhLnOFTfHfzN0XXcxkHbc8N8ZLbUK+6QDCen6bFVf6tPcHdc?=
 =?us-ascii?Q?1pLWyz14zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd249bfb-0747-4473-4fc1-08df1fcbd660
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:54:04.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0aQ5A41fgN3M1/9V6RtlMJVplFR7d1Iqr6eqwib0KeTgEzs3u4/6ZMhf1DmE8JVXiPbmtXiwa1YP1yLDg+9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

On Wed, Sep 30, 2026 at 04:53:20PM +0900, Daehyeon Ko wrote:
> A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
> and mirred preserves it when redirecting the skb to a native ip6erspan
> device. ip6erspan_tunnel_xmit() treats any non-NULL dst as a route for
> PMTU updates. A metadata dst has no output device, so
> dst_dev(dst)->mtu dereferences NULL.
> 
> On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0
> created user and network namespaces, used namespace-local CAP_NET_ADMIN,
> and triggered:
> 
>   KASAN: null-ptr-deref
>   RIP: 0010:ip6erspan_tunnel_xmit+0x10fc/0x2cc0
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> The collect-metadata path already skips this block because its metadata
> describes the outer tunnel. Native mode must still propagate PMTU updates
> for real route destinations. Use skb_valid_dst(), matching IPv4 tunnel
> PMTU handling, to exclude DST_METADATA without suppressing valid routes.
> 
> With this change, the same trigger processed three packets without a
> sanitizer report, oops, or panic.
> 
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Affected since v4.16-rc1; present in v7.2 and all four pinned
> 2026-09-30 upstream snapshots.
> 
> Tested with CONFIG_USER_NS=y, CONFIG_NET_NS=y, CONFIG_IPV6_GRE=y,
> CONFIG_NET_CLS_ACT=y, CONFIG_NET_ACT_TUNNEL_KEY=y, and
> CONFIG_NET_ACT_MIRRED=y. Config SHA-256:
> f992c9fdb881ca95c467896791c52554719f6204cf06268cd92ac37c14c14f83
> 
> The reproducer is available privately on request and is omitted from this
> public AI-assisted report.
> ---
>  net/ipv6/ip6_gre.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index e61cb10b50dc..3ee7fad6089a 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1059,7 +1059,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  			 htonl(atomic_fetch_inc(&t->o_seqno)));
>  
>  	/* TooBig packet may have updated dst->dev's mtu */
> -	if (!t->parms.collect_md && dst) {
> +	if (!t->parms.collect_md && skb_valid_dst(skb)) {
>  		mtu = READ_ONCE(dst_dev(dst)->mtu);
>  		if (dst_mtu(dst) > mtu)
>  			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);

This hunk seems obsolete and it's better to remove it like commit
fe1a4ca0a2b7 ("ip6_gre: process toobig in a better way") did in
__gre6_xmit().

Nowadays the ICMP error handler sets the PMTU in the underlay route and
ip6_tnl_xmit() propagates it to the overlay route.
