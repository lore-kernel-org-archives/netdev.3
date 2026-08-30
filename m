Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8EB29B77E
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071829; cv=fail; b=gBO6raOL3yMs2q8mxEVWR19vTbzSHS4yv8YjhsO4T2QZ6wC8xjhiwIeRKZG1IJI5TcNz+0mjrau5qT8HPl8z7ey3YwJHSfB4990hMuGGtaaD3kfL9dcOo9grwe7UkzUWJJP8rbeOWWL+GYTheq4/sF256tioBMA5DItx3Tqo0JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071829; c=relaxed/simple;
	bh=7P/GT1wxi7r8bXkX4ijKS0Bm+qUJeYRXFscTA/rsJCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VzW9Yz3Pq7/93xe4T/chuRkjbWDkYzi9SV+uscR3/ciPURUCa6xOEoObAB/FF6XBvZqG1cZK+Z2sDxlxpxLVC1q9ZVKkqhrxKvr34MtJYFqz1ANuuOxvcgxcQVlC2F5hgpCZE/5Kcjo0IAk2KVeFIEK2QWYLaGi+h1NnqdRtEZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B7wntgqD; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7wntgqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmf9DYexEhJEFkKdx5jIXcjxVAps1fY0y/qkpuwFf9nz/Am1aveP4tq+gVoh7NGJ6Ur7YMAw5GsNkzzw8ZWWsBP9dBfkIbR0+pxiw91V1ADTNUAxZ1NFt8LuqDYbI6jRbK6mKWNzH5TpsnncVyyCfDhCUtB/39Xoo2/5V71e1YR6PJBHz2enNhzUUBKCNGRUCCZ9KOzYNRhduCQlQ7cwYw56sapBD0cCJ6cT0bYseHxYC/sx50zHx1mbVTNQZfXnAC8+/gSuot5Hm+K24sKvz3WvCEBSd7/KsjMjw8kF9vUp+aBzKZr8hu03AkU6qpj0OLXwiqcBEdqxRuPZJ7AIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUiuAuBPBM/W6821AOBQeoieMcKqkbbJyDBn20oN9F4=;
 b=mrmloL+N8LvF6/v691sUpiA0DzGnkjTXUgN3yL22G8t0xf/jjUGc86fJl+AjeQIesJnlzDkndnkV3Tx96ptNwPbpQUA+Ez0fYG2yFPjG9Wunl/fyyWlW6rlp9yQt5Pqyvez3rrTiXaXniCdT9KFhsAVKeoZ1MCq8a9IjrlCTjhMyjbb2RPkZXd+BC840l7V/UUzBSErFdtz8mFeukWev0HdBAtxMY5F8DFEW80DW+iTLRpFUgV/GmVSD15XBKbiulEGHkoHI8b5szcmvr9V4ks+L8r2zjAdYlkJxxbWYFuO2QoY+7QQV0ccKNmJK/Y4zZeVRqCCIKxt8uh9GZdA8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUiuAuBPBM/W6821AOBQeoieMcKqkbbJyDBn20oN9F4=;
 b=B7wntgqDejMXO7gAfcRdihEVz+3s5yYPM13oEjJ5LGFsYZ/swV7GPxntXqJZSp49SAQxkCvZ8put4yufBjm9B6lUiibgv+diMOzrPyLegz1yZoTCRq+3EJ8ZGIo3ue1b3RV+rcc4gphEjW5azAybImLx25t12h2nreXpT1PyYRdBn43gIjv68LA4G+MDWfyGUKaDiYR0p60+vogRu9/afgWc8I66qk0qZRh0Ya/r0ABg/iynh5GqQSZtDzMrgCu4yuhvTiCQai0aa4Rx2Ih918VfWPWSTbdlVqPAf8BhPMX9K3PJ2nFWbPYyyPp01Zi+B6f+8uD744ejS3appPbjBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 06:36:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 06:36:57 +0000
Date: Sun, 30 Aug 2026 09:36:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: iprintercanon@gmail.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, tom@herbertland.com,
	vega@nebusec.ai, petalzu987@gmail.com, enjou1224z@gmail.com
Subject: Re: [PATCH net v3 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <20260830063647.GA2725797@shredder>
References: <cover.1787499036.git.petalzu987@gmail.com>
 <99ba13458fbcff6d646ee223f0b70847b790777d.1787499036.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ba13458fbcff6d646ee223f0b70847b790777d.1787499036.git.petalzu987@gmail.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fba02c8-1ae3-425c-5d25-08df06611681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|6133799003|3023799007|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	McAFqS/8/axWa/RExGlC9V6AYDkNaA1PsVLog4iVaFgScNij7NNvOmrIuPW/RkBZfCr76xXvorprT2QRf691Ilo1QOr+ZFQN+qrt5lOeyP+vWZiiu2X0OtjqgRzkAVI7v1ijaGwgR0z4kRUU3fItfgU4olDlCgY0DADAyL261Z0MwDXe2k7TSfoYYT6Da8P3Rd/QzD6N3Hwfrp6Fk5HS26goNjsAuirCoNj9s+YZd1wya/dfRjpd41K6U9Eq7lTpVZT4nen3623TWFWUGlT7bFIoavT6nPi1AESvgilUFRsOBshdkqyKfv5c4nVbJT7c2FyWEBXQ+ZWWKpwMMdClAQC7Ln/XoxYrJ7kl2lEYq9dzaCZRJLxLpwnhvy8xiAWdGtTp2N2WN+C3cx86l1Vi+5Ae0vVvGK0GjdbC339oC6+gQMO2s9dXj11RYDtatvpSSCZxkpHXiMfUpeVSxRpVh/V74oNfqNyGSmtS8yKLsQ0eU9ApFoYCZXkNTnOhPXlJ9hpn+qvtOfKG7xXsmHAB26Bts9ej91ooBbQfHnfHrG0O9SXB8BkQgDazzarT5/+GD6dLwS5w6Bxchpe5jL1R5NX/FEAFExMTYS/ZZh1qM/ZQoapnjgujPZmjtU4wZfaFAY4mv+LK6tcczqzhdvDDZJFtL6ZSkY3TiV0HTFVo3s4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(6133799003)(3023799007)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IBeAelqGAzQ0eb2M+7DmGfbbnMguHqPsySBv6LxBxSUr+5ziWBebx4aL4IYE?=
 =?us-ascii?Q?YAlTlTKt//4VBXi7mjrt9Ado5y80xKc5yPeZE1cbhgZPlL/Y05w/nLMj9R9g?=
 =?us-ascii?Q?nRzcmKwVoCXhPhP2kVuTOPKXlpCLtNXDXWq3nUozAHZLv0tuYzBjwW1/YWCK?=
 =?us-ascii?Q?GQKm9flJv7u/YaUKrdBq6FaHEhk47i3VN8dwk9BesUERDC20PrcFUfBSlD2r?=
 =?us-ascii?Q?6OdoZQfFyHyuI2aBMGrEjPffD+aGN4YrZTfIKSwnpYc/vEwU1JdYXQQxA9/S?=
 =?us-ascii?Q?sBt7E/p60vUB39zn6oB6Vk4Gka8LdmqygjOwVRApw/3ti2rOXwXrbb3ihmsG?=
 =?us-ascii?Q?SRj35w4ySzkgvQBJ/uYZk5MtRQ3id2wdG1SN82naev99xBunIw5KjVlE0M2T?=
 =?us-ascii?Q?dFaLQmNqYMU0T21qYKgU+0MqWJpnG8faeTz+uewE/Dp1Qqw83JFPKAqNgV/v?=
 =?us-ascii?Q?UM04a5su9duUtNWhfrHCPTG0JHNKqB0Wssu1MsGW2aiSnCARq6c2RZjVi7Vm?=
 =?us-ascii?Q?2jTH4Qxz9gjtNa1cdIsGsLvg/iOJ+3z61al+QeyR0NEZpF9dfSe/D0JxYN5v?=
 =?us-ascii?Q?5elvp2M8R9mIfSoLVk4X06VpPoK8NweTBXT5Xu2WkzxN9GK2Q3laJR2cHENG?=
 =?us-ascii?Q?cYTq7Oed+cGB2pBlZFGQSGFSQrzoj/ywtg0+DtOH4/64bCi1TxQbo2NRFCWl?=
 =?us-ascii?Q?PGfW0slgkoyJp3zn8Bl6FpIUQoRYHG3G7b+tEA5FovbnEJp39jP/v6nshO+N?=
 =?us-ascii?Q?e0t/Z1Z7QZ8QnsmI+jeU+ShmkHgWOCm7qMH7nKWlxo+70ova8QD/AKpkHkbo?=
 =?us-ascii?Q?2flh89pVEcBCVP664NFkdqfO6yPB8H889c53b6ahnWkoLkHML7c0JCItVfZi?=
 =?us-ascii?Q?Vyd63kUlPcgV3VrLuUiNgS3GTuhwljKDf9eVgRr5kwSf1C7axoXa4XUp0/ZY?=
 =?us-ascii?Q?FR4MMYBNbzMnpQzv2+ZyQsaNnKg6+l67kQPr2D9MxcLxWTER5MSNdCQaFSt6?=
 =?us-ascii?Q?eB5rG3evgW/sfwIEX7H+iqSZpSFuaZFtVHsN30EgP3a0RFrZoDREI6mDVxqo?=
 =?us-ascii?Q?Ej+KSa8p4EgoGse9S5DSOrHDgb1rw/8O0Ngctp87SBvmHDQ+1CATTb2jdW48?=
 =?us-ascii?Q?V0Dq15NDboSNNr6jLzd5PJhJ3Lc0DKV2LVuEpDpVz0qvniRLFQ8M3anUcdgi?=
 =?us-ascii?Q?2FFJxsddxLQlGDT1E+bw82kByy38x38SxTINo/JCYMKM++AdbOP4Qj+y2c6V?=
 =?us-ascii?Q?CA5dbrmhAjI/wMwSai2c7swjlF+Oc5vNYbtzP9TmhCGU3Igr/lerf8+HobYJ?=
 =?us-ascii?Q?ruv5vuYB9fXzj1wkGqkfQV592GMXCWHtTOmjN9jVEz+OJoBOZh0lyh8DiAnU?=
 =?us-ascii?Q?qWNg1BTPdkFxYwExoNF0G3xQ4Ltt1YeOi/YSiZLgfefFbhzcK8/s9FvXySC+?=
 =?us-ascii?Q?3WHzvtlaEa6No1Xt9pGbFvK9Al8/KB1G4JAyh6S2qxUXul61T7cQ/rJJcF5w?=
 =?us-ascii?Q?GfjGMODXs37yTOVmqKA/yfxUi1vVm7Giy6TIQUs5cnR72TV2Xml9ASFz8uRp?=
 =?us-ascii?Q?QWhSiaqSYI966eVDEjsh3oQ9DGM4IMOQo7KWsksblD4WznfjXmT+B9jBhpI0?=
 =?us-ascii?Q?AUGS0ihLoCRfOiTJA3V/iqC0HTcFXrkC2ojBTR7w5+hXRiozXOQsdOvuUDKe?=
 =?us-ascii?Q?neXpLl/nYQQ8OnUGLKveqJrzkIRwaCTE1eYuVx2oWafREM5I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fba02c8-1ae3-425c-5d25-08df06611681
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 06:36:57.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is2sNm9FC5xFPgpVQdd70LJQultaQ4c0m9ZfmTiTiQ6z1ksFQ3W0gKpk9kLq9ADeaEpsUy65aa9U2niYk8By+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194

On Tue, Aug 25, 2026 at 03:29:49PM +0800, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> ip6_tnl_changelink() can update encapsulation parameters while the
> netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> headroom with t->encap_hlen and later build an encapsulation header from
> the live t->encap. A concurrent update can change the encapsulation
> header between these accesses and make skb_push() underflow the skb head.
> 
> Take a local snapshot of t->encap before calculating the encapsulation
> header length. Use that same snapshot for headroom accounting, metadata
> validation, and build_header(). This keeps all encapsulation decisions
> for an skb consistent even if changelink updates the live configuration.
> 
> Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

The comment from Sashiko [1] (which I asked to review multiple times
[2][3]) looks valid. We need something like the diff below. The helper
can then be used in the IPv4 code.

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe3..97f3e9e3ccf5 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -522,6 +522,15 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 	return SKB_NOT_DROPPED_YET;
 }
 
+static inline void ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
+					    const struct ip_tunnel_encap *src)
+{
+	dst->type = READ_ONCE(src->type);
+	dst->flags = READ_ONCE(src->flags);
+	dst->sport = READ_ONCE(src->sport);
+	dst->dport = READ_ONCE(src->dport);
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 63c524b080dd..6ca373d6205a 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1205,8 +1205,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		goto tx_err_dst_release;
 	}
 
-	/* Can tear, but hlen and build_header() use the same snapshot. */
-	ipencap = data_race(t->encap);
+	ip_tunnel_encap_snapshot(&ipencap, &t->encap);
 	encap_hlen = ip6_encap_hlen(&ipencap);
 	if (unlikely(encap_hlen < 0))
 		goto tx_err_dst_release;

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/99ba13458fbcff6d646ee223f0b70847b790777d.1787499036.git.petalzu987%40gmail.com
[2] https://lore.kernel.org/netdev/20260812120827.GA3410841@shredder/
[3] https://lore.kernel.org/netdev/20260817064250.GA196908@shredder/
