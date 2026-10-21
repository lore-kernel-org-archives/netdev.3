Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569724;
	b=nhlE8hF4DzmfmRsZmsgR23wc5CSJw6QlnfcaJ01dCds3AkFSy8DS7VTNvWsnM3z/MpaE
	 KWC5JF3YzCKyZb/0EVwX1v6fdQqfhjkSXtDCouCrTK7du8LXCVIdb412CNsbdufhaKRKz
	 cnHCYUkuOx2AdPxUARbHKX9Fa9n2j+ETvwLOjgDfLIO8Aw6+ViUqBiwWnfdAexPbtf10e
	 6QS5x3EAZHXwbmsQKpD2NxNdChP3TomKYOjU0d9qNRKgkdR3OUQM/owR8qVCw1P/9AyWr
	 u0YQNx7wQVZzdK0lsCdDdUpchQoA+6Z15gFh/UojI70f5J6Z3K5NCLnvCTLWOE9aQkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569724;
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
	bh=dCecmYleDJT0FDuIkwSjWM1tjrjnOyp6Kdu626orcXU=;
	b=4SBOEPoWKkUGA+8QJd3mNPNTlEKhuIbPBwP4b8oYyoud38dyIJccZV+ZxIe1MOZlvZ3B
	 mlc11wMrsHCi3jd/ANqk/kS5FAhGq2bBI+BD09DdFMjiSz9U6GgMz0Cor2mhFQFHn8Ky9
	 tRd0nHDDRU2MgJnPi2+kscXOPuTsBsBwx4cSNXoIdIsnsZbV3TcafwHPBOsw7RtZcwDRg
	 0PtcjFlpC8U/qYchZfpwBsN0BhWUgyrYDwV5ffIWNSKVN/gF2+ySVNE9lnFAqaNAfA5h2
	 13a+0QQeBRHhZxzOkaeBNRc/XG80DHQm18wtWrnIEPR12OZuEKKFS32JErth0LxRwCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Dp4k5aqD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.22
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1083606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1083606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Dp4k5aqD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6K4vOa1+SzLJAwVaKIHFcpl6e6jxZIzXc74eUbdaiX6P2UguFsiB3Rz3XmwobQuwQuJy3wCG2x9KAQuyGpuhg0PRwwU3apjxQKwaH8B1TPtGN9WthmISlcXGO3k2wRpDTe4TADQWQY+K+IRqVEU1bvKpaeUhGH7QdIafMHXmB1oiorYSx9uYgpRnB3HcD9B7dx5cbmPXKgx2mgLeZwgWNDPg8EkOHQkxv9Uo/j7/RHRjtBl0DUDNMGpxmL4cltznhrSaEJ6839gVqHGhLkGzjbwIKHWPrEFsUR4bZLuITWBHiturfuuW5MGm9UQl104HJ7ldxVSs1btMfQOSXv6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCecmYleDJT0FDuIkwSjWM1tjrjnOyp6Kdu626orcXU=;
 b=DpCFGRDdSwgu43BF5uDktxYFr2c4Owkc7uNmQiPe3HkY5ado4Km8/1QdIaGXuvfdPSwqPeq0uVkcEe+fRUhZLPCCPkbME0oHSQiRzT7faAGE96q5uWja84pYbYbmORdVbXrJuYuv6eGaZw1rfPkCMiDt2kzcwiVw+VanGNAo0TPHfpcCwVdWUV3PaYZzAS18wi2YubCg1r3EK312unDsweKIbXGjWonV2oSrjVeD5mCCpi7ySP1uPqfzqizcCubnIVCkzM1ohULGQJ0KJwJ5l6vZ79R+IiXSDjNAbw4skXNFTF4njNc15LBg98Gj/+m0kNiMb2sH7Gxlg9QLnw6Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCecmYleDJT0FDuIkwSjWM1tjrjnOyp6Kdu626orcXU=;
 b=Dp4k5aqDu8QjKz4PlwkkVbusZVIvx4Cyj1B/CAreBYzpZGwQrqddVSr8JlKKgwYJLU9Y36Rgofa/DS9Mj07BzNa2hpER3iqO6qQAalLBzVfCYXd9TSJ9ly4Z67F7Un/n/+MZ5iNe2dNLm8zgEmFX+QaF0zqDwUynDjKNi6BTKRZ7Gj8mAvZDbx3Wi+wCshgI3gjXRQ65aMjAUg6S9XbY22vcaX7uI7CmZ2YCoXHwYOY6WWdZLDxtIUWBtUozJMC9tJG8L1YK0P8UuaansNihReVaLgwchrcmnHxTRFpukIlmig9yEfn4b/BsIw9n38xH5uJb5cbR2paegSW1MBI7Xg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 08:01:43 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:01:43 +0000
Date: Wed, 21 Oct 2026 11:01:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: namangulati@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ipmr: validate VIF indexes before offload
 lookup
Message-ID: <20261021075513.GA3285789@shredder>
References: <cover.1792476942.git.zhilinz@nebusec.ai>
 <23ce70e99d6c710bdc4cf065d70350b754ed8f66.1792476942.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ce70e99d6c710bdc4cf065d70350b754ed8f66.1792476942.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e91eab4-01bd-4de0-49bf-08df2f498ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|10067099003|13003099007|3023799007|260925021911599003|260925022911599003|4143699003|260925021311599003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9YxPCwMbPLa4RdvDEezZsLb8WG32sDLPf/J6+o+N0N+A6WHF3dZvxTnUR9bvdTEXGNmkO7DMWkqj0TIU4PhYtGC4JzQEw9wdNfqW2LHjOi4lgx25ke73vErecjJvR4j8mijiKk83KU7XWYkhS9/5DL1hqwRdN3qzYcJx//honLh7dBj+LjPpDxVbK3n6zR3oaisOhdaflwBgqYpcMODlr34dFI07oyr9K8v++nIMt3YaxLa7Cq6Qu68tXcSCU+LHT6OvHaf04WxRfXwECQZVgND03shOTt0+pkgO8v0x8n4FnjSnLgPd3lsfTPVDQX4qoKYRkqAjyHHK016nycP67lXuV8a3XH9YGqyJze4u2SeTje9CXLFt95o+3/4XfzohGU6z+mvsU6s/yQ2TObRXvXgPP9dbXnwRsp9+xi4jFZNNS1S0s1jfq7gHtQ6XgCsluwrVJ+y/a7tvi0fyGgZJGfMI7CDjJDuWhQxsZAYtlgg3IHKNO9sZyw4GEhpIIEx9RfdAd/mS4KQu5f2misl2dcjoRk6ayaP/5pJvTD78lMWwJdCQ25EG9sXF086aMhOkEafbXzQRnpODBy0Wk2sq238qig+WvpY3x+1VZW0+WVb/nfU2Rpf25sxmsRXL98tfSyiq5uqAlCdjRYOJ3lAB/zhzEXkIvWkJlhBHfXLDH9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(13003099007)(3023799007)(260925021911599003)(260925022911599003)(4143699003)(260925021311599003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxVSJT1WUUTzwovPmhuxxOuJZHV7uAD4QmBdDPEbIoJM+09OM/TXpVkXVN/A?=
 =?us-ascii?Q?yQbTLEbVpojwd6Nlt3mClZtML9CS2+zEMR9v7x9lqc/89xsW2qLdGDIaWVFE?=
 =?us-ascii?Q?iHKmYS1gh3FNkNDZMU7i0H0+JWMz/ZsQ8cVexVGMFkikbkuv52727LE1ippV?=
 =?us-ascii?Q?e+6RbCGoE0jfKV3TlhCsw9RgbZ/EQ/Ie91DqW4xHsKfSbqdMFV8t+lWDq1SV?=
 =?us-ascii?Q?zeFmaiFnAKemK87GRRZ3TVXy3iSvSB4RVRMyNM/WU5q6/shJK5gor7l29Y+d?=
 =?us-ascii?Q?e5DTubFk+VREVaK/z8ZA8rW/tYPUgITwAA54aqCdzUYyx3Ua3B3Jz3vIWYLR?=
 =?us-ascii?Q?g1+dC7uO1qklvvjtpmHA+dSasHrszMLfY6eDjXCTJ/gtUjvhaKZyoy/xKRCN?=
 =?us-ascii?Q?8UEP9OaM9xgcCEulp+TCJMXMhoJ3BpkZcSz243cfm9SgsWPoNSeVp3TYzYyu?=
 =?us-ascii?Q?p3Vod4z9QmLkiPxD1ZSDiojiRvqSeTLVwdvN09WGXpYXqB5BnPU3mhtr28TY?=
 =?us-ascii?Q?mxA+ozzs0ch3Sac9ElNwmZGejniC0SVXgMNXEETqhnYVlr3pZjuGAI3ZyG0N?=
 =?us-ascii?Q?esu1stxEN4TRKLP0Anarb75FvPL1xZzU6780g711Zic0D+NJsWDIfUrhSAHu?=
 =?us-ascii?Q?MZsptzjw7TPhPaFoNvOMwEdKV7FaMemEeZ6nSMLt12n6KFMJe1H+n0pMtqnn?=
 =?us-ascii?Q?rGj4PmgZYl0Mx+/VPCBMOf/7ylaQJaiVeo5dD7m/OArRsvMkvf8aGENPqU6c?=
 =?us-ascii?Q?pVvyg6yP3OpCPhMtcFpy8f2a3h66pnSPErsJVQwIBnR/dhkXNTWhgb7V3Wo8?=
 =?us-ascii?Q?r4bQMobQZ5zZ6uw98vAEGmJOsX3/5hpu0Kw74lJ5LeFZZMOWDZQO10wUDCrq?=
 =?us-ascii?Q?TJHam7YUq+F5ncBiZ5xkdo2uu45/EcB0tdDYlu3PuOS5UeGCtYBj00DpTMr8?=
 =?us-ascii?Q?GNsU5+ifLT6eovKZCID4drAglWdfo30vsZ4dPPP4wUXt1FXS/Ql9FD2wSzj+?=
 =?us-ascii?Q?uTK9Z7E3m5HT9K8QbRRMgko1pZhTjExDqtI40djNYTo179A0YztQTDsxvu3s?=
 =?us-ascii?Q?nQTN0jZsiJeF41E6bCpHJujDB3H+ZR/TJNqi+Si4JPJAYRa76svhMcR3LIJW?=
 =?us-ascii?Q?QKTmTmDbeYZN2w+sb0SmW8GH0Zk1ejqSYX8h74JC2mwJ0FECc09u8vEAyI1E?=
 =?us-ascii?Q?log7l+N/Pkl/1h88mDU/8BdVl8ryBtwDo3zzFlTMJovJzaEcteBkJ0bvuEGv?=
 =?us-ascii?Q?aKVXWhV8lM84FJjmKrdCyxULk4JRaJYdVXgRMfCDf5eZCYXn7ZdIjpnR3cqD?=
 =?us-ascii?Q?R33M+wSW1tLn5WCuRIEcpNVS/vi0OAuby2kg+xd9Cbj+qe31WpTI2KGtHE6Z?=
 =?us-ascii?Q?hnfM8YM7Y+XoQPj9LKwMOADwKEp1UH6FNRCwtl6aLIEpFG/nI+G2abqhaJbx?=
 =?us-ascii?Q?n2wk4LxreIR+hbrgCtf+cYEuRJrEuvT1PVlmuTALQr0UhfMhGTupjf2t/p/n?=
 =?us-ascii?Q?xo0ZOAIAFLLpXOHaCdQ7TTBod0YR6bI8JZ426vXTCa7NsNbD/ebL6AbETHKp?=
 =?us-ascii?Q?ubEpEXH1cX75eAThK94Y2KT6CO7iL6uz0KUIDQk7PR8D2FgG5R/6Jn0zvJSS?=
 =?us-ascii?Q?J9o1HxLUsYbYrOBIDRrVM+V36z3RFfymFkjsBFbyxrYODi2Hyz1QOvqpSVtr?=
 =?us-ascii?Q?U/ydXKtyZgqTmlbvV7EMBIKo+1FsGyCoKYJDOlwjRYHANQnW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91eab4-01bd-4de0-49bf-08df2f498ba2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:01:43.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzpzeQ9I1AQCYV9MZzg2uTMp/r5dIJcI1VUYq5vOwezzhq3+Xvq7ii4QqsAXqyG2srUycKzsRsp2hDnmEGhvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124

On Tue, Oct 20, 2026 at 02:43:34PM +0800, Zhiling Zou wrote:
> A packet can race with VIF publication and make ipmr_find_vif() return
> -1 even though the VIF device pointer is already visible. In the IPv4
> path, checking only the MFC parent device then allows forwarding to
> continue with an invalid ingress VIF. Besides the offload lookup, this
> can let (*,G) forwarding loop the packet back out the ingress VIF.
> 
> Reject packets whose ingress VIF cannot be found in both IPv4 and IPv6
> forwarding. The IPv4 offload helper also checks for a negative ingress
> index before deriving vif_table pointers. The output index comes from
> the bounded MFC output-interface iteration, so it does not need a
> separate check.
> 
> The out-of-bounds read in ipmr_forward_offloaded() requires an skb
> marked for L3 forwarding offload, which is currently done by mlxsw.
> The race is rare; the supplied PoC triggers a UBSAN report for the
> negative array index, but does not demonstrate an actual out-of-bounds
> read.
> 
> Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
> Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Naman Gulati <namangulati@google.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v2:
>   - Reject packets with an unknown ingress VIF in IPv4 and IPv6 forwarding.
>   - Keep only the negative in_vifi check in the offload helper; out_vifi is
>     bounded by the MFC output-interface iteration.
>   - Add the Fixes tag for the corresponding IPv6 forwarding change.
>   - Clarify that an actual OOB read requires the mlxsw offload mark and that
>     the PoC reports the UBSAN negative-index diagnostic only.
>   - v1 Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
> 
>  net/ipv4/ipmr.c  | 11 ++++++++---
>  net/ipv6/ip6mr.c |  3 ++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c452..d10a66534ef9f 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1879,11 +1879,15 @@ static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
>  static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
>  				   int in_vifi, int out_vifi)
>  {
> -	struct vif_device *out_vif = &mrt->vif_table[out_vifi];
> -	struct vif_device *in_vif = &mrt->vif_table[in_vifi];
> +	struct vif_device *out_vif, *in_vif;
>  
>  	if (!skb->offload_l3_fwd_mark)
>  		return false;
> +	if (in_vifi < 0)
> +		return false;
> +
> +	out_vif = &mrt->vif_table[out_vifi];
> +	in_vif = &mrt->vif_table[in_vifi];
>  	if (!out_vif->dev_parent_id.id_len || !in_vif->dev_parent_id.id_len)
>  		return false;
>  	return netdev_phys_item_id_same(&out_vif->dev_parent_id,

This hunk is unnecessary given the check in ip_mr_forward(). The subject
should be changed accordingly.

> @@ -2064,7 +2068,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
>  	}
>  
>  	/* Wrong interface: drop packet and (maybe) send PIM assert. */
> -	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
> +	if (true_vifi < 0 ||
> +	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
>  		if (rt_is_output_route(skb_rtable(skb))) {
>  			/* It is our own packet, looped back.
>  			 * Very complicated situation...
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 9d8116b5edb17..faaf04f5c4f33 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -2218,7 +2218,8 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
>  	/*
>  	 * Wrong interface: drop packet and (maybe) send PIM assert.
>  	 */
> -	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
> +	if (true_vifi < 0 ||
> +	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
>  		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
>  
>  		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
> -- 
> 2.55.0
> 
