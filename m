Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC749EC5D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466463; cv=fail; b=rixRCKuiYrYH3Yg2Qqk6IAbUShe85eRnaM0IYH9GPZ59JP+hcIwNWQFvS7hMFP733osybtLfzkfi54acSCnBS/KtvOa3kJ7GVRqotB/4UQ/tQWUH4pB+WnuswUcg4hN9/5nwRs/iXpdvk7/HLr0pmUb5/GNVdhr1B7o2vPtCh9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466463; c=relaxed/simple;
	bh=p6TJnHli8Qz6KjnmrB64hAn6jKIkDIVk4/fcA6+9hv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IStakSWrwQ4eLemZuLshHI8X1WOuKCPUIKaK6GhGkYVY77XS06y+NS+D8U8rWSY0NNEeIvsUgjKN/3fyx13YfCI3Z7nXa+dA3LP8u9R8gsgmpUIXgJJ6DKSWskdIHQ1S26WjhM9Wfxj6sIRgMrgY1k6AKiP3tVW0QnMDf3xMZVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayy4QVY0; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayy4QVY0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVFfDlW7caHm2ng9OHpWFLxIErCmIU211zySagU743jHitp483DE2d/uPM2AAQpUs1gupICM6enP12LjxywglwCGw2vxDpGkH/yw16tFn+zttWD0zd0um9H52YUyWt/MzIxQS3VLwsd3LufFslcqJDPzQGlsGhNOmhQQtRAhxvrwyQ216BQEqy/cnxPUmcDza41rv9ayyjla5bQ+iKoV5mlQ8svj9g2N4TePOdTeffskIBK5Y9Z1SwjoeiHqMUwTPAHrzOY/oANuuv1LnjHduxNmh/+6c5O+FZ9Aq39Y2yG8YSZB5geobqyrcKQuOhD9N+JIyTxiaeYv6G1C8Kb+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgK1LGlU4OrigNIyvIToxpIDvqylFbTmbLxrO1Icl0c=;
 b=I/J7foMUoNadlO8N/zi+1epE4CBTVWEtt73mM5U64Kkc1QHO3B1BEOY41gwmK1izmBLRYg4pxgMWNEYOUMFjmt5wUzslkrQ2QFxX7biIGtUyLPS1kJp6PEPhfXoHdZjzHFvCl7UrgAPATmTJsPPbmdxuvZjTUZHDWP/oCvfPfOIbX/C0MS9z79vYgrd4DnmQvXFJ3SO9XzLCwaFaN/TLrupZ6QbLPr6HJ6FGAIvsG90zLCoMJtjV1YJvLVE+K2TsfOiji/yBAdYgCGSEdRrUO0kfA+BDlJ6qpYK/xICQv6sv6exr5gOl4WNIMNvgrF1lcwFgrJL6mk+tSCjrqMW8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgK1LGlU4OrigNIyvIToxpIDvqylFbTmbLxrO1Icl0c=;
 b=ayy4QVY0exBaz7CaV5Mr6QumHHWUet6XiqAEJbSzOm8A636duz7ZXa8edIyTycz/uKFPZmrlagjUYbr/DudkwEVkXOt6N7jd3WzFNmakbY6Hj9tMyuK1l3vel94gthlG+7uu/UWDfIIC4jChdarJav2d3XA2WzWraGQxYiyNCZkKnVFtQERjvq1MTRiB5TwfxdymwZyT3KzQkJULzU0tXDxmB3L78NpNaH1TlknppdYVz/wbUiR9Ij5kxH3U/LDrkY3bGgvW2nPGOqzJSR/+wmj+0/UvDAoYE7MDhVWJSdwhi0P2lsa5cSLQR0gsDTACFhsDmdrjPsZ+g18Ak4H4vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:34:14 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:34:14 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	daniel@iogearbox.net,
	petrm@nvidia.com,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/3] ipv4: Pass netns to fib_table_lookup()
Date: Thu,  8 Oct 2026 16:31:57 +0300
Message-ID: <20261008133158.1438907-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008133158.1438907-1-idosch@nvidia.com>
References: <20261008133158.1438907-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dd4755-1bd2-421b-93de-08df2540d842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EqAEZBCzGd63KWjXlkATcaF3tqAY6fLf1QjvZwkjphZfMTNxnYFxs6acs/XKgsgCqM1fSzAs+Hd8A6vKBLvcuIsr4vi52aNr1uANjdVYxa0yN/ZlOcqWLMjUYrsHcMTN9jiaPxxURUbFLp+Sh5w9Cc1fdaOfYzsh27R59slWyKjSO9EGtEth4Ub8IPzqruyO23eVrzApzgfzrA2uhYu7cx0bxJzXSn6Lg4w1m2Sf4ZX7TyKVNopehRqNU5d/n1xwHSwCRwaQJdUYWLfMOt/pDTftesVvX3DRAL48SReU277870a/WbmLLM3ymID8OUZ0V/y/TLsBKKUNt7fynEqVskgKeGSXwvWvZ/d9c3ZPhGK+XuJJQeNSv/VOqComP8Vc6xZGvPFp9IzJGlGSMyXVGD9tICocSwaRJK//m1rhsWKskkOkzKY7iwuFimEDfY5q7sFcavv7i8c/80E+75DreYdauXxQyRvwOpwDGvbXSdn8HE7ykx56KQGqTdediSMZjBX3AHM3w+5Jdl/OjotEoltn+PpmMTfDco/+2VcNBb3KUM1MmnqUTlEzJL2vci3wOGDHlWbvNhue30o0zFCL9VjamD1/mL6FAfL6aLdthdlRzDWnqptQ9jsmm9oOLdj+65EPuVF/w9KDNjd0HIrgJTymyVRNFWSJ1LnYkcz2l8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCucuq077e7K20alJ39uEbWkH/nbLy+1fDKn5QLNNVklJFKzwfH4Q9h4jD+r?=
 =?us-ascii?Q?2jJ9t3FUJevsjPSNzS1SQ2WcuHowiR8KkVB7ktcT1VKwmbDEGrz5XG9nFnMr?=
 =?us-ascii?Q?vcudJMoiMsnOQT1uTq5EjJ05BzK97BpJrciW5z6X7ByRUppoD8CT/a0uZXi7?=
 =?us-ascii?Q?lKa8tmYPZhGR0cpbDqbHcHmK7zFiKK4AvDeGfx/vKW6vx7lUeOn9gdOb11LI?=
 =?us-ascii?Q?M6fz3/jrwogBRLEn/fpCjPJ6u2WlEsJepin62nLjQiX89w3L7qOSVdrplPET?=
 =?us-ascii?Q?YCOR+8S6e+gUEJLmsCoPWkgYMn5T+VWyEQgMZHZeMQSGKOvImJ/+33NVs5HW?=
 =?us-ascii?Q?ceovB6dSJfKGpuee9Woj5PM4sEdl4kDbOM2DWRanfFpS0ZNPKPBHzPpv4V4W?=
 =?us-ascii?Q?mAuSuwwDbJXjGJcAhcyN6BsvalnmdsMPpGNTBQKRz2QczV8zWNnGES/NIiyc?=
 =?us-ascii?Q?xE1qiaJgXBCoKPEG8Gqvt/clJlbiotbxEzK2zxA8Et9IXVQM1DUEzpCm7r9N?=
 =?us-ascii?Q?TrvpGnFrgCyzkMlIbe9siXytJ7q3Jm9QGmNtoD7WyQdmP5Z0Xzerz3SFrsu1?=
 =?us-ascii?Q?2ed1vTRSy7fEIlmkk5+eFKQUkkc44O3Wd52dedvm+WtvtAkUk4uBbt8RabZc?=
 =?us-ascii?Q?KrlDTP6SRfUgwOB0b3Slsx+WkJIrFKuMa48iJ4HWcuz9yOxJXSxFFACPPY4N?=
 =?us-ascii?Q?4VPxFAoUIivSeeSq0fTXfC6w6BdbQ5fgzTcp8wv3nes8iIpjBDLX7CCzymDH?=
 =?us-ascii?Q?oE/hhEP+a0LWBokrefhvywynC6Ck9CrjkMTKU4jUA7bctREPhDWYf1wtGRF3?=
 =?us-ascii?Q?700/+GpmCrDKnUOhbF37AfjAraq+8nTmdq7hUW/LHIQb8JnQvsRKatNra/j3?=
 =?us-ascii?Q?9n5ocEXc5UrtchYVLw5caxzluA/ALip2eE3mcBbOGBrryKGgqNKD1748HzmH?=
 =?us-ascii?Q?yEthesgmYBUMFiNSdqATfg0vqkLuICp2nuxHTanZAbhVo5KgrSQUjB24q7Qd?=
 =?us-ascii?Q?I9QhVeieqlYlBPE2gnnN60KA0jydTp86V5KXWmBwG0kSY4hsRPMFX9axk6Ft?=
 =?us-ascii?Q?wb8WFdl4MyMKrJPStNDFMzqlRxPuvJc5ouvlhbzU6ckkSeEF3TweKld/sl9Z?=
 =?us-ascii?Q?1DYSFgKRH/+/nRE6FgnpL3rvw7YhLfTc3aYrxE+Gd8wVl0LdwpuB1q7+EADm?=
 =?us-ascii?Q?/Dtnhu9GfrCm63PWOvD/l57+okm4CtsJOS5ngcdxNiI8wC2p6VuGA0RCW7Ni?=
 =?us-ascii?Q?VMxuh1VqP6Vbm/2H3wAsP2PWzVIC486JhoRS9vIfn7q9WPODpji5A6dBpzKz?=
 =?us-ascii?Q?oswN2T868nijUPXnJjgwoaU1TduM5OObYukgSVOslF+WTHrV+BasYswtQDww?=
 =?us-ascii?Q?Jr83G86aLsMuUnXyjuczZBVAN6E7EB9jLMJbWtiFxSlfxEcdkpDSMXQlm40y?=
 =?us-ascii?Q?WijdG/Numu4rvoVY5x71Poz9BleFti3t9f0ETwa9A04QXEkghXYuuzte0JEy?=
 =?us-ascii?Q?EiRL2n53pSpapJIJnT+fa21RDpzMdAGnmwmYOVmuaQqhchxiRnyFtMz7uMrd?=
 =?us-ascii?Q?Ly5LOqoNOWS7YYDhsdQ7md73aPui0zBFcfb/dVVwp+SSsTjwiUZSSygNd/Bi?=
 =?us-ascii?Q?3/NcmxWTZnZJtEjS6udQycL0mbf3uMeXxBP3vnL/e4M7znDnfAzRL9jGyNhE?=
 =?us-ascii?Q?zJ5WbQ2PGmUWLmlhPiv03DKTkErcDHU43lvP9dDIkWSOT/XBRQMOk9MuAc5j?=
 =?us-ascii?Q?7tpI9eZdNQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd4755-1bd2-421b-93de-08df2540d842
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:14.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFnEiXngojAgMU5gj44blmwe6x4MMFF8Tg2OBHw4jLA3lAerq9SZGuRgsKCDmyrS+X3bYTuSYsYlZPJd8YGaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007

The next patch will report the network namespace cookie in the
fib_table_lookup tracepoint. As a preparation, pass the namespace to
fib_table_lookup() and from there to the tracepoint, like the
fib6_table_lookup tracepoint. All the callers already have the namespace
at hand.

Add the namespace as the last tracepoint argument so that the positions
of the existing arguments do not change and BPF programs that attach to
the raw tracepoint are not affected.

No functional changes intended.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h       | 12 +++++++-----
 include/trace/events/fib.h |  5 +++--
 net/core/filter.c          |  2 +-
 net/ipv4/devinet.c         |  3 ++-
 net/ipv4/fib_frontend.c    |  6 ++++--
 net/ipv4/fib_rules.c       |  2 +-
 net/ipv4/fib_semantics.c   |  2 +-
 net/ipv4/fib_trie.c        | 14 ++++++++------
 8 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 0a35355fb0f3..fb446f01a65d 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -275,8 +275,9 @@ struct fib_dump_filter {
 	struct net_device	*dev;
 };
 
-int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
-		     struct fib_result *res, int fib_flags);
+int fib_table_lookup(struct net *net, struct fib_table *tb,
+		     const struct flowi4 *flp, struct fib_result *res,
+		     int fib_flags);
 int fib_table_insert(struct net *, struct fib_table *, struct fib_config *,
 		     struct netlink_ext_ack *extack);
 int fib_table_delete(struct net *, struct fib_table *, struct fib_config *,
@@ -323,7 +324,8 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
 
 	tb = fib_get_table(net, RT_TABLE_MAIN);
 	if (tb)
-		err = fib_table_lookup(tb, flp, res, flags | FIB_LOOKUP_NOREF);
+		err = fib_table_lookup(net, tb, flp, res,
+				       flags | FIB_LOOKUP_NOREF);
 
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
@@ -387,14 +389,14 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_main);
 	if (tb)
-		err = fib_table_lookup(tb, flp, res, flags);
+		err = fib_table_lookup(net, tb, flp, res, flags);
 
 	if (err != -EAGAIN)
 		goto out;
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_default);
 	if (tb)
-		err = fib_table_lookup(tb, flp, res, flags);
+		err = fib_table_lookup(net, tb, flp, res, flags);
 
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index feb28b359eff..341905b5edf3 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -15,9 +15,10 @@
 TRACE_EVENT(fib_table_lookup,
 
 	TP_PROTO(u32 tb_id, const struct flowi4 *flp,
-		 const struct fib_nh_common *nhc, int err),
+		 const struct fib_nh_common *nhc, int err,
+		 const struct net *net),
 
-	TP_ARGS(tb_id, flp, nhc, err),
+	TP_ARGS(tb_id, flp, nhc, err, net),
 
 	TP_STRUCT__entry(
 		__field(	u32,	tb_id		)
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..3ee1a093337e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6413,7 +6413,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
+		err = fib_table_lookup(net, tb, &fl4, &res, FIB_LOOKUP_NOREF);
 	} else {
 		if (flags & BPF_FIB_LOOKUP_MARK)
 			fl4.flowi4_mark = params->mark;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 2ed4c706ca9e..c106d56eb2f7 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -157,7 +157,8 @@ struct net_device *__ip_dev_find(struct net *net, __be32 addr, bool devref)
 		 */
 		local = fib_get_table(net, RT_TABLE_LOCAL);
 		if (local &&
-		    !fib_table_lookup(local, &fl4, &res, FIB_LOOKUP_NOREF) &&
+		    !fib_table_lookup(net, local, &fl4, &res,
+				      FIB_LOOKUP_NOREF) &&
 		    res.type == RTN_LOCAL)
 			result = FIB_RES_DEV(res);
 	} else {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8a3dc04e8cac..c80c1b36f1fd 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -243,7 +243,8 @@ static inline unsigned int __inet_dev_addr_type(struct net *net,
 	table = fib_get_table(net, tb_id);
 	if (table) {
 		ret = RTN_UNICAST;
-		if (!fib_table_lookup(table, &fl4, &res, FIB_LOOKUP_NOREF)) {
+		if (!fib_table_lookup(net, table, &fl4, &res,
+				      FIB_LOOKUP_NOREF)) {
 			struct fib_nh_common *nhc = fib_info_nhc(res.fi, 0);
 
 			if (!dev || dev == nhc->nhc_dev)
@@ -1400,7 +1401,8 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 		local_bh_disable();
 
 		frn->tb_id = tb->tb_id;
-		frn->err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
+		frn->err = fib_table_lookup(net, tb, &fl4, &res,
+					    FIB_LOOKUP_NOREF);
 
 		if (!frn->err) {
 			frn->prefixlen = res.prefixlen;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 060501b376a8..28ba35125383 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -136,7 +136,7 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_action(struct fib_rule *rule,
 	tb_id = fib_rule_get_table(rule, arg);
 	tbl = fib_get_table(rule->fr_net, tb_id);
 	if (tbl)
-		err = fib_table_lookup(tbl, &flp->u.ip4,
+		err = fib_table_lookup(rule->fr_net, tbl, &flp->u.ip4,
 				       (struct fib_result *)arg->result,
 				       arg->flags);
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 235c51a6f8e5..24def626739b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1221,7 +1221,7 @@ static int fib_check_nh_v4_gw(struct net *net, struct fib_nh *nh, u32 table,
 			tbl = fib_get_table(net, table);
 
 		if (tbl)
-			err = fib_table_lookup(tbl, &fl4, &res,
+			err = fib_table_lookup(net, tbl, &fl4, &res,
 					       FIB_LOOKUP_IGNORE_LINKSTATE |
 					       FIB_LOOKUP_NOREF);
 
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index acb1e4385914..9ad76de68081 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1417,8 +1417,9 @@ bool fib_lookup_good_nhc(const struct fib_nh_common *nhc, int fib_flags,
 }
 
 /* should be called with rcu_read_lock */
-int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
-		     struct fib_result *res, int fib_flags)
+int fib_table_lookup(struct net *net, struct fib_table *tb,
+		     const struct flowi4 *flp, struct fib_result *res,
+		     int fib_flags)
 {
 	struct trie *t = (struct trie *) tb->tb_data;
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -1435,7 +1436,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 
 	n = get_child_rcu(pn, cindex);
 	if (!n) {
-		trace_fib_table_lookup(tb->tb_id, flp, NULL, -EAGAIN);
+		trace_fib_table_lookup(tb->tb_id, flp, NULL, -EAGAIN, net);
 		return -EAGAIN;
 	}
 
@@ -1522,7 +1523,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 				 */
 				if (IS_TRIE(pn)) {
 					trace_fib_table_lookup(tb->tb_id, flp,
-							       NULL, -EAGAIN);
+							       NULL, -EAGAIN,
+							       net);
 					return -EAGAIN;
 				}
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -1569,7 +1571,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, NULL, err);
+			trace_fib_table_lookup(tb->tb_id, flp, NULL, err, net);
 			return err;
 		}
 		if (fi->fib_flags & RTNH_F_DEAD)
@@ -1610,7 +1612,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, nhc, err);
+			trace_fib_table_lookup(tb->tb_id, flp, nhc, err, net);
 
 			return err;
 		}
-- 
2.55.0

