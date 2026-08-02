Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A53168EB
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695594; cv=fail; b=WjteRy2dZvSjXX7sUoFE+lMP8kyjwWQvbMBPfIYYO/qQ5YbTO+FvHH0Sh9KQjQvTMEX2KPRcWI07USm5ndRDSxvpRhfbsYxuBlAJ+NDi2wbZrDkc315A1nNoDifiwvzs8LD0Ue33IL2ow9ZzMH+qohUYzmMhiVTjh9hOnEO6xSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695594; c=relaxed/simple;
	bh=6+TFNOZZBzd/lZmbCYPlxw8Y+bvzZEvu7P2JpyJY7FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8JkYQQh9hiD+vHJgswTTNx/wxYC7sc3KDkYBQouKPkhW5dkDX2AKCOX16FpNjpexznui2xnYA/al2ohO6YmAGGkGlskSuFsnlPqgX3d4KMKXpO6kXVHsAgNGV3nfyzWIRjSifY3ehgWk1xEYSK1JoP4f+zbITJgdagsgu5pOVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBLu2HqN; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBLu2HqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caWG6BhdauJi96wDxEAO4bw4Kg5WN3fTc+62iy0ap7jggMZPaI4ZQVplzo2kj7B18a8IviQqLHw8/TVBxpiuu5oI7A5TaxgmrWZwEBJi4acVh+yC4FnWwpBLCed0BACOO1p0i2zFggaOGg8dzg1/P8Af6nGnvueLYE3ZH/7/fsnzKtwgeSBQ9zltHIZzHPEmYE3NqQg3816UdMy+OXfMCJ4N0WXfUKJlADf9fYh8wQBouA0Yaqh3t7PuDmFvL1JWrJmbR2bLpcM2RFCi6UnbP1GQpU8ZuAqEH7+CeEUZ1dju+LiWxJ2wE0mSg7gfrbIMMMCLOgXQ6Z+5RUcl1fAHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DER8l2ISAbvp5FAbQ7SXQqkuaj1IZWvX0XH/E5cXj7c=;
 b=fwVsiPp8Zl09CV9Inc+OoIcER/tcHt/PpwlTkfGNc6Aj+Oa4UMlroKPqgd8w7cz6J8Ezb7TuxPiimBNhcIo6oluAZsWPqJ+Uhc5ouTeqCGlYWTWeubidM88dy1ijJhf9RT2tMIOKPQWmNjopoFwLqXI55IFym6Nn/ToPXFXwb8bSIpto2FkAiHy6pFm2yzRnIA94jiwRMe1z+uFdN3l8MJvlgL48pMgjDFDtRT0LcNM0UX7NtTCMYGrx+EHCsfCJZmGs8+IH+X1O7QW5yJxPlPkzpPpEidsufiNa7cQIUHZqmwtFamK8q3PU2mtrTzGoxIC0StLairGh+FAQJDRBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DER8l2ISAbvp5FAbQ7SXQqkuaj1IZWvX0XH/E5cXj7c=;
 b=kBLu2HqNOjcB0daMFcaGzYU9/eHitOMBswYVqlYWTtdYdH3WNacWDcYDqYt5YfZo47ZPXXH+c4xviRBoMtpjTL0IEb/x0FrZ9cy2iZHkpHoGmejjxb38p8rRTLQPXP1yIgQscJVHqVZJirOrfSKWpP/Rt8CEOknj7L8rFj/qPBb6hH3m+uQ809v8qmyR9k2ztNELtVmz6mamn1UcRe39k8TCjGRXP3oTIYzHPEUdqNbcZ4RkM6KT8SuGH+EeNkhkxrMUr9mrShwP5xmGMmfXuU6ybrgfitUKMVKvMtt6e8uSZaP6j8FqfXLuTyXh29SAgQECrnXTuw5UdkvJMdwQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 18:33:09 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 18:33:08 +0000
Date: Sun, 2 Aug 2026 21:33:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	tom@herbertland.com, vega@nebusec.ai, petalzu987@gmail.com
Subject: Re: [PATCH net 1/1] ip6_tunnel: avoid racing encap setup in
 changelink
Message-ID: <20260802183300.GA481323@shredder>
References: <cover.1785221754.git.petalzu987@gmail.com>
 <f4a1f215a63268d5b1028521537e8f292d5f41a6.1785221754.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a1f215a63268d5b1028521537e8f292d5f41a6.1785221754.git.petalzu987@gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: e37ad5fb-d4c4-4db8-247a-08def0c48004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|3023799007|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	X0A5myK6Fi5nzwLbwK+QW3Cqktevy17/XHEpF9YZPKcllyNjsG8mzTAFJveCEhmSl+C2dWqKXrTdTzAD4Zlnbyj0AXUHd0xWIkRySqwPtoq1TjHjnKw6fbDFndJMLnQHCbvltMPMJOhBlCpBb/0lyc7i2rMpLYFbFmC/1aLZ/YtHkyQzrfzCBtvIsGess0F0OGWl92C0MEe/EPXBdKu/1IvD/rp/ZODx/jhIvdKUbmhRdz5YB3pGHzMKBJRFrAwaSD53qlL6x73y+8VqOK4YX5v2tD1BBmn1ZxD17jvtm7zox8LCoRL3fxndDqCWIeGo+SwhAOfWl6bvv/uJZsQrzKvczrMoUaR9xj9t0y7KP7t0imeou5YhPHpa1XiVJJ+SsAE9BTt/Q5bt04xgugMW6Kh/wBH1+BVMB3NnM4G0V0cirR8zFy7IiwMFPRho7pn8ISaSQVwV4gfDKj/8vrp/rxo5WmIHBnZgkZFkMbHLqRThIt+HrfaETp2/DZzWvU5RW5BYVWSEHObjBWHV75rbN5GAh1BFwr7GFuSMEwHGUm0XUpH2foi1R0OO2bJThdnkZ1Re4+A9k27BYLeDr6VR6tRM0FTNHErhNDYkIfhuk6fjTgyEzHR7oUcrI77/taIxFw+fASrr/likp7AifhIo877u9/jP13I3pu7cqnbgJEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(3023799007)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rN25fFdXRW77gbx5DGKsmS01TLV8oeGAunqazyF0kTtPcU9qgimMnJFo+5iN?=
 =?us-ascii?Q?5M5SDvAPC8qT9KW7tXOHhqE+8P7qpNG69rE1w4xbmDUHfSW0bafZ93pVMJz6?=
 =?us-ascii?Q?tSJQ6sJHicIJio5uo8q65GTz3ZRufo1dV32M4pzlSyUN4TdlWC8Vtbc8FJmr?=
 =?us-ascii?Q?CO4DBB66gNlTMtaC2HEZar/6Hq44cORR7nNurp/9AwlTuOnpd+wiqOyEIh9u?=
 =?us-ascii?Q?hCr9nBcXRTA5ERx07YORZRjTVk/nj82PquxlIFiecCi563Z3Lg2wRJbtv+A2?=
 =?us-ascii?Q?iVm6JYX3V8sVKB/v4ku8gkiJz+Smy2jkH3RSgDrypnKmQOlDOzxWLkLr2pp8?=
 =?us-ascii?Q?y4n7TEwuv3QLJFRDVhMeS5kykNBKVrUahcnDDqDRJseukYm28PgukbWW+5Ae?=
 =?us-ascii?Q?zYpw82FatjYibSb0gzOxCXZdjszCyH7MgQig8Li2U5k9UGWEqd0oH0auXp3n?=
 =?us-ascii?Q?mzm/QZdsi8GBSLjLZg+W6baCUpUiCUUGgFIvs/Jkv8F84FHoGw1mp3Lg1ydf?=
 =?us-ascii?Q?V7NWHZ1PziOfvcd/8uBj9nFLBI1xoykBw2Y9St0teSqmjLcCu7EygX9KYhga?=
 =?us-ascii?Q?TKa4J3UqeAOBCa1RoeXWqi+WcYdYj77qA+PF5iEj1pDcLZRkJczYlnQK21LR?=
 =?us-ascii?Q?duWYuGyNk0722xsgGRrl/lN/XH4luT1jD2JcwrwBcducbCRQHkfOq15VDF7C?=
 =?us-ascii?Q?wfLUtyYBhm/jhox4x/7BpXYvN93lXQhkp4jujqG0htGy7EqeJRcf4kveae6j?=
 =?us-ascii?Q?uHy8j5vYEPmyvK2qFuQt2yhV9QSsYmHG6qeJ3Erq85Ci0zT6ccfoDNP5xnTG?=
 =?us-ascii?Q?r5ZdCFwxxcCAJfG/8P5MxPSN2O+MtjHIarz7ygfuseuYpvKp068XfngQ0qZ2?=
 =?us-ascii?Q?g/pirvM4acYvTdrDvszvhchqJH9vnK2vZc6h2YSZg8T4h59+7X7rAzNUfwVv?=
 =?us-ascii?Q?7+eQ60W/nI/CpT5aStc6erQejCr0xI3qZwykL195Fu47vTozJghtmpZEpbNG?=
 =?us-ascii?Q?edRq27Ta0jK3I1Qravg0qhKNPEA7RVzb/peeqA+CPnqSPBXBRWIArO15OKg9?=
 =?us-ascii?Q?NyS4yIvGCRslN20OVRQ0jtBBjGTt6FS09e85jML8utuOYUoS7iGRJJsPeQyQ?=
 =?us-ascii?Q?P8h2NwQdoc31uEBudLQah77Db5xkKalVXMuBi1QGOKAMHma/U2PgJ4ZVEk58?=
 =?us-ascii?Q?EgYXwIN9JPORjQWHPoFcXlZA/gjgBSySRhbXBk3jiyE1TNOTA4HFcfHMRjdK?=
 =?us-ascii?Q?ZL+WcbkfuhSTuQN5ezXYcHaU43fbJQBsY4Yd+0II194YV6LAtID0jOMp1nzA?=
 =?us-ascii?Q?s8DC/eZdGKdTcbJMl8VJvADMFkXvyFC0a5APPUnj+lKMFvsk3MtNcsplMYyf?=
 =?us-ascii?Q?3WD5sL5e4Nf7YPhjg5o2ciJCOgublZjDp9WMBbZxH1uYKXa38M6NrDk1+FR3?=
 =?us-ascii?Q?5Qa79YQobutacOtqKtkSrwNxoz4Tj8eSYAW7R4NEKfrRTc4N37/2M0dUGlil?=
 =?us-ascii?Q?T5llSqn+/LLmnddkphKMo8kLbnkWrBf4BTmYwfi4p8QdnmGSgHIxG3gyIxl3?=
 =?us-ascii?Q?Z8cyG1RPzJ6ymE2U34S5ZY/bWrvCAs/aWYLDo2pK8i0XfVVtmbMVSp5kpF0I?=
 =?us-ascii?Q?OGPGg0MFueCKL4azQoISTSudbZ5oEaLiiG5uVw7TbKZdIuPp0ycO2/PdgLi8?=
 =?us-ascii?Q?+PAdfYtY42eukoKiYqPciOY83hOjPtmgJTDAyR7evJh/IwziiEIwng5mExcU?=
 =?us-ascii?Q?I5+t0SPMfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ad5fb-d4c4-4db8-247a-08def0c48004
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 18:33:08.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TjnBcDHOwPKdDMRvhWN00ObVxQ2ri0cKsUr8PJgabqchc2dYNS2n0raGQ3YFSI3Ov3cMElb/pEMt0y67oZ4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

On Tue, Jul 28, 2026 at 11:17:13PM +0800, Ren Wei wrote:
> From: Chai Zixuan <petalzu987@gmail.com>
> 
> ip6_tnl_changelink() can change encapsulation parameters while the
> tunnel device is still accepting transmitters. A transmitter can
> reserve headroom using the old encapsulation header length and then
> build the packet after the live encapsulation state has changed. This
> can cause skb_push() to underflow the skb head.
> 
> Validate new encapsulation parameters on a temporary tunnel object
> first. During live updates on running tunnel devices, stop the TX
> queues before waiting for existing transmitters with synchronize_net().
> Then apply the new encapsulation state and tunnel parameters before
> waking the queues again. This prevents both rejected changelink
> requests from mutating the live tunnel and new transmitters from
> entering after the synchronization point with mismatched state, without
> leaving stopped TX queues on down devices.
> 
> Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Chai Zixuan <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

There are many issues with this patch. Please check:

https://sashiko.dev/#/patchset/f4a1f215a63268d5b1028521537e8f292d5f41a6.1785221754.git.petalzu987%40gmail.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/f4a1f215a63268d5b1028521537e8f292d5f41a6.1785221754.git.petalzu987%40gmail.com

And:

https://lore.kernel.org/all/83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com/

Too tired from reading walls of texts all day to give you a summary.

I think that taking a snapshot of t->encap and calculating encap_hlen
based on it should fix it. Something like [1] (not compile tested).

I'm pretty sure that IPv4 has a similar problem and that we also have
the same issue with the headers pushed by GRE / ERSPAN, but these should
be solved by other patches.

[1]
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index b99805ee2fd1..6e76e50a4406 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -106,22 +106,22 @@ static inline int ip6_encap_hlen(struct ip_tunnel_encap *e)
 	return hlen;
 }
 
-static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip6_tnl *t,
+static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip_tunnel_encap *e,
 				u8 *protocol, struct flowi6 *fl6)
 {
 	const struct ip6_tnl_encap_ops *ops;
 	int ret = -EINVAL;
 
-	if (t->encap.type == TUNNEL_ENCAP_NONE)
+	if (e->type == TUNNEL_ENCAP_NONE)
 		return 0;
 
-	if (t->encap.type >= MAX_IPTUN_ENCAP_OPS)
+	if (e->type >= MAX_IPTUN_ENCAP_OPS)
 		return -EINVAL;
 
 	rcu_read_lock();
-	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
+	ops = rcu_dereference(ip6tun_encaps[e->type]);
 	if (likely(ops && ops->build_header))
-		ret = ops->build_header(skb, &t->encap, protocol, fl6);
+		ret = ops->build_header(skb, e, protocol, fl6);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 97c3f61d627b..7764442fed4e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1099,6 +1099,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		 __u8 proto)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip_tunnel_encap ipencap;
 	struct net *net = t->net;
 	struct ipv6hdr *ipv6h;
 	struct ipv6_tel_txoption opt;
@@ -1106,10 +1107,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	struct net_device *tdev;
 	int err_count, mtu;
 	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
-	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
-	unsigned int max_headroom = psh_hlen;
+	unsigned int max_headroom;
 	__be16 payload_protocol;
 	bool use_cache = false;
+	unsigned int psh_hlen;
+	int encap_hlen;
 	u8 hop_limit;
 	int err = -1;
 
@@ -1199,6 +1201,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
+
+	/* Can tear, but better than skb_under_panic. */
+	ipencap = t->encap;
+	encap_hlen = ip6_encap_hlen(&ipencap);
+	if (unlikely(encap_hlen < 0))
+		goto tx_err_dst_release;
+	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
+	max_headroom = psh_hlen;
+
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
@@ -1248,7 +1259,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	}
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (ipencap.type != TUNNEL_ENCAP_NONE)
 			goto tx_err_dst_release;
 	} else {
 		if (use_cache && ndst)
@@ -1269,10 +1280,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 * needed_headroom if necessary.
 	 */
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
-			+ dst->header_len + t->hlen;
+			+ dst->header_len + t->tun_hlen + encap_hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
+	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
 	if (err)
 		return err;
