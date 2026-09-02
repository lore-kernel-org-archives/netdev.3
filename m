Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A849F117
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355761; cv=fail; b=ZTAUkN09Tv52+coP3vRwKo0rApIoeEt7oxHO5W/h9VyVRYuOwWvg79WQyQ+zi6Zx9F90o1/N/q8HhWNIZwrOHpg/JBky1ROVp0nCpGKIAEUBTQw25I8TTLffFSobu+37788pOoCDiYfIiIY26hqj1JMRrlIhAv10AcxXOA0s16M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355761; c=relaxed/simple;
	bh=856SmpW/OZ0DimmUmVtoBabR/3JrZD94e0b33aZ7jbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+iNGbH7Jqjjt/qwEp8//ikzNgbLnmfhNTr/Iq0HDBwFs3HpUhrobOed6dzV8tXEB4ySRvhe+wO0Zck/EOvqozKn6anckG5kN+Ays6XgW5bi698DkJEIN6L0Ln3RF03sSnjUgZrFDxYWtESG88Ctb5eSSH9bg5eUt1wrej4EFH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SFN3gz9l; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SFN3gz9l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNNxUbTbnB3rWjMjFFyKCq9mquTBi2PVmHSrDHA0c3E+7d2PqURQXPPmEf91omau8NAWgSjdJC4OHBPaMzVjtbqhH+7dV+GOrhvwsL6uDn6VXPuo87yfaFgH59bcP4ncxRolAYmOZ1ajfEH5q5viMQSvC8lQIhUwbW/oyrw7JDgu0XmW5EUKYgq8GziSi95N4IjjX1zDu5/Gc4LZQ4ZNDSdPJGwRpDDvZXMrDvtYkfninwmmdKSshccb3xMHYJtwEhkMxukZLgI9NeJiTHqbBbgfFD46WHsDLNcYWPS1fSOS22ZzzvuMaAYqp84iGez2xn1psq64AhP6Gg/RFTV8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpHfhvq6ceI/TofpPk5eyk1LUaI+qt/4LF3js9ssgE8=;
 b=YYDOpPDJ48OHHDLVKWPogfayiqgse+a7C3mPFGlGP9gjMS8JnhnbtbMu8asYxbzBriQlIx3fieXDwbyEo1PhPeakdpy9Yo9hE4HozTE2NqONSpSultQlP5GoMkpuqXDaD+6npMvk2/UYZDUU8DCapJCMbifO/tACH40KVD0Rn5q6+rWQe5OZ9ThXfSn7ZW42QKPshD3gzR9gzbliICKpeTfV+3Da+w31ZqJn4Ysx1AS4VrWWxDA3mOhTlxiQWC1+ko8HlleVtUE0BQZlRXGBmLIsMg0v+C9Ow3umT4kUcNYTwZDwMgnTko1yXHI9cJSETkTeY7F8W5i06ZPzNM7TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpHfhvq6ceI/TofpPk5eyk1LUaI+qt/4LF3js9ssgE8=;
 b=SFN3gz9l7j59HYy87YKnvH4P95RjpR8X8NwWhBvvAZe0QdetjIdnLOWs6Z/3UYzHI3YFh0Z/ejQ2wUVC/2D29aB0XoZW+Bv8TZMvSiOeSeqyEm18wBxz0psb+O+3oSWwngDz6DTa5bWLJ0C5RM4NXv2fTMiZJT/HVmCwnd5P+8Ktnlmr2OHogVGs1zwfhCkQ7NcSjY9Jlst/zHZz1WZHYgd1OMse9GF+BF6Cj3kehWicdBYuSOip/0RHzSIpOgJ3aF9XeGwlbOBqUEOxu6vpe1k9LTp+hK//8o0DOXToIe/hUfnPhpS9CK1VHqoMgNDpbjuBNnp72Q25IHPj9ttZOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:29:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:29:15 +0000
Date: Wed, 2 Sep 2026 16:29:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH v5 net-next 12/15] neighbour: Namespacify neigh_tables.
Message-ID: <20260902132906.GA3929399@shredder>
References: <20260901183327.3332855-1-kuniyu@google.com>
 <20260901183327.3332855-13-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901183327.3332855-13-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c03a1f-0b25-440d-9bac-08df08f62f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HWJzNbXl+Y/lhMXLAjfThoO1fycRPJvWTfYgJL3q2f05K48wKJnCdswCDpv2J6FqbZltOdllcnz/8riRPfKiPDR73BW2XkU1K+W3N1a8CKB8WARS5r+rfGW1BgvA+OcJjv0NW12+4AEl/3c/KUfdnxKnnX0fd54jbKZJoJ02GNnqA0WUPHnxL392CvlOMAY/adr0i34Yt661uXcY+u8KXKJEXyraFQ2a/tm9DRpkgO5wGYT51AKkhq4Lotg18GNYXixI46ZrK8ZMzW5hZcxghCAovGcFsNVjYfxswCQmYdl15JUlaA3sKZIGu4B1SuxytMh7bbtQfpMQLHxjJHn3XDS3qkUypnafBmOrZNHe5B0FyTmMZyQxDVHZNFqFsH8jEPszf57TJuhJ+GNFmJd7KVtQzYWfc1mNT/+QSeG/Zh9wk5ODWaR/Og3KktiQtIG3Niofjyzk6QVCsCNKplRm8hovYj29byFKLVJ0UqQJ5IqP2rcPjJIhGBtsqjG0PyYTsd/mIs2zNoQaJ0D2mb+XgEXRUd5ZQ8J8KvotMkBY8zXnU7+bGnY5xsiC1Kq+KLBNTLDndFE+psMKZSm5wHOzmikp/SuXhiG+nKMa8aFGMSYzZ7YnOM/wezPf3kXB8BQZzJi2IqdOcVo6YjvdfVEWSN2IKuP8iMjKiWJbn7SUjTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3IUvhyGVyk+6FoNTGt4gMxNlZYT5PgKHwP0arzy01d8MWqzD1P0sj+W+bMo?=
 =?us-ascii?Q?Qzgtv6AEGj90OUBYC5QKPmUmwMzh/NNuKD8TcdPoBYFocX0qQtWnT6d1DnZS?=
 =?us-ascii?Q?pcoWwyXqVXHhbZjaJiGz47vGd9pOO94wgZC7Hq2cfzi3RhJIjO7HNtJMTvsv?=
 =?us-ascii?Q?yT0HTai4BwsXg/Y2R+SEgVBTEPbnEQK4CkkYONs8CS+DWkJRUyx5TY/7GmI5?=
 =?us-ascii?Q?VdydC7Pmpr6qFW8VGZ3xvxTa2GLGBlS888FTDWiXj9fNE3Y1PbrMWmFCRH0H?=
 =?us-ascii?Q?10UNejT6jKESBDcZAKq2iiu4GejxaEzdqUvnJX7btT9X3hZDzzhWnK9cT4H7?=
 =?us-ascii?Q?lmHB63zThNpbs0kRyRA1y7Wo/n/I53ayQmNHNj8KdZ+xwKdlHDA/fk4w+xtw?=
 =?us-ascii?Q?ciVCkenhCZiD9G95+oVISGpK+Yk6cAc1ohdYSkt7ppftjR/4UD9xPL2zqINQ?=
 =?us-ascii?Q?AFk039tDU14Y6UJO9keFJ2KZjKOmaM5niRuy+npLXFrlLEtLl6Z2yVqquQLK?=
 =?us-ascii?Q?85+BhJOsH85z2Qa68E4FyMiJBbmOlfwyOGroVUwDQGq+6UR2FQda8/AfIMi5?=
 =?us-ascii?Q?IG8wA+eTZWQbLoRYuS6v0XILhBnno1GoKn5VH6Cy+E4fY4NeIpdLUY9q5bPa?=
 =?us-ascii?Q?T5H04++/SA/XSa1n5QXDobi6153p+pC7KSNmv5gKvEhdPEK0H7QYIvgyasxM?=
 =?us-ascii?Q?ROCbihMZgWHNGOX3DUcdCGRKXeAVxcU0SweR7kBh6ceZV6OqAsRwjUB+UBsI?=
 =?us-ascii?Q?zBBmYb+keypnXxPsXvt4S1WVI/4UzZ0Nf/rFir0fIRLCaCKKrfZizpuc9yzI?=
 =?us-ascii?Q?xbkrDOnHYui1fu5idIOBAIxeKTlY9DFOcvLB/lbQAglwUxBsbUgA7cFlYTMN?=
 =?us-ascii?Q?eGNPA9Lev8KvxnVl9OMSuUThe4CmAQcCqWxNl59l6BY47Q+7qpknGn1uvULW?=
 =?us-ascii?Q?9sdFdeMxSq1tS9Q0MYWCcNzY1mBr0JE0fj53kHtChju5pIzSdhtJbrVdJF2g?=
 =?us-ascii?Q?UwKp7cs6wy9pcDUDlbm7ITq4I0vpQIW13kYjCmcLQh8axb2Z/vrSwGfYlSgB?=
 =?us-ascii?Q?ZQJOBNc0RKmIUy6zo2oMBTXzgfNs0txCouc1ZxI7gJGvnS1/VX+aa9PIEl+B?=
 =?us-ascii?Q?dDTdXGw4Lv+/uu+ox/+bMs4HljRbC6KcHPEmbCj+0qfJabG4jq5OW4F+SHov?=
 =?us-ascii?Q?XG2w0e8//0WsfYCLdllq+lt9QpyGBljRpQh/5c7V59Wo6dwJ1XVVP685YJPf?=
 =?us-ascii?Q?Xyb0GMNHd7iYH2P216V6ql9ydXhkHNPPsQsgXjssBBT0zd/63FVO3DL+MXMb?=
 =?us-ascii?Q?BBiy3N2xzAvOOYKrH2qBGBs+dBaRQTPmsyk/NSf9jYX3Q24DwryVHX8nRSk/?=
 =?us-ascii?Q?wsF1Lb84UyXhRInJc3PxCu7fwUX4RUXcIRyb5Dcx74baLBL2/Zrlp0V1HaBd?=
 =?us-ascii?Q?LbPbYWeSvMzR32foE74+hfZW0liwSnipmh/WJpfHaniQf7yq7kgXhGiYc7Yi?=
 =?us-ascii?Q?lCtTOdkGW1Fnz68UVWIVK1hadylOgYuuaGVAFYRAI8zM0e7NMVac2OBBfsLM?=
 =?us-ascii?Q?QADsdCVeo2MnveYV3ryxDhmx0WzirqEpLoPLJBVOvuFivg+pIpk0tQdypS63?=
 =?us-ascii?Q?puWlhcVRBvCW5DEaqaC3Nac+2AuDAeMQO6hpX//QyXTsa/F7MIQX1EYNvYOp?=
 =?us-ascii?Q?biNpJ7ZfQAlvj/awO4GiEZP/6E7bHe+1zr+lmvuxBtze3KOlOBuvfA8dkt2G?=
 =?us-ascii?Q?YF5qbYcbrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c03a1f-0b25-440d-9bac-08df08f62f24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:29:15.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNTvjsJrPgrMcmxqMCztKkcKV8hvUnOgUvFDvS5wkUye/YjJ3mXAtY83VBobjWoO9yfH4KcbOXV44ylBVMjchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079

On Tue, Sep 01, 2026 at 06:33:01PM +0000, Kuniyuki Iwashima wrote:
> +static void neigh_table_inherit(struct net *net, struct neigh_table *tbl,
> +				int index)
> +{
> +	const struct neigh_table *init_tbl = init_net.neigh_tables[index];
> +	bool inherit = READ_ONCE(sysctl_neigh_inherit_init_net);
> +	int i;
> +
> +	if (net_eq(net, &init_net) || !inherit)
> +		return;
> +
> +	tbl->gc_interval = READ_ONCE(init_tbl->gc_interval);
> +	tbl->gc_thresh1 = READ_ONCE(init_tbl->gc_thresh1);
> +	tbl->gc_thresh2 = READ_ONCE(init_tbl->gc_thresh2);
> +	tbl->gc_thresh3 = READ_ONCE(init_tbl->gc_thresh3);
> +
> +	for (i = 0; i < NEIGH_VAR_DATA_MAX; i++)
> +		tbl->parms.data[i] = READ_ONCE(init_tbl->parms.data[i]);
>  }

[...]

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4..53e044fc53b0 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -21,6 +21,7 @@
>  
>  #include <net/ip.h>
>  #include <net/sock.h>
> +#include <net/neighbour.h>
>  #include <net/net_ratelimit.h>
>  #include <net/busy_poll.h>
>  #include <net/pkt_sched.h>
> @@ -53,6 +54,8 @@ EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
>  int sysctl_devconf_inherit_init_net __read_mostly;
>  EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
>  
> +int sysctl_neigh_inherit_init_net __read_mostly = 1;

This fails to build with CONFIG_SYSCTL=n (yes, unlikely config):

$ vng -b
/usr/bin/x86_64-linux-gnu-ld.bfd: vmlinux.o: in function `neigh_table_inherit':
/home/idosch/.virtme/net/core/neighbour.c:1920:(.text+0xc8ddd9): undefined reference to `sysctl_neigh_inherit_init_net'
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[1]: *** [/data/idosch/virtme-build/Makefile:1376: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

$ grep CONFIG_SYSCTL .config
CONFIG_SYSCTL_EXCEPTION_TRACE=y
# CONFIG_SYSCTL is not set

Can be fixed with the following diff:

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9b28f40b019a..27602bcbeb69 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1913,6 +1913,8 @@ static void neigh_table_clear(struct net *net, struct neigh_table *tbl)
 	neigh_table_put(tbl);
 }
 
+int sysctl_neigh_inherit_init_net __read_mostly = 1;
+
 static void neigh_table_inherit(struct net *net, struct neigh_table *tbl,
 				int index)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 53e044fc53b0..23310581f494 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -54,8 +54,6 @@ EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
 int sysctl_devconf_inherit_init_net __read_mostly;
 EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
 
-int sysctl_neigh_inherit_init_net __read_mostly = 1;
-
 #if IS_ENABLED(CONFIG_NET_FLOW_LIMIT) || IS_ENABLED(CONFIG_RPS)
 static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 			struct cpumask *mask)
