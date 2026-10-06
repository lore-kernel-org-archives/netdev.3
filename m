Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0123EC808
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302219; cv=fail; b=PUzMeOqaks+cqdvK0N9jmjeGlZOUNJVBwHSNJ/AMwx5INzasXrtpuBiTNBAzqA6bo0wccih+6EX/spOiYl/JS0vxPudA+lJvm+3Vm4mvWgQ3cGWcNxa87lGkl3WwuTLYp31L5Wh0hnDDh2SzSFFaKkUl9kJsRi3M9OWpbXY652A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302219; c=relaxed/simple;
	bh=/Zeu9ustPBkCc2XBuC8T24oRd4JrSujo8yr5J+arcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s87hKWHMqYRQ+VWb9SuFkBIDliN/EWWCtb6xwaZcv77U9eGL8gATlA2qFtLCOQnxPSUB3oFl9/rg6fAJw5C8euQiu85jzDuwHiy334jhB0wZ2U3VWc7CdxJarbuDGDWReIBpQY+0KCs7wtKUOwasRceT6SFbUhIHaU0TRFVewMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8LRmQgB; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8LRmQgB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2U2tOGSG4oI768C5QMQj5SEzhraCWvzFlqvvCzhZa6+NQoVWQzxuVOLeoq7URYQDytVaNAuF4N3khHZ1VxXAneHxkC1HAcd8kc8NVSyO7TtgIdrHHjXfPoyP9ELh3bIFI3VQnPKOPVygRboPkbh8T8VpNMVfQaMY/HumUxoY2crTfNU02DLNkkoJdCl6Nhra1OqawS8z4bFjrKl2LtYD97RDUCJ7LWNNLTBkU2mbSgbNXgIIQ/gkjBvIOg9jSwdsfmW84PCf+I56e9yzGsoH+0G324YyDDqeBEeQri58C4pn6fG/DfTVcC87MLrjwaEpoNHt7nUBzojvvbQI4TQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hAyRcjPjfVAH9aTqvujXKy7slPgon3Y0NQoz0g52L4=;
 b=CQkZ7qenId/zIt8oH/NGVpFFaZvihDvfcDlTqEkhF91xkGNyLE/8kN/T/mzXW3YZ6dMc7qdNivinSYEd+Uw3/91dHKdghRwv2hFUyFxEDPv6jhZ7NkEdlDQXW/Nf88EYm8MPTjyiY3uib0YSt3+ER6odthc8Usg2p7LlcWm+mYXzXB6uvVplAt/eE+SjF22qdPRHVu+4rZdRhnsMXQzMPlPv1o46Ws63yatvOC/5NkAF8Zvfo28laQ1ds67WbuoDDIWtx3sIbJCvEMI8Yy6xSmtg7lVRTWX+91kdwH5Ztp+ExfXOaM0RhxjHmxiuHvByu+1VrmZ6l+krhY+wod6SIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hAyRcjPjfVAH9aTqvujXKy7slPgon3Y0NQoz0g52L4=;
 b=X8LRmQgB6BqFPaCPX4ICavHY6bfrUpqzE4/Y4eJ+5zpSLeM7mShSSNqMTDj8eULzkID8qhxYFGDvK0axXHvWylOjPKTug2Mt+jC6Egu2mPGr3lRWoQ9CUuE3aLBfe0j5tZXuyx65aq1OWnfxh+p3bGz/vP7zDSoiRN3EoggNGkZk+9kmCeE2bLNW+vd2x6aQmXIMRR6LF4nNeVT4XxP+8evOZL4bxj8/j7j81fmFSBXoSND+qBJZ31SUifBemARfVdACEhdKoTIyeQkMyMnBCwSqTXTw66Vw35g3+4vwFc2ilrEEKoHknpoo6w1XbtL6Yj333j+NDt7699qNCCRvog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:56:51 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 15:56:51 +0000
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
Subject: [PATCH net-next 2/3] ipv4: Pass netns to fib_table_lookup()
Date: Tue,  6 Oct 2026 18:54:53 +0300
Message-ID: <20261006155454.853588-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006155454.853588-1-idosch@nvidia.com>
References: <20261006155454.853588-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc8ac49-3eb5-4a0b-a947-08df23c26f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rT34lING+QGEn1OldxURJY/gm7rBb2mNT/sILfuxS92F/K5NDabvd23lSzeeXlalazJpKwssC01SBPq8WdzG/PBHWrRZhRBcogk/BeOXNXV6bHOL+k2n5KJL8tPI6v0V5PzxkvbwYguv+x36C/2Yj6ZgD5N7Vxy7vZIjvbOlTCF4uZz2IlOTdmPeS1l5m4y9A1bLmmXLQQmpcSH6Ho/ffSgWYg7YIReCIlNM/XGzixCdIcOzTsZfgF5EMN5tWmB24PfHVgVpS9D9XtfE9ZsfOmfMxUDy29l4P7BBsi7j10afsoXhE32HgyWi5jNyANszXZioWgPBx1KAyU8B7bougSx6zOnwIp6Kx8hKUT9nVoXVQrocju4symV/JvZW7b8fwS8i7rRGjzp1tgFDAnaHX2+fRzoP5MvvLUySkUdnPM5B2KyFY0hKHRlXO/6xlXG6rT9qpSFKJdz40NDLfybebssEgp1s7CAUkIebfaNvPFIu/f9DL6Z/Vmb8Lh3+BODkmUFZt20UsWnsoSvOFhGFS7NT9z2sMnBQ5LtyEHAiCyIUsoSnRkCCds2/O8PgVIeyuRCWamc/upXigoEfLTBj6YmL6nNPDjQgq5DQpkeaww5XJx+XsTVYjAUpT/AclKT9+5z43Bu3bGIxCCl7A10QnUbsP8yZXIbROoTvmDyhBsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmbintvUiCQAZ6ICLNgMvpZpfJd3KC+kBAGAVZTvFReoo5LH8P6gD9AToEKG?=
 =?us-ascii?Q?xY9ZBmGe3JWsaonl2Psn7wMtps8VTx7MPvOa3jsQUU5M0Og/eFtD6YVqKKSl?=
 =?us-ascii?Q?Kx/XNCn8Hl1MttiUyOU1OjOaQSY7FPy8vErRBuyc7lxElJSo0uMPzzWYVOvD?=
 =?us-ascii?Q?aO2mRW+WmLXBKif1QG2xwDD4q7W6kWSwsJCkozjVSxzWE4sR63N8jB8kYzzv?=
 =?us-ascii?Q?o/eMU5So6C0QxyqK2KWjDEc2/zzL6Y0ShDvSkBIJEii/h49MCQLVFtf0jq7k?=
 =?us-ascii?Q?UvWaZyoGz2fmibMwJZC+PMFgABYn17cSzx8GqrlsX6+S0tzvLjtcx60krwIY?=
 =?us-ascii?Q?TNb1UhcCXp33GcHBBenhYCyk/2xlpW3XUzwcExOS0EQg/++NGieNbHbTyXFr?=
 =?us-ascii?Q?MJnnWGaHKJ0TvdT9qG4rz8Z2ZnNpx7fSQ6u8//M0L+mth5Mcm5RfwpLGjHEn?=
 =?us-ascii?Q?tT5BFq2v0Vg8XyI4GMcH0u9iJWyT9oAOqBzlJqM8LvhlJyOUWL1Ar5ParBi6?=
 =?us-ascii?Q?EeqQwVzYN6+Cce06oKXfPpo4fouV1N9UIC+vYzpNmK6d1Vn9GomJbGUf6SMg?=
 =?us-ascii?Q?0qZK5y4UB4D/gGOQI4tYvRnQcrmIKzIC6GIZIrudJLR7o6wKdXlhJweGzkcC?=
 =?us-ascii?Q?RjkT+dwOkFvI7c0gVxkbqRFKCoAt50gohJFeuMtMbrKAwray5MLHi/D3gbkA?=
 =?us-ascii?Q?sI6GWtlv8zEPjRayYFhDlsgvb4P376Ve0jMKgzyaSkTH49f+hBb66MbOa0ou?=
 =?us-ascii?Q?YdukGfr78RySiKPTt86RWsMosSkoA8ejYulhQ6EqKzA+hc9o/xTTqD8Hx2KA?=
 =?us-ascii?Q?PhOl234KMiTTMtXOphCl3QkBpcmcMoCrR22lZPnnQGvWbrb5TC0Ud/ZelEMq?=
 =?us-ascii?Q?2G40gW5pYp+lfUdWShdqwZTOsboek/v3ljQbdPc3F3k0frapkGpyw/7w1CaB?=
 =?us-ascii?Q?/+pSeJx5Sam6TEWbj5yxYYfXeJi8AOjE/Lg8SimFd+sJIf4ijBf7W0yr8snH?=
 =?us-ascii?Q?l8+gj4g7PIOdF367nC3VFhIwUPLFn32UIWfLG5UMnNeww2HzamXrvrO/z+ok?=
 =?us-ascii?Q?6glPgYgOq/diBsm9NHbGGrM/wbfeKMaeFGnlB/tdS7QDTUunhMEouk4YauhS?=
 =?us-ascii?Q?QUI1xszrR1uhcVO8EVjGnv3JeEA5ui4qBVal1JFha4/VcOSf1VjCprxd77Or?=
 =?us-ascii?Q?CivRNBb4Qscl0c5Z4eoZfbzAPBixR9Ptv936Jv5TRDkWkP+5z0fPJG6oktef?=
 =?us-ascii?Q?CmvHVKOUfVhaBE2UlkMBLO9NclDI0haPcCfxVYCQFf+k1h6Fyi1S0F/1n2nw?=
 =?us-ascii?Q?VFwKdeH1HtWIMQw3hkXCwlqMEo0afEarqWd96TD9RMt9x2fWNsizh/o8Wpbi?=
 =?us-ascii?Q?cHEeIbgKzS8J9P3mo1LxdU71fxfrYxbwGR4/X74lzgJaZmFhT/3c6ruXJ1mF?=
 =?us-ascii?Q?aSRcMBpXYtUGb7LMLhlDyDVIxmeBH4ZfLQJIRwOxr5i/gIGCvso/VAwRILH7?=
 =?us-ascii?Q?3tHQmg6DqpyaS15WK2FuE2LmYYoH6whZlTBAePCqYjBlhcJHjcmJH9mGt1Hz?=
 =?us-ascii?Q?b4ZLFJlBhn4Fda7NxLJJrqSGg+aDWcrPp+R4qPCXh0M8RWi3dUQsG9yjNjcT?=
 =?us-ascii?Q?22tjjHG9LwmabH/zCaid9l5fE16TsRh2CmbKAMkwmfIYy3dqbv7yqhNl9WYq?=
 =?us-ascii?Q?VooTE6KMtHTgyhZ/QzWD7F+uL7T84mRUe3hrKQe2e3lxKYvq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8ac49-3eb5-4a0b-a947-08df23c26f4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:56:50.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyrVcpfUuIz+m8GRVFq6VkequzlvisXfWFYT/Y7X77ld0PEf8158vZj56URVhXKhm7UO1aFP8jCVaHZW/ULYpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

The next patch will report the network namespace cookie in the
fib_table_lookup tracepoint. As a preparation, pass the namespace to
fib_table_lookup() and from there to the tracepoint, like the
fib6_table_lookup tracepoint. All the callers already have the namespace
at hand.

Note that this changes the tracepoint prototype, so raw tracepoint BPF
programs that access the arguments by position need to be adjusted.

No functional changes intended.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h       | 12 +++++++-----
 include/trace/events/fib.h |  4 ++--
 net/core/filter.c          |  2 +-
 net/ipv4/devinet.c         |  3 ++-
 net/ipv4/fib_frontend.c    |  6 ++++--
 net/ipv4/fib_rules.c       |  2 +-
 net/ipv4/fib_semantics.c   |  2 +-
 net/ipv4/fib_trie.c        | 16 +++++++++-------
 8 files changed, 27 insertions(+), 20 deletions(-)

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
index feb28b359eff..9a88060aa92e 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -14,10 +14,10 @@
 
 TRACE_EVENT(fib_table_lookup,
 
-	TP_PROTO(u32 tb_id, const struct flowi4 *flp,
+	TP_PROTO(const struct net *net, u32 tb_id, const struct flowi4 *flp,
 		 const struct fib_nh_common *nhc, int err),
 
-	TP_ARGS(tb_id, flp, nhc, err),
+	TP_ARGS(net, tb_id, flp, nhc, err),
 
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
index e84d3cf92247..efcd9fc88139 100644
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
index e3bcc25229b0..f064bee79806 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1222,7 +1222,7 @@ static int fib_check_nh_v4_gw(struct net *net, struct fib_nh *nh, u32 table,
 			tbl = fib_get_table(net, table);
 
 		if (tbl)
-			err = fib_table_lookup(tbl, &fl4, &res,
+			err = fib_table_lookup(net, tbl, &fl4, &res,
 					       FIB_LOOKUP_IGNORE_LINKSTATE |
 					       FIB_LOOKUP_NOREF);
 
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index acb1e4385914..6ab95e19b3cf 100644
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
+		trace_fib_table_lookup(net, tb->tb_id, flp, NULL, -EAGAIN);
 		return -EAGAIN;
 	}
 
@@ -1521,8 +1522,9 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 				 * further nodes to parse.
 				 */
 				if (IS_TRIE(pn)) {
-					trace_fib_table_lookup(tb->tb_id, flp,
-							       NULL, -EAGAIN);
+					trace_fib_table_lookup(net, tb->tb_id,
+							       flp, NULL,
+							       -EAGAIN);
 					return -EAGAIN;
 				}
 #ifdef CONFIG_IP_FIB_TRIE_STATS
@@ -1569,7 +1571,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, NULL, err);
+			trace_fib_table_lookup(net, tb->tb_id, flp, NULL, err);
 			return err;
 		}
 		if (fi->fib_flags & RTNH_F_DEAD)
@@ -1610,7 +1612,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->semantic_match_passed);
 #endif
-			trace_fib_table_lookup(tb->tb_id, flp, nhc, err);
+			trace_fib_table_lookup(net, tb->tb_id, flp, nhc, err);
 
 			return err;
 		}
-- 
2.55.0

