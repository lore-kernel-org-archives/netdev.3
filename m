Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB4AF9EF
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966480; cv=fail; b=rzav/0YM8H1SpGy1eoMPG7d+p1tUA11q0awD8UJ1cl3Fz9oZaEOnboIXfeuj7qk/iyYXTeA3hfsDoqhHIxuSyyhzB+ivfWFmSbaygUEu7pJ703XV/Er46CVvngFZ/rL8K9seb6r8EQ6N+ALAqXjTKowtjQxXH8aLawSHGRmNroc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966480; c=relaxed/simple;
	bh=AXnavR9CV4kUAyq9o0sttODTR5WkZv3w7BAttBdhoYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLUPFuOqjNWAgRv3As4ituDoJpOwIYz5niwu901eVk7X9az2xzYozAI8lSPwO9sS0Wg8Cr+mgXgPYR8Ls+wkzK28TMn35Ne0ejNofvhtco0zt3jYLhMhynS7AX9NWFt5dng7URl4bfqpvc95IyHlhobWH/Jk45nMPozpkX/p5CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAbyHuPl; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAbyHuPl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7qdUNGelKQ3CuTQO2amZDQrGeWLHr+0iPu20j1lLW737b4wsx7A25Au47Hbial/WuXpfOZnXjMH1ym/5R9qAo/0xs1CcL0VCOIAwPocUjmArrppb90rANqjsPGvEfpj4LB0/EcwObhUmtnUqOAOSVsqImJncce4BEraCzaKhk371MIDfQrEkvMpG3n2A1TfUeJHCUO/Zo0Hk6MhcHScCC0Mz0cx3D+J2Cu6//FYSpnjYG7HZBBYI64KdJUVwcTM3RTruX2Lod3zE4W1HCOMfpeEZ30iT6Pvsh12aiuIYPq6xObS2nn0mgb9Zba6ZAQDqeHEex8Fxd8T0BK/uRWfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Cd/f4wM/SDFMOYeAqOnjS768c28PzpP9qQRpx82icg=;
 b=bFqKcN+WvS2IO/EVlc0UmGrng3JLz20B7vrkW0FxaDbp/sGLKtz8Wi+TJnsYrbLfNMLZ/tHoP7heO6R9r98wa0J+uzZwGRiO/LTvy4SSmXf1fpn5kgYTL0DKSBydgIp91IVN0dFNYtMlxQiEFJJXoGfDJE072XO5JStMslsXEqykxI4wTe3ADhBLbPt2Ey4kB6CpE/0Q+PReevpmRwHjBHyKHX47Z/tiytiTOsPnyvjM+FVxfErvwjivr0STMjIR0b9HEd6xLPM62ygU1J5fveDN20T5u9vKlbL5jcFDcAWAQFKiwFbcIRZjv2iRO+K1VlhiPdFjBlx5HicnE6zxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Cd/f4wM/SDFMOYeAqOnjS768c28PzpP9qQRpx82icg=;
 b=LAbyHuPlqxMdWlFiPu7NFCAli16IUv+2OArXvyQnzFD5F21h4xGRmYij5yp3ZFTz9hJvpYiHggUVzI4jsisButQyziO3cMvy8khGLPJNSKeQMNEUpTdT/EFk2huSoNOr5CDu2YvmETe38qF+JJ3J7a8scek4efab5Ns6WAomMt2POUTRus75sr3AB77+hgX8WTMZwZm05JyvvmUGzWbDaDjm9i/5/xSGhZ96wTYW1j/Q3DzXeztq9n5n85LYhkzOyCdtOrCr280btvLMbAFH+j7yMEz/vujk170Bb0BCAECbZQ2PBaKgD6VrLtbaWLkurEXW/5RmT1urTL5DGlWOHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 08:27:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 08:27:55 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/2] ipv4: Store netns in FIB table
Date: Wed, 14 Oct 2026 11:26:11 +0300
Message-ID: <20261014082612.1280756-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014082612.1280756-1-idosch@nvidia.com>
References: <20261014082612.1280756-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: c592e18b-ddb9-43d0-4241-08df29cd0bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WuiWiw5+6BvgasMYS+ThSaB9hwgIJVuRG+9poF8RC2i/QDjfiu6G+TWi0Adq/SbC0/V3jSbp/NXLo4FfMTgCB4P2fYq8HYa/rqtn/l7qp1ZAYCqk/rsxAUus7AIvdHDrAWQIYzU+MClfYP5C0B9kXlVI7AJngVeTUK0fGv48+6P6cdnnRe/j53K8SKOYoJq8WiAef/RJQh38rIePNv2pRHv33nmfGmJjKqwD4H8Uvj5XsAHjjNBafEFOelpPCBztfMe/TUeiL87eAtAdIZpj+MUqAPatPIFhZHPJJaYCdHdWBcKZSh8mGCiEdr0lYFtGtgBtP54j9oqH4esLj0CBiJ68kPyYYG+zvh5Pg8A9F7BOHui2PgJV7BP2+soZKganLKqidpTQywScGq9xcF66ecF8gtzCJNJViV/7bdbFcxAxaUyVpSBSPrJxM7xC0LccGrHRf8SJbi1KM04quDcLke6PEkf1FRIuJCQHJgoQWpAvJeWNlDAy31O3DRiCSEwPOdebRnL/cf+rgH33XaRyeREI43HmMBBvChP/cndnl5Fzb8Vn4HIaWL8PZzPlGGfU5egb9SPfdsfNvDpEqowfQrZB9NxlaKpwIVOgmhCG4RyO53tviMYcdlffk49vlS3O3sNFDS89FrPLr1jNCCvFS3ly+2JXFjpisonrdGt/JOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DrS1TGoG+xSdOHVtkg1qQQnBrwzLgv6XJ390Y28mdUYwGSUBqGTAwnOtms8w?=
 =?us-ascii?Q?Y3VD12+Htz11tVlvLNZTPn+M+vcJKuTu+rW2VX6zYgcDiKFldSxFmZNBjphG?=
 =?us-ascii?Q?gMHANx2KBOJ0ZYFCoKQEuHTf7z+g02LAuUCa5uj5nfWmj5R/DDriLacLyvPh?=
 =?us-ascii?Q?EyBWInI55TexhvETursBU+v1F69KjMu+Y1kD3VF4+HL6hrUoOGGbCBEq6yxN?=
 =?us-ascii?Q?nrpe9CPcvDmkQZuaqka122pkaHtPAyAA0+S7JEOK0SCue52sDo71EKGVmPir?=
 =?us-ascii?Q?Z8sJ7yxtNcE5iDvw3JsUzhSV00s2V1FrkATrVRTQ3trUvwlEnmefPA+NCB+J?=
 =?us-ascii?Q?TmzHkD0yfRBwaQ8SDo4n0SdMTn85QNpkk7qFbT+LVzBIZPVfLHgF6W9idLuL?=
 =?us-ascii?Q?B3hR78U48UDfINmsnM2C5N+jwjH0lYAKuQZiAgBC4Y/aH3BNcaM4mZbejqQ7?=
 =?us-ascii?Q?04lbRPg6dnqmzqZp/TmprEshiU2gxY5Kuv4J+o8mjMkXv47mum1kaGReYdnl?=
 =?us-ascii?Q?ZOulQOpyldc4xiOmLozBA9aWt2rB4aQkska/PmjAWj6ea8RvkHH5eogzavfc?=
 =?us-ascii?Q?Vubgz1TlrTX0/uw8vP918Eq6iVMmIg0Od6pq8BBXMe3bEldtTavhmuHFACc1?=
 =?us-ascii?Q?zK92lA+oUE1WcGlfIdRLPrDn21ItC+V57euS8zYgIfBmTjyTbmJGIv8D9p4A?=
 =?us-ascii?Q?bKOcIAYCUeEe40SHkWJ1rPALkxFPH2PwHvh0R1RbMTbm24+0KE48tuoMUHPG?=
 =?us-ascii?Q?QZvspSus471CWq6ZDTYYE6ASmrsCa0hRuzYGTFiknmfXW4TNP9W+0h+q8BFX?=
 =?us-ascii?Q?bW8XsoBj0SymMqL7Zv0L0W35fXX0dKOF1ak26zJI4GCWqOjNQ34kmcpPVbhC?=
 =?us-ascii?Q?vF3m6NnUS2rSLrrPN//2ZbfNpwhSSAnLb1W8ZABBjoLyb92jHLBozEsHSlw/?=
 =?us-ascii?Q?yaennhXTQvDRsK7YaZkiCacNDGfGLjYQTB7yMxzhqV+5Bg98T6keUJoDV5zv?=
 =?us-ascii?Q?QhJwH3tVGttoMzJem5u9SwvAnKpq4PUMHIkUI9yImpAb1ggPhqoJVLm+jp1Y?=
 =?us-ascii?Q?XU2Dpg9L45qOQslJ+vr08nl/619J2RTcq/sUswS1AUFNV5Wj2VndV6MaQ1yu?=
 =?us-ascii?Q?Lqq7ZyD+Cn+cf7vXhGDp4R6rR+kFYjBxrktjE31emPDMWVpWFposWfRJ+MhY?=
 =?us-ascii?Q?LZ2nXohm1jvU5Cq7nCoUk9zHNd8grVLEF/1Wcd501ss04B4YPHmZ5o1AzfEn?=
 =?us-ascii?Q?Pc2moIzNWv2ZFfv2dLGDfxYUZcFc9tBC8bM594JVjdhGfBsxlAAAxipRniSY?=
 =?us-ascii?Q?pVhW8KqvbZOKhfv5jtX7YhZdZuiNTKyzbbPVwXaelX3NoL4ixhc2dbCz0SL2?=
 =?us-ascii?Q?SMeqRWOv3z0uifStfmRHK/MPvCGzGhTsywHcTeiFle2H5VkWSdBnu8vsX/Lc?=
 =?us-ascii?Q?r1/jM4PKBw8jyB+WOdHtzpRd7ZzxEn4hpUeyt7a96kl4kCfoMFpXLjqzzN09?=
 =?us-ascii?Q?8bhS72p61n72KsnYXkcQQhcTmmNkBR9WsqHwyV0ngEYsfpxF08cd1o8nlk4Q?=
 =?us-ascii?Q?XCYNrfLuGnAtyE216eX02d+0OaQHmeXk3bgpkc/AGFJOjrQUjeY46DqAKO6P?=
 =?us-ascii?Q?bO7lM5qv19FpjIxJ4U4iUBKVsIQMSr1nQhuv5b68d1OtJtsKswfzEwxE+FTs?=
 =?us-ascii?Q?QirXTVNOQK9aAO7zZ0TWbXuWLN2ioCkLYrreT12MnnwAlAmp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c592e18b-ddb9-43d0-4241-08df29cd0bb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:27:55.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nb6y2RbTPn3vediBiX8q21LIcXSdInBSdqMrTVRfSupS0h7FdkpkNPTnOwKxyXlcSEOJ2Z8f5PSYRL7vFUEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

The next patch will stop passing the network namespace to
fib_table_lookup() and instead pass the namespace from the FIB table to
the fib_table_lookup tracepoint. As a preparation, store the namespace
in the FIB table when the table is created.

The FIB table structure grows from 48 bytes to 56 bytes and still fits
in a single cache line.

No functional changes intended.

Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h    | 4 +++-
 net/ipv4/fib_frontend.c | 6 +++---
 net/ipv4/fib_trie.c     | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index fb446f01a65d..033ed8fce35e 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -258,6 +258,7 @@ struct fib_table {
 	struct hlist_node	tb_hlist;
 	u32			tb_id;
 	int			tb_num_default;
+	struct net		*tb_net;
 	struct rcu_head		rcu;
 	unsigned long 		*tb_data;
 	unsigned long		__data[];
@@ -593,7 +594,8 @@ void fib_nh_common_release(struct fib_nh_common *nhc);
 /* Exported by fib_trie.c */
 void fib_alias_hw_flags_set(struct net *net, const struct fib_rt_info *fri);
 void fib_trie_init(void);
-struct fib_table *fib_trie_table(u32 id, struct fib_table *alias);
+struct fib_table *fib_trie_table(struct net *net, u32 id,
+				 struct fib_table *alias);
 bool fib_lookup_good_nhc(const struct fib_nh_common *nhc, int fib_flags,
 			 const struct flowi4 *flp);
 
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c80c1b36f1fd..97acfb35fb12 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -54,11 +54,11 @@ static int __net_init fib4_rules_init(struct net *net)
 {
 	struct fib_table *local_table, *main_table;
 
-	main_table  = fib_trie_table(RT_TABLE_MAIN, NULL);
+	main_table = fib_trie_table(net, RT_TABLE_MAIN, NULL);
 	if (!main_table)
 		return -ENOMEM;
 
-	local_table = fib_trie_table(RT_TABLE_LOCAL, main_table);
+	local_table = fib_trie_table(net, RT_TABLE_LOCAL, main_table);
 	if (!local_table)
 		goto fail;
 
@@ -91,7 +91,7 @@ struct fib_table *fib_new_table(struct net *net, u32 id)
 	if (id == RT_TABLE_LOCAL && !net->ipv4.fib_has_custom_rules)
 		alias = fib_new_table(net, RT_TABLE_MAIN);
 
-	new_tb = fib_trie_table(id, alias);
+	new_tb = fib_trie_table(net, id, alias);
 	if (!new_tb)
 		return NULL;
 
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 4a800fdf1ad1..3bc8247b3d75 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1881,7 +1881,7 @@ struct fib_table *fib_trie_unmerge(struct fib_table *oldtb)
 	if (oldtb->tb_data == oldtb->__data)
 		return oldtb;
 
-	local_tb = fib_trie_table(RT_TABLE_LOCAL, NULL);
+	local_tb = fib_trie_table(oldtb->tb_net, RT_TABLE_LOCAL, NULL);
 	if (!local_tb)
 		return NULL;
 
@@ -2378,7 +2378,8 @@ void __init fib_trie_init(void)
 					   0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
 }
 
-struct fib_table *fib_trie_table(u32 id, struct fib_table *alias)
+struct fib_table *fib_trie_table(struct net *net, u32 id,
+				 struct fib_table *alias)
 {
 	struct fib_table *tb;
 	struct trie *t;
@@ -2391,6 +2392,7 @@ struct fib_table *fib_trie_table(u32 id, struct fib_table *alias)
 	if (!tb)
 		return NULL;
 
+	tb->tb_net = net;
 	tb->tb_id = id;
 	tb->tb_num_default = 0;
 	tb->tb_data = (alias ? alias->__data : tb->__data);
-- 
2.56.0

