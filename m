Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7445C71C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302196; cv=fail; b=jaDWjHBvbep/sXF62y6oIDcJaKMigesZ93KqaHWY6VMXUMrwm7oalV/SA0QWurU530QqtAEtOl2bVgRbuejBvsFsm86ASimvdugb5p581jf5v0l3jVNjmVb7EJCfAvNhvkC+4rtfJPpXR5tsveZc9PCHNmzYYWxQMZfbhq/FNaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302196; c=relaxed/simple;
	bh=7c5LBemzTn8nUJWEvcTzFnJd3FZor7N8pXeKEw9J5m0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=otI5qQMY9ljcjrPLD+mhpI9XYKjM3EXZWEKvNWBCXuP/DyvHyQJse+AuCLg+IRxxtBlBsbARWrWW7S0JMtzU32aiBIuJzLAIcZ9gXNWsoEai8l110B1NoA5M/TEKJ8KkQBMc58yXffWxgzvDI8a7no5Bny+9C5RTNGCPCxoy3vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujglyjgw; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujglyjgw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/S5TZAoc2d55yYs9I2cplWgx4kax9Z6SOkodIWKMXL79aUfWL+bExMyIxW4vShulMjh5tXG4sBl1+MXe/4sGnFTuMOc0HU7t0xCoVELjOFCRjflohG5xf3CiNDmz9+p5+O6nX6g7823m1UPWpYHIzTJKF0VG9lmm/0P5P5Z1f6/EP+E+bCZwdQ+G/mnUz4vtWhtvgPJkfJOWb+p1IAlP2t6JzJId1C/Az7wb7nAGjoaglPcI/GDYa8hjCcaUp20UsdUhbFe8vnK1flZkBAm3WCrpMfJdHlYDe2NS3zcz4MCVJH9Gbw3+L804VRoK6vUHsBZHyL60v2UJT6t6I3vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApwcsWdcucWS0ZNwafNTstZE1vtVVMQOtyHrszxcmpI=;
 b=aG73eUsLnH/klOjLli88cY4P1R+GCdEbR0OcrT5q2UNof/ss/sxf/ADAF8eKkqGezFnOM8276Gd1s3vH/gSZSHbM4l14gDBoFzyeE9whTAzADzWO+jC7VTmh3LNIipOWwq/aS+AH9DHhcx5nTkRqs5wAFnhj9RL1gideQ5AT2VxNDU1vj5UHQwQ/0ADDkCDpaIIfUB10imFgD55oYGS9wg0wKkxoJvqhtYggZbBEfZF6oUh4P1DjQ4h2QXYoYxDS4wX2Li45cycTAhgseNghWaXVSlgY9SzjVjNhx20ydUrVDQm/XE8hWdTGOsV40NQh+xpOrppnPNpUKtTeEj/YeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApwcsWdcucWS0ZNwafNTstZE1vtVVMQOtyHrszxcmpI=;
 b=ujglyjgwhjdJFtQPwaGHNtpgwf1r+ln3WGeIM94JjnPEtpuL3bVFEoOgG01X0H7QH7wDBP8IvIMMrX/SRMf5d/Eo+3qrgam/fv92kpexg2X76OSiScJMqje9D4vN1zQKcTevE4GH/iHYrk/wtnPsL/8sZ6u7hBIi2qsg6CTm8tw9ElJt6iPoj7nDkfOFbwSOUvtY+OxPilz8mS+cXc4TUDEaX6roh6BEStu4+xvOsjlOH5GGrA/V0CZjb+qPfYxUhhZkBj1nD6pNXGfBMNx5bf3OpiK9dQB7GV1uxsp5JSKAADvYFyLtUNEptbyPpgzp1U2ju6pE7YJOBuK9tgU6Ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:56:30 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 15:56:30 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	rostedt@goodmis.org,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/3] Report netns cookie in FIB lookup tracepoints
Date: Tue,  6 Oct 2026 18:54:51 +0300
Message-ID: <20261006155454.853588-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ad62eb-df53-4bfe-a181-08df23c262cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LD16dtXk+Jdy1wHSpolY9MihC2Vt8jTXZ0Pk4+J0zQ2Ht0/IUN3zckHHc8bpzr40eiqPFC9A404AlTlzJ8iuZAhObW2ToCW/3GXAoqFlG4PiiWaD1/8ZrdorKbKX1lW6ASkya37YIrLE4fbH4JJeeO7HIBjZK2ZHcH5Z+qtYUVcp+j3utx+SCzN6wyfGIjnJ2+1vy5HJ2pRtIOfTq54Nsg4STz0/cPiGKyNtGfK3uEaOimQEdR+pG8CwgZyQL8YC4X54vV17zZEZkTcFHriDR1On5Mou1duIsryWnDRC6jXSgVzhD8cu+crJLXpmVKwZpY2f/65pmOkZM72iGNusxQqVsZDJQ493uzDzL8PMAoAxkOewqNhbMIbHEkXtHD5SNh1eZavm7d7jKCsmLpaTJsyMDGADznXHwSWtzmBsk1cZ+6qtXO4NfSqlbiNbNG2kkzoTPB1+Y6upftjyHvFQtMOO7YpOt2QRC0tA9cKyoCvPahr96j1Wdsz5Fk+1BUcgQJZF240gXuLG11GERy5ZaqcueaDCDSAOnN2/uQAuaChjZwUcm0YrXrjNJBh1KUqNsb8MWfJDM1R29WE/dwqKQW6Mh94Uu9nWvhcWmJLRRIm3Fz2AhNVs2H2ONBaOCXel974me1a7bFckQnmQrvmIQs4Q/akN2VHIAHD1qBziQGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTGJJVFLTARwTiANhFYHc5Jd47fTXHIu5QYdBYh2K13mFMVG6yqFprouM2f0?=
 =?us-ascii?Q?rT5WSpcjMzj2OMolbNVk5rCTgLR77SeE0H3aBELDYCDQh74Z/YYn6TBXikuB?=
 =?us-ascii?Q?jIr4RnESoSKhg+vioPhNO+LEwEsXvnWUL7GGuiDhaNcZaUA+s4WJHIyWk2wF?=
 =?us-ascii?Q?XrhTvxua70kpWO3WRGUM3rpWx4GcQdBv+P89Njki0XflhNcAcwWvX9X100PJ?=
 =?us-ascii?Q?zLTMQk7zfbBOlY22r5wIfLhjujLiZsZbYbTwmAylIJWJscQuyUNyKPxk2tOs?=
 =?us-ascii?Q?HLWqykbC7aQPKsvMyaR7AJNwluMHuUDnNI/fZ6PliGpUaVlQ0LdfvZmPq/8p?=
 =?us-ascii?Q?u6L2+Se3JIb0zGZ2jDzrlBvjGXZmDesfwha3hXFM/aoEyz8nY5YUFBaDmuh2?=
 =?us-ascii?Q?gCEb/Q7uUbZs/JYGMszYoMtiYWym2eFRF+HR9EZETvKFwTS8namfpwzhFU4S?=
 =?us-ascii?Q?6e5Z/lvBnPum1StRWyASYUa29gb4lC0GTpsR9Y89lFPKLRkLhVMEK09zPdEU?=
 =?us-ascii?Q?Z4+f9iSRFTGVDPU8UyPLpkvfgBiVGIQ+jjpWcfjSW/KATzy4kT/qyHIUFzGK?=
 =?us-ascii?Q?cBNR+o3+5Uf9umfbAwIK6IdAO/R72fY/hxaGOzqi03eLMK2MeWeb9fOUzCOG?=
 =?us-ascii?Q?21GP7VuIiD8LZkk8d6decH2W8HV0GPNYynLjnGtpy7VDxfxznqEDVtWfVdDo?=
 =?us-ascii?Q?dEo1Ls2PrHVQ8Gw75kJp6GSbitZ94RrkPfXtFjqG5l21cY/sGdqJeJERREEt?=
 =?us-ascii?Q?0b3htSh31tnQzowrS0DkRKWysZ85xIGB29IX2tZLbBKGCNDIwpPnQPU1chbh?=
 =?us-ascii?Q?HpvEU3UTBKIwOkpZNEVVYpG5syCGD5FbhdywK8Zn7/5X/x4/jr6bqGY0abPw?=
 =?us-ascii?Q?eBquGFUyslwLJKMGRwA3XrLRb/Qjh3htrjr4cgKy6xPjphWfQqPO4tnrdRdA?=
 =?us-ascii?Q?6s0Sf9oKGJPnSHQ+XrvyVzt1xdfI5m5HvbOG90klhf6NDe0dSf6nj2gFmUJi?=
 =?us-ascii?Q?IP8I5GkB43uPNsnNPqcJwVR7s/uAUa/OK0T09OlAUBQPuqt1AWZfnOsKaXm/?=
 =?us-ascii?Q?Rf1ttHCceytoYKfa6NXky5rMNnCGqoFbtPNOTy9DHKR0lNf7u0q0cWhCTs9i?=
 =?us-ascii?Q?NU9avjy3NERFqnnkNxhROmnpFHr042v9hNQ1iw3wuFONcIFy3RhUgZ0WWOO3?=
 =?us-ascii?Q?SxVONg0vmxT3fgucIwBO6O+kTw+NvdKHfMYiBE7E0FYruM5R/X9EvJxXhkXA?=
 =?us-ascii?Q?YhZQI/zzxHDJEghSeg7l6tH64fDpO0FqR2aTtdQTC1qvBUFduC1w9UFlGgmU?=
 =?us-ascii?Q?g4xLUOJK7pJcfOt3/DtTZh4bSRVQB9Jwep33tcyIsM5JT3JdUoluKn19PEAX?=
 =?us-ascii?Q?C/SIC8DJSLxp3XO9u55dKsd0tF9X742GBqCnWeJJ3FXa3CGyh2E/v25JtR1U?=
 =?us-ascii?Q?X3kcfAesqRWBTYYaTB5uVlxgUVvdeKqvuGpEdwhf2+G3R3Man/luKKgEPC8a?=
 =?us-ascii?Q?klgc13Go2RyB4EPr2hryh7rOFvanqJpCbG13wSSK3OAV+sikN/FgF+hKMGu0?=
 =?us-ascii?Q?zZaREhxZJzBKVYExfckLfZpJoWGARSZxROqQrHnhlb0Fi2yPJFVRcWrMrNvk?=
 =?us-ascii?Q?KmeNMFN5FpAKMn+5bPKjMaG02WzGHQdPt3T9FshA4oLaf9ytYumaAlUp9Tqk?=
 =?us-ascii?Q?urW7Ck1WnTXyaGA0r3YjdzTlVCz0f12HPfjujbWOMvSNC8mR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ad62eb-df53-4bfe-a181-08df23c262cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:56:30.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMgzCecUn0qJGhvvWLzkJt67m5klgVxJkLlxzg9nIRLQMbbNG2Fo7fCEuGORJTp3xYfzDsCLZkGbu7WRTw98Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

The fib:fib_table_lookup and fib6:fib6_table_lookup tracepoints do not
report the network namespace in which the lookup was performed, so
lookups performed in different namespaces cannot be told apart. The
recorded PID does not help either, as lookups in the receive path are
performed in softIRQ context.

This is a problem, for example, for netns-aware tracers [1] and
multi-ASIC systems where each ASIC and its ports reside in a separate
network namespace.

This patchset reports the network namespace cookie in both tracepoints,
as commit 27cb3de7f43a ("net: add net cookie for net device trace
events") did for the net device tracepoints. This allows filtering
lookups performed in a specific network namespace, for example:

 # perf record -a -e fib:fib_table_lookup --filter 'net_cookie == 12'

The cookie of a given network namespace can be retrieved using "ip netns
cookie" [2].

Patch #1 reports the cookie in the IPv6 tracepoint, which is already
passed the network namespace.

Patch #2 passes the network namespace to fib_table_lookup() and from
there to the IPv4 tracepoint.

Patch #3 reports the cookie in the IPv4 tracepoint.

[1] https://lore.kernel.org/netdev/c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev/
[2] https://lore.kernel.org/netdev/20260923161756.2914560-1-idosch@nvidia.com/

Ido Schimmel (3):
  ipv6: Report netns cookie in fib6_table_lookup tracepoint
  ipv4: Pass netns to fib_table_lookup()
  ipv4: Report netns cookie in fib_table_lookup tracepoint

 include/net/ip_fib.h        | 12 +++++++-----
 include/trace/events/fib.h  | 12 ++++++++----
 include/trace/events/fib6.h |  8 ++++++--
 net/core/filter.c           |  2 +-
 net/ipv4/devinet.c          |  3 ++-
 net/ipv4/fib_frontend.c     |  6 ++++--
 net/ipv4/fib_rules.c        |  2 +-
 net/ipv4/fib_semantics.c    |  2 +-
 net/ipv4/fib_trie.c         | 16 +++++++++-------
 9 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.55.0

