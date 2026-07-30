Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66083BBFB2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400463; cv=fail; b=dzJ1gFkzK7189E4YoC+o34Rummv09NEnp0U2BWgFlzFVuDLPziOCQlhby4KySHZKzd+SmrTgI69u6SFVt+tkTTHjTd0hh04oaF9HNOtZwgFCING/PNuBN2yfQRgVCKw/0H043w+x9MIP4fjlZMmbgyFPaiMNVInx4lDkLDCQcYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400463; c=relaxed/simple;
	bh=3Igom/XXCJzj/tFTL0YPDa3o6iZj1+TyytTBhvGWSQI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DhOkHNPoekHfejJ/l9QK92BPsQD0xkwThzmMjyoc94uKqmygOWoa2GGniC5JmGYHF4ccRyslGvIlTyApB/gruXzZp04Kxl23N6/9UPja34hPHGWaCLQXaJWjMdg12nn6m0eI6eU+Ch00QRzdAeJRUkWhQYR5R3XO/HkkHR/4OvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=p+6c3W6X; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="p+6c3W6X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iaz5gqnuExitJ8ZLv1VhcMs5IE6FcIPB8hhOQQb5/70j/D8lF3fg+JgVNCtj6s6OH9lE8fX8feQAWWBhD/msFIYyUchm5HdLkz9jx7sS1vsrm7OtfH+524ft9fcm7x4u4KU+vfq+pITJ61zUeZ8n28N56oQO+RSADPm3see0IwoPAJ986tx+A796GjMWDlIltEhZWFsTeXz2SWEWhpiKsaJh4XWYnub+paTYw/PORY5uApxM6378HIbNFALgcQY5diXbvfKVVgfem6jUJ+R69i10jFwvpOLV6iWahej83yKJQhwrZvt5aafHp5ISHKKkETlY1a+DlGn1Y45jO6n72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYtgoYf6nU41dioWzjl8Xu0UxLaCP5dVx67GLTid2jE=;
 b=U7MERwpxQLYDb3z1ZARTmRznJ8Z3MnYuGy84+7TCA7LcLU9hAd5efrNYdtWgtiswXqzQ+Ks51NL0YGx47xrRbYqF26YonDUc0Bc2SMaYmXBeq2MpnVuo81j0g/1kAVoBtJKgnoNvtU8JXtWrUu0cqTSSBTv478vP+sFbQVWecx/gQiMZe9/5zQXvrsK5KLfGKI/IY4MGSzI0rzk/tgTAYvbjIkEamk1ESwjgWuVYMjki/vJL6Znt7TS+AociTmzwmBYoMvi/okBVLwVll4kavbplrEEHVxn5rTLyEGbVpMdB+DeiZ8IQ4XQUAIs9Pp71qGhand/LXJ9NNK3Ga4bZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYtgoYf6nU41dioWzjl8Xu0UxLaCP5dVx67GLTid2jE=;
 b=p+6c3W6X/UmaamYmMzGIRrQmN2Zl3V+05vQ8a0bHq0mKxAfGzyAQpJhG3wjFrkOjzApelIT3XvfPKKfIrRSpGJ7OBZMNJM3Jd9htqRhzyUFKSPz1O8MmdGQC/OLIEHhxCwbEbBKWC3h1vgiFrn4HTieIzXxCp3BwF+m8wo1rnAiQBq/i45vqKWNQXMrJ1XqZvAOySMOi9z1C+6yVWp71B6ibJzgen9bGgtEHiUcoHbpCUTF0cBwMhGAREaapcSRx4F5V5sEXOV2ErisH/LpaKKdRGSHpyYB8Rut5H8WdimSA0M/g6Pp1hWlSJan7IvG0XofBL0kLFMO2eTmyulotZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM0P189MB0674.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:19c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8; Thu, 30 Jul 2026 08:34:14 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.005; Thu, 30 Jul 2026
 08:34:14 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v9] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Thu, 30 Jul 2026 15:34:01 +0700
Message-ID: <20260730083407.14915-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5b::17) To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|AM0P189MB0674:EE_
X-MS-Office365-Filtering-Correlation-Id: bae660fc-8388-4b12-6c53-08deee15563f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	deSUnTe5YqhG13epUc44tEY3SIqoxa5u/JScLlJb+ZJCmAo27d1ZP1t/WNay21D3cv5avHs/cLGWBzp0TP6+TnnqEmK6hcaBEdIYc4TsxZ5gKSqdo0DF//nHyIkPsNOF3bCVz+4yVnMPNn+nc73thH5iEoM4MutJTgw8BJwjYzIb52VQUMlb7ffQM5X/HRA2YFupWtjfB+Nyw3nt+Inuh2y9gSEE7oFVRQJKk+Kit641Y7Nr3KgNQTUaY6dM60dcxfwzDvmBTLx6Fn2J/a2tIyNP86Dtq0HUUFT24kXDDa5hFEyk0D1CU0GOeXiSwXswbapPIBxtluWlLP2tBlhYVB0y9SU+PxpjfZNLIs9HVPvmgjvt5wEPt0aD8mtQs9l4eDHhYZxcRUdNkp+eyo5anqAx8rTtA6Aaujem3fID5FP7tEs+yoDe2AumRo1+QTJHUzgTYGtMjbiQKfM1F/aOBt6Ujas5GL8ovU1kgNFJ0sKXOlUyhGroWs3+GzFSoNu/4KVHZRR4VLo7HZSMaS9D0J9tiIdpDkkJd7GS8nYPjHr+8bY1d+qv4LLhxu/ZWXtk8+sEX7P3+AO/2g8+1z0/D8WMMyL8bgbBSX7rbpT1RnYYqsWqhEejBapncVCLUb/kD2CkLl7LAyomHAGpA9lKGo4RCLQIjKw4bRUakjmWAa4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0b1fPESDSKCQda5G7she3h6UpnDGDjJ/O1GYFjW5avyvmugtF5ZhfxeP+1X?=
 =?us-ascii?Q?sQ8PEKqRq3KrJ7wz1m7ud+i+43Qmb5gKJmoCYi6zTbiCjEn1uS2NsgpAyEh/?=
 =?us-ascii?Q?0FRnjxFFhENHdRD7CqZ2Nn+NvcPGL4OTV0IDjW91iyZ4AwZpsToc4A8RAdYN?=
 =?us-ascii?Q?igLFEnuErJuBe20/FiR7QKjKmab0BqjijC7lK2C/U6RCT1fZmxrPLssIWsPh?=
 =?us-ascii?Q?B+dRW2p49358bJGkMHiwEcEUuhxpsYkuDzpRDuWfOHwcNkB0pvpea+ZShk0j?=
 =?us-ascii?Q?SkgW5CFprMfMPa+cuIKhO2In7PNMR3aADi7uMJQSd60awRcmA5MJMbTAlfxT?=
 =?us-ascii?Q?boJR2W/aSdVR6tiwRZSR3kzatyNhVBFL826vBZ6z7ajbv+H8U8WEYOVpOZGn?=
 =?us-ascii?Q?S1dtrYNO4Ws6r4wEksG/ttLXUiqk7vjsr0o9YT1ATWQHiWfiIEzUt0+35LV0?=
 =?us-ascii?Q?poPSEodkhVldLHmz0urFWsPfGSH/PDkli9jk8M1C4RsyKyBsezX8QOSg0/gO?=
 =?us-ascii?Q?CkduRdSATM/VWIILpHIZCoBWUuKQuTFEO2/mHOU+np3D4ksnZ2JpmMPt8cUu?=
 =?us-ascii?Q?1+kxbFnFYMmpxj6mpC576FhA1nyT4Q/rlcZUcAb5+jF+gNp6PQU8m1im05fB?=
 =?us-ascii?Q?nBnYg+FEsTX89tloK+ct1EphPtz7bngsa7bJlBZSxdIWSUtbAthwWAq0Y4SA?=
 =?us-ascii?Q?QS5IKG7AdoowndvQWok1jNppzoHOxhrtH2LQt/dZngooskmJPElbh4EkM0pg?=
 =?us-ascii?Q?tKrmSu2yafQ1hevOtoAtfDk5K8AlP867f7Y+lEWbYriYouxOdP9We1iZDnTt?=
 =?us-ascii?Q?pBLMwHDagyDq01oONPBJn+6X7CeZ51fch/0X54wq9XotjVq8nNlyOEB+cb2c?=
 =?us-ascii?Q?qPCR9SFL+PjHUChtFL6AHuv5Xx7/McsmbMK89xHwNdPJsyEARO9brl0cEj9R?=
 =?us-ascii?Q?Yr7oyPcoLyPIlswO4Zt4Biad94MYHn13VnSjK5qzENxIaQ4B6c1ekC8UkJlG?=
 =?us-ascii?Q?LHUR8MBhGxh2AnopFNrnHBQnzyUoHOQNsHasL3DTGX4TieUTWuRsFOR77VRV?=
 =?us-ascii?Q?Yrr0NuuwUAHlYd2bzeBBdctEqjeGWXvIgKzXhy/2xRTcjfvLVo9awA9FVDqi?=
 =?us-ascii?Q?iGYsfg4m1Nvc5KJ32vyQtmCWfYGSWrzzLJEJXsMxhbcvqACWbXJjHJczSydd?=
 =?us-ascii?Q?4AnhJgCckwRWNKs3X/jMiaAY9t4aVLnYatPYTYZkQxO4HOc/rhXgJ82YyiPw?=
 =?us-ascii?Q?FOWbjqTO6FMHVmTIDFh1WoYL5RJpaqeYflEyDCBPknjWDOyDI3PC7DPHyAvM?=
 =?us-ascii?Q?KH6YITOqvN4CMuin5ehRo5cXtuRYunkhKE5TPDAp15rrz8TfSP2vXyRzZ+0D?=
 =?us-ascii?Q?O4/CdWD/lIuEUXUf65xbPgQZWNspv0+xgipUDGWwOgq7xm+TmAimFqBN2EvW?=
 =?us-ascii?Q?ne8qMZSPbdUA74buC4GLywGD0zre8rjjQ5iFhiCo3TsMMJt3u84jHTH/pWSz?=
 =?us-ascii?Q?TDmDyCuc8z5z9o/yNtwirP4dT3tOdf4YeVcn/HnaVm03yhbVNqYrFn5Iy95q?=
 =?us-ascii?Q?ycKCsTjM7mh3+BrcmeIAgQtavauxDr6V6lLHp/azGzCPLdDMkE9umIoQaXZG?=
 =?us-ascii?Q?IAp36tTVrQc70HJ1cOaIL7DLdX4YZPugaNb4oXf8fmj47I6UO58TkvHZtmnL?=
 =?us-ascii?Q?PHVaT+tamY0zCicl7lxU+QrPn6v8WBkaD/pVETE+b5oUO2kAuMXmU+Q8NCZO?=
 =?us-ascii?Q?7rj0ugMpamY7yI+RotDr0YL9+nqj4I4=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: bae660fc-8388-4b12-6c53-08deee15563f
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 08:34:14.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT8KMcaXQGZjW9PLagUdKgxZidewIvFrQvlxzAIentkXrSH/g3gCnSPxNLples1jsAXUNRhgcJZG1fQytwSmEKZ4xS1hXeoy60Cyz02Pbr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0674

User-space applications can bind a large number of service addresses to
one or more sockets. Each binding of a local-scope service address inserts
one entry (publication) into the TIPC name table. If the number of these
publications exceeds TIPC_MAX_PUBL (65535), protocol service types
(such as node state and link state) are no longer inserted into the name
table. This causes two issues:

1. User-space applications subscribing to node or link up/down events
   stop receiving notifications.

2. A NULL pointer dereference can occur if an address is assigned to a
   node after no slot for a local publication is available:

   BUG: kernel NULL pointer dereference, address: 00000000000000d0
   ...
   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc4-default+ #5 PREEMPT(full)
   ...
   RIP: 0010:tipc_named_node_up (./include/linux/skbuff.h:2251 net/tipc/name_distr.c:195 net/tipc/name_distr.c:221)
   ...
   Call Trace:
   <IRQ>
   tipc_node_write_unlock (net/tipc/node.c:428)
   tipc_rcv (net/tipc/node.c:934 net/tipc/node.c:2189)
   tipc_udp_recv (net/tipc/udp_media.c:389)

   Thread 1 (tipc_net_finalize) | Thread 2 (named_distribute)
   -----------------------------|-----------------------------
                                | ...
                                | list_for_each_entry(publ, pls, binding_node) {
                                | ...
                                | __skb_queue_tail(list, skb);
                                | ...
                                | }
                                | ...
                                | hdr = buf_msg(skb_peek_tail(list));
   ...                          |
   tipc_nametbl_publish();      |

   If 'tipc_nametbl_publish()' (Thread 1) fails or executes after
   'named_distribute()' (Thread 2), list will be empty. As a result, NULL
   is passed to 'buf_msg()', leading to a NULL pointer dereference.

Fix the fisrt issue by allowing protocol service types (node state, link state,
and topology server) to be inserted into the name table unconditionally.

Fix the second issue by deferring each node's cluster-scope publications to
that node's workqueue if the cluster-scope list is still empty. The workqueue
also retries 'tipc_nametbl_publish()' if it fails in 'tipc_net_finalize()'
(Thread 1).

Fixes: a5e7ac5ce134 ("tipc: fix regression bug where node events are not being generated")
Reported-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/core.c       |   3 ++
 net/tipc/core.h       |   4 ++
 net/tipc/name_distr.c |  91 ++++++++++++++++++++++++++++++----
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c |  30 +++++++++--
 net/tipc/net.c        |   5 ++
 net/tipc/node.c       | 112 ++++++++++++++++++++++++++++++++++++++++--
 net/tipc/node.h       |   1 +
 8 files changed, 231 insertions(+), 18 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..1e1fe78cc4ee 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,8 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	atomic_set(&tn->node_wq_count, 0);
+	atomic_set(&tn->finalized, 0);
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
@@ -119,6 +121,7 @@ static void __net_exit tipc_exit_net(struct net *net)
 #ifdef CONFIG_TIPC_CRYPTO
 	tipc_crypto_stop(&tipc_net(net)->crypto_tx);
 #endif
+	wait_var_event(&tn->node_wq_count, !atomic_read(&tn->node_wq_count));
 	wait_var_event(&tn->wq_count, atomic_read(&tn->wq_count) == 0);
 }
 
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..be335ce83389 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,10 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* The numbers of works of created nodes in schedule */
+	atomic_t node_wq_count;
+	/* flag to wake up scheduled works of created nodes */
+	atomic_t finalized;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..c8e28497356e 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -147,8 +147,8 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
-			     u32 dnode, struct list_head *pls, u16 seqno)
+static int named_distribute(struct net *net, struct sk_buff_head *list,
+			    u32 dnode, struct list_head *pls, u16 seqno)
 {
 	struct publication *publ;
 	struct sk_buff *skb = NULL;
@@ -164,8 +164,9 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 			skb = named_prepare_buf(net, PUBLICATION, msg_rem,
 						dnode);
 			if (!skb) {
+				__skb_queue_purge(list);
 				pr_warn("Bulk publication failure\n");
-				return;
+				return 1;
 			}
 			hdr = buf_msg(skb);
 			msg_set_bc_ack_invalid(hdr, true);
@@ -195,15 +196,16 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
+
+	return 0;
 }
 
 /**
- * tipc_named_node_up - tell specified node about all publications by this node
+ * tipc_named_distribute - distribute all publications to specified node
  * @net: the associated network namespace
  * @dnode: destination node
- * @capabilities: peer node's capabilities
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+static int tipc_named_distribute(struct net *net, u32 dnode)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
@@ -212,15 +214,86 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 
 	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
-	if (!(capabilities & TIPC_NAMED_BCAST))
-		nt->rc_dests++;
 	seqno = nt->snd_nxt;
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+	if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno)) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return -ENOBUFS;
+	}
 	tipc_node_xmit(net, &head, dnode, 0);
 	read_unlock_bh(&nt->cluster_scope_lock);
+
+	return 0;
+}
+
+/**
+ * tipc_named_node_up - tell specified node about all publications by this node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ * @capabilities: peer node's capabilities
+ */
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+
+	spin_lock_bh(&tn->nametbl_lock);
+	if (!(capabilities & TIPC_NAMED_BCAST))
+		nt->rc_dests++;
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	read_lock_bh(&nt->cluster_scope_lock);
+	/* 1. tipc_net_finalize_work() is not scheduled because of namespace
+	 *    teardown.
+	 * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
+	 *    to insert node self address publication into nt->cluster_scope
+	 *    due to memory allocation failure.
+	 * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
+	 *    executed yet.
+	 */
+	if (unlikely(list_empty(&nt->cluster_scope))) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return 1;
+	}
+	read_unlock_bh(&nt->cluster_scope_lock);
+
+	return tipc_named_distribute(net, dnode);
+}
+
+/**
+ * tipc_named_dist_cluster_scope - distribute all publications to specified node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ */
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
+{
+	struct name_table *nt = tipc_name_table(net);
+	bool reinsert = false;
+
+	read_lock_bh(&nt->cluster_scope_lock);
+	if (unlikely(list_empty(&nt->cluster_scope)))
+		reinsert = true;
+	read_unlock_bh(&nt->cluster_scope_lock);
+	/* tipc_net_finalize() ---> tipc_nametbl_publish() has failed to insert
+	 * node self address publication into nt->cluster_scope due to memory
+	 * allocation failure. So, reinsert this publication.
+	 */
+	if (reinsert) {
+		struct tipc_net *tn = tipc_net(net);
+		struct tipc_socket_addr sk;
+		struct tipc_uaddr ua;
+
+		sk.ref = 0;
+		sk.node = tn->node_addr;
+		tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
+			   TIPC_NODE_STATE, tn->node_addr, tn->node_addr);
+		if (!tipc_nametbl_publish(net, &ua, &sk, tn->node_addr))
+			return -ENOBUFS;
+	}
+
+	return tipc_named_distribute(net, dnode);
 }
 
 /**
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..cadf4e8c3e66 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,7 +69,8 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 253c72d1366e..6fda36ab1766 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -763,21 +763,40 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 					 struct tipc_socket_addr *sk, u32 key)
 {
 	struct name_table *nt = tipc_name_table(net);
+	u32 max_user_pub = TIPC_MAX_PUBL - 1;
 	struct tipc_net *tn = tipc_net(net);
 	struct publication *p = NULL;
 	struct sk_buff *skb = NULL;
+	bool protocol_type = false;
 	u32 rc_dests;
 
+	if (ua->sr.type == TIPC_NODE_STATE || ua->sr.type == TIPC_LINK_STATE ||
+	    ua->sr.type == TIPC_TOP_SRV)
+		protocol_type = true;
+
 	spin_lock_bh(&tn->nametbl_lock);
+	if (protocol_type)
+		goto insert;
 
-	if (nt->local_publ_count >= TIPC_MAX_PUBL) {
-		pr_warn("Bind failed, max limit %u reached\n", TIPC_MAX_PUBL);
+	/* Reserve one entry for node state service type because it has cluster
+	 * scope and it is distributed in bulk. So, the maximum number of user's
+	 * publications is (TIPC_MAX_PUBL - 1).
+	 */
+	if (nt->local_publ_count >= max_user_pub) {
+		pr_warn("Bind failed, max limit %u reached\n", max_user_pub);
 		goto exit;
 	}
 
+insert:
 	p = tipc_nametbl_insert_publ(net, ua, sk, key);
 	if (p) {
-		nt->local_publ_count++;
+		/* Not count node state, link state and topology server types
+		 * so that maximum nt->local_publ_count does not prevent
+		 * protocol service types from being inserted into the name
+		 * table.
+		 */
+		if (!protocol_type)
+			nt->local_publ_count++;
 		skb = tipc_named_publish(net, p);
 	}
 	rc_dests = nt->rc_dests;
@@ -810,7 +829,10 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 
 	p = tipc_nametbl_remove_publ(net, ua, sk, key);
 	if (p) {
-		nt->local_publ_count--;
+		if (p->sr.type != TIPC_NODE_STATE &&
+		    p->sr.type != TIPC_LINK_STATE &&
+		    p->sr.type != TIPC_TOP_SRV)
+			nt->local_publ_count--;
 		skb = tipc_named_withdraw(net, p);
 		list_del_init(&p->binding_sock);
 		kfree_rcu(p, rcu);
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..75ac4e3cd01a 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -139,6 +139,11 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
 	tipc_nametbl_publish(net, &ua, &sk, addr);
+	atomic_set(&tn->finalized, 1);
+	/* Wake up nodes waiting for distributing bulk of publications
+	 * if applicable.
+	 */
+	tipc_node_wakeup(net);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..334812bdab76 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,9 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @work: work item for bulk distribution of cluster scope publications
+ * @work_scheduled: flag to indicate the work has been scheduled
+ * @finalized: flag to wake up scheduled work
  */
 struct tipc_node {
 	u32 addr;
@@ -145,6 +148,9 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
 	struct tipc_crypto *crypto_rx;
 #endif
+	struct work_struct work;
+	atomic_t work_scheduled;
+	atomic_t finalized;
 };
 
 /* Node FSM states and events:
@@ -393,6 +399,59 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
 	write_unlock_bh(&n->lock);
 }
 
+static void tipc_node_down(struct tipc_node *n)
+{
+	int bearer_id;
+
+	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++)
+		tipc_node_link_down(n, bearer_id, false);
+}
+
+static void tipc_node_dist_bulk(struct work_struct *work)
+{
+	struct tipc_node *node = container_of(work, struct tipc_node, work);
+	struct tipc_net *tn = tipc_net(node->net);
+
+	wait_var_event(&node->finalized, atomic_read(&node->finalized));
+
+	/* node is down */
+	if (!atomic_read(&node->work_scheduled))
+		goto exit;
+
+	/* Stop waking up work in tipc_node_timeout() */
+	atomic_set(&node->work_scheduled, 0);
+
+	if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0)
+		tipc_node_down(node);
+
+exit:
+	if (atomic_dec_and_test(&tn->node_wq_count))
+		wake_up_var(&tn->node_wq_count);
+
+	tipc_node_put(node);
+}
+
+static void tipc_node_cancel_work(struct tipc_node *node)
+{
+	if (atomic_read(&node->work_scheduled)) {
+		struct tipc_net *tn = tipc_net(node->net);
+
+		/* Wake up scheduled work if it is waiting. */
+		if (!atomic_read(&node->finalized)) {
+			atomic_set(&node->work_scheduled, 0);
+			atomic_set(&node->finalized, 1);
+			wake_up_var(&node->finalized);
+		}
+
+		/* Work is pending */
+		if (cancel_work(&node->work)) {
+			if (atomic_dec_and_test(&tn->node_wq_count))
+				wake_up_var(&tn->node_wq_count);
+			tipc_node_put(node);
+		}
+	}
+}
+
 static void tipc_node_write_unlock(struct tipc_node *n)
 	__releases(n->lock)
 {
@@ -421,11 +480,32 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 
 	write_unlock_bh(&n->lock);
 
-	if (flags & TIPC_NOTIFY_NODE_DOWN)
+	if (flags & TIPC_NOTIFY_NODE_DOWN) {
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
-
-	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+		tipc_node_cancel_work(n);
+	}
+
+	if (flags & TIPC_NOTIFY_NODE_UP) {
+		struct tipc_net *tn = tipc_net(net);
+		int rc = 0;
+
+		rc = tipc_named_node_up(net, node, n->capabilities);
+		/* Defer bulk distribution to work queue */
+		if (rc > 0) {
+			atomic_set(&n->work_scheduled, 1);
+			atomic_inc(&tn->node_wq_count);
+			tipc_node_get(n);
+			if (!schedule_work(&n->work)) {
+				atomic_dec(&tn->node_wq_count);
+				tipc_node_put(n);
+			}
+		} else if (rc < 0) {
+			/* Bring the node down to start over bulk distribution
+			 * when the first link is up again.
+			 */
+			tipc_node_down(n);
+		}
+	}
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
@@ -564,6 +644,9 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	INIT_WORK(&n->work, tipc_node_dist_bulk);
+	atomic_set(&n->work_scheduled, 0);
+	atomic_set(&n->finalized, 0);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -653,6 +736,21 @@ void tipc_node_stop(struct net *net)
 	spin_unlock_bh(&tn->node_list_lock);
 }
 
+void tipc_node_wakeup(struct net *net)
+{
+	struct tipc_net *tn = tipc_net(net);
+	struct tipc_node *node;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(node, &tn->node_list, list) {
+		if (atomic_read(&node->work_scheduled)) {
+			atomic_set(&node->finalized, 1);
+			wake_up_var(&node->finalized);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void tipc_node_subscribe(struct net *net, struct list_head *subscr, u32 addr)
 {
 	struct tipc_node *n;
@@ -801,6 +899,7 @@ static bool tipc_node_cleanup(struct tipc_node *peer)
 static void tipc_node_timeout(struct timer_list *t)
 {
 	struct tipc_node *n = timer_container_of(n, t, timer);
+	struct tipc_net *tn = tipc_net(n->net);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
 	int remains = n->link_cnt;
@@ -814,6 +913,11 @@ static void tipc_node_timeout(struct timer_list *t)
 		return;
 	}
 
+	if (atomic_read(&tn->finalized) && atomic_read(&n->work_scheduled)) {
+		atomic_set(&n->finalized, 1);
+		wake_up_var(&n->finalized);
+	}
+
 #ifdef CONFIG_TIPC_CRYPTO
 	/* Take any crypto key related actions first */
 	tipc_crypto_timeout(n->crypto_rx);
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..c7bc3bc05328 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -75,6 +75,7 @@ enum {
 #define INVALID_BEARER_ID -1
 
 void tipc_node_stop(struct net *net);
+void tipc_node_wakeup(struct net *net);
 bool tipc_node_get_id(struct net *net, u32 addr, u8 *id);
 u32 tipc_node_get_addr(struct tipc_node *node);
 char *tipc_node_get_id_str(struct tipc_node *node);
-- 
2.43.0

