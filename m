Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A9414A3B;
	Sun,  4 Oct 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100967; cv=fail; b=GA/tHbLLW7ygRLIj4xtObO342qsS1db642RsIwyjSVc+4LFfdSaNLkEbcYb25m/p0l/gpMX05mQDx/mU1SAypNWeDQ3LfvgJEIheLvRRgLeH2RBkqkiBgO3Ka0WvlFnNS1M9zP4fj1IHstbJ71XivFIBYazydAYkVPes2krySM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100967; c=relaxed/simple;
	bh=vfs/yJYtFtoruRJ2jbMiYIEsxe4t7GZwzHuFGrY/TbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/fknP8nzk9gJNj14pqMZhlFIwKBKpPFZ6wy4fyFbLoKimqJIu7FTMbeQV+sFHch3MqwkpsFD+UwShXjpk4fSy17IPVno3joawbceAU7n+KkcY7nzvidFXwZyB8j0vTpUWfqJF7WWIfviZrqP/vWTOBXSHGfWhBhmv2hnXrG6Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mn1ai1G9; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mn1ai1G9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1mXi1MSKa+s9vL+pe2Yo3ffME8rD4U8F10aHYfPxvMjPvhhMODSXnZUwx04i758MMoC0HmxozHPuTkrAWzYnlCqormHwHZ09vonMUiRs3orkVm7xU2C+9FCflwOuQxPZwLHz3wzRSGlciX7u9r1Tsgi7yWDqhHBlO6QSugn98p1RdN7ByLcUQt6tqRpuDPaTZS14Tqj87IY0MkwhNKZgMZutXATVwp7k29CMxVLEROLYcgOOR3SN98s7mb0Q00zRi6fui6obw4Om3ppjI9mYTBolEZlZVw13B3sj0dAtT4CCBrgTB7aivz4jBVib0mXEGw+cZI7yGSp8zEARB4HIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RmuSFYJXzpfx8t2GYsyKzDDFvLcdOSiZkcw8l3ddTk=;
 b=pldNIJPUuoMDPnxx2uPhOAse0w2AP0Ax4q3fyCtKO2d7L5syPRz9Z1aSqDlHXfRWr9+7eM3rlYkyQPUFZm6/X3ELEp2YlCtIyCDFjcCimmyGAmsxfiLp2jh3VzDoef7P1jkZW9SrNw/6iisEnyNZcv9ik53xuNXvDn4kJQPAOgVYfZh7bSQnE8LtJMw2sPPgHKL9X/pfEZTyoKMp9wtsCpbaipnl1iszzqcv0msr93I5TWjVKGtRHt7DvDS84JYwKHmkW0NNe/PI9IYrzjagGUUiz5BK9XsLKxTcP+oUVE0fLLfC7yoxBwaIB+wNoZDuLmNFhrGvcTwLGdZFz/SufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RmuSFYJXzpfx8t2GYsyKzDDFvLcdOSiZkcw8l3ddTk=;
 b=Mn1ai1G9ZwPxGdAnWNWVMLuC1Md1KkXzTiY6Ev5eqGNnFrlEIl8RsUnb0ALj0/xQO3RNcZICmTxEcVVVikfx/GQERqgS/DTI9kVHksiaQ6ofc7Y8wm8DVHTBGL6kqZfxcN+66w50GsY/z2DVIlcipzsTU+I8tCydF4nk2If4zutxLzXOrB8VQgy5K9NyanwFICD8q+Y/4CfxBR1Ft5KnrwFc7ZLSfPlejxO8yICVtuuJGshy227y3rABkHy2ozwqYOore1xIZFSSVlgGouDYInhieAMRzTFw3672eEvtWzizeFqk6SaDNsqkfBC82Mo+4ybx7G+e4MaIK69zhZMBQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 08:02:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 08:02:36 +0000
Date: Sun, 4 Oct 2026 11:02:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] ipv4: stop exception dump when nexthop group
 shrinks
Message-ID: <20261004080228.GA92032@shredder>
References: <cover.1790915964.git.4ncienth@gmail.com>
 <5bb7bd97411eb9db454464bf449107395e760f26.1790915964.git.4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb7bd97411eb9db454464bf449107395e760f26.1790915964.git.4ncienth@gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9ec4ec-c986-426b-1b6e-08df21edda25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ym5e9DwGytOFjH3rudycAi9JDSwTFSk+zg61FsdowztHkXgYGHVUcqRuYZkIOfuw3KrG6KSiMn1BZrWXIoqW4JvxDNdpuZqOEWE1KarAHvEhKLDdXcEJfE9BSZcwvLCPNQMeOy3no8gd+N8VSm1ghZV0SGz/B7HKlNMQrFqBQZ4aGC/WbXiMxSpMhnl2fB2n7BVE48dx70FSiVQMIsZJdIsDRsJu2zt8yY6QKfM/ZCoD/k7R0+SiFJ0FW4kNpebwdO+GgCqZgndeSi72H5sbC/K/HDI/56UqhfdY+nZxE7AlGV+O8yt/OTNmOn2t7fCHWNxq5yOv07lC10x4x7kG2hHlZ8shZX5SIz0MbTUt2fbwLyTjstFgb7k0NkeaEM24Aw6KCwZzImE6L6rjJ86R5kjUzLb1GFBs9hlA1RWATZdqo2P0F4Genl7Y48AptegcWEQ9yS18EVTwzsMIoyXx0AD9exXDVF4abb19LtHSq2dWKmNEHIf/50GboryD96CxLgp7+IIeSsQ80I5l5L2v6nelY+0E79QIaidMZqTlxeITwyxdIgxSXWLiTTmS+mkJ9b5VfiFWSSbSr9SG+nVu+XOKNgAWOHRUxDbZcKA2XwJFmyNLhwngrcqtEqyiTaxhHppRBo9yHP/RNK0/3/rrPI5vG36YoreTv66LC3l5MDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WM94sDHotQGofSPFJSbPHyC5obavGF6vlKTLdYdJTCekJSwfUkZKk+59hiI7?=
 =?us-ascii?Q?JTzyMvTDymd8hS6rQ3lyCGXFIOwbzsxdUBeNY9w4+t+POTEfaxA17k1kmGMT?=
 =?us-ascii?Q?vQjP0h604rR9YTkzQdlEMVBf8bog6MsDuDjBN562Y5LAFwiiAKKpb5zi5k7g?=
 =?us-ascii?Q?18X8Xxt24J74lHYf86j0OCpfbl3zcjcr/FRjz0bKwQyE6VpQQX8LrhW7XnSk?=
 =?us-ascii?Q?2s7Vsn7VdhaXyfsV6HUKnYTUcDk34WpnjiaUvoafpJBQlptkHjC9lg8m63fC?=
 =?us-ascii?Q?Vu8LhBx0BFRlFCpinnLxOF+fBKl5Gp9YsZc8il2XebzjZvwBLg/4H66nuQEX?=
 =?us-ascii?Q?alKcYwz5ruopC3JPZhooDyfMtW/qtl3VbX3R/sxbTbcmqQgGTXs02V0ScLGc?=
 =?us-ascii?Q?VTc+SasDFqJBXs3CzXOiMuzfMqegvKhHPgpbCF0LS2aZBIlotX+v+Y3Aoin0?=
 =?us-ascii?Q?mX8IiDQTkgF2h6b5zsugcFzDmVQPhlkdwdCVc23fiwS/XXckHRsWxJpzXRkS?=
 =?us-ascii?Q?l8p8a3fFiVzEiUsRnA55ARYUeJHVo3pF/VTRRxB5CVpCgOCKYYJtIrMVypk/?=
 =?us-ascii?Q?+xpo5aCGNpJ+3zV6HOF0Dsmhr6LUB/JI41hk/cb/bQBbNu+XI73G0UrVFiEt?=
 =?us-ascii?Q?a9Se2iO+PiDVPgh/VeePwrvGoxNIwNZIMl4gkRskhZmKGMMTl3+C0egAhHL4?=
 =?us-ascii?Q?ln1xIS7ca+KsFSdZrkJeeU/hmUM9Q45D6Xs//x5hiH3w5HF2gByH9XeAf5IJ?=
 =?us-ascii?Q?iwRY5aJ7Nr4qmuhaCRij/UFODhJibUGWdry1VuTWuFOhLUZs11hZtGuHza6R?=
 =?us-ascii?Q?D2PZtPp1X+3zOkKuqjE7LcBskuIBQCLkQNal5VyR7QgdVLqQRuKSqaYdBfad?=
 =?us-ascii?Q?V7DUmgJ3DQTJGVb+/ihJhgjmlv2qUygCKm6lAT4ROVMUz3QCFG8QrH1MN2Nb?=
 =?us-ascii?Q?r8RZy+4o4pYA1stpKPjvagXveG7w4xynEVHnj5bQPQKpt+aVcaDfMoDYuuJh?=
 =?us-ascii?Q?/bUhDAKq+2zuS5EXRYLGNS37uh7mJ5FGw9zNTMbv4JaPX323+cXxv3uw14Tt?=
 =?us-ascii?Q?biKY454+F2APJbws5cVslVeBDXg1x5IWf+f+adejZpgxKCtE/+W4jtWMBQLp?=
 =?us-ascii?Q?9BkZArg5t5XjkaOKxwAb1besmjg5XVWJGwX0h89A2wxhv7snK1h9Ep/boskq?=
 =?us-ascii?Q?IX3lpO02Cg5z/fBKCeGjv1jIdnzF8oyyVd4WBLQENhPdnXiI4w4/IT7tjqWc?=
 =?us-ascii?Q?9MEmzm1ArIB70RhbWs52HxD1qe0Gh/pHtdoZFWKYDA68/uyxg+AoOwsPoCp9?=
 =?us-ascii?Q?SKW7eDXG2rjKKonshh40T7Wl8y1FgBTPE7wZnPt28iYi4kTNY0SEk6VkVVLm?=
 =?us-ascii?Q?MKNqnDXeuKMbSIDk1p9SoRf+JldhGVUPFsn2Iiey2SgdSOejLpLohnVUYH9J?=
 =?us-ascii?Q?GyTJLYPKY5NpziX9cmXQZE8t1LMUkZJf7NwYoIadli1aGwlD2xZdcyo8UZQY?=
 =?us-ascii?Q?Ozy0DElXMoBS10zNnszlMsY0IlRvsj+Bu75dk6u+hA51EQADH2IUPtOZUT1L?=
 =?us-ascii?Q?TD9NQsA5NRNCJ77dhjPDdGX5Ffj2LFFEkREAnbVkZKsLGg9cjLvwQWGMFSc8?=
 =?us-ascii?Q?EnsFRww/DnnQFaPp2QwKO/4OwxNW1ptICHGG1qDH35twu4VyLcSjQq71Kqz1?=
 =?us-ascii?Q?NiXB35xxUyneeRaIR8/yx232oDu/mzrBa9dpULo/egsrsEqm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ec4ec-c986-426b-1b6e-08df21edda25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 08:02:36.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JSCQPOWc1rXTwPKqSlCEkG7x9tUtyi6e4iy/YGfNezjgr2+rkL4nBksobHV2ZMpkTNWmKbxUZBftEoTrZGB3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

On Fri, Oct 02, 2026 at 01:50:59PM +0900, Daehyeon Ko wrote:
> Commit 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU
> protection") allowed IPv4 FIB dumps to run concurrently with nexthop
> replacement.
> 
> fib_dump_info_fnhe() uses fib_info_num_path() as the loop bound,
> then fib_info_nhc() independently reloads nh->nh_grp. If
> RTM_NEWNEXTHOP replaces a group with fewer paths between those loads,
> fib_info_nhc() returns NULL and the dump dereferences it through
> nhc_flags.
> 
> Stop the walk when the indexed path is absent. Nexthop groups are
> dense, so the current snapshot has no later path.
> 
> Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20261001170513.GA1657889@shredder/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
