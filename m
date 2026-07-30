Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0D3FCB06
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418563; cv=fail; b=MUM8PaNrMjxgKINbI/VB1xIpByRduFaiofQkzrVCe4+KFCPzLWuLIZ18HV5x05xHRMLIjbsuw0nZkYhuW9VIsCu67SzznzuR93EW920uLQp5s/RB4qvM26g81yLl3QgoPPj7UucVJ6pDw6CvnqlSkfaagP6QhhQXC0nLYSzEogI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418563; c=relaxed/simple;
	bh=j3XP8obbbfO4Hg/0g2PhBlfc2xXuof6Xqc4vBSfsfOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bv/p5DdY2C6gr0+5hjCLIYdP5OG8clwXLIzzdElpKYxBLQpA9G/E/WDQZol1wP0i/V7K8gfsR6/bQ7gwnlAqOItGtYz92YPe+M/j2t9G5iufQRqYWK8plzDWA/DQPWRXqR9Gm4td1nHq18lAxGiMylF+Il/kasP0HNr3o/AQu3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CLEJKNKa; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLEJKNKa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAQ4uZHnai+DssR6OdqmpwhutkBx4LYZax8gK3uObGtD4O02vDRUgFPySGGMKGdZy3ytzwTz6fwgK6WYpuKop3zE/HRegpB4KOTuavCD9o43ba9SRp8PdF7QB7KNA12NDYTKh7jxUQxrAo7c+ucgo7IX6nGEl/7iOK6ZSrid+vnpDuVl7AIRtr0JTqteNgwTgegD+0s6b/j+4ArnL4uoRqb17v/MRy8pYAvGPfV6cQ/GR0ZZ1OQGSGVqjDbp6yqOH93s8sLKGjcLuCU5cDGckYKfjVCVKsWo4YTvFAdLQoCR0HgnPA+nrQG0uRfPsqKWd0PWoWbCnssXWTkqaBpEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUdtKrT0jW+tcJAUWf7Pgr1QNJvf/G/ICDL0fEEXgc0=;
 b=y8IBZox9ttyKJCU4bIY91U44rNPpHBJXkwiE/0lRCSG5uWwYLQ9V+qxNyhx6fVPEzLagEI3AmHKmWGVNI8m+nVrbazmeRQEYPCpOBCiJRnnljVUCpMEN+5cdo4SscmnpdyK4yWHavtlMjI/M/l9TfjvGIEyksOmnV4Yo1zBkEfeQGIOzc1YpZW1E9fay56OY20k95dTNguxnsWxtwPo0gpcemHuM8sUS0200qH4HqA9fUpFAQ+SSdEs7L7rkoHwPtqeCmAIRHhA4mJ3j4J8fUAzs18oqHThxr5FkzSfYnsND1lmSolHInT+cHpgc5nKq7KaEftM95uKapDmGLU1HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUdtKrT0jW+tcJAUWf7Pgr1QNJvf/G/ICDL0fEEXgc0=;
 b=CLEJKNKak2VK1PFw7xjuzKp508xmbpBTaV8rEFVvXKy5YsZgwV900UT5hNt5SV1W0J14a9chdHkP7qfbQt9eNREGSXHJtLlofs3du3uq5qpqt6dxOgu/Yq2NAGQJnuiWw5Jaj2dLVA9HIiovJkjDX3eM9JUEiiVh5Wjog4FhhiynOafRffycTa2EPit7oF6c2DsLuMHkyGjpcxkYkcoPA4hu4QwFncvO+gnX4ZN19PMEdu4V8hqKRA/J9SgCmg589nmMW3GW4rmf2q6Lzp5UgtxB6dJG2yluaFSmbaGUyHaC1L2Tp0p33iBkmoL/N3b90xFkj+gTMjUAiy1t5V214A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:35:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:35:56 +0000
Date: Thu, 30 Jul 2026 16:35:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>, edumazet@google.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS
Message-ID: <20260730133546.GA1761428@shredder>
References: <cover.1784972917.git.edragain@163.com>
 <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: fd731e16-e27b-4078-4eac-08deee3f7baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9XqGN4kNkWu9xdptzKiRSa1mBv1dQEynPxCGMlnGReJKaRI43/ehi96yR8J/W9NJXV5pvSZ2K7CwbqQrzb7XXcwsQSCyzfxK0UlfShrbRNrgsuhC4G6971l8Ddhb2gtlUR78wOs3gvmUdp+4kLB0oFswlFKPbluBD2BLjBFnlfSs3XlZYkUneFURftjDcD0h9hKCfEl7Vy+eZ24Kj2LoSXBQ1g5KGUPz5j/5ywiti+L6hvhsB5XUonFxaWYpHirrTjsZhMHzNOeoMwjc8ss+VkJkKvcmcQsOe6tZP+4C3VVTGDaTy8UM6vX7N1WkJLXlkCiskKfApoI1aKtnXtTHOwaBqAmhzODsTH6AqnD9S37tj+AQDn99dD6zJmeG4ELpSXvMYrT19SB1Sj4yEzCFsz+pyWVJYn/v5E3L8lIa8Uznybspo608R8o9Ual5eR133B6ZUDmuBylKdIXq52F3lMTmYBJb7J4XqB7BbP5lDbTGNUsUc5BG9dyUNOGbtJSBhI2XqTdXIDI06Ec3dIlAkLYFADemjakR2697FWYcgym43TkJKmICtm18ZphWmwCWDSczWyLL28VXHI44voOCLySLgYN0ohYOf/2LSH1Gc373BHEm+tcrQEWBPft1OxvzKnYeuWa+swEHUnKexsbo/vw1+FGSbfkHM95qvMwyuLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4I4/ok1krx4Kkuhnz7BXRoDCnyrw4xNRolxV0/cJ/H3VorG0xKf8M9rcphY?=
 =?us-ascii?Q?H5Omeh6gE9uHjH+O6Ui5KpsSzVGEZBXJtIlIBcOOKijOWHC20mUT2Q4jvzZF?=
 =?us-ascii?Q?no1Kuwbw7eVM15Rp8bsdVCXBr7HgNmb0SIq7fgtuoSvlq4mgHppj3B3vvunh?=
 =?us-ascii?Q?zHRRHztku2xah+pr1fbt7/HK1BgxpqpJ/0RRHIUM0G6gNrt7wLC+cLTlCwIq?=
 =?us-ascii?Q?+tOvj9dIC5nEWV2VTqlAq3ECvcCa2eMbH3FU6x0dAuRZL8IoTofcDnRCdVrX?=
 =?us-ascii?Q?2I6hYiFZbFZiD6Gu+umql5X/knSMDh5NuzOJ4ui6PuTe/s0KmTgCj2Inr2DK?=
 =?us-ascii?Q?sEuGyYTx8HbbG05yImzjBh1u/JXP1qPqtLxKqkhI187/5XfM599HOmjs4DUP?=
 =?us-ascii?Q?nR9tgrkwpUoUjPtSJmi1o7uCiTK7h8zpghzs2Ge68TyVKRwZsovz18m7SF9k?=
 =?us-ascii?Q?sdoEbm/GpREaY03WnNG3RYr/rL+fxdmeQF+M6xBkMCK1n7Eb2YL3zRkyiRiL?=
 =?us-ascii?Q?i1tMv+bBNqGvSug76PmKQssB8oTeDUySRKl/ITug/dWjhd4zAwJqKwh0aD5x?=
 =?us-ascii?Q?ZD2LdsX/Z+dvTGc/HMYBPxrm6MfEoe+PNRZ6vwI+/YGRJSWCqMGaFcNtkg63?=
 =?us-ascii?Q?osNKuPzoi1qJ5Cgx3a0gOgF3uIrNNTZK8rdklwLYP4BwVrCxsmi3T8J8LSyd?=
 =?us-ascii?Q?USlRPpWeP64LjbzYOosTiezGTFE796r+08B77y9UnLrqtEvGZNk4RFCtHOoZ?=
 =?us-ascii?Q?9XpF3IhOK/Wmnmw3gh+Pqtbg1LL1TtIQAcpecNOqbSsbTFx6IrdNtIdvSDx8?=
 =?us-ascii?Q?r44GbdVYrmiV2FedlkTCb4+mVAlu8SuITAl4hJ32x9npmZngJl51wVITt9wO?=
 =?us-ascii?Q?4Wy4MpiNF6nhs1M9DejMTWTTim5V8CillQyWDZyD8/w6aGgDoL+5PlYHo1Ft?=
 =?us-ascii?Q?R9kPgmlWmLrS2KZPbqH/DTkn/FCIjNDIZsgX8IRBlRGo5gCWAd8yQUEYY25G?=
 =?us-ascii?Q?m4S7gc+23Pxp4lnTBch/m+w4GoUk4gaqCc+al/3aaC0WoFDgPCsFvCDGG+o1?=
 =?us-ascii?Q?pwO/QSPHYdYRBN7/C7MTRNpRpUuxDXCjq4gunOWQZVWWmOUSUtw2OC75e5dA?=
 =?us-ascii?Q?HdGj+5G9ETF2RbqrHHzSeqCVzP5E7sz7LJY7fLJ9rD+k6hpMBwJRZRNCWSf8?=
 =?us-ascii?Q?F9fOPxH7Vw5ET3LYgPWdWU2hPuyew+ECxdDBORUFkWIiNSe0tKCZFlHQGKBp?=
 =?us-ascii?Q?b5VY76fovMl4uM4DCt1hY5JL8Orc85CG7lhj5ebyMN+oTnMUQl3Uu0ckE5lO?=
 =?us-ascii?Q?/Uui6xQmcoTQ8TVIjF2fHWql+XVsNtRgYMpt9cSCY/SwdGCIqpm650YoPHv2?=
 =?us-ascii?Q?gGf6pzSzFLBJPsHzgpOmNxaI8x9ES7vkvmdK//HwfIAIECIO8Xewq/qCMugy?=
 =?us-ascii?Q?z5MGw2xbTrfBnXyPm9vmCpH90BPYxfLXJLft8L9KAH2D+csH/Y3EjBUe+FP8?=
 =?us-ascii?Q?4239PO2Bktj5DtTZ6yi0U3tB6MJrr+eOb4EkqJdRjFCfjGXkO0XId1URG7L/?=
 =?us-ascii?Q?gdEOUhOU94ES9Y6aqalJYGJ8SImJN8HHEqGmtMBicbSYzDlTghgCPfb1jlAu?=
 =?us-ascii?Q?BQluJrE4rXvJt1aSB6k6JJa0MM+86NJbMZTnk0Lys/TMCTytpcs0IlSUvfwt?=
 =?us-ascii?Q?TvYoBfkLTrAkFOh+IplVdhFVIPeHOOeI3btSB1YVt9KB0Davr1KXzZZydrvy?=
 =?us-ascii?Q?FZ5rpYowQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd731e16-e27b-4078-4eac-08deee3f7baf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:35:56.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJb0wsVPrKNCRHqDmEQPpc+NJkM2+6k+M/yoSFD5ji7KH01qPfEGcplnMlbSZB8UyOA38hP+rZSuX6ntYXPqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001

On Tue, Jul 28, 2026 at 01:08:17PM +0800, Ren Wei wrote:
> From: Yong Wang <edragain@163.com>
> 
> ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
> still accepts undersized non-zero values from userspace.
> 
> A route installed with "advmss 12" can later reach the passive TCP
> open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
> subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
> tcp_select_initial_window(). This can reduce the effective MSS to
> zero and trigger a divide-by-zero in the rounddown(space, mss) path.
> 
> Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
> keeping the existing "0 means use default advmss" behavior intact.
> 
> This matches the existing TCP_MIN_MSS based validation used for
> TCP_MAXSEG and fixes the bug at the route metric input point rather
> than adding a redundant guard deeper in the TCP stack.

Eric / Neal, the comment above tcp_select_initial_window() says:

"[...]. We assume here that mss >= 1. This MUST be enforced by all
callers".

AFAICT, tcp_openreq_init_rwin() and tcp_connect_init() are the only
callers that subtract the size of the timestamp option from the MSS
without validating the result.

Fixing it there also takes care of the comment from Sashiko regarding
RTAX_MTU:

"If an unprivileged user sets the namespace specific sysctl
net.ipv4.route.min_adv_mss to 0 (which is accessible due to an exporting
flaw) and adds a route with an MTU of 52, the IPv4 stack evaluates the
default advmss as max(MTU - 40, min_adv_mss), yielding 12.

[...]

Should a similar lower bound check be enforced for RTAX_MTU during
netlink conversion to prevent this bypass?"

Do you prefer to fix this in TCP?

Sashiko link:

https://sashiko.dev/#/patchset/a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain%40163.com

Patch link:

https://lore.kernel.org/netdev/cover.1784972917.git.edragain@163.com/

Thanks

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yong Wang <edragain@163.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/ipv4/metrics.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b38..b9b97a0a5126 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -44,6 +44,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			}
>  			val = nla_get_u32(nla);
>  		}
> +		if (type == RTAX_ADVMSS && val && val < TCP_MIN_MSS) {
> +			NL_SET_ERR_MSG_ATTR_FMT(extack, nla,
> +						"Invalid advmss, must be 0 or >= %u",
> +						TCP_MIN_MSS);
> +			return -EINVAL;
> +		}
>  		if (type == RTAX_ADVMSS && val > 65535 - 40)
>  			val = 65535 - 40;
>  		if (type == RTAX_MTU && val > 65535 - 15)
> -- 
> 2.53.0
