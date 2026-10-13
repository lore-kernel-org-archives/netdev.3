Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84D33B6F8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875795; cv=fail; b=l0fbi4yNRPRUPfYO/bZhDW1mvshfQbRuNhHxso6YkZxSS8nU9NBmkDt2dXsmKXd9pP8pbcCeUmjGlWMUzTwMZTOmd9G+hmLput8U/gevGMXDRNKFcTHq7kFtoumrfWRASLnBXt9NhxbgQITcN+zlY7zieArLp1FRTZj87IfUdQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875795; c=relaxed/simple;
	bh=I0nW2nyzjQhWflUbLjKgVhwalI2xjrc9XqaJkXChMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jHrN9uO8LDOMGSiqBaQw+3eDoDhZPv1DooaAek1DFE+1IRL3R1f+knVMiL8lMQpfBw0ioHU8J76JrOYoRoPUiCbBwWYq3T+0Q3bzSM7JXUmMqpoyK4M895dC93UFuE7WzCfE5C3uTJAtSD8PReQJHQVOefLN8G4czNknKSlUfQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9n2uZRp; arc=fail smtp.client-ip=52.101.57.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9n2uZRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQeEJRZhyFra+RIiyYsVLiiyUL1dNDdnC9nL5v6fXZ1qHlZi4frUfin+FEqYxsKAHnCCngyopnSBbdk3mBqz4xGljRHZPRoeV/BEalzAl/7lpx4xcx4kPrA/MJEPOTva5yW8KNLgN+OUxBq+qXghkGtDrGyOIMH/4eEsZmxO9Dg8gydDGfot7eOIx/1skm2ACHHQAsi11B8pqJWq7zyNikMTYKXxLUawrqvpDjEaxWFTITL7T1tWiSnaOms596/XawHXL83Zv73ISAJXzpD7Mp7zklCHiDVCc76QNDCbUFlJjFAZc5KIQgZBgxFq5mGdtpM51i+nakptCSrj47nf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOoU0zTKrBYP0F3kVGBtDRRsoHX+/hgycNz53eijaG4=;
 b=KImk+cOeRjlgevDlexQUsK1y1k6HG0+jDY6dUX9NNvK5Z6RbiceomEOKRQ28TfOfPCSsHZndxWD6zyWyIsiQuJz+52DSaZBwNkbB/Hf3HLBZ6s/z0y+48CweOFF7NhXXjbEmt0WWCKmkAd6VgNEAYY2fEqMcqNfnyGP4DdgFeTge2K8VXdcJ8VwrfJZHs4Q1k0SgNOyR4J34wUcJtagntw0ka91MhHdFwDzIPURG1NO76XWHEEBP0Gzb6xWOJyly+wQarck9CP1oAfXzB7Blt41QraDzMfFXv9lUVCVN/hKAZDb5JcFNh/PX/naSHErqG2/3t6/OPCunHGDb/g6XEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOoU0zTKrBYP0F3kVGBtDRRsoHX+/hgycNz53eijaG4=;
 b=W9n2uZRpyjUtDf5TVV7lw2jjw/MQOgAdIrPnhh7qzC2pbJvFBLoprPhKUDnLNb+ZDZF8AqZf3iO4qqVDnmsH00tj7ARArbYkRW4HvEkhiWov5B7fE+ePbu3+E67GnyM6zeFZuCpnGozxdCqwnZRo6ETUO/5i4A6cZBBJuvHENPf3M87IxhSrAv+GjTzt8Jk3MBI8lYdWz4E9+UvvGOZ6PftSj1nFCVvYdb1XqTBQiPcvexWgHzMpFtjhubhjasrhzqrAgD0VfuA6+o6G+U1couqNjJnVVMUyXmjflaQeHCk/R1AOsuFp52DHfyjeZ0Tn4lqoeqf8+yFAqUaKLpfbjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:16:29 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 07:16:29 +0000
Date: Tue, 13 Oct 2026 10:16:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS
 at 1000.
Message-ID: <20261013071619.GB852441@shredder>
References: <20261012194530.3751034-1-kuniyu@google.com>
 <20261012194530.3751034-5-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012194530.3751034-5-kuniyu@google.com>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: c876f95a-5d9c-40dd-8386-08df28f9e69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XwXYkJ+BrJQVk/FLYhd2nBhoRIAgTSOsPtjKO8HWyOrS5sQXrhxCqGnxLoevxFEoqOXf6XoUEX1wld+7Ql8vjo5upQMS+pzGRWeRwwHQZ7WM2u7zHciy35GWkcJfvdZrBZoi/ohtrlf+2hzrbWQQNk/4hMRS4NYSVMrpIsS58viHILetzlXpEs8d7+9+zv5MmSVVq/DNpfDkwyTBq6PPH5e1VVPDDaVkcVEv1LspGNWAITZhmqWnr8ZXJHQ/+3DxYzm+DQXCLsnu2PIWn2v53aaoUhyABYTMFgUmaQYSadVi21t3B5jBXq3E0xtS5E/EqloM3roY4oj7sxh1G5zvETQCfHT1VaRu8feXwMToh6olyUzA64A+UgmWwdxBQUyjp962gYoq63Xp3EP6aOoZsMmMBum+xRKvj43UH9Rr5t7YekBnAQnML+XrLhSKwfkrfKYJjNXLiXG+IrSgP5n4mJvPe4XLJNQTFz8J65d47gWvDreUqcl1GCOlBLeHsPa9lSZmoOiWFRCb3O2fya8dQ1XPUD1Plvw9ZT+xxkbU/J1vT/a7rPH1X3JLaLpe7kFimuKbclruB+G08MfVim4HpkyaDLOGHG4zksDNE1ZIhiSShHb187LaCgoSoRaFxN4v8+Lc5KbVvMn8EZfmyIrLObUUZRPUT8gfogpz6axnVs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IY1nLuCiVGLXsN9QeQ0/8bpWPohVVgoQcwVMAlHTVw5d+lkP7XPkoGetfpPY?=
 =?us-ascii?Q?hR6L+RPuYTjKRfk171n/bEdk0gk6nQz7zSrCPkTurju8a7RTdm7PVqtmbTUv?=
 =?us-ascii?Q?aipnGLYHWfuzsKuImorAjf/KDDJ088WH8Ik9fYyNNu2sfV3Jwnqe1HYq3DyV?=
 =?us-ascii?Q?bLsuym6H8wcZIm1zhqto8EtDUFxp133KzE+OrKZ9fm6iuiWzo/rEKq5sRJkD?=
 =?us-ascii?Q?Lr9An0humswKCHvqPQe98kx8j7ozHPRUuj3r7zd626V0TPmE0eSFFtEVtNEN?=
 =?us-ascii?Q?/iOinmJzrmslyqdtbSqKPdv+Vu6D43OwlfY0jcXxOW47PC8Nmi03rYBpMd29?=
 =?us-ascii?Q?9BGW4xcRpTgEmCuFMZHnnOj/8igqqg3XWTT7pL5OjaFLNBrzKTwJiQ0oHxqi?=
 =?us-ascii?Q?uXu5d3iNejyDvitI7Aga6P21DN0rUhn2NSWTSfm/iW0FN0zutY5/bqC0xEDf?=
 =?us-ascii?Q?QRocwgBJ1aLd889IIp++2zBKP7d6qNgnAMMSN0N9KrCYnmFgN22wwiPUJNxo?=
 =?us-ascii?Q?hGiBdiswkCZPxPKgFVwmhFk2doZzn79wZ45TT0NKloqXs72A6AleIApesRdf?=
 =?us-ascii?Q?6pbIgi3HV2jK5TVpkKAtsTCoUGZ6lIr3QF3qhOgL5+7FUPpEv36AU9OeONRF?=
 =?us-ascii?Q?0eVXfh4khGastWSnJDMd8hDOaO5zEyaosi2Eq4UlRUe7VuAggbS+nifvW0zG?=
 =?us-ascii?Q?8GL687Oyrgl0q6vHGBH/ug6aGCvv5tAlcuEmIfd9Z4Q8tslaSfNU9+S8ZXut?=
 =?us-ascii?Q?fVfo3msYCJUqiGaQ/4ET9fiVCg2faULqA5mcx0kCCCyBKMsvTn3uzvGPY2CC?=
 =?us-ascii?Q?/t8pQQIMFsJwDcZcBOX7wdwsPZYK1yEE3tOWXeyUYiFKcONKQpTgPL4TOax8?=
 =?us-ascii?Q?BukOxlmvNTflZzoipznk+DC3I+2woY+yLuRO6jR3aDPx4ORZGmYYIMB5BbsG?=
 =?us-ascii?Q?x2TRCn0qeKA6GCz6tvh5TOWMw1ile9gKZ0ItIppHzIG4PZfPGrp0i1ZxUa14?=
 =?us-ascii?Q?1BFHlS24+Nx2Fe64mHyd7pXoVlg3+dDtAxnGPFXODnErEG6hpDOLK2kz2AxM?=
 =?us-ascii?Q?xHwHqZ2YSmpqCnH9bCN0770Ij1otfugn6v6tdUoD4Py7yNi0p531bLc5HrlG?=
 =?us-ascii?Q?s75PPKLQoOoh6p4YvYbDI20cgvpgDofweaojobzpFAA0oTFX3QkePBkc4Opk?=
 =?us-ascii?Q?8LgX8SXZ2JPRioj+btTQL2rgqJ+9+37RrPKmWhFJtkUDYskkDfSppl+zzZgD?=
 =?us-ascii?Q?9+lW2S6NRc86F7u5zHOYrxlFl700brhnoo0RDU34FbZ5XEQhRfsVFiHQ4agf?=
 =?us-ascii?Q?skRMOAi/xGQuo8NT4Ls4mUTAfIsNMujfAUQjq3yldkbogTc8bleHW2idmEW+?=
 =?us-ascii?Q?dKSUNvtukLmlqk2nDuRB+a8H8qSM54iZsQInB/rfhVqwlXja9Kxhn9vwwTAr?=
 =?us-ascii?Q?0j2GbBXaXvxrtP0zy9pplN+s9wHH5r03EJnj6pQFpL13SCKuggWAgMxhrCY+?=
 =?us-ascii?Q?DsGqfWJqj+M4Q0LuZx5+pVVG7tSadgS9wRyk0rWi1hglWK6QE52AED9nAI/e?=
 =?us-ascii?Q?U8Hq0a9noMfgJcOcwrmSxvgZwT//7yRzMrCaV+5pG4s0qXHzD1HQqu7ypMVj?=
 =?us-ascii?Q?h/gjP24x6Wc1/0+k3BU7+L0o6zzYNmeN87ObN2fwHHxNwWn4rGLnF/Z15DB5?=
 =?us-ascii?Q?xOs2sejLyYL0K3dN2trTOB2QjLArSTErjDqd1Vh7ginL4A/S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c876f95a-5d9c-40dd-8386-08df28f9e69d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:16:29.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSqB87sYkOCiyNcF7MHW2b7ixiRkFgAz8agxEfHcnXWcL24Kqy+aYzXCMwFXDo/s7aRvAJTPyD6UpBiLkreN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

On Mon, Oct 12, 2026 at 07:44:59PM +0000, Kuniyuki Iwashima wrote:
> Previously, the lower bound of INTERVAL_PROBE_TIME_MS was capped
> at 1s by commit ed6cd6a17896 ("net, neigh: Set lower cap for
> neigh_managed_work rearming").

Nit: INTERVAL_PROBE_TIME_MS didn't exist in ed6cd6a17896. It was only
introduced later, in 211da42eaa45.

> 
> Later, commit 211da42eaa45 ("net, neigh: introduce
> interval_probe_time_ms for periodic probe") changed the limit
> to 1ms.
> 
> The limit actually did not work but was fixed with
> netlink_range_validation by commit 6d79b223ec44 ("neighbour:
> Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.").
> 
> neigh_table is now per-netns, and a user could hog CPU by setting
> INTERVAL_PROBE_TIME_MS to a small value.
> 
> Let's floor the value at 1 second.

The bot will most likely complain that this changes existing behavior,
but:

1. The original floor was 1 second.

2. It is unlikely that anyone but syzbot is setting it below 1 second.

I would explain this in the commit message to suppress such comments.
