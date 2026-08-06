Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088D43F4D7
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012704; cv=fail; b=BBTw/o7r10sI4Lgznz6xP6i7fAhb69Qqk2Cf8+1fSc1cmzX2SidsixYGG7G/WSX4dqYEL7/YzMlJ23mahlXrLszpoBPF/DSjPe6dpozSH8no4ZqVTsixlT7BXK+BpaeGmMx9bVx3INQZQdnMYwKF5+yueFGg9Zb5NPDyfr5Etew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012704; c=relaxed/simple;
	bh=jRY+6Sm6bg4UPK03u8u6AqDON1t5VW4vdE4FC8EuGKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwwcNk2OL3UqnoRN7QObVWuOp2u0vZ3vJufWSr55f4wlbxzPDLUNKQEQt/8k1FxguIPewVAcbZWtOIKVfIb7PxFBSfk6Lk2M/ZLxpRk0+gj5K2Ca9usfmCrduBbhvbBDpshxjmi5VdBOIazdptKdlW7t044ZkhfxVfMXAYGnP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LuDJP0kf; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LuDJP0kf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7yE584/xGtFSguS0wYBDbCzYV9d8t0fKMD/ABh27+RbbGObv0Zx692wrPR66xeswWETFQs5zoCMua5Mz+dw/06nS1fdG++Np5ZUo67uTAdGuUsq7gxlOGv0qei5jrfx3qA3QsyfnYTBc8I1aHOqLs21QBfK5SXSGzf1oSDAEC8czGMocVx61Ysg0mYklZZ/DgantfOxZd9HiiMpqC4tTWo2r1r5lsjc83Eeu87zLMkLd4Sfqo4hXzgBNfkh4qBmXipv/gySNoBW7pkE+cyJiRxDejm06BtCJWUa0GyaVo3DjOlhL2XXzujCHmBpW+/ZdcqwhELKdd7LhuAILlAe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN4vNdSMghpeXgXa/ORjP/0XPq2TtjY0U5YQB2GvMSM=;
 b=PpK4+NQCoyGQ4giyuKcWRHF8OMHzFIY3/GgBx1pq5CP1W9mOFx5SqONx3JtwbTyqmfQeBVCVrAAIMwpN5jfLvcLm1pL2+nOB3rOE00SapvOBoqUal4W3Xu6udVKYer3GC0oPfk56wMefL2Pr/ID/5az+x9VmlYX0O18fXPUUxFWmf+QAbaUjyqPazqwbFpX6f1BdU/4NfdA6OwC9mr0Lwy5L+zpxnEQJmQ0RiB33lwIyDzwbkZucDfuTGbS+o1k41Z8WfUSu2hace69WuLX99HM6a64B8xH4LLeRPH1I5d5LsEccVoYux5Jv8984DcsBQrUZlWMA8cfRyluWbOYZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN4vNdSMghpeXgXa/ORjP/0XPq2TtjY0U5YQB2GvMSM=;
 b=LuDJP0kfCuetUWXVApbmbQCqpZ5Ku/4OZ99jNNrybM/WaG46zg7oPUs2lt5a+m+XS3DM3zIVnacrgygJzg38m2D4e2guHAtaNr2Vr49sKvj1MlIPKgadY000MOZk8N+Gx7g6oQQcpL8ZPuzO/3ne++RgreCZ9sDKHiHRP5IC8NofxnaEf7XGalZznIoMXHQ5ivEA+8d6XBQBbNnnXdFjgF/MhvL9Q7RoUIj7eErWnmR8J4/9EjZnjtB8fRbCxfQ2/fKXN2oZbCKmQSTNPfChwtm3eknQD/y7U/2hjY5lD/OuiY/ClN5uNwd6caXuwY08TGQwWdidtBqj3Hw69/XBkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:38:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 10:38:16 +0000
Date: Thu, 6 Aug 2026 13:38:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, zhilinz@nebusec.ai
Cc: zhilinz@nebusec.ai, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260806103807.GA1818763@shredder>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
 <20260805013126.4161847-1-kuba@kernel.org>
 <20260805081737.GA1284302@shredder>
 <20260805163624.312b4df7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805163624.312b4df7@kernel.org>
X-ClientProxiedBy: FR4P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 986cb8e1-88de-4b58-5535-08def3a6d329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|56012099006|4143699003|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	0QAREFmhaSoWSb6z5ziPbEF4jRTjvioTIPdDrsBjXaKKX6gvwythkgI9pmxQhKPRGXJPld34uNjobW2ycTNPlP+QqKrewURVraSVOfk1I/A3o6OhShoT3BoPlOKCC3rhBrRIQ+PQ3b72zaJYxFPzfawMBLUd9mcB3Ac9kvD69EvajfMur9OLSAPRMzDvODbBFnxLAJzVOjGYu0LMl3jnNfnbhRi1xuJJd0BK0ffWvv111zF/qCDRUriUDQ9iaEz/osmXpida9N2KLuewM8+VwTZP9eLWir02X2ioJVZdoNqJBqnzCjnNqBCKexl/Bu+k+0Lw9eMT37bEUsqb516sC5Ro3Phq9uayn2o+nCWJo/vxFd7DmP2WjldDvHfc92fwldhtlyvJk/ew3bKJhawAtNZdLcokDoWsD/IMnUOOO8RhQ/c3Vo6jr/xEJVp9LBH1YjUqYS/V5wC9lA7qNJSx8e04AhbNthUGHD7N7reQn0ejpSmNz2RKbkmAhB/0y3atGYQQOeuNHTonPH06QG2Nm8ADHFAP0cffvToFW87Rowa8ayrJMACd6jJ/ZO9kxOpRVWsujg3xln4gUOn8Z6+OQ+lXFiwPg8S+Vwvpwrdz5iFazxJMua96JW/PTCQzrAlcRRAqcYuVG2inyHI4IE04TV9VrHPyGZCQKyjXpilmsLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2T2BUfR/vAM3Wh+r5vjzoILFrrMrqXzKqYhTpkJzW6G+x8Xhx9+LEQ6JHUJ?=
 =?us-ascii?Q?9xPpAWTzdCbsUepyM/lRKZ+6/dt97V9SNMX05QfDqFfeXtScWXTSxiFW53YD?=
 =?us-ascii?Q?di9mchHqNZc8DhVNxCHQGm9LkqW+18cOdVDXAckvnJmlTCnJ8lItC7PKc6me?=
 =?us-ascii?Q?GIxcnlbGz+TqJXFswJGVW6M0vdiKcAecXTFiIw5qlUmBhD6BOvv9nb90OUaN?=
 =?us-ascii?Q?5cPGcvyMrMUgEkrLgbdVe3HRxud//8Tf3Gzf811oHsYC3VG/OSdhT5X7T83d?=
 =?us-ascii?Q?+lFIXHrJKKJTx1N7r6DK3Xwyyr1mG83SigYAI5j+Ck+TwfHSgXNjX5zXflh0?=
 =?us-ascii?Q?x7ewVYBOHMOg78W/tZdmB42SohSSRK2bIfWYZZT75o7z/EFZI4riZy9xPv9p?=
 =?us-ascii?Q?l+8bVwnkGnqJLNXTUKfD278RSZRuVai8eknWE0566EdruJ6Qp4m0Hgog5l2x?=
 =?us-ascii?Q?X6/Am1hLZQkWzkk8HXWBxaf+wgEw3HYjVGV9Zlg87xXxCRPjT2CKKLnFgTas?=
 =?us-ascii?Q?bgRPzeDJq68Fi5S1+0mjYydjwa+F8y418RmHyQLoKnoL5rClmdXrcen47h1H?=
 =?us-ascii?Q?z88/F17dyQ8H5jUK/7ioD5oNn9Q94ZfG18E6+hnO7Ex5r4R5fKETRdVPyfM7?=
 =?us-ascii?Q?7a4yPZ0BS2tpbvv2tYMfJ2GYntd+v7vIdgAxlpEWuZYR/+FCch1robGsOJVK?=
 =?us-ascii?Q?Np29IwyS9R9mp5ozucpcTFj0rolNQ15KEdITwlZRrcYlucF7KGz98TIzvsvy?=
 =?us-ascii?Q?ILHivQcTrufGfP27HeQZtCFKd8ZQHpnFGCafAvKXpbKRsPCJhb6owxGjbX8K?=
 =?us-ascii?Q?aBmuXjBaasAcMiqaEAprGnLP0uqScNaweUkoqWATjl9uwKpHHCGqj5kcj/eI?=
 =?us-ascii?Q?3cKgxF0vdQ1+jp8Q6d3BsLkHJSoRWDxfdm7A5gOE6hAUZFic56vcYptol/le?=
 =?us-ascii?Q?cWn7c/ikwQWOFgjtXYUCnephTrWbZTp+VpFbz0QncNVo6KXYexEwwY7TKYxs?=
 =?us-ascii?Q?cP/zn/4aaceI8Eay6VmBAgPphKwggnm5wSZmEx/OcH3OyQVZbGzRAV9JjGQD?=
 =?us-ascii?Q?4mXIX4NLNExD2+eKmwRD/GsfYbnO3HqBZ1NDiIfPaosdsrflEJGpqApNf99h?=
 =?us-ascii?Q?kfaBWiS8k9EVOHOffBhwnK25HPq18MWn78+U42hdj9h+VwRDOQ2Nz0zgAvZ5?=
 =?us-ascii?Q?Aj+D8zpeIe0lRtAe55UySsowwUPShr9d6X3TQn7xB6mhAoCDZNwwEszP6EN5?=
 =?us-ascii?Q?Jk3Z2dfPQpCMtg0BLsFNSCJD+5iT/GK7QCUgzjzbV3km9G2B5Dz2IvS8UIbU?=
 =?us-ascii?Q?byDwWnIQ535E5nb/wb8H2XnuIMHMHIdCXw2ZDy+NTUU78qJpVJkIQUdr2UWt?=
 =?us-ascii?Q?Kbq6Hid8Gg2GMS3vnMPJ4IYjBa+WYDBkUg9aRsu5jN9eZs9ICniPptYxIEj+?=
 =?us-ascii?Q?f6/UbUV9gvMUSDVVBvG7WfeBvzAtcOyN9kLPsUdFOFYVCnqago5eQ3KCa6EW?=
 =?us-ascii?Q?sPoCcDVDQCaGQS+vKe1f3RBEQxXC4nW0TbtS7LYFR7vTikTn8bOgmc1rSHjO?=
 =?us-ascii?Q?kj67+cgcr1x48PY2wrgXACT6hkBMQVarxahnC+kt/kx7pgOpYRvkH03VkEjF?=
 =?us-ascii?Q?kRINCoojZ7FowhM9pqnDzNv/OJswBhDamt/l0mSF2jqpL8MbQFIIcPso+8xK?=
 =?us-ascii?Q?O/wBYFfTsLVkzhHNBn6sNpQ/aV3w/oek4lWgXNrr5I60Xccaqv2xBCM99xhg?=
 =?us-ascii?Q?qJR4RgA0zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986cb8e1-88de-4b58-5535-08def3a6d329
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:38:16.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RfCvwUtpP3fe1k+4y3gOFrt720xBzjaf/1kAA4SUlqnWeKtngnw5f5jh0lItaGy/3GqasT/Vl4vw+jxenJIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

On Wed, Aug 05, 2026 at 04:36:24PM -0700, Jakub Kicinski wrote:
> On Wed, 5 Aug 2026 11:17:37 +0300 Ido Schimmel wrote:
> > On Tue, Aug 04, 2026 at 06:31:26PM -0700, Jakub Kicinski wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email says "Looks legit, let's fix both in one patch?"  
> > 
> > I suggested [1], but the bug in the IGMPMSG_WHOLEPKT /
> > IGMPMSG_WRVIFWHOLE branch needs a different Fixes tag (it precedes
> > bb7403655b3c) and Sashiko [2][3] found another bug in this code:
> > 
> > ipv4_pktinfo_prepare() modifies the control block of 'pkt', which can
> > result in this packet being processed incorrectly after
> > ipmr_cache_report() returns. I *think* that [4] takes care of it, but
> > all of this needs to be explained in the commit message which should
> > carry the appropriate Fixes tags (bb7403655b3c + 1da177e4c3f4).
> 
> TBH no strong preference on the geometry of the patches (could also 
> be two fixes in a series I guess?)  It'd be great if we could start
> grouping the sufficiently similar fixes a little bit more. Otherwise
> it's increasingly hard to make sense of the patch queue for me, if
> nothing else.
> 
> > Note that this upcall is not fast path, so the extra work shouldn't be a
> > problem.
> > 
> > Is this what you prefer?
> 
> diff looks good at a glance..

So let's go with one patch and two Fixes tags assuming Zhiling can
confirm that this diff works well and solves the reported problems.
