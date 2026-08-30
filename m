Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C3197A7D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086839; cv=fail; b=iYHXVI3rxwfpzsAlmD+QfkjyOp1KNEaBqsclWw84VcE6Pvnp3qhVYuBEKlNaCs29QI336NJytaTJvFi9AtKfvsAjgG/YJMwFujWdTqhH9Ewr6zlD6GrcJQAZxjBnlFeUiOsQJd+4tPs5h61a1wMEPiz+zMIEPu/GSBSsWQwYXZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086839; c=relaxed/simple;
	bh=f3E3IKY+ujEQK7L952xih8Pir7yyiuWJX2eiHpowm9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mzDLzfB27ohgWtJU8OJm7AABKoGgzt/YPc4k9tw50pv3IDLpITwXicDqhMjou/LR6X0WHRt5WCWxGOibDno6DEQ9VcsoWO3HT7wsGM3lqF5OuPZ1mkORD1PWPCxejLgVgrnrkKBkw2upOfOTmSZPNjMn+n4xmaghKOgBCcQ+BYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6O2p/FY; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6O2p/FY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeJo7ZobLNBwhwTOoR487WBGlGIRFTRPeBCPQIRIT0uKIws4o101Z8Q1v6fZnQi124/htc5KiwQQTNKynoyZ5AKHlGY/FDGUpdVY98zFsT93E6Kel8UvcR6MWUYxWox0BiEFXBP7xH99NNwU0QeL6qtb4p+fdEqq2UhNpwVooff5uRzTC63vRJqTo5gl9RZApbBV1mFuyIXi9pjPhBQ+DK4YBl/RrUiZWcJn1yWdv5xdmhSooJWqecQH9ei0aCCJBvZuL3/+GvQUbRMAzr75YHOnI9Q0adbftstlRsvTaLu7/sa9IbWz7HZwqAQdaPtudbE840W7ip/CtdLKWivMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9BPJLHzBQj/ASQYoIdil0zBbnOrSHi2PND18KwFSrc=;
 b=Te+8EYN3QxmBmtoDDUFP4CWnWN0JgRlEU1lD4SUAYnr9d3avbiOKxKTc0fHlkJ955saNmZv7aXM7TqdUGLYflTQILdgztBjsWi19cE2Ur5ClXZQ9ji5SfwknfX7BgItiF2OM0ZVXA4kqK5POiHbrpTV81cLtnX9XHGfFLpO37Jvxufw5sDA9SjLxhGlr+O4qpG25TnuB8GGrL1vW71/3JP4xnU5GrhZxWY0xnF1lJI5+BTC6Jcf2KEnIt6vptljkVAKLDtJmEnRtyBdW/SodEvQlKiL4R7QRP05Z2JUGP3fNBRTpuG7H+rz5F6z0bBD28rKl3kFOopRaEREn3Eyzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9BPJLHzBQj/ASQYoIdil0zBbnOrSHi2PND18KwFSrc=;
 b=j6O2p/FYjUB9Ctmsww9x/ALBv48SWjOCOWvgOP98ythDbWEk8v/BrWBGTN0xJ4HSb+qI+HC8or/Q0mZ0MBdrKD7VCLXeESdZ6fEDj6SuBJhtV8KuD5itJjSpTiGItJ33Wf9IxyTYQPQbKaJuOyuB9c3kIKO2YnILnxxa+C23oW/RUdqSdnscXtFBqEnAV0QUKdMi8XR5BRxHjqFr3zIXbkxadF0949h/svlknbCXkikOFJcUPQWPX/ED1Uqvs3qMfjGRxlmNYoBOZU7pG1v1b3fQyhL12GUVCWu7YwDN059oSjUXTFLzlirlfA2KUTNXqTN+J2GUr8n7hHTuKPlC8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 10:47:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 10:47:13 +0000
Date: Sun, 30 Aug 2026 13:47:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net] ip6_gre: check tunnel info before xmit in
 ip6gre_tunnel_xmit
Message-ID: <20260830104705.GA2834418@shredder>
References: <20260828103731.1951815-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828103731.1951815-1-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: eec04efe-ce86-446f-81a9-08df06840d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OIYsX2aFbJ4xqFacXzvAjWHt19prVvzYvcwKm+/jqw1h+T+gnwAoxgOuAz7eI0ci2QiucrITeizfOF8aAiowS7Svns/fefltBkZOho9nscF7L6Pv0JSQw9qY8ANuhBZlla6jcK5jTl9b0nCmXT9DkV5kTv6oGXwVjYRyGuQyRk65AiYAa6ZTu607uwP4CT6m79KqiF7IxJV3n5kSHFCWlhF6XHb2ytHTPYCg0BjkxAvpg22jUgRF17eqQas0jhpf3LZVhJlRcqrL445a8Ba+ZMvCDXDosSsD9CXfU6GMLj902Cij/222yfWrvhS11kOgX575Yi8TxLW/fOt46Q6sbJo0OLQQMKhQD3iK8FojciTYtXe2tzaBjcAdKlP15p3LD66/AvAZutvVvOUJf72CRaiL4TJOs011bhBtTpdrwOBQCxABY3ryEYt/hsXmYwCcnEeyVhkNaS3XVDCN86h8K32nNtXBRtWZ+26SDCqVGYSDRRQ4XXszweZDi+Sgq2l3D0+/z68f2hmtbk72OXgrBGfb8wIV+vJ8S68RwW5jkoP4ci4FVzQMRGdvzJMMc6jX2R7pPM+cWJ/dj/m9NTq7ztsxLKL6u8f6rxzF734TRHH8AN4+9xUdnlsPc8wp4POkwklspruSy2U8kC68m9uWwI7q7gjzEU16RWdN3Q2JXrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TGjvSiq8HSoqpQg78C5ORYgkWNtMSiFfvq/eyG2PX1W+yIhL3zxjN3/RxCj?=
 =?us-ascii?Q?dx56cPV6fD8hF2gLcr7TGYZfBzqAwtbDGxiWyGgrj9eLLf2FCyReoR9YRKKZ?=
 =?us-ascii?Q?zG6mghzSXvZ4v6IiDX+u6/o8xr7Q13Eo8dvqtvXQlGt1dG1vUkEwzkS5yDQv?=
 =?us-ascii?Q?VbYrNbOL1FIEm0ZQKQPEikaXjxaaIeyqeP0Jt1mdjBNg8lLVp8NucQyjmuan?=
 =?us-ascii?Q?Z5dEij6cyDcZgYRSy49IkVVl5Tr04d8H5Bn1ezw7nUP8aIm/rmSbcv0jmvN/?=
 =?us-ascii?Q?fC6iYos/1nyreQXnT7Y8vOI8VBlQFGVk+zWdzv7CDkMqbHc3iZYAbVFhW4fv?=
 =?us-ascii?Q?68zcp1BVarog4PCVk0jV+3cuJs2DmYp8zPyZqipibtA9eUkPD1eEWZ4FdX9b?=
 =?us-ascii?Q?H9m99riVj3dN7rhFg3JQoReS0ZUqlgLo11SgZn+Ry3mHucwUSBwn1jbXW5Tb?=
 =?us-ascii?Q?nsxzLJNyYFcbQA+P4rBHCa+sEqOCsA7Af43LdQYDBOPgUH93UbXM+l5n656u?=
 =?us-ascii?Q?vR/oxGNe9RQTPpnWE1lZZCif32yjYwhyE62IYdkr3CBFQzkfjWuAnjE07MGM?=
 =?us-ascii?Q?Cb7MqRf6rk8e7ULjx1g/Y9TIUcRHdp4oLrRhQUg3YqwI8qEYjhXJKY6NSack?=
 =?us-ascii?Q?h40qCipWReiZq7xc01T9MECmbVjcfG35AMry+ED+6nULZ48qONNQTd+eGt0T?=
 =?us-ascii?Q?0874RPcKLQRChTSBp7mrsZi6qUistALnVMu4aRQvGZEiGHaZvPmhjneXtykL?=
 =?us-ascii?Q?yRuk28S9NGEGxNPyiIscYNh8n+p0GiMWc+rHXw+kXjp+8GkKoIEyNcRNNl+4?=
 =?us-ascii?Q?XS5+2eQU8WGPKFwdTNtKC3R/XUdkZAX6MmNJYhfvQR0+uh5HZXcBjTntDm+o?=
 =?us-ascii?Q?Lb6HNFwa8iWqQI1cpeLymJ7ImykN08JR5pF0medtbERhE5JNcU/QmBPL+eoK?=
 =?us-ascii?Q?HdXb5KKYlAUucfnqdE+t5N3yVG/E0m1x6UX1UevIHF70CYVpHRwgSyqOc/3d?=
 =?us-ascii?Q?uZbMUhCns5CmTowlLuI/QnRzEFnogBxZnaPIeEzqc9e765onPafZZnymmyb3?=
 =?us-ascii?Q?8o8b/y7cYjY+owQyIFFnvhZlWE+B82GadJyW/qR23JHI5j30dKUnPQ6QCPis?=
 =?us-ascii?Q?SMHV70Pa49nxviSHOX+sZoANx5wUifpQtCi4fanrXrQ5+PyekUvN4xkyLvb6?=
 =?us-ascii?Q?zhdf3FmCrnnY0ISB3/GUFqpegC0LwvOHp/E/S5JL4yR+VNB3JyTPEmHTRB2O?=
 =?us-ascii?Q?tcqsXMGcaPYBoJpJl2KeCcE2zZqbcxP4IOrhf66XyYo/+oh2W13/jsU1PAaZ?=
 =?us-ascii?Q?ySuJrU5g7e38nT4suPuNh/ljkKGre9Y6SQCn++0GlQkyYNPK65dgnk+o6QBG?=
 =?us-ascii?Q?2pebwZoyrQyCHY2Wd92XyukpUljh/sXrEkUUUa0G3e++5MIbHZPEkY3eqOJA?=
 =?us-ascii?Q?WbBOowqfGGdBNTCdQxwnafcmCCTPKTFeVYCjBVjQz7qhevpO5KUFuwkpG9sj?=
 =?us-ascii?Q?YqGS819cgX5swDE+qBdiFMlB/ZjkQqDgeqW5nR1OJXqc1d7M2T5NosJhey6g?=
 =?us-ascii?Q?a1iiKQ0tHbLKEy3uzUuUahg3xjWv1AH5lN1yvk9IkSD0mEh9dPOM6dAvpSMf?=
 =?us-ascii?Q?jcilOZGO71gYTTKPflfOlCRpkPExWyvlz3LJnbEx80qR+bqcbohaJj2sxvaC?=
 =?us-ascii?Q?OnH7dnzOhSNawq+3e5rS6827wtHyOF7bGyPeH3YFzdjKp7HR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec04efe-ce86-446f-81a9-08df06840d23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 10:47:13.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQjgEBFb6Mklzcynh8CKtut2aT1use1gF0U/Ql7JE30yBMJvU125ELUUxKsrDecCNcjvDYWHWRLmz0cV7Ved1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018

On Fri, Aug 28, 2026 at 10:37:31AM +0000, Eric Dumazet wrote:
> Shuangpeng Bai reported a KASAN slab-use-after-free in
> ip6gre_tunnel_xmit().
> 
> The precise KASAN bug was caused by ip6_tnl_xmit() consuming the
> skb during headroom expansion and returning an error, while
> ip6gre_tunnel_xmit() still held the stale pointer and called
> skb_tunnel_info_txcheck(skb) at tx_err. That specific bug was fixed by
> commit 87f21b59ddc6 ("ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()").
> 
> However, calling skb_tunnel_info_txcheck(skb) at the tx_err label
> after the transmission attempt remains problematic:
> 
> Downstream helpers like ip6_tnl_xmit() call skb_scrub_packet(),
> which drops the skb's metadata_dst before transmission. If an error
> occurs later during transmit, inspecting skb at tx_err sees a scrubbed
> dst and misclassifies tx_errors vs tx_dropped.
> 
> Commit e5f7e211b6aa ("ip6gre: avoid tx_error when sending MLD/DAD on
> external tunnels") already handled this correctly in
> ip6erspan_tunnel_xmit() by checking and caching tun_info before
> transmit.
> 
> Align ip6gre_tunnel_xmit() with ip6erspan_tunnel_xmit() by caching
> tun_info before xmit and checking it at tx_err.
> 
> Fixes: e5f7e211b6aa ("ip6gre: avoid tx_error when sending MLD/DAD on external tunnels")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260819062224.3197349-1-shuangpeng.kernel@gmail.com/
> Cc: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
