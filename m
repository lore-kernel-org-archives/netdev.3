Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB9456E1E
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949055; cv=fail; b=f2MNT8srJtqQ+pXeaEH0QbblqJsRqp/Cinz2763H+NLm71NY/vUdsSV+SA7+EtFfteqMI7IWNhOgQqVDucRKj48W/fpist6v4JYr667NSiKJBEkE06yoCPH2WvXKNzUfLx0noyK1wCCJRzfhc3mBi77zPWTgyDjvHQTle1VpATE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949055; c=relaxed/simple;
	bh=wEL2K2vMUtkHVub4sS/dVCstmQQxROkED5Or0RWx6Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJGvpYqd2O7a+aR3HPo04QOcDmv1TbQsG9yCNQqNhDWegAEoRj0XWyYTr3y8MIxD60CenFAZp9l6tWu6Ui8c6/woyRP+EkRdd9QDdLJb6e9AL/Pvo4JL/U9o4LRdNVLz7hAEX4PBl+z3PppVG7j2xtSkSJt8oTLBAKxecRRrcCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gsNXIaBR; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsNXIaBR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b25Fpnka71F09gV5bTiuwz+XEsY/RsY5sMUDp6uNieFsbfSV0uAP5Dq/bTM7jzpBQYCpftcjkhY50v9wb+Lb8flkJDIlrTkOMFN4uI4LNrR4vx+WAk50xnDsJ3zsr3FSyIIqzRhANzB2cXK4YYUDwN/8MT5bVziS9BygQLnGGiGJ9JMYoEGCenEWtkkgc1YJScgI8r1LhP1c0MH+msr90ICbXlhmWuYBdBwg7SlPUKV9C4ye3vXXz5GcBae/gPRcBehhNFsVkMgr1h+oPf6gyDRW7FY7H6W6CwEHPL2hinerbnrMKjmonwPTEWUc333iASvBYKZAmu+TGg368hECaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi9fL0TqHW1mIkuR0zmEjNTQ/GZtCYI7Ot1DZD6K8KQ=;
 b=Jf56nnwwTPhp+rcKopsfFY5W36teMIQehct4OkqzvQedHZllKIpjgMVw7YQHp5jYn4OXiuJ37DVJgRZv3i1ayfyKNXQzYjwyAeYC6cHSfYlQQWCeK+0PRH+UmEjTGIPWjek7LyL96FQ+8j/ymenpB8IHo/RH/Jq6iAQyZ1Ve6DML3kJsIDZ3A+fkay6jgqLD8v7TtjFQaP/4emIY2FZKh4/v8As7FafhLv1T/rHzb6Hz2+ssocya7gOifeDCq+DWyob8U2QgVbY0MV5ciRlmmSFzwEot1BZSf1kH5nMuLVC1aERdO6+vH5cJ1yKg5tmw/090XjyO01k25mfVcmkaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi9fL0TqHW1mIkuR0zmEjNTQ/GZtCYI7Ot1DZD6K8KQ=;
 b=gsNXIaBRsVrBXGQS8PTYLXnJ9okxdSYI1lC0Lbetmv4xox54ED39AtA2BKmM6YqqnXCVPpdzj8dnVk9S8AOh/ecT4WqjuwhRE2b6xtHAnnBn8YFo+bg0/dC2A+sxvgfKqzJ+h/2NyyqKaZKks5eipxvvpEfgEwcV1/QnTT3lsIftuncm5ZsAm3Nl3+k0CUwlPyUjadrQfgNicdaIDF/xrmZbhckZ0Otz3t0fv+Kk/VhVge6/Iu8xAtui5wWmj6nYZYLsW1woWzIyA6GIvvXvYu4N+hyCO+2rnsGWjTOPlKy8gp1I7F4VwWCu6uFiN9oDYn/dQtZO8wOugI5vJR8g1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 16:57:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 16:57:26 +0000
Date: Wed, 5 Aug 2026 19:57:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, yoshfuji@linux-ipv6.org,
	yasuyuki.kozakai@toshiba.co.jp, vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
Message-ID: <20260805165709.GA1600318@shredder>
References: <cover.1785736562.git.zhilinz@nebusec.ai>
 <fe1a5e765fbca88d69391887f0ed26a19e3e4d39.1785736562.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1a5e765fbca88d69391887f0ed26a19e3e4d39.1785736562.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: dec7b7f6-f381-4702-c63e-08def312a05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ag5MIg70oPV2Dm93Vyyg0XHFrK3GLt4usyiR5nrQfmz32DIWcMAU98Rme18cj61FYw0kuobYzHqACgdJbpYD4gyZ3vSfZisByPC/4SJCMTEB2JJaZPG2PbIRWBiqgeRDd2DASZ/Fly/NDgSnwB6lgoy69mh2l3nzXcJreF1f+WkalykVQovKHlxodm++HfxKmU3MxpPP0GkmIKiYxv5qq86s/sjkOJiS6OqDgubTh6mG2ZAzTFf8CGU6XFyPkbcHEt8sy0LZ+G/i2l9kPqpj67fbObeGskxoA8HCZFwrkTuGSfLieS689O26nyiKzU/eLen4I1Q+rqJanGTdDoZizf9JjDFItWXigiclfdNGkT2RJgTtohjF2v5ly/N+7rr+69adUKifrhvtWC16T+Mv9CPOwpn/y0AzVIC2XvphDtnDQ62xmI3fzlBtf81/b32CUQyf4eTVVKpcv5xfFYpPRG30Xcghg87TmQBUaQ2OuJbwSWV8KO0GquTN+7fwasQcqOVAy0VS5bdnnd6x8oa1H+JEZPWbaskg0hx/sn/LphaY1ArSi7y0YtWkFhgvlCDclAagVZAZi87lrPIaQOPdOQte+CJ33/LdmGhSOzKOhrfUUN2eKjfPTKcCKeJa9GJf1JfpLPA8IyYTZmao5nusHpK0bgTDVnl6WQRQ/oEmeSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6YGT9ht1mIAbI5YzQb3+IJzzs+z7RNn7jpfrftTnc9XBtNBM5PDsXl6pN2vv?=
 =?us-ascii?Q?Mpbsbrus5NEIQwLgzPSf7drPuQcmPRJyBYeddS+zyz8dzgKxw9gTeD0c0GYH?=
 =?us-ascii?Q?bPGqRwbomkfg0rGytAwfpRln69buOVQCoWVVQwIvGEH61BU5YkRYU28G7jU4?=
 =?us-ascii?Q?JlWUR3Nt8+xe836S0ogBVv0Ug0+vvr6pS8YRa5SXURu3Qcu06tDY2gj+a7HD?=
 =?us-ascii?Q?X9a0PWBUXHKtKXfrKI8s3lKPYi5gf8wvqkYJ4/2tbe5pcE1j+vXnrxTrPWYC?=
 =?us-ascii?Q?A3Nu4k8PWLtYXgd3snfM1h0xAPz2QgKImPmizP1C5xkEBZSMmEFG7vu5aWkA?=
 =?us-ascii?Q?7lCDW9NCmAel5H16YmMSr+T9CB/24134+i/TgbixLpPeWn+nlqhedqQqaxmj?=
 =?us-ascii?Q?BexxlSBnj23ULPq4MWFiLMvsGJAl2UzguK2KhwCHG0eatzDTzFu7jQzwnSOU?=
 =?us-ascii?Q?vOmI+uotbpywuqc+5PwYJP0Gt+z2jUFo3g9rd2GY4D3mVaD3tBccRhvzr/gw?=
 =?us-ascii?Q?fXBw5X7nEY5LkgxdTx7M9P18uXsCIOsSrxKuoF8OFWRGN2Q5S1/8yYSL01p4?=
 =?us-ascii?Q?wIusXZqyANvJk1nA7ggk6NCM/nX0GlGWmHaDrfZYNmOSUMmDl6QIXF6VrWMu?=
 =?us-ascii?Q?M4SxwCr976OrERpfj6WU/EEEvDuvp+KubbxmOJnrPd+TyR/WBtWWDM78klB0?=
 =?us-ascii?Q?C3oOZxeUZratEhNzL8NOuTa24mopYthwhUkw/HFGUIbyXhq3amM9gDytqkRB?=
 =?us-ascii?Q?hYF6Jmbe2eNtnkx9iq3JeGVDqpkpvY+1uAPCqTHRup+cBEtVcsiopTEAQg8M?=
 =?us-ascii?Q?h6YcAr3eOqKBHmvbmt/jwpy20ICsQ9VpHJ5A8+pL5MUoNbdC4ABUt/Q8cZlZ?=
 =?us-ascii?Q?zMeBYvJUpbMMpqwP7zSlvx+RprwfwpYVY5px3zlg6nDuKqZVS3iSpwCx1a+p?=
 =?us-ascii?Q?yZgQerDyL4pI1gSXGcCwWwOtuS+0nW6sk7WT7WEO2y6GfTNYMePD1Hl4ZOwP?=
 =?us-ascii?Q?PY2pjGCY8Aw1U/yNLrl47tY+TJleQl3P9U5nbwzfmVrhh8zOgu86FeZ45L5I?=
 =?us-ascii?Q?IJWeZS6fbsqSoTBz5S1fjeG0CaAtwZoBJdhvlVDuOTxT8jKy8NK3jFV+AWEu?=
 =?us-ascii?Q?0z+WXE1yLp+JzJShF4tsehsqdUGyvdMacYmsiqIaj1ABC88DgmZJd+eEpu4G?=
 =?us-ascii?Q?dAW2+5GgmR51DHu4MmCBnQokglVSHv5ihPasSYQl49O1uTg4Z3uJBrtM6EkF?=
 =?us-ascii?Q?GiPgAGkBIulBJeHlCos5Q9Rarsk7UkygBWppeH+ihYYuRiq38Qkdtx8/UYSh?=
 =?us-ascii?Q?ampNpc8Yymfgp6HSITcTCYdDNFun+Fk+4ePGsNn5VfOvld7oXzg1GKHsNASW?=
 =?us-ascii?Q?hWTpjPL2BSaCef36+EdfrUe2bN+tsmpKSJ7YtwBKvlcU+VF3YYZZmpYThYTT?=
 =?us-ascii?Q?Q9Prilet3dTYpdmz+f6F9qNbz7rcXzUFHSqdIQS/eQyLSEoGafyAcQAxI5dp?=
 =?us-ascii?Q?ze79Iiky9SiZh+nxr1LkVti4+CvsE3tFAr20bg00GzjIkk2gBvsXy5eRwB45?=
 =?us-ascii?Q?O9OGkdTouWXrpqqBvOiOd4TTNLUFNcui6vdKEBm2IfL39IxkcU42lkISSQp7?=
 =?us-ascii?Q?y9iu4lrzIx6QrrV0POm3XWuYx+8LwhNSfJaiVEuG6ljRuxvfTpaCbAvDPEcp?=
 =?us-ascii?Q?9DEInyHu1hQELP0SpI9sTwWXiPwJfRJd1NTS1CwUfqK+9yhlwDH1Q476TJ8e?=
 =?us-ascii?Q?F7GjQrTf1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec7b7f6-f381-4702-c63e-08def312a05a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:57:26.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fqOd8+JGkzkL5W0ouEHPT56MkLFyAW9liiGr6BaNUlQJtuTigXV9tYBUYm72mU6JtTqgzY8tbBqty4keRGwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598

On Mon, Aug 03, 2026 at 02:12:33PM +0800, Zhiling Zou wrote:
> ip6ip6_err() clones an outer IPv6 ICMP error skb, pulls it to the
> quoted inner IPv6 packet, and then passes the clone to icmpv6_send().
> The clone still carries the outer packet's inet6_skb_parm in skb->cb.
> 
> If the outer packet had a Home Address Option, IP6CB(skb2)->dsthao
> remains non-zero after skb_pull(). icmpv6_send() later calls
> mip6_addr_swap(), which uses that stale dsthao offset against the quoted
> inner packet. A malformed inner destination-options header can then make
> the HAO lookup and address swap run past the end of the quoted packet
> and corrupt skb_shared_info.
> 
> Clear skb2->cb[] before pulling the quoted inner IPv6 packet so the
> reply path does not reuse metadata left by the outer IPv6 stack.
> 
> Fixes: e490d1d85cf5 ("[IPV6] IP6TUNNEL: Split out generic routine in ip6ip6_err().")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Regarding:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/fe1a5e765fbca88d69391887f0ed26a19e3e4d39.1785736562.git.zhilinz%40nebusec.ai

1. "Could this description be tightened up, given it is going to
stable?"

Nitpick.

2. "Is this the right commit to blame?"

Nitpick. We can blame 793832361fe7 ("[IPV6] MIP6: Revert address to send
ICMPv6 error."), but it doesn't matter in practice.

3. "Does clearing the whole inet6_skb_parm here also throw away IP6CB->iif,
which was valid and is still consumed by the reply path?"

Yes and it's fine. It needs to encode the iif of the packet that
icmpv6_send() is going to quote and it's not IP6CB->iif. It's
rt->dst.dev->ifindex, but passing 0 is legitimate.

4. "This isn't a bug introduced by this patch, but should the consumer be
hardened as well, rather than only this call site?"

Separate issue.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
