Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DF2E4257
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419652; cv=fail; b=dhoW0tp7Pnd0C1ZKD/wMYIYaRU5wyCNLbpQkUgnk/sZdgwglz1u/8fzVAhJSTe6n/RwEDIYM5vMAMMnAuFNIYy8EnFagjT6j7o+eG9xTe6V5kzB+eZI0fZ/3QXYYBkayh69UjTpBwCpk8LzuaO+Ln3y0S52SLw1mFJEfo/rFAiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419652; c=relaxed/simple;
	bh=yTfF+6o5enW9GwnNqcSBJ4nXRNdSBr1Eez3mxQmAPn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHGZnpDH6/uo6Cq1IGew2ruLQ7Fn8dAV723Y1kp+hERMd2LfoK5NXE2+icxTq/1Z3WdHafnK15wQ63XlrvHXT7LUepMgufDIVt0m1InjIc4delNT5XtwsseE0oH2c0L1qBFXOKeh6PYdnSRLpixtNmm4IagI33+4f+3HXHTz0Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohmpEhXG; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohmpEhXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKUEuBoLC4HETpcXIyG6UfutrfmPCmmaxzcQdzqmzwpmfaxPluE7NzBaAHuzL3CQVmJfXLIThzRG/o6q84FokkJfCCq2Mik6zBGYJ8mknMJbdYXkJV3ctiCX3dLz20q4a/5WPmAgFRZZYKE5Qk7g04E5ucQbTGpL3eZEcmTebQw0Sph/ABP2/u/PuSgp51Hpnd0hkZfP9oSzwMXYqVR5zwgCQ1rnKzksVIosRKJkRx0OZGEOQwEDT2l4MqTIXGlh4PaXhQgFWRg/hi2oJXmWLaeiF4YbIUfAKz3iRoZ+qz1KdWa6pD1tqLLueCM501Ive84YaQnSEKxYx9QYl55uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDVyjo0anU8bmLaxjOk5TpZbB46w9q1euX2BFcFVueM=;
 b=gWk0mHm1Zj7OddV1fLh4itflsOqtGDovU+Y9AM0JU9BDPgs5j+nS0lrbQM8pDaaIQQ9puHq6SfdzVy2xaXgSBIBleDyfqpiu3DY0JjZ7N9yib14dpw4pkLcNHmzwY94lO/9k2StxzpktIdt6pVc5ww5F8qQG1dKf5BnVaK7lwVm4YJE0OqNAykJmOMpvr8nLUmQAiGcLF+EoKPeSMrXhLuwEYdcN1lnxMRGOSvQ3DhlPJZ0/W5uBYrt6ZeO9Yg4Sd2bzE3H8neSRsaDkMF1SSSp6+khg37r4QSVzrPFQ5V6g2pU8O917wQtuAjEPoKNnT6FKyMJTSygEGEFnYjzXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDVyjo0anU8bmLaxjOk5TpZbB46w9q1euX2BFcFVueM=;
 b=ohmpEhXGsvNUrUGtOFTEFLTyZahLpzz9KC81amyHZnhuTPAlYL/VPTwUo6F2vKDUy0aiTFI2ntxq3QErFPgMNRKFnXihSvDn0Ts6Yr6Ufl3xKI+88PlazRoZ/eDOBi5YW9kBuj9uadG4Dm/mSuNfx6mccJXZk/kw1Rbf2kM8aJWChj+eexbJybh5zfK8DeICsvAcrOlren9z2XZAy9Bz7pDDp/naMu01n9WpxS76PwoUYkIzN66bljhZ0EbqhJp5zUHD1O/uVwPQytb0q8hCHaEAr+VVenAmako6BhJ9klbaePdRJN1Sf14lgd8i7h/vJayCFKEEPngsqN1evyXZ5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:53:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:53:58 +0000
Date: Thu, 30 Jul 2026 16:53:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA
 nexthops
Message-ID: <20260730135350.GA1789341@shredder>
References: <cover.1785411219.git.zihanx@nebusec.ai>
 <6f53fa797fcaeb26966432ed7ae9bb87c4961f37.1785411220.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f53fa797fcaeb26966432ed7ae9bb87c4961f37.1785411220.git.zihanx@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f39120-d051-4b5f-a3a7-08deee4200fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SFgXoAaveHCPmPHJj869FiIyKsKlpzxJPtP1D3eLP6BaPZX0lBbIyh5llLyBu6t5EVImfIomppbwt6HXM36JJx/2CaZR4RWSKiYRtuewWzkjOvMr4IPkAPAmu3onahVPLxsDbXuzucviHPuNAjUXx4Zqt6EXNb2BbEOG2kbvioQ3scYoMZXilRfliPb3J276qr8rzXJldvA35eFANwotEzp8uJhuemEegROH68gDXu45/JRvbIBg7D1wfo6zuktsgz3vs0vyC3/3fjgMSKGVQFdJavQR3MGfJ3w2luYTw/kgkMVqBebOudXqkyYdiqUDXjvcYv/w6r0PuMvUyom8Lg88RI3VYsqGmXQLnnE75999n7+YR7z3T1el3YllEK2wbGwp+aJG9ipnmGlP+6c6ojH7CSOD3Ix7guZKMF9DbV2pxMg3X8xIM4hX3Nbag2w5UFUF3LMDxFAgbG76JhsHmcEik5LLi7LOnNjf5bvCtUBKRzE+1UQi3magpRkDutKz5YHQEjdY5JlvNkEbnODf+G+nxa5GoFWN77cVMOrBFIgD6zoVSQCEUcPwfAGwqgSko8YE4Enp5uG3/r1cdvMcgOoE4PfurvKVdOvC9EMAcIjLGS5RvaSPt+o9NykTQSdIhXRgVPxXKQE/buJT3n5tgje76ShTM89Eq+MFqYAQruc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4Nx5HMFga12o0R8bDAyeJjRQ1j2S7yp0P9WEz9g2bVLZBo+o9ciBNl4ZUOi?=
 =?us-ascii?Q?IOjP+4tyabnQiaeSo57lIQrDA68LRVWUW5Ok3hS2+/XWkXVdofYlrDm8ynKZ?=
 =?us-ascii?Q?gfh12xzzjeEeioPS+lkM3L/P/qMDJtBCNHKxifRZXxw6HDRLUKsORxfETNrI?=
 =?us-ascii?Q?NRfIwAmQionrvDDjBKkFFD1uEOT25iY1X2oDwVgbXVv15XaOTQOqAXHzyznQ?=
 =?us-ascii?Q?RnTliS1RTvmmPLYXHLHVf1+Teb3taivvORX8OT59YdmYkD9qDxFAm+LY6y22?=
 =?us-ascii?Q?SUjb5qaSZ2WEhjIt3M1lnz5XHLXdW0YbBX+hj08fhoSxoXDUI9nGtMLT8bXt?=
 =?us-ascii?Q?+qZ3PdsOW16OeQ1WjzC+D65gNSB70fi5oLrSkDK1+0V0ay46Bm+08WC+bn2g?=
 =?us-ascii?Q?tIy1I1PvEMIGhI2DG0IYMotzhVNxMJ1KTK9IqBsmmzMbwWrO58sOi51QNfDt?=
 =?us-ascii?Q?xdtvRTA0PYW2b/k9ITY+B7EDErr1ibUcybpygQJfMUijiMA1/QI68lZKoQNb?=
 =?us-ascii?Q?5B+5I7kXqU84UlFriQb6bcl0jJdyfrSc4Ix1JqRo1ioiiX+S3PPLPMHgesGX?=
 =?us-ascii?Q?XxZgOqzs6cg2PTwm9UAc5cQdDCU8e7UzwOrdUIPtiLxzxgCwvmnWWWE7A23h?=
 =?us-ascii?Q?/lGvJ6PMSTMF6Ah3EE7vydmVW7V07jnSR3Agt63r3tvXE5I/0pDn2e/2pe5C?=
 =?us-ascii?Q?8ZG+Vx1a7PIOmQu9Ze+dp6Pn3Y0bi03c6uHGF3cMZUYuXWug3DdYaI1jjlRq?=
 =?us-ascii?Q?dtxjDysb+fbJrdETSvXdHRHZiezY50tZdKdcUcF901d4ssAe7cldfU89XXHu?=
 =?us-ascii?Q?QZNmjs5lyraXuLswa3nxoWWrmd7Q7BCA2Da6wvZn82Ugp0y3B3o+KEZ1XUjY?=
 =?us-ascii?Q?27yTzhCwHs3wovbVVj4IDoteu/3zficXko9ExYg1ZKdTXXU8IsiyUyGwnVlR?=
 =?us-ascii?Q?mzKNqNc6fIJMtnhfWdIQVGu2FHp86vAhabrr/aoDOoDTBCbYW7VF5cEXb0cL?=
 =?us-ascii?Q?wUV5MnMvGR3pPgBa0ldEXlXsatDMpAQf2MWxWLChrjA4YXjyh28A1a7cuqCF?=
 =?us-ascii?Q?FNzUJCwVcG6vKu5T2bwHIrFOrS4Eo0vKLzZOQb98SgLm5bOpBOWkSUwu6OjF?=
 =?us-ascii?Q?+ZDfStpuoX8KY5PXqFrxRyUhTuvIi5NwIXr9glDLeyw54xx3iwqRvoWQ/Xrs?=
 =?us-ascii?Q?8EWIDFEP17HnhSG690vXFPlhSOD4m/+EXfIh3XxpfxY3MsIiVvZyDmaOa6AC?=
 =?us-ascii?Q?d5OcykNodC9ih2WRcj03Mi/ZX3cijifxDNo7RDckg1Ek1A1NVUQv2SqX7b72?=
 =?us-ascii?Q?/0vKtCaBWBdN4WXIs3ipATcofau0zTa4K9qC34QZUOACaVCLVFPz/wIUWD0X?=
 =?us-ascii?Q?RDgqLBWujIFMhjgRHMpG/kys0ZgeuLYFkfBNRSeqI2SHpSt3AznmiyioTrmj?=
 =?us-ascii?Q?vmULm0DvRD/+HAkuq9v//liKVDvSJAU09nUFgnfTKFR3aSg5nL8LeTU1qHP5?=
 =?us-ascii?Q?bdydA7elOr94Bmou4MdoHbQa00QTa2Gu1BeC1N4oBkzuW1aYgY7iIhhHyeaB?=
 =?us-ascii?Q?9UItodMOyMar1fcxxIe+5QhNQsenoebDXFq0C3hROxZdmP6tL9LFsbklT4vz?=
 =?us-ascii?Q?RS+pg68rt8Lhrz7yY1l1zWu8KyvtPmf/LDB0f2LeM8YiFv609pZBMI2/y8+u?=
 =?us-ascii?Q?HKY4srWisXxh/lv7KtdzdSYIfQwDpbiS3TcaTu9hHwIjJPVGJ4xwr1oMOPI4?=
 =?us-ascii?Q?Z7fj2yS9BQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f39120-d051-4b5f-a3a7-08deee4200fd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:53:58.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lM10US21bOCYG8CUldLxR8tT3gTRsZuJ62JAtvOs+PojGSu2OZiho/COwDbtAWPTBgby4SH+eIdBl4HhBmmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

On Thu, Jul 30, 2026 at 12:59:26PM +0000, Zihan Xi wrote:
> fib_nlmsg_size() still estimates nexthop space as if every gateway is
> encoded as an IPv4 RTA_GATEWAY attribute. IPv4 routes can also carry an
> IPv6 gateway, which fib_nexthop_info() dumps as RTA_VIA.
> 
> As a result, route notifications can allocate an skb that is too small.
> fib_dump_info() then fails with -EMSGSIZE and rtmsg_fib() hits the
> WARN_ON() that marks such failures as a fib_nlmsg_size() bug. With
> panic_on_warn set, this becomes a kernel panic.
> 
> Mirror the actual nexthop dump layout in fib_nlmsg_size(): account for
> IPv6 nexthop gateways dumped as RTA_VIA, for the no-header rtnexthop
> layout used inside RTA_MULTIPATH, and for RTA_FLOW only when it is
> actually present.
> 
> Fixes: d15662682db2 ("ipv4: Allow ipv6 gateway with ipv4 routes")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
