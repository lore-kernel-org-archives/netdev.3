Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00AA628639
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418703; cv=fail; b=uVCoUYNL7XOps/zqulsoMM6DewMQ/YoU5e8bd2JEGVXToI6B5sHuM8EU5c63bZUSyKC1WIDBM9biEEXoQCwi6SQcvwhcxcMagVJY6Z2flPWlcKIzx1Z9vF4DkgLgJDVlUrxYEcNk6E3sWOkFsTmhGOFUZ0NdFLe1RQxXFyKanIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418703; c=relaxed/simple;
	bh=RTtcnrJz1uUhrSwY63wbWhP1lelYa7NVqQDmglo2nvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tE2ufMia8ZlTKlfmiCOP/nBz4+12M9L5G6/SawNSz6SUqfHksLRTLAXcnmssHiXBxNfL9h56LNmZnXzQqJQPzdg+PncpYHtF3HvYFSepSy2sFbsbBEuPrPipyKBmRghUVNivhTsue6L9f0ipgDp+KqzZghIm0K54mUxcOAiykTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tTxeEtrt; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tTxeEtrt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnyU5G7bRZT9HfCwwvjZ4Pt0bCaGutiguph1gyNWNknSIkH1x8zyRB5iR98wB+qqaGLNWQJOlIjKGkYC/fH/lBA8VQcvFvI28fAhklHJN74fuekmb19bLxONj+icCn9UypSsO8cvcPdL5Mxd1tBQLbA24bpIEGI3ncOjUytpbmIeEd00oyU1sb5uNzXIY6ucFAm3PwK9Dq7gSfVYvsOhoWbEUYvlobbwKGabE9A5C4hiKE/64sxg911Ktk6QxTOZSYHnOvq/yNTwABZnmZ5HqnrkDZz/E59psyqpFYENqOefxyO5tJYNslUfS3YkkS885FDW6wGtKOIg6mqDgmJ9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLkYF+1wtoP4dWjJR+frvOO0qrXDZRDdT4Shm+mmbFY=;
 b=v6RJYIX5vreyOHpOGMN7wVsIeJ4Ixj1MiR0ZKfcZA3o2noBbim6QT5V26wzZbFu9P+AWq2ZyOMgWk7VeNUBoq4XhWNW5MM0+YarTitOypT8HxKEHnHtPHv1pqkHHyED6BYGUte3+/mE6VyGK+Aq+zNR7NXkW7bzucq5hCL8rqT4GN96vPgtz4c4dQ1yarc/4vm0tVzFD8mZVUiB0DtIkmc+mcCKzL143SAOq0d1gN99JoruXNDU7SXtFvc+NIpa19xMwIuei9JCMyLhH8gAvy/y6Na3eqWKyK+x1yAIrkjznOP/YrTQ9er62k3Vm2xqySHiSts5hN0OmS6YmsdFmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLkYF+1wtoP4dWjJR+frvOO0qrXDZRDdT4Shm+mmbFY=;
 b=tTxeEtrtW1zcOjX56G27tu0rhRIXgeCS7zurXbEocyn0KUM0ODxXJsAvgNJtaDBmqDo7eavW/Hd7HIpv1oSPwkv/m40DJlJW0fTz66b1NsdXvmgBLnDlJshVtXk34UON9K0qAzLa9Hh4c4FF+tf5RAOZLj8pqGTijScz8Tt1u0Cs1yFckz85KGs2TVKk3bEdsRI5/x1WNSdMmGWccCMjpuJNcxpDjLxUJOBot4pTFD8dOE15NjcNhErXG4+g4m/D62woTM9r06P98o0erClWZjto5hr+b+7pXbOXPDIAIsu0UrOtUHhxnmS/7jHQrMvVX3Y+X5HX1GrvZgkK/gLR+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:04:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:04:55 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] ipv6: Hold RCU when emitting route hardware flags notification
Date: Mon, 19 Oct 2026 17:03:36 +0300
Message-ID: <20261019140337.2886875-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019140337.2886875-1-idosch@nvidia.com>
References: <20261019140337.2886875-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: d02c276e-2721-4fe7-2304-08df2de9f3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qxMoe2RCPwGW2E0uoI8Tsne+eyft5P9GC5Yrc2FGU33+Vl46Kx51iIn5nvX6m8AC+Ynk94cLljiwoem9zh5MkuQU6W5PtFzel+eu/dedlU2ZjAoYLyFsPZniOQWfmydEAoj31XA+6jgntaYSIKpqjj7rOz7QkS83bnXfw4XvwFpQ5+bT1oovnuXQpjFz/otR/3AdgdkEt/25SCYzSD7axrI2Oc5VVKf1458NFQd+utYkog5aL31bLqSIuILT1OUUmZWjwVhdeIkwsJ5onhARkVp9Xm7S45FDggw4YXYIXDFMHTLEr4cjHgz18Aisr5XwcsNqSpDWYJM9aDbZgOE53X6M8MUStVgSaTExD0GSDuYWPnarIp6RWyVJYSGGDvPzbv+TwrRFWIDwvFfya+sfv+wer3nLoJ8D/D83FxDAg1Y869b9HjiQqz7l5UOlGyz5SADOHc5yqzhsT0k4ACaoh27HksUZI0Mh5YSqz02eT03Vc9JW5vSVTFG0CAYP7mwMpCTNUPUmP/mS1PwhuYe+zhIHVkal651huAlnCZqjffejZ9VhNCIqhfJv19J9JVTQjFb9WBQbcyLtvP350nZQMC3sA5QaNpZH/DIwLFMjT9J3k6af9QMxhBkTFLb3WWMbri0G26M6ekPxLZ0C0RGYBhciBllMnzqDk0wBqMTS9RA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iNjKulY7pejHSQ5KNWkq2JaOGufqd7jXuw+8Z88CkZZ5WiI49G69/DSCPtH?=
 =?us-ascii?Q?vgwLmS2gcqs19+/fcrhCF0/Z094oPPuYt2U8pZorWZYYTBy42oQgv4OMaaKq?=
 =?us-ascii?Q?vgXvxe7x+SHN2x/axtD7Q/k5aDIyYyHBz5jnsvtujdG0I6QyoRGDMpoFBhRr?=
 =?us-ascii?Q?e/G1winkBdo4xXRA3nxoIisYSSivbuQm+pNX4wunvkNXrLBbHPgzJllIctUj?=
 =?us-ascii?Q?r8MMS9QUM2JlS0Pny7NZ4qSECK2OAuYEUTMTFHszFX9+xeEOY5OEyPwx9zJt?=
 =?us-ascii?Q?vf0oyEznR6d8AbNXTEj2CGhpm9GF/Zli83LtyfiL9j7tsZUDyrunfFsD5rhD?=
 =?us-ascii?Q?aTTZXt1I/R48ahgLPUBasZOzm2OejjQ9E3Vc3KuLbUCke1y8Xau4SmKanxHv?=
 =?us-ascii?Q?OS7Fjy+eQoXtxVw96cwURCJ67yFLrIPMzRZfq59OeBkzFTF0mEsOcToywsw2?=
 =?us-ascii?Q?rfg/xV0UZu0z2MYd0x4v3bGGYIpLHyzUW+jt6GxFZ/4pt5YpSJ2iryTucQBn?=
 =?us-ascii?Q?2XHI+SD33XLXoWOibxbx5RTH8Np3eK1FNfBRO77NNgbYcTz2nGvjBzydrs58?=
 =?us-ascii?Q?ojeH3eI/8RTko/6amVqwaThSbXjLT5ngsVnFdVcDiJ0lsWRzBJz7SbcP38GG?=
 =?us-ascii?Q?ekjt4CERwwEgnTlj71M67di4Tuj+wS0PAXFs3KlgaetD8mJzL/XrlptW85Q/?=
 =?us-ascii?Q?haC/kIRIKnGXABX2SaWIeaXEqjbr6Cec1NXT94CGbDtwoWAT26A6vnX769t8?=
 =?us-ascii?Q?YbWVI2vR/BR5y/ju/HVYfK7W6qcC0yyJdWTdZBzpY0ZzVtZDK0S5ymCvQhj2?=
 =?us-ascii?Q?tOJBjA15CKacWdrfvVypCCg7Fd9Pa77/A039WbgH4orYpQPaoZhy0Kb9xEjo?=
 =?us-ascii?Q?Kicvyzr3dB4WIIF7kE7RJyx/anicx2MMQMg3WZZMwfe96tpBTXRJAi3n6/R9?=
 =?us-ascii?Q?D9o8OEUVg3iLwtwRisqBYZAd+Zi3ixN4TtsZem3bI2dx+gi3w9+L6Qtp6X8E?=
 =?us-ascii?Q?6xkB0SU9uOWtYB47VuAMWJFA9qWL86selYgJ0fOQth5ESpUv71d2MsrH8dD2?=
 =?us-ascii?Q?lZqvuQ07YnpN0WYgdGwMj2jGa9gL0yh55lYKZNXPsqNfyol2hujM6Y9h+UMx?=
 =?us-ascii?Q?NoWz8YRzOAi/NUaAh3/SJTVEyqNO+4Id3iVNduCFDxtXLB5PwJ7gCx0KZbkH?=
 =?us-ascii?Q?cYJSqAZVV2jBW4SK1FAh9Bnsm9XwDClqa6jftIJCKfvyGzK5F1Npg3qP0sop?=
 =?us-ascii?Q?t61K0VWn5cTy/SDRs7L0fWRd257RIQJJlOUkswaEdSPO3oWPHRzAPeTKoZ36?=
 =?us-ascii?Q?WSjrvbHdvLQ5lvppYhKdl0RJQ75t8sIJIGu2/DtJ91/nvf0pogjsZMd1jq4z?=
 =?us-ascii?Q?8MQAMwpTotZg6WGC5wTpxpbclP2O9FXFyYggFsUsQRppnJ0tuMDP57hRYBgJ?=
 =?us-ascii?Q?I0UgtzDr3BKH2TcnqIbdZ18acML5+s2P1gsSdxhep/bTUAAMcPDjHnosEOL9?=
 =?us-ascii?Q?prHejq/apM+042FRkqBsN/GQF0j6D8Yr/2Ogc1Pucx4FOL5h8ucl8Swd65Me?=
 =?us-ascii?Q?NlPU9y7Q6k8FQEych2gfq8/8flvwTiF8U1+bWwYeTHNhGbPe/qBq/+o80bms?=
 =?us-ascii?Q?7oWwRU6AcG9fsa1zcIRASpNsts8ueb1tMB8dAi7wI/04CLBUX2R1/sjpnmPE?=
 =?us-ascii?Q?PW5QbQWUhJAk6HcC/c7yPXleTDUNxH4XqW/GtW4vVl3VZj2v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02c276e-2721-4fe7-2304-08df2de9f3ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:04:55.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvJugoW0LISJauc5i2B0RimVQyZ6LshNC48elKiIt3ouvWcNtVhYCGlO1xhDX6CBY2jLpJVAPhm2GSnXDeU3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

fib6_info_hw_flags_set() is called by drivers from process context
without RTNL or RCU. When the route uses a nexthop object,
rt6_nlmsg_size() and rt6_fill_node() access the nexthop's RCU protected
nexthop info and group pointers via rcu_dereference_rtnl(), resulting in
suspicious RCU usage splats [1].

Fix by holding RCU while sizing and filling the notification, like
fib_alias_hw_flags_set() already does. Switch to GFP_ATOMIC for the skb
allocation accordingly.

Reproducer:

 # echo "10 0" > /sys/bus/netdevsim/new_device
 # sysctl -wq net.ipv6.fib_notify_on_flag_change=1
 # sysctl -wq net.ipv4.nexthop_compat_mode=1
 # ip -6 nexthop add id 1 blackhole
 # ip -6 route add 2001:db8:1::1/128 nhid 1

[1]
WARNING: suspicious RCU usage
7.3.0-rc7-virtme-g191aa41548b2 #38 Not tainted
net/ipv4/nexthop.c:1539 suspicious rcu_dereference_check() usage!
[...]
Workqueue: events nsim_fib_event_work
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 lockdep_rcu_suspicious.cold (kernel/locking/lockdep.c:6972)
 nexthop_for_each_fib6_nh (net/ipv4/nexthop.c:1539 (discriminator 16))
 rt6_nlmsg_size (net/ipv6/route.c:5728)
 fib6_info_hw_flags_set (net/ipv6/route.c:6503)
 nsim_fib6_rt_add (drivers/net/netdevsim/fib.c:671 drivers/net/netdevsim/fib.c:694)
 nsim_fib6_rt_insert (drivers/net/netdevsim/fib.c:759)
 nsim_fib_event_work (drivers/net/netdevsim/fib.c:856 drivers/net/netdevsim/fib.c:889 drivers/net/netdevsim/fib.c:1493)
 process_one_work (kernel/workqueue.c:3396)
 worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>

Fixes: 907eea486888 ("net: ipv6: Emit notification when fib hardware flags are changed")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/netdev/179152182668.434549.18232968419539498055@kernel.org/
Assisted-by: LLM
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a5e955e56e79..ab355e86ea54 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6500,7 +6500,9 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	if (!fib_notify_on_flag_change)
 		return;
 
-	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_KERNEL);
+	rcu_read_lock();
+
+	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_ATOMIC);
 	if (!skb) {
 		err = -ENOBUFS;
 		goto errout;
@@ -6513,10 +6515,13 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 		goto errout;
 	}
 
+	rcu_read_unlock();
+
 	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ROUTE, NULL, GFP_KERNEL);
 	return;
 
 errout:
+	rcu_read_unlock();
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 EXPORT_SYMBOL(fib6_info_hw_flags_set);
-- 
2.56.0

