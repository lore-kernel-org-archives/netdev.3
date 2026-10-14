Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89437B036
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966491; cv=fail; b=h3pIIrFCRQNCIg2c4o4BkDYejZ3S6YReQsosBVf2tRStrWtdwPkkqicUTOBrr3Zzo3VIWDUVcYf0zSN4VQB2GUE1g0PQQ9WyThytpFdYndADrhZkIwfVH7ddLluzKfpD65AyrVdUIezPV6mb3G8emAnIukff9tOmkoFgolJtm9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966491; c=relaxed/simple;
	bh=wVVxq64pDDkDTb8DgD5K112t0EKTtk7WE3hkGktj60s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ1V1q4YFswe5axP/mJd6KasPrEDgv/sA3mYSNyHU+G7NOT3qjlnYBhorMK32/dmrr3sLCMC80lEHvlc4QWqAMqWSwr/F63osAlDRXtcOAe8GrZTY8iP478Rl8UZjF0xQ7LWw/iqXFeYDFR5u5c9fTVDJcQ0+Tgz7vXqo0tfh4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=poxaKGm7; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="poxaKGm7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf/cJlMKRnZfuErXGWw+71sAPqWYRbVgkBzW7iE85sgrNx4fgioQt2dM/zegnJhqQHYKxxrYhRqUrBg+mT1WdHKEZJ368N1LuG3mqAOZjmmMGBqAh5cnDhM04FitoZScj7gqxp3D4zcim0m2bl9bU2SOkVnRln7X/wjh6Lq0C66kiGhqxnJ2k00VMwloVn+VU4xTqM5LmhXohQyNolJWvPHWOA34uWJ65krt5gsbvQLAVlujHSyRdE9NWu8VyXlVSnWci9DSHnR7ugfJnPOqW6GQGCuz3gWnfiy4hCAJFgqoVtrLG9l5JL4W/dBREYBihpig9y14k2/yB4jaAfpe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4h9rj58/jjf4d15RqBroGfgvfkW4k6EFY6wJJ924vw=;
 b=u4p08FjJJiYsFQcSKW5a0l2alkHID8iLvpaTMX9EHD2sKTs5Q4Gq/oX0Dfv+g2x/r3hgY1HpgRoz84qqmJp6C01tlhju/CemoMOd418et59db/Hbf3ZkLRpJJFZwKoTiOtYzKhbZgur54QO7YTiAzBerHITZU4iS4rg9sLJAS2gBcHJqwRQ+B829zEJIC9pPLUChp+lKYQSO5DIfR40LMBJhHiKjc+m1mn/lvxDGAptLgig6V8kBGk4pi03k/tTjkn9InNj3nvVMCTWyJUQwiTTRYF3huJearRbVn+DKUhfbG9VI5w84aiWxgPhL3VE9sGiJ1opX0DQm3NbiENmnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4h9rj58/jjf4d15RqBroGfgvfkW4k6EFY6wJJ924vw=;
 b=poxaKGm75P1Y2Ul6MLlDEOuBxY5dERSNRsOU0HY6lOXtbW9m2R6GmIuXGLTQ+ZOh/rFSWCYlwN6rbVWX7LIi1/UNstsCGth6m2miILJlkr8qHZbhQF9ZQE0zBLBXL86VxRXqFZx/ldXH8AyKvmZoNUVnxP20OLGUMxUo23vMMJI8HksB52TDZUtSm3cbrvjdB60LVVByCnhhVP9oAkKmoc43fX0eo6CeaZf049Kyl7fBO4rPzoVgpea/7N5Mp3YGuGZBy2nYRGkNroFh14OAOBO20wWFuPyOBFhuFsWlLv9Tk11BHCt7gwzaejjrzmcO/jfFT2caRYAx2P2ZQSeorA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 08:28:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 08:28:05 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/2] ipv4: Do not pass netns to fib_table_lookup()
Date: Wed, 14 Oct 2026 11:26:12 +0300
Message-ID: <20261014082612.1280756-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014082612.1280756-1-idosch@nvidia.com>
References: <20261014082612.1280756-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fe2e04-6309-4890-8582-08df29cd11a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261009223027099003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EPP1yoABjmTW2t48LP+3jDYui0av6NsmieYp7XIKe268ZpI+0XbRKcdg7hNqflJt4MiZ2t1SzP25wDQXPvqtulX820Bbf+MTpNkS20VyKf+as+rHUT1cTn3vdEihb+VadsdWoAqQvdMBrTxeqxhaizgGLVbOJm5bW21XD/VHl6SMCCLldGTxJAJsofVAlRmLr4ABpOtmAZ+sVBiHC+RbutJAQNJnrXLxMym9sxD9Q91ALSFRDlLTrmtgCYn9/uQc1ulTS7BPrVcV7RgfI9oSp/s9CvIPEXaTZd1oNQGUL37SkX1LCC6yujFY7hKt1VqmYElPLreeqnQEO6RmmNmId4C+AnacOv/6cH/zPz6yE4qdP6jaDJXDQm1LIBYfcYKNXm6ER/oFotIaUhgjeEbQUDHs8tiR15RaCkcJ8jQLv6G87hRqseB0DrUAt6Dq2i9Et6Ps2luHy2JTW7QYgRugIJk1mQEIZwRP4gBTtJZ/8ib+yhTcYbXGkbN1yfg99K1JzhkekRnPeBMrtjE/y/Z5ru4ixoh2t/Ay80G2f9KNA9Y6SJUSYV+ZNs7+zTs8TxCLp/8OAgjqe9CbTI39Js9bWh1i9M20qKs7W+QPMt9MgpMci9l0BMLkswzR1woeb52ky0VQIs5hopdCvFcjcjPKYclrYj2lpC+13P79HGruzGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+e6Pr4S64s2uWWAY5W++LWx5jei1/AiRGa87tDOotERQcslqZeaOk/+Asg0?=
 =?us-ascii?Q?rrqLHUiFnBRZSA94koo4O8NIYSuFthwhLylygraj1H7fApksoTO95dpJBtoq?=
 =?us-ascii?Q?ciPnSut5C6nK/Vm0v1toOHy8zutsxgEYVHlj0nGVW0w2JNVhvxE79skgpxuO?=
 =?us-ascii?Q?KcXqDCxxnBotN64nRbHU2Ia76HbAGre0dzSYlr63IkUSffmNTtKzPODEVXxP?=
 =?us-ascii?Q?Tfy374Hjd1dviHmwE7el0WDUFsqI4rq88qBrmF9zv9/4/i8G6NrTrj0gVyXJ?=
 =?us-ascii?Q?1ceztiC5sy9P99V5cDpwDgrDG31e9aUaKQqkUtEztKjYx0gILEPBpKY2DlQn?=
 =?us-ascii?Q?3+B7oTw+tFawPXemdlgPx5u/eirGUxdXndIRm/r/StA4RpFmVtzgA6/n+Lmm?=
 =?us-ascii?Q?PaKa8SE7Y7f4HGE9yS6IEGJvB3MpohG+byguNBcYlVU++c4ho3a8NKziw+2k?=
 =?us-ascii?Q?Y03P4c0AQrzkd6FyQfO0WXxDvBWF2Qe091V+tDCXQSs0DXxCa3PNJ0SkDEuC?=
 =?us-ascii?Q?hczLpGZUR7Im9WYH2n46npawJN9OXcWqfMqfQpVz7sOazg2ATyc9RcAdJMZo?=
 =?us-ascii?Q?Rjm3k6aGopgQAs8IpUB0RIfqvFhNfzfWZiko/FDT9GNoEAplZi1HNU+LqZea?=
 =?us-ascii?Q?gFeeFJ54GGZuDpmLhph6SaKn3TIPhsldXURU95VMo1teayRCauPPTxjDCtFv?=
 =?us-ascii?Q?gSkMxWCOS3pfa0cs3DixskPzQIP0VG8u7aFO735rxftCNwhG/RwpZesDMYKg?=
 =?us-ascii?Q?U1G3Jgt9L7GkkrsIJ+JBwBm5XxVWBk4WL3zf/tg8k7O7nkU5JP3DIKKli+nO?=
 =?us-ascii?Q?XwnSAP8ZFEedk4lGwB5dZhiyHHvN1MbVTY2k/NFMB8iHdWBmprAuRAJWcI7k?=
 =?us-ascii?Q?MN9S92VZXWut/sFSiAmaTwJ99yF5fUMgsuzGhTU+s24QVoYr1KcYkgH8fYJV?=
 =?us-ascii?Q?LVNnQxUJ7KuHf7aKJ/xqTPzKOVhapLUnRA3iXGP1kCLnWQ/9RyXrJq2w/+sN?=
 =?us-ascii?Q?i0kqLdGGRIpzQCPchiJWo18cc6U3GLKF0iG2CYR1Zia6RrySM1Z9zvgamUqu?=
 =?us-ascii?Q?eGS5pYVauJL5GDxW/9BWM0jPX89uNBT/9WzOaNMIjzPllEVFj0XDZ3oWYcxb?=
 =?us-ascii?Q?+eDd3pDbH2Es0swqAXrfnCjG1rt2e+RTsbnTVMQl6/UruhUy9vj7TAWZ3Sd+?=
 =?us-ascii?Q?cvJxUqd/bP0ttSxwI9ntqMlGlx+gnLUk09XbgGp9Y6zQdbYH7WBhFZSL4Nl6?=
 =?us-ascii?Q?vpF3THya0DwV04nsoV8+rxGy7QL4H8kZd4qvXb+N/IH9G0O9K005f4O17Dvd?=
 =?us-ascii?Q?AHKzUqm5N8OL9N/EJ59z3CwqKQR99CfXef7XhSYEaM2svOp6t/bEYDcAGY9J?=
 =?us-ascii?Q?aIcmibWPl3YtaIWO7/tlclrsjLCOC9ILPQp31jzBdNtEIfX9IkmX385dSpyt?=
 =?us-ascii?Q?FS45bVD5/GZUi47LxoVXQRgG0wOT8VuVzjZKHJ26loe8QyVf49k6e7auWrke?=
 =?us-ascii?Q?ugPx4u1pJQZ90a02t+i/mpZgo75zCI1RhrF/btAY/0a8AmM+24EIPTuj5Cxr?=
 =?us-ascii?Q?WhxA7xD1q1a0hPXh4PBY2L/tmWjfEQQdo43XN9r6BuF8Rm/KQqRahgOqRQ6m?=
 =?us-ascii?Q?TTJ8A4TuhF55oCL8BFh7xAyLMlqlc4t31JyK8x8SHAvk95PrWvBIK6zXdB2H?=
 =?us-ascii?Q?WXiEGBxTQAeFsRLVr/aRCV1prGyKVwKIxuQzDvTLpYavjNqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fe2e04-6309-4890-8582-08df29cd11a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:28:05.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf/eSsQPcTVa+xt4g2i7SJngaaRWeqaj/YSAhsXCmxz8XFZHWivF1V+VpZ9+BO1pgSqaj5I98eNNIuCkpNxikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

Commit c436a624f89e ("ipv4: Pass netns to fib_table_lookup()") added the
network namespace as an argument of fib_table_lookup() so that it could
be passed to the fib_table_lookup tracepoint. However, the function is
called in the data path and the namespace is only needed when the
tracepoint is enabled, so the additional argument is unnecessary
overhead.

Instead, pass the namespace that is now stored in the FIB table to the
tracepoint. This way, the namespace is only read when the tracepoint is
enabled. Revert the signature of fib_table_lookup() and its callers to
what they were before the above commit. The tracepoint itself is
unchanged.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com/
Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h     | 12 +++++-------
 net/core/filter.c        |  2 +-
 net/ipv4/devinet.c       |  3 +--
 net/ipv4/fib_frontend.c  |  6 ++----
 net/ipv4/fib_rules.c     |  2 +-
 net/ipv4/fib_semantics.c |  2 +-
 net/ipv4/fib_trie.c      | 16 +++++++++-------
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 033ed8fce35e..92f4eb8b86d7 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -276,9 +276,8 @@ struct fib_dump_filter {
 	struct net_device	*dev;
 };
 
-int fib_table_lookup(struct net *net, struct fib_table *tb,
-		     const struct flowi4 *flp, struct fib_result *res,
-		     int fib_flags);
+int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
+		     struct fib_result *res, int fib_flags);
 int fib_table_insert(struct net *, struct fib_table *, struct fib_config *,
 		     struct netlink_ext_ack *extack);
 int fib_table_delete(struct net *, struct fib_table *, struct fib_config *,
@@ -325,8 +324,7 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
 
 	tb = fib_get_table(net, RT_TABLE_MAIN);
 	if (tb)
-		err = fib_table_lookup(net, tb, flp, res,
-				       flags | FIB_LOOKUP_NOREF);
+		err = fib_table_lookup(tb, flp, res, flags | FIB_LOOKUP_NOREF);
 
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
@@ -390,14 +388,14 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_main);
 	if (tb)
-		err = fib_table_lookup(net, tb, flp, res, flags);
+		err = fib_table_lookup(tb, flp, res, flags);
 
 	if (err != -EAGAIN)
 		goto out;
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_default);
 	if (tb)
-		err = fib_table_lookup(net, tb, flp, res, flags);
+		err = fib_table_lookup(tb, flp, res, flags);
 
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
diff --git a/net/core/filter.c b/net/core/filter.c
index 3ee1a093337e..70dc621672f2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6413,7 +6413,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-		err = fib_table_lookup(net, tb, &fl4, &res, FIB_LOOKUP_NOREF);
+		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
 	} else {
 		if (flags & BPF_FIB_LOOKUP_MARK)
 			fl4.flowi4_mark = params->mark;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c106d56eb2f7..2ed4c706ca9e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -157,8 +157,7 @@ struct net_device *__ip_dev_find(struct net *net, __be32 addr, bool devref)
 		 */
 		local = fib_get_table(net, RT_TABLE_LOCAL);
 		if (local &&
-		    !fib_table_lookup(net, local, &fl4, &res,
-				      FIB_LOOKUP_NOREF) &&
+		    !fib_table_lookup(local, &fl4, &res, FIB_LOOKUP_NOREF) &&
 		    res.type == RTN_LOCAL)
 			result = FIB_RES_DEV(res);
 	} else {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 97acfb35fb12..8c123b111b3d 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -243,8 +243,7 @@ static inline unsigned int __inet_dev_addr_type(struct net *net,
 	table = fib_get_table(net, tb_id);
 	if (table) {
 		ret = RTN_UNICAST;
-		if (!fib_table_lookup(net, table, &fl4, &res,
-				      FIB_LOOKUP_NOREF)) {
+		if (!fib_table_lookup(table, &fl4, &res, FIB_LOOKUP_NOREF)) {
 			struct fib_nh_common *nhc = fib_info_nhc(res.fi, 0);
 
 			if (!dev || dev == nhc->nhc_dev)
@@ -1401,8 +1400,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 		local_bh_disable();
 
 		frn->tb_id = tb->tb_id;
-		frn->err = fib_table_lookup(net, tb, &fl4, &res,
-					    FIB_LOOKUP_NOREF);
+		frn->err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
 
 		if (!frn->err) {
 			frn->prefixlen = res.prefixlen;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 28ba35125383..060501b376a8 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -136,7 +136,7 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_action(struct fib_rule *rule,
 	tb_id = fib_rule_get_table(rule, arg);
 	tbl = fib_get_table(rule->fr_net, tb_id);
 	if (tbl)
-		err = fib_table_lookup(rule->fr_net, tbl, &flp->u.ip4,
+		err = fib_table_lookup(tbl, &flp->u.ip4,
 				       (struct fib_result *)arg->result,
 				       arg->flags);
 
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 20da68240f61..db030bc26b6d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1224,7 +1224,7 @@ static int fib_check_nh_v4_gw(struct net *net, struct fib_nh *nh, u32 table,
 			tbl = fib_get_table(net, table);
 
 		if (tbl)
-			err = fib_table_lookup(net, tbl, &fl4, &res,
+			err = fib_table_lookup(tbl, &fl4, &res,
 					       FIB_LOOKUP_IGNORE_LINKSTATE |
 					       FIB_LOOKUP_NOREF);
 
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 3bc8247b3d75..be1e40780ad7 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1415,9 +1415,8 @@ bool fib_lookup_good_nhc(const struct fib_nh_common *nhc, int fib_flags,
 }
 
 /* should be called with rcu_read_lock */
-int fib_table_lookup(struct net *net, struct fib_table *tb,
-		     const struct flowi4 *flp, struct fib_result *res,
-		     int fib_flags)
+int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
+		     struct fib_result *res, int fib_flags)
 {
 	struct trie *t = (struct trie *) tb->tb_data;
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -1434,7 +1433,8 @@ int fib_table_lookup(struct net *net, struct fib_table *tb,
 
 	n = get_child_rcu(pn, cindex);
 	if (!n) {
-		trace_fib_table_lookup(tb->tb_id, flp, NULL, -EAGAIN, net);
+		trace_fib_table_lookup(tb->tb_id, flp, NULL, -EAGAIN,
+				       tb->tb_net);
 		return -EAGAIN;
 	}
 
@@ -1522,7 +1522,7 @@ int fib_table_lookup(struct net *net, struct fib_table *tb,
 				if (IS_TRIE(pn)) {
 					trace_fib_table_lookup(tb->tb_id, flp,
 							       NULL, -EAGAIN,
-							       net);
+							       tb->tb_net);
 					return -EAGAIN;
 				}
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -1569,7 +1569,8 @@ int fib_table_lookup(struct net *net, struct fib_table *tb,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, NULL, err, net);
+			trace_fib_table_lookup(tb->tb_id, flp, NULL, err,
+					       tb->tb_net);
 			return err;
 		}
 		if (fi->fib_flags & RTNH_F_DEAD)
@@ -1610,7 +1611,8 @@ int fib_table_lookup(struct net *net, struct fib_table *tb,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, nhc, err, net);
+			trace_fib_table_lookup(tb->tb_id, flp, nhc, err,
+					       tb->tb_net);
 
 			return err;
 		}
-- 
2.56.0

