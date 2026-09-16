Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22E44C662;
	Wed, 16 Sep 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546848; cv=fail; b=BeMt2FmBSQ6+rOi4cFeZ/YhtCPyfuuOGYJ/zC78taM5WuUlpGtlU/cEVlqYu2/fCs2nqAMS4kiFSNoEUSpeRAy6ltoiX/oOT0OpE09iHTDEiGIz6cvoNGzhqIeLufVevYd81CLQKGbe8BqFVEr9O8tq3Vx4RnYeqE1QhwfoHX74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546848; c=relaxed/simple;
	bh=mvxgqqWcACPeYjxh9AXbLrN8KtmLxlctLe37yA2CfDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kL9riMWkzRa5PfSZ92tb5GRG5NJgChfTgoKdx69+TpfmT6pn5WSMNVkT13XTQR4Uba9ZwAx2aRuLHducNXTzvMOIM7qtPGrJdAZEclPBjlvAAycui4ld0EkHzLnBhmxcySuTtp5Sf0g1ZZGpSCU1AiWmb+UhDBmHCux7+TDRf60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/GcNS96; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/GcNS96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY8LAFUJn5IjLbik+4WxufeTAfiqCSjnniLBKBC3iMpEJIkpsUOPaapCYAp1TCUs52DLP0GA5eA74UD+Kb/dOVKVJfpXog6dfFdCPxqb9jFPGuKRp0kd/po5LF8MKnEgpvVuhkia5GRZEubR32Ee0fsCneyEMrYuLLFML87OBL0YnGy0oPukJyJG2AgVGQk98sD0nEwJ8XsGlXRqTNvppMbz9sn+rN18tiM7UpIE7Xvmy1OM9/ZyX0Wivn+b0AvhteY9RZcwvMvy70DfTkWZe65c9CJG/iYE41z8cNbDBv7CTYIJ2qUu8nx+kELB3hGj3+rZ0vfC/+JuspMQeY49UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XQLnQxspT2WGlgStY6UUTdEfeQ3zNnl61R2VQvkliQ=;
 b=N2ER4adwMujQnp5yLs3v2jyFTyegQ5F8KVrlWYdOnavfJhqPF+48cVhdFTAeAfLCPAJxY2YC76GeAUc3ejAW/PjsiTkXZ9nt4ZRj5r9eBYXXu24iMoHInNvJwYAUhZotRqX22VtAI+iMzXulDv52RbWq4nUup6NPbdkHP+qmFLzhCisSymcKTJRVToiOTOE2YlbOFzEX4+xh0eJgzfqJUb7iiAfdmKO8HuweGFwKTgmXUWHrtQmaoPSXhGY+GVONCDdXno4eydw0YaO3wcylD7GLMQUkpM2hKyvyJgcrWNx4B9HJdfg1xE/5f/4l4gesCEIyyzTrO35Tsj/J6Fk05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XQLnQxspT2WGlgStY6UUTdEfeQ3zNnl61R2VQvkliQ=;
 b=P/GcNS960oBbZwxyeACcSj6AN8yO/ixuzKdSpBC/dAZIl+nYzmbvBgFVwhx67RPbvHZBR99Jm5rPwyk+LZqqw7sgQDbwhWLwz3MvJziSPb4mYcVseXEQOsatnZuSlSRPC3fP6A/bAZ3nR9P1e32RQDg2aGgDr2ihrH0mhhZXY2JyiMz6kZuID0AY8/bRWg2pbnfQ3/1rfFf//XRpHDsoQYcD56SF6xOlN+zI+/FdVnwsIgkJSaisiI8HgHe1ZPSoNrylb724gtOFbhurRNHa0KdmeTawb7e6TZMAPk8l0j0YWdFWVugQ1DB4kSlnY1iNXPLhdEO6E/S+liVnI+evmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 08:20:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 08:20:37 +0000
Date: Wed, 16 Sep 2026 11:20:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
Message-ID: <20260916082028.GA879236@shredder>
References: <20260916061314.936440-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916061314.936440-1-yun.zhou@windriver.com>
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: e1315053-1836-44d8-e379-08df13cb633e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IFXmclXk3g/pn5k76vGxgfrgtAxDAVH91GHKhNbB4WRSvoRg2EyOzDZNRJALPt5oW8IYm6BWtvkuS8+z3I6jXEr/wx2xNZMPb8T16ugvbtN1/7D5CTKJq2L6L2XQAHOgpKyqNxCpi2W94RXp8EzcWYqwUi1W1dD6jZ8WKDsMElyOyEhIHtywgMMOJeFZgA+n60PMarE/9rSAWI53nbil21bBeJVqZhd5/0+XzTo2O8Bz2kmawZQKoPOYALqfiy1ClCXbA5iWPZCTsmjWo+lzwTmMsy9LWP3XJf+8M1/JfHe8XY/fUprnLiEN09rfB2qWjEozAMfr9ljMOWpGnlW5nUT6tZ7rF9jqgrc4RRTfNOndzQu1a4IH88Me2kvGUwqg0yQCiEZqYyDZNvM/gvef6yTZmNIxERvBxNqPLoyCxDQzDvJmDIMGiISyglZ3My02CMLcysZ1AYxqaEJW2s1mQSJ6sXA+rTSVrFfTCaDV1cwld3c2Skuv/rzjTzI7rqMBc38iqrrga/CKozX1eU9NFdqogdyeV3gqc1OMV9VIm0s/YUVqhpN5dy8RkIKSlxTnzwsQnQtBtLKNTIRkP9mPWNIn5oU2oEDWBm6PuSbfxkhYyczZ3cdsYHn7QUKGVfMbAQ5aHqx3gNf9GSHfTJQdXPLBZYB5JTXCRFhnNrvK154=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HsM2Af8LQ/ntGJISLd9hU7SI1PDVu0Oz/IQ8RVfnB+P2HA14J+AOTdIKyHm6?=
 =?us-ascii?Q?i1RiSqBFzTA7TAnvhnImEQRhZlO2QTaCUg4W6aqt8VdAvzSqPdxKAP9bMSCU?=
 =?us-ascii?Q?rqsgGqLJkGumasEt+kQuo2VNq4Z7UpStfioIrxB7AgsZ5gbXXdOyJRjMHs8Q?=
 =?us-ascii?Q?KL/lhrLlzeo6CvqdfR+RHUxcZhnaB6EMb2L++ELPkM5zi8uVUZJaMcLSJOBj?=
 =?us-ascii?Q?aL1Q9N5h6EJ3nnNRjtgEPtYynHK9g2x3tlt1ylrCtAzAe7e8IVYOmN0BisoX?=
 =?us-ascii?Q?dpBxkXt9QsadpuzvPtbRqgegZH5J6ObJyO3HixOWGsppU3WIIKM6iyoQZ0Cp?=
 =?us-ascii?Q?CEHxMvExO9jXH/Jzq5xz7X+j8eCFS50VnLUxR0Tqcv3nMXfwZ/NkW/vqj13u?=
 =?us-ascii?Q?hzc8ELUuKdnGSX33k1CYRS4OUn57N3FqJ01kcuOoD62/dJKgyH3ZqNdz9fK5?=
 =?us-ascii?Q?YWNqMJA1loRhOgkMRcSZCbGzv7VFarSmeJZAES4S/81Ct8rNusH3JS+xyzFv?=
 =?us-ascii?Q?uub8W6mQYvBs44hCcvskqhTK9rZysZuyRFKnemOYUGU13r3xnukyxzrxu4Nw?=
 =?us-ascii?Q?8F++LTMnkwsEJ9+4adB/ufbUdDwImAhaaPQFl66GAhr/Rz339iqe/5HtGBxg?=
 =?us-ascii?Q?sgU5iNtplz4ULUcU0HHz5tvyc2Ulos5Lrw9Uf6ejHvm365DdlKmJRREM7r1E?=
 =?us-ascii?Q?Gb7au5cQ1CzKO6To/bo2q86Mon3SeY/Y2zxKq/cFTqyEse3OT+m9y68UJNJA?=
 =?us-ascii?Q?VYGb30QzTnDbTKoWlnhS2XOW3JC55nDSAkGUzz7pf3nFBxq5fEzLBd/6y4La?=
 =?us-ascii?Q?uEVO3aaLApAMlPVF381zr3O7yqbV32/FDSKHegzCJ+ZSN++xDMF4JXAwPIrK?=
 =?us-ascii?Q?sqURT68bQ6pVY/vm32cjCiuapZumOYBgWDCmM9jtdXhdVHHVGNtp4JJMB19s?=
 =?us-ascii?Q?E1TsGncUBd6/eBc2vLrchuZ3PByFpnbPtLTRYMKz9W2G5Ozzvr5UgFEpwAk6?=
 =?us-ascii?Q?uJoNLF7SsL1Ye99MohP2Y9THaz8QI7t2SG/qcwmeXSKzR7VNW7Le7tnmvNkc?=
 =?us-ascii?Q?78YVFVIzHU945FPHPrOLWmKxSC1FiZHQGCZhfPwcCSmIaFG+qdiEDsDh3df/?=
 =?us-ascii?Q?8vcrxxFNouU5rKBGYcb9afT0kJB9oVZn78vzMw3FZBVSgi1pJfCMqAbxSFr+?=
 =?us-ascii?Q?W3jL2zN41pL293RAW3W4Up8fqp94GpzdOY/pfGbKUqw5ezdivOCu1dMJclbb?=
 =?us-ascii?Q?0EQsCrcm3NzCLnu/x5RAQHUmfpV3uhlEHQSWSIpgxS1dMLqBrNYUVO9gQ2RQ?=
 =?us-ascii?Q?Sn4IIHZqyTcIA+hR99iCHQ1X+IEaTm5RBphxmmcTdxku0p7tigM0IvzvzwNT?=
 =?us-ascii?Q?6FH6DGnsSgw7mw3Kgvr/81MXgPYWF5xuOYmw5MEL3cLuzou+Q/BFqMh/izl+?=
 =?us-ascii?Q?HxByp6EGqNSNloKiOLZmzxeS0Uc3SoWaaizJ/BppZ6sfYg0FSdrGF1lHGOoz?=
 =?us-ascii?Q?fq1+NfPQf8XWZGzR2ag/siB5oFw/vwABM430sASB/xYM0YgxsaXXhz/6NLXF?=
 =?us-ascii?Q?8N+XrFAZffl61OG/D2FfTuLM9/2zWJ9YtNmmaFDJ/Y04zxhl5Vj8DTteyilW?=
 =?us-ascii?Q?c+hNS3fKfcJLxuvjC/qSigsQ8tOvP18mpgf3xnHEdzDM3YS1uD24U6Rt/Ne6?=
 =?us-ascii?Q?R0QZZSAmNR8Bp1wmEfWuIwx6WhCLjndd/a3qFcYJx3jWwNJk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1315053-1836-44d8-e379-08df13cb633e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:20:37.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IQhuZqwfFmsmJsVcYm7S/DMyqR/vyYSAHZyz3Yiv5f10c8NKoiTpICGIWTEjfLBtaHgRhTfS3tRcDYCsN6kyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

On Wed, Sep 16, 2026 at 02:13:14PM +0800, Yun Zhou wrote:
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock, creating an ABBA deadlock:
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
> o_flags is no longer modified in the xmit path since commit 9958e69b9893
> ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
> GRETAP, the sibling device with identical xmit structure, already sets
> lltx.

In v3 I asked that the commit message:

1. State that the overlay and underlay devices should be of the same
type (both erspan or both ip6erspan) for the splat to happen.

2. Mention the IPv6 fix. Currently you only describe the IPv4 path:
erspan_xmit() -> ip_tunnel_xmit()

https://lore.kernel.org/netdev/20260803151146.GA766007@shredder/

> 
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
> v4:
>   - refine commit message
> 
> v3:
>   - add fix for IPv6
> 
> v2:
>   - change subject prefix to [PATCH net]
> 
>  net/ipv4/ip_gre.c  | 2 ++
>  net/ipv6/ip6_gre.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e..0058cb20e36a 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1367,6 +1367,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>  	dev->features		|= GRE_FEATURES;
>  	dev->hw_features	|= GRE_FEATURES;
>  	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */

Nit: I would drop this comment. It doesn't add anything and we don't
have it above similar assignments in the file.

> +	dev->lltx = true;
>  	netif_keep_dst(dev);
>  
>  	return ip_tunnel_init(dev);
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 8ebda0b6a78b..578fb3475f8c 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1871,6 +1871,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
>  		dev->mtu -= 8;
>  
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */

Same.

> +	dev->lltx = true;
>  	ip6erspan_tnl_link_config(tunnel, 1);
>  
>  	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
> -- 
> 2.43.0
> 
