Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E28331ED6;
	Sun,  2 Aug 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671812; cv=fail; b=ADby//SHBkR8kxZIgWxjQKAU3OjdxD5askRxbS5LzbPDISPkRJqZ2f/UyU2irHUIcXgDWveP2Cqw5mMI/yxRpg5c/2r0zOPOYrCflIl07okSqYgm12OH4egmgFvXSH9hrp8Qc9i3DsYWzzmRYFOR3kUa3RZcg6xL7gfHgu9y+YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671812; c=relaxed/simple;
	bh=txyouLYGe/7OVRc6cQyFmZmmefLmjveE5u8BuxQZo0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XsCrBemBb6WaOEmvE7IwkXNBeXxFczGzDVkoJtfMzRGM4+9johS96Ya3V5Q53SBA1lytgv2+FmAUhr7WBgwJGEaJgZtofSY1b8u/2IUdsTvW6VtoLx+8k5OLj7NaaoDYkQasnY+b+05KggDDvdLzcIHGaokdtAwHACSWCamsR/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usOyMWYj; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usOyMWYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bym+xf4Jrotwzh8hbjc1WMipP2naOcV7fmq1r738CLCwIlNvsJ6hpqUa7jz6d/Jc0vxl23vJCA8/8Cb4keFYFzjGJmtIEMjqNpZrAfdNv8Ylg/uiqvpQD6UttgozOTA9a7wHhqnSN2/dSFamMa2Fmnaftft6B/YHv/NRl0Bmk+tS0VC6kL53XLMQ94UzUIhgAihJrDOn5pZsM9y/aI/3UoY/65M99SsGZunN/uHgFRV7PU5Net59M5GBRiNZv8MY80+92aiRnmuk7eq8d1IwoI9MQPG0qy+Ptfrkwgei1lYhdc9Q0NMUSoCiAQ6A7FamT7lYepQbKd32Ok1Iyh795g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZK2Gp833+p+kW7xwARSZX31v6BA5+Lx6Xsi64mCK4I=;
 b=e8OkbBwBjXXMW2quDZsLLUw5PAn9wPEQc9+k42p5EJ/2a7sgF0EkJtCHfqiN9JdphfqC6fIvNakk3MZRr8/FwnDYkYAGwMnxfrZKO83wxTdvZF2VUN775LKJTt/HO036OAo7wmteZvCLOdo9j/z2J1IRAb/jyrR1whvyPe+SBsedNnwHrf/kkNYiaxc9I2Buh/9qwV1Uy+IgPT12s2wXYp9tTvgsRZFXEBGvWYpsd4buiJdlFweJC7hXBQTrgR0AfFKu5i3JpU0dTTZlhKJClIu+BZaDTsTVSeb3RJntOuzrZmdgR81u1XZxx5i4y2zL124ly0imilQ4PzXanwtGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZK2Gp833+p+kW7xwARSZX31v6BA5+Lx6Xsi64mCK4I=;
 b=usOyMWYjCDxQ7L9QmLFDkHqcmcymUyGdPlIn9q49oQYLBLF3zdlAdXaDVchZGQk95guV2WIKJnziFoU3tBxIHVAdXtbU73QZGP2HDunJMVCOPgAuQwy3reiVB9Edov3KBIee1iGnIYZAmAW1YCvmTwMUnsldGwYhuumOseB+zkA485YAAQiYudNAB9hLmnvVi8nBcuQnkw1M2upvCkR/hn6MnOgcTkCGxJ5bNpfnN1gi7EKq+IesJv62vHt4dez+0stf4n0avMfnWoe2vRN2fKwtget5wdW3CDAdQOUghU7YJEAuyLhjmXhRArNhzdaT0v0iUhnD1LSonuGkJ6sUcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:56:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:56:48 +0000
Date: Sun, 2 Aug 2026 14:56:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Lee <david.lee@trailofbits.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: prevent in6_dev_get() from resurrecting inet6_dev
Message-ID: <20260802115639.GA270646@shredder>
References: <20260731135202.566337-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731135202.566337-1-david.lee@trailofbits.com>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 84924e8a-2ba7-46f8-63be-08def08d21b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N285LLqLSz2QHKxKY51oD5xw6XlOjI+4XerSN4MIcMsY1PIHZooO6TuwgH+iYUdWKomzeQ3TWijgU9MJKwTubI4du5h6Z/wiFfnNIAgOvZhYibcMu2ieqdOUfsmubpUkdn0NCg1FiLQCA19OfEpMp/P0z6T3Axpi2foII2wNEXzE7Dy7gjWjV758GbfKQaVbBXNQ1R6ug0bLqSGuEmjl2ocSqJ+dGighD6sOicbOCeQFSwmw8giEf6ol1UFSM2NMlOYKQQYHlU8WMRqnbAW8XvW6y512Gzbv/JZ+bwA+rH4s/LN0J9q5H38g+zRCv+kHwN5TSME+SJiN/xRCpTvgGaLRIwrY8X9Qa6MgkPETCrLho8mzZZnyZjpjUjgj6BJfSuJp1QETAloKT4ovnrFGYpPYvwUA1VNcixeCh9XGmU1GGrOQwwUIdIYTpV1de9S7PiXsQ8ZAg4zkd7oTbwu1aIYhtbOQKQfi3XZYvNfOFw4LiIh9fpHsKBJM8jd/zk6uV13TAwnryvW2ygb+i30Fap26Nc5oot46QmrSJ1yjhrQkoXtyorhCEItKrfdse5VEdqBW7d0YRt9uk+Q1rMAQ9kgMGSDm1R+t5fxwuvpsQ4r96SKaLGuIvtkVRFwJLmNipZEk/py6TSLGPhPxDDq7KMudjAY0S/NTbiPpymAFPSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZEdyLJWo6ABbS47tc3N6C/EWE0vl7BTnxlgULEFQVNEBUrlcF06XPXGQ6rB?=
 =?us-ascii?Q?AmWkHNFsbXzbw7tAKkJQ/UHmsXI1ngm2mbIt5Yx8k3oKLk+5x6cPT8mqK+ZT?=
 =?us-ascii?Q?Kp132Q9J7zYQ9ZbyBfCqRdtDFZDVMyE72yaXupHdJft9L3sL/fV3rG0mXJ3l?=
 =?us-ascii?Q?U92EVRK+r4LXFVzogK9MsrzpIQ1g/yMh+p+P7iDeyhTlpCD51puQnATxt/jQ?=
 =?us-ascii?Q?GSiV0Lf2JmSs+2PxVC1z4AYdbyjOtfHQRDVuT63xUdrlmxU8lBF0ab6vAIAJ?=
 =?us-ascii?Q?7MMksIjpqRK+Sw93n5Hp709aMcj3TKq81mI30J92Jb1tFRwNptPel0dInZBX?=
 =?us-ascii?Q?XsQWdg1OPgEQA1xUUPOwUgJHEuL1StoNtddOlz5MwldccguUnQyvPf91OHxC?=
 =?us-ascii?Q?sFkZClFCxRpzFPl8A3EXqcCmABoR8uyr3dnj0l7Iu6CShp1LM/dit6lqRon+?=
 =?us-ascii?Q?Vqpz4/kYGEhq8banC6p5DbpRuDVouHyLhYjpofSitdD39oykeMR/LQuZ1ZMJ?=
 =?us-ascii?Q?Lzwx/CUowGAc8LzhGFIDLt1Si8z/HHKwm7hxGw8GRcc8OAQ9Uyt/jTYQjcWz?=
 =?us-ascii?Q?Ef0s4r2jK2oW7lvvD2D4M6GarEEanXbsnCydTZPdLzD+nWBbCsSUsRzNM5lX?=
 =?us-ascii?Q?xmir+212ODJSPj3N5yEE1/cHfvTHxNB1Z1poQaFvYzcnLNKQuSogHf2DA4fS?=
 =?us-ascii?Q?4AgUXAGq7W6C+2mE5Hcwh9ZQrMvFPEhV9QXyr14/WR+W67Kjopwv6ywJn4Nu?=
 =?us-ascii?Q?inISC5CKA3+5jQE1eiNaD2h015uhgFbhPLfFYNED9EENCnUXJb27mGGtAhAb?=
 =?us-ascii?Q?7Ky4Ezl/oZ3FB97Ufkyw5hceMhNVw8R3PFZ0TNxs48zb7rMiH1JpgANXrvTV?=
 =?us-ascii?Q?yFMezDOlUuzu7qMbHfZ6eEYGJdrvA4+Z5movxh2R/ozO1kiyCVUH3bV3Ldma?=
 =?us-ascii?Q?oIgO2LOpLRsFfIX8DuEIirr1NrS2ml4k9lu6nHGj7RzZkm1Z5HrBT6YEa90w?=
 =?us-ascii?Q?4mLY7wAlyDskRa3h0uaK6a0q4XOKIT/2YLKk1qNKQLpzab/Bp9R93Jg3yRH9?=
 =?us-ascii?Q?4FT38W+U+MjN5Fa62cDjegDfDJtlsM6fLlW+VE22bVhM+PLT8nbr0wD5rg8N?=
 =?us-ascii?Q?SdlV2hVqySS/tzHYSu8eI9+xQ7ezlWBUbJY8a/1xkGJp2OCnaFb3s4tHlIG+?=
 =?us-ascii?Q?lud9tC6zZzcgmBWqj+pLjJGndBHawYhnvKNg/0qpVeSvfFwEu6kyCEtUSPUM?=
 =?us-ascii?Q?5BF3e6PU8tLrBlS2wQvQ4UKjQu9jF4G7CSyRzStQTclO1XmOsKgcU+s+WJYp?=
 =?us-ascii?Q?ilsarqVb4zaO1bDl44u9aSseQ9fbcCwRenZH9qJMLrWR+3OFDDvm+bP9/T0z?=
 =?us-ascii?Q?lDnuUdZIFwIJ200+9O+daeDQ8cWKTWBafB/gUptzixINoc/6Ur9Bc5dpeLSI?=
 =?us-ascii?Q?t/Zu/DD1nM185VhTDRKH6KMHN9MQy2Q7RnvRfDkse9nr4BWd887Cq4XWM6ss?=
 =?us-ascii?Q?nx5ZCTTWO+zt4DKSoCIfquQZM/IZNxKnVVXLKkL4ejmVT24RTnwhn8Df0nL9?=
 =?us-ascii?Q?HBCRHO2cKI5SjM7XbhRCeIRsViO3j2sHK86ZbD9u8HvSqzt9W9o991/c3V4U?=
 =?us-ascii?Q?QggvO2b3bERqPcGTeQvOVR8OWkj99fn02xmRkbQ0t4Sl+v6ZkaIxvutTWw2b?=
 =?us-ascii?Q?xIWSpKLh9ilXBKukExWK0LvVQckkiJVUJp8H/MR9Zcof1p4O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84924e8a-2ba7-46f8-63be-08def08d21b0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:56:48.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah+vm1wB/xPc+0D2iByOa5+zw9cbuxgyUp44ehYnys0j7lMnDtXz6psedpqDRfM/NJfw/g74lhrFHEjnmDtnEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

In addition to the other process comments you got, subject prefix should
have been "[PATCH net]" ("[PATCH net v2]" now). See:

https://docs.kernel.org/process/maintainer-netdev.html

Get the process right with one patch, then send the rest.

On Fri, Jul 31, 2026 at 01:52:01PM +0000, David Lee wrote:
> in6_dev_get() reads dev->ip6_ptr under RCU and then unconditionally
> increments its refcount. Device teardown can clear the pointer and drop
> the last reference between these operations. The increment then
> resurrects an object whose RCU free has already been queued, so callers
> can use it after it is freed.
> 
> Use refcount_inc_not_zero() and return NULL when the object has already
> reached zero. RCU keeps the memory accessible through the attempted
> reference acquisition, and a successful increment pins the object for
> the caller.
> 
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> Trail of Bits has a reproducer for this bug that triggers
> a KASAN use-after-free and can share if needed.

Didn't you see an "addition on 0; use-after-free" trace before KASAN?
Please include it in the commit message.

Was the bug reproduced on an unpatched kernel?

Also, what about IPv4? in_dev_get() has the same structure and at least
inet_netconf_get_devconf() is calling it without holding RTNL.
