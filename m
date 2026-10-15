Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546F4DE700
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064748; cv=fail; b=gQ5QwSguevwjA3FX2D2Rx9/mg6CBIemmDkGjuppAyNr93CSUW2nWrbPGWY5aaeLRgkhxymYgP2KhvMGSYK5l27rmfFc2kow7etFDCkQxGjzK9bn4SVJ8ETNeTRi9c1SSxItvf/Bvva9I0SXMHwXBEoYJ83atezaR9okDmv8U1ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064748; c=relaxed/simple;
	bh=hG8C5v7bXXxLVTkuKHQ8d1y9ono6KB3OT7ZB6ZGdKxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tq3rUGTQo3c0JICxgQDRzGcYe36+DWCZKEYY6El2wFXuEPm+Q88/9UX/Ejgp2j5BdsdtAlQAGWL51V01Q+XEpx3Zd4O7ZJ5BtevDuQoaAuEbHN1Q806aypJf6WTFipARcso/yOQ09so+QXDlaXQ1WpwTmBWXHmbH+Eo2ENEoxho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hbzr9TNF; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbzr9TNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSIJlwQaAQiKpmaja9ujEDv5Z+3gmhEdUoO5qy+i0NRRPevHepD2yZH9K5bHO+7iht1WosDqhr+0xeJqYc1mx8medM51ahvQeg3F/ZfuSrrzdzrq9A4eLcyfWs93LalKqgNlWGad6xkM86jW7LrfToaEqRI9b2urHS4mnONDzGz5ldL+kLUVysM85+ucAKr9tq5ZBsUhJmHuFF35uiE9LWZpYXORuWP8YHUQVB6zuEUt0KmTI5QpC0MiTBDXWC/TI2KfMmb+nQErC/zSYpsW6L/s5/Rf2LEdHAlFE4bjvEjUN998/E2GRhmJ8Qi5h/vzuMzGvfEbWQR/r3YHSyBbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KsWxZ4e5qrx5Eixsc0Kyr1KjEZc+1YAKxgNavOoTzk=;
 b=o0FwZOlJLZulSQF/2wRBriJCDSBDrmltYM0Q5mIHYJDHHc7tuVQblOq7LjQa9WKtbEjmu0/QpG7HgVRNh6BVf4qyABIWkhkT7upmrrymTlQ5zXu4nvXh7VhpHjWI1YCZ8CQm2jvQBT1m+30oUqh0fhvTszpnUS8scWi07IeoqBc3uK2bTRkX0n7YU5pPXV2hg5isVdw7rhzRYgW/oqxqdnzCmvHeEZxmj9QU0dhxSpffrfi8XQNlVRNhPBVl+sDsT9Y03k7/8g/0gywyBW62lAXJMyOezc9s35IshDokeS6Vp5LDkFm+Us+eFSSv6W9IaC7EWIRPiGZVsjRQ2S8JcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KsWxZ4e5qrx5Eixsc0Kyr1KjEZc+1YAKxgNavOoTzk=;
 b=hbzr9TNFldq6GtAzwXt0ywYBiSi0IETh1oUYMXhqXCBFmA1Qv94AVfR30mlbn1kRd13vVjr0eEdeQNLJJGdBsx0zY+1PB2pc0PeWhdXWQDuB13c/UYLPm6vmY+1t6Qe1eJZUKV6+jESakwn0G+EDqy2M1QKGsuWS/k+AaZy5FKqGcYp06Ko4gVcXHnmbeCLlzlMCmOPA96q0TMcecf4R06IOvARCKTIhGrF1JqYNpmnwT+806VghnpQm2TjSBI5HQa6g3dz43VVeSdFxKCoH2ROFYZd8gejMJMjN6N8hs1GfEDIqCOylIORsP04pt280wJ9dmXhevzmfuvZo78uFAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 11:45:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 11:45:40 +0000
Date: Thu, 15 Oct 2026 14:45:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ipmr: validate VIF indexes before offload lookup
Message-ID: <20261015114531.GA1716181@shredder>
References: <cover.1791899747.git.zhilinz@nebusec.ai>
 <b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: f768a9a8-56bf-4ba3-e0b2-08df2ab1d67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QAmFi76jfS99lWbJ3UkE6T4e0SpGY92ioo6JmwOpkhjuJxku8GsXXC1YaDcqkhxhtgLBndDrrO6/Sly7G4VO8RnQvNYEylMcdAEsfNiBleDKrQCPho5bTbqQxBht1z/dH8BOTN9cKwMNGhTpUSjO+D7L0ESvtb4U0RviAlKMicXJebQ0Hg3fs2/E/NwTfB5C8pZOEgf2jzo9Gt485LfeCYgCvszhLYDRw8jFeyPskOfBhcG6Y7kj4ujsbgdrZ8dZqpa5DvgKjgBDrWoVeNjvTuVkeTw/bXVQQk6M/IBKNhJuyLOKYdean6/JX5DiJ8Y0ttwcXLTt+U6+OqDPooAO03Zvfd4CpVyu3rf3uYm8UfmmA+EWAtHMju8klHo9uBfcErUmhDIB5ry+K8R+c2Kt8UOpaFj9FQnON0qzsqhSQL2i6qDTc7AlOGZfjmUrykINRKLe1FG8dMQWbf/eKUKlq2iBuZzdo4OOUJ5rVVD2gjm37IB4DhCnHm05gLSGZ4bXaRZsCvF0jxHMiQ0gUE86sHysD/QopbVgzK9sALz8GPGeckah9J0GrqkOU77atk9iuYq7DrvqjxTA7VMsITL5xXLfyB3NTE8PVO+MJjWcRxxJRkMezfEAzvUggcAQV4v4XgvqqGEaHl90aIyfR2KHIl9bCUdcxg7l7DBPiJi3fNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yT2Xcd3D62kj25St1e3dqUi561FsaKTGH1CWWxYSYS2GxR2rJ0PojDU8aghv?=
 =?us-ascii?Q?xzisflblZtiIDGaJDBrUJk8I37MY86aZ7m40SOPpAikovGditB2PioieXo9Q?=
 =?us-ascii?Q?gUlwgklDnFJCv7Z2NPcyuXYtL/VeR7fyFOd+Zygd5+pOCD7VUDyZtrQUbzQ8?=
 =?us-ascii?Q?obAYP1RhmL4KquecN+TLjwSq32avcCxKtlna/OCX4RlcyhiHlR/L/KX3HmC+?=
 =?us-ascii?Q?42JS1mlwGzujOTgCY2JSqQF5KgtGRRMw5KXToUyq9u+ePIOWPMPZS+7VySVu?=
 =?us-ascii?Q?M4AivJNhq7SY+Jnw9CHKBRXqr28Tg4cHkFLBoP25Z1YlgT0JAWhlA0IrJMC2?=
 =?us-ascii?Q?oRUt0XmJs8ONilJhjkxdJMxR+Ps5NBHGWj87B1dsBTvxDm82XR06MTxr2z2j?=
 =?us-ascii?Q?9QKLPtVeZQ6uZ/ww02gDl1tsqJ7GASVUjRJADt34MLM3ZpyKul5hls17m8Vj?=
 =?us-ascii?Q?4cq9zfYwDIVqrP3ANCT165xhOoZLIxfKOyeu0nVZ9EzLmbwJAosWv6x/CbGm?=
 =?us-ascii?Q?yZ/remfAy/mO7mrhtExtfGE070NoqVvWhms88MThHeZ97p0uRbAqXpjjgTX3?=
 =?us-ascii?Q?3JSnFyqLOZe2hsRMF//HRal0xZLLz+EVSziwARf+iHvBqHW+4h0I9gcMm00j?=
 =?us-ascii?Q?COXTwAYchsHBRXdPc9YnIxylQ0LtGgfvdunEKJ2yKwAJ+fLb74TvfWCJpz/N?=
 =?us-ascii?Q?Wkb6d2UjmHg+zLrk29QDz7D2//wE9wciYGXiFlj1p1/eB7ahFfUkCq/9fCdz?=
 =?us-ascii?Q?lNK1WEMi9Ke6fNvVPM0XFQA7xHpuUQWU93CpP04xETna+RctxoCA2UnFRhSo?=
 =?us-ascii?Q?rOUtFjsR6W1AgzxeZf3iwOui2W8QmCQazX98iGNFHYH2zUJR/hbM+91KF8Wd?=
 =?us-ascii?Q?mYvfvqSwTZiXFuIy9A+L8l6uPhPMOk0uY/F996pRu2CIIc7YiEHtOv2Pn+Mp?=
 =?us-ascii?Q?08Po50vho0zJ5SMFZ0Fiu08fXWe3DJ71uNcz/9YO3zWX6L2d9tH5bUTBm5fw?=
 =?us-ascii?Q?tdg5shc+jRPhcMXnWr0rS2NxJrFWGtcHyq06GKF4vAvOxYzBJJ6dW93jRyrD?=
 =?us-ascii?Q?TVzT63RxtE0LxBg8Su1/QYsi9bFDQCaZzG6iX4sz72qruGpqXGSjNdiUBuDL?=
 =?us-ascii?Q?uJW2+yMZh97xTAhsaKSmW7UML750u91OMC/24WRxgseehGvBH6NXetQwG9cl?=
 =?us-ascii?Q?Can55difA21r5sgUHoyzT9NqoCd6rB7sowGgfqyMwK8+6FZQwwkdg42pl/9P?=
 =?us-ascii?Q?dmTGSbBXfx9fDMGXEq6Sq1BRQwyWuFPu6unHgRihHL05EoeVqFeoUn+OwUnK?=
 =?us-ascii?Q?1gh3xV3yoTHIidAZWEsDmBOr6OpOmgUpc5ipqcoxpe15kG3YLNAqdmWX3zDT?=
 =?us-ascii?Q?NHrjVKf+4KXZp/obgEHmE+GIJqH8vyL8/Oo0iBSq5i0GwLr5R//4jE0yRPsN?=
 =?us-ascii?Q?tppmBKWdDK0z4Uq/IEybOV4GqzrLHW4jLy/AYph130cSItcijx6NaNj6/Bf6?=
 =?us-ascii?Q?70Zih3Cj4x2FqGc2DRa/0UT7DKJOMDyDUMKDrYTaS7pM0goqNrhO9A7QkVkH?=
 =?us-ascii?Q?LXznLmSZl0GtLPp6yXQsHlA+oiuzsYpiJdJ/DmaV7aTUt8wfA5jZcUq8ade6?=
 =?us-ascii?Q?iN5gKSqZSni+fNPPOulIHJP248bZ2waVQjIOdofnZ+ZVHFX8Fx9XnA38c4Yb?=
 =?us-ascii?Q?T3XCtB2ceCSEBS5BdCilZdcka/ktlFJx9yX+8XuZi96ieKnO9odPSDDQ/kfJ?=
 =?us-ascii?Q?bQoBBhXI2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f768a9a8-56bf-4ba3-e0b2-08df2ab1d67b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:45:40.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecOF3Jx1mqX3dThA4cyxyTqZzSmo7Zt/ukRS0le+eA4ua59UdkMJrnZ4mnjIllrzYDqpVSMR6cAwL8MWg/mWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

On Tue, Oct 13, 2026 at 10:33:57PM +0800, Zhiling Zou wrote:
> ipmr_find_vif() can return -1 when a packet races with VIF publication.
> ipmr_forward_offloaded() forms pointers into mrt->vif_table before
> checking the packet's offload mark, so a negative index is out of bounds.

Please clarify in the commit message that out-of-bounds access only
occurs when the skb is marked, which can only happen with mlxsw. Even
then, this condition is rare. The PoC only reproduces a UBSAN splat
which complains about the negative array index.

> 
> Validate both VIF indexes before forming pointers into vif_table. Invalid
> indexes fall back to the regular software forwarding path.
> 
> Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/ipv4/ipmr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c45..bc3263d15a44 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1879,11 +1879,16 @@ static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
>  static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
>  				   int in_vifi, int out_vifi)
>  {
> -	struct vif_device *out_vif = &mrt->vif_table[out_vifi];
> -	struct vif_device *in_vif = &mrt->vif_table[in_vifi];
> +	struct vif_device *out_vif, *in_vif;
>  
>  	if (!skb->offload_l3_fwd_mark)
>  		return false;
> +	if (in_vifi < 0 || in_vifi >= MAXVIFS ||
> +	    out_vifi < 0 || out_vifi >= MAXVIFS)

Don't you only need to validate 'in_vifi < 0'? I don't see how the
indexes can exceed 'MAXVIFS', and 'out_vifi' can't be negative.

> +		return false;
> +
> +	out_vif = &mrt->vif_table[out_vifi];
> +	in_vif = &mrt->vif_table[in_vifi];
>  	if (!out_vif->dev_parent_id.id_len || !in_vif->dev_parent_id.id_len)
>  		return false;
>  	return netdev_phys_item_id_same(&out_vif->dev_parent_id,
> -- 
> 2.55.0
> 
