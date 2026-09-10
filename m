Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CA53D0BB
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060422; cv=fail; b=FTLYn53T5kw/6qIkclCMisSTdtxndOiNTTHDQ/9BYbCQHzE9YOtW/2XQm2BATJUFFSi3akwnuEvBcPZ7JPf31CnAEx8xKXoQPbhps4RN+12jnZPSYGrE4QbZ5SNDFEI1mTXqVrs83JZFdfDAQ1SMmLbIyHKVtOeG+WvEuiulu74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060422; c=relaxed/simple;
	bh=jPx0zLHASQQrsWKsTKPmPPI0hF2CJyGeLoKcTGTZWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=daTl8uG8ITXb2sM0gVNmhRNdjL3BaW7G8BW38gANcjYD82r1+IhcAAvGo/d7vzcrtzsJfRC8MDPXO6v2kIRrQ3lJVhs1bIG8umKf3nZftV8eBxD9v2xKc6AeNk8Bu+ZOsl+BvG9Thv9C36DnXy9HlreG/IcvDfj7g9FL/17vVq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V932AjJc; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V932AjJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZtV7ZDc40sD2Yusz1njJrqLLyiCXgjpcm8NNeg1+ue/f6y5+58Wn7pnTx8vgUKQpqln+27H64ILC165PXtJLHaXLFAXwWJkcO8c1yGNPV0O3GiakVk+H5xTjNfTz7iK8GNsb0IaT/nQNAeSLOpw+gvPT0ryqq7ZD5klgLCY3thVjFe63gDmLSKFXC0YnEUUpwuBurvy4PxqBVYVFwajnpiy3etYV6954t3FzHTTSRf11VrlfDXPBy41Dzio2dxYgyKdNPxZbYiHhWZ4DBpDa/edZ9Obp/c7QpzJ1c1jURS+ebe+nCcgCBUI/jmTCq8oBKpdivlt+NQpZEL9w+746Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW+A4vu2GHFMKjnMEjXXkTOALxswB/hPhDVUHbMqmo0=;
 b=iiuzoNVE7U5U1pMtrt99BVbvsHlg0G5QoE7kt4QN7tNUTrm3Sc3GSMRNNEax0Wb6ipnOsBsMKgWRg0l/Zk9e0nb2LlU8fx+mwa/LQeheiiRi2XBFHbRUqlqTZ7f82T7QpPJrpW88ikojWkQoauNuoPcrE75pdIGK3U4c83iXKVvkfuDXbd6owGmX0lzYLW3TgnBMMnY5bZbFThqdNAMgzpptNQTSpRYJ2gXgXPw9cwANu6OoczyFZpuNgYt/NqrmkMMaXEqS0n3Qyjjv5gCPUdwurxRmbR9JmUxBKLeaaNTYS6vrToPWFN9LZdh0w6vdn2qEu/aul/7HIdiffac75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW+A4vu2GHFMKjnMEjXXkTOALxswB/hPhDVUHbMqmo0=;
 b=V932AjJcwheHNvMxgiPwuZPY3S8jGBwVFnIm4SzqGMaW+1veKZ5Eyx3GIzCHY7dOhn7iWCnZyew4YvufaqVzl1ymeBphNdOCP0UJVKA5ydhfkwlu5Cr5B979JJ/UmBmJ5/Getb/sZxZHWWaEdo3k4NH7T6io24AxD7QuZfyZUNhN9DlWvdDIevMb0q2E0nDx3OH/XxQa+B6LGsMJUrlttfWCIwG3gZ+N7z13jqVSu8TDfDnh8k1vMHLB5RjW/yVVAVWLqTgnfTleup6mwkI/2PVsd8PnAR9kWKDYX36DxOkMvVlnXfdy0j7MnXn2yrN8+ZWFNpMvNuCd3ufP0n14Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:13:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 17:13:12 +0000
Date: Thu, 10 Sep 2026 20:13:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 7/7] ip_tunnel: Support per-netns device
 unregistration.
Message-ID: <20260910171301.GA1902749@shredder>
References: <20260909234422.2416506-1-kuniyu@google.com>
 <20260909234422.2416506-8-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909234422.2416506-8-kuniyu@google.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d36485-c38d-42e3-79c8-08df0f5ecb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a6g1BmPa7YQqDW3Y6QFZL31yEOFT80EDm1SECfHvobhFDSGzBXrd8BHJcVLngYxzSxIpUrHKwE9CdAR3SLpMK6C1RKEWP9veHv96b3T7vYNMsXyXhg+WL3e0Bj6oCFIhZ6JJILzZdJDbwOQdWJqPMQiohcZfBkPqbJR8ICaVnJCnlte8jF62M3b02R4LsyfPs4xJoPD8xhnDC2su2hFl1FzMc7zlDoEjNle3Yv949IOrLsUz3HygMSqg/B9zFC02axus/qEPRIurII0ehovYB7eHYWaiqlMvKRhZgh/PFhMxw4odV8lBtssKIiaWtN2DaSljZZBM7sLXWPMPY33jcydGJduNH+4zEXqxHJDtWaX8HQTKW6k+QnIsxYIQrq/9KtzFe4091eetsOfzkAq2GoeHEN7mNyFanYQNaMvhageXaRnBdurZc6795Z4dB+lwPfxCXIwqpZt8Np3W2jzQrBTjT7VE01wFlNMz+3pGl5e1StLT2b4ISETxbJU5f2xui4JWeMz2le44zlaA/hzy5JqTdrmEO0/9Lv2pFS88qq/UbSU0ISRrEgyhyjbHsFsVupecTAv26wZ79UD2bBjVInX8W6p+9OOOyclFpMCXUrbyjiLrIbHbeCt1y6wn2lxq9M/jGB60f3MUTX7TWuA7UQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/eNuE1AUu+SQdrG4Gwq9RmxSBZk0HyTm2QZ9WF40DbXZMJaGCIWFgQUIGqA?=
 =?us-ascii?Q?aePCbe4i12F2Uqv+Pb3IzXjpoITxSCiVXElG5y2KYyXWWynb2hOdbKxWCj0o?=
 =?us-ascii?Q?58idxwQyShY4X0RiJhPJFLV0fhBJy+3YTRwYmYOgBG79tRsCCPcnR70TJUBk?=
 =?us-ascii?Q?84s7cE8SJfHJh3lHX4XzHS1XWpKPn3Em3uoL4jI0k8aJzoy1pdsJ1SkBO0pg?=
 =?us-ascii?Q?1/QXH4uqAmRNvoqa5DEkY2b4XChJXrQvnuQvUg7hwIrHFb6pjnV1dzbV6Hey?=
 =?us-ascii?Q?9DIdNjD9agSakBj1B5UpwPsmz2koIT5Vn4uY2QnUTo4JkV7tPzjEx01uXQZJ?=
 =?us-ascii?Q?SSGFd2OfYKGSik+mRpMnqxr/FA+ARZTGA9mv+L0dO/GLrDTHHDntsHtjJ9om?=
 =?us-ascii?Q?UMQm5Ot7QdxHOWQ7RLgWaz8IRfkhXztlCjEvt9U5sQwfyxMgRBh+EslH8Q2b?=
 =?us-ascii?Q?YT2niHgxqt5kN5yOZIYNNaGc1sHTsP/BMzjBIOqCzjbHrm9EMsOym881Ps9f?=
 =?us-ascii?Q?B9ccvfhTAGW/jQur1A6aERIPE1+MrZSt4/v1yS2rYIr1uPVvwC2URQ+iN8B6?=
 =?us-ascii?Q?WvF63KaS9cFVbmJAvcbEWsXeTjbrvfHzuDAnPyH1tpVG514wX7K5eNkzSmbh?=
 =?us-ascii?Q?LN+VXUNEUCXrY3csslciHyoEQqOaNIWPrbcExtH3BT2DbOZs8d0u9d+Ay9cQ?=
 =?us-ascii?Q?69szdjOcV6qEUkimJoCUM14xHJFaObaVmAm10dPfUaA0U19UxhOI+d0Zr49h?=
 =?us-ascii?Q?pN424RGkd0Sv3Ab4wZr6iZ2KDCH0FbiSjAWLteXgWZ8USxWbuYR+CHfi3RhS?=
 =?us-ascii?Q?PKU/iDc1uZ7PuTc2S0aduUGmwYdN5SuLR5KYpqE/U6uDc3Bd9z6SGBCAW3lt?=
 =?us-ascii?Q?Va8ZMbYO3lx1hy7lzQa+NgYGbT4S6HSMzG49QAyzCl5F8v7ORcOPf42oISlJ?=
 =?us-ascii?Q?5YMngXGRMvtrjcB34s+QHitAGVaEf552grnXJQBFD9GHQV+d7HtKeQUBbWq2?=
 =?us-ascii?Q?G1KdwO9UsDGPf1sRusT/fzjtuFmXkiD3WsZTD9/9wsLdpU5ME4fC0e8L+9zx?=
 =?us-ascii?Q?wpGRxoDZez2/ni+TXCr3x/sLDFB+dHhWyEWhxwg/tKvvoU8msvRt345VicpZ?=
 =?us-ascii?Q?7VwuxOYXRR03IU6js4r/6xA1C+Wc3Rf6VMyUGBNS4/5pf/R6lpyOQNcIpuNJ?=
 =?us-ascii?Q?lYeW7n9V082H/SG3nFfK88rD4AtpgmDqik9jo3yqSzxR9pEhW72xd8DMUGZP?=
 =?us-ascii?Q?dUmdQ1ZMGzQBIFG2t3qonYi8pe5dkMybMfzAaVB1Ic2z5t3ySEkYNzeAtFmH?=
 =?us-ascii?Q?/eJoZWpE+B3K0Pe8yC0qnVy9Z/NX+se/zckdZzUIMSXaWk1OaSIE6UI+P5Co?=
 =?us-ascii?Q?MzRtP7H1Aff5FA6q0Rr6YuBUOJewjb7o5mWzsFR+UNn1VAqMuu1M8LyCfayw?=
 =?us-ascii?Q?887BPeUoZWZ8+0BN+BOZ0SGOHwZCWlBrgAokYJoOW5yQ2+L629P3X9Sk0A7a?=
 =?us-ascii?Q?xQEhWzgJBA0rnWYz3CzWFQYMIjPF6IjOtxr7VaUMuDalibeA0xbAwppGaOxu?=
 =?us-ascii?Q?JBde00rJQu+cMckD136BmgjeAOEPcUO2uqNuN7m8tKwEFwbN+mtSr7Fs2k1z?=
 =?us-ascii?Q?YvOOSGLf5iKcW9yA2nZQim1yryK79aJbJvX5ry2QVBWOpoy8hJ+g+HTScSLt?=
 =?us-ascii?Q?jd5h6wh575959xZnr3vMmKgRxuiLabPaB6yQ1jezb7SWoJYMAI7XUfvdmLsx?=
 =?us-ascii?Q?qxV+/6eRyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d36485-c38d-42e3-79c8-08df0f5ecb2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:13:12.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr2yOOlbrYngzDRISx9v5/NWjccf1yWHJkwbPmLGsoCCMGv2wzQhWimu6F3SgiNUrYQemnALYNHFXNFnmhoBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

On Wed, Sep 09, 2026 at 11:43:50PM +0000, Kuniyuki Iwashima wrote:
> @@ -920,6 +927,11 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
>  
>  	mutex_lock(&itn->tunnels_lock);
>  
> +	if (!itn->fb_tunnel_dev) {
> +		err = -EBUSY;
> +		goto done;
> +	}

This is a problem in network namespaces where fallback tunnels are not
created and the pointer is set to NULL.

Before:

# sysctl -wq net.core.fb_tunnels_only_for_init_net=1
# ip netns add bla
# ip -n bla link add name gre1 up type gre local 192.0.2.1 remote 198.51.100.1
# ip -n bla tunnel show gre1
gre1: gre/ip remote 198.51.100.1 local 192.0.2.1 ttl inherit

After:

# sysctl -wq net.core.fb_tunnels_only_for_init_net=1
# ip netns add bla
# ip -n bla link add name gre1 up type gre local 192.0.2.1 remote 198.51.100.1
# ip -n bla tunnel show gre1
get tunnel "gre1" failed: Device or resource busy
