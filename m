Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FA19D065
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809801; cv=fail; b=M285AiDOEU/w8YUZUToOjVe++bekHkdW9gM3I0zQaZpdF7IXQ5VBqKF1zcj0EBthxfD4EvSN2OYDdFd7GftvtAIryLIgClAus01BJ4mYvv5OwNIvUpHHRg61EN0rvzLZ4qUE/tyHXzk0lhSrXZdI1oiKA0jVFZBGGRFYSvtIpiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809801; c=relaxed/simple;
	bh=8ho73LdeRIRCowX90qLryOeoXFzdcUWJmuSfBFN+q7s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=smxjMli71DuMldYg+gwlfQeB6q1ab3Crcfx6bZMiw7FTx3gzJD0Kq3mlI3ZNwA1sZFvNOafTvncVnDd4BtUiJ86JAkSBzk5yWokuDOtAv/wpuNoShG+1RrWzD6djp2jSaQ4I4YqcsTTb2f9KSHgnBnAAVf6Ab7k3H7EdyTmsWac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=noPcpnir; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="noPcpnir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRg4iZfsXhCbaic04T25PxUQ+Zf0jU8mMDFR0ABKb1H8ZrIOZRc1C/qOwH7gjYOqN5zMtF+NM/vXKskiaa4sxVNU9ksdyEeGWZtvE+HDTatkat8yXIhy/LeZA0r1AmMtL7A6sO0KtstE3nrAwBQWBK0MQR+L+L6NfO5Wd0RFsjWwO3PxAAPQsiAzTVftudUOMHrwelrvWk5CALccjX8LEyhjilDzi2GdO1SXSB+tH9uftB6aJ6r4HROUB2gwQDF4F71UVJP8dU1Psa7vQD8IrC49UyGh+h0yvlewFiDFBFZlpDTLaPq3lLII7WxsWZ9/fkL8R/UZoR3d9TG+EFl5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bz0T3RVQypVTr5t8TQacPZSn+AHWpeIny/jkqROVU8=;
 b=IabqnJN4EhlK0YiV5tyNax6go6Qt3b5eix2mSfndNP9a0xKfjNMspfHfhViMfwJN3mXQ0PEmx2P3VzzhZ/2lBZCih40bNlUE1pV0EWAqLh0LamMEgZGnaceqoYY8GI/nCXGphn+AxSKxKtMMpUilc7JH0trl+EuUMZicGNozheidznQlXtGIFB/8GNzt3A9dR0RbcWXlMgCRl0j5N/Eg7irlbl2mS1zUCyve6cka0fJLH2VRB8r1wbXLpJlsxHvvDFdWi4UZw7ZEFBSLSV0xIW4dg3cGErXp7jB0021EaFmB2V/l/msDuOskejwJoDOkF+F1WG4t1FgAdopsah8Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bz0T3RVQypVTr5t8TQacPZSn+AHWpeIny/jkqROVU8=;
 b=noPcpnirpOT8uQdv+rypH+gH3Gi1AcI9LVU3b9R6BKMzWkNyVqsXjFA0jWr/MBjLBs0pTHZHVdqUMRo3iaaMklnv8lW2MSPbpGC5HAolkGRdiWMpJ+7Pv8S17DRjucD3brWsnpWmS03wpeodc3ZHCKTVPoZYazPpxR8EiJlCoTQdLZTc9L5reHE4rV0VqwDzYLUOvL4VLql3o5GzmZko28EAYJUZBPl+yaLftAZjuUG3jPNwaIf3LTf2vbw6sRfQKk62UhDGDE6aoDBtfogm4z5q75WHwc/AYls87AJH5IvCOYSKRSoieKgcFvWFNwlB2EVtFI2zni03b3M+koDYxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB0713.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:122::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 02:16:35 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 02:16:35 +0000
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
Subject: [PATCH net v10] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Tue,  4 Aug 2026 09:16:15 +0700
Message-ID: <20260804021628.28607-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|DB8P189MB0713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cde77d4-a2da-41c5-7a78-08def1ce6852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fLnQbI/EeDlxb2mc3zuNFhjlRiFfq9E+SZkUbD/HlfcFxCaz//RxxXOc5BuZQjYWVffylyLSRcrGp6R60vNyzQexMKC7chXeOhgdKGBthiVOOjNl+OtjK67W0uEm2vBnW4HQUh2mNVkIIQf3wfFLAHd6qZ0FpPkelKEeg0ILkmrFqKk6wihbsICZBeDVAym2LKkQFmkrVigdhjueo/TqkaaAO1WDm+QYNW6eCNZ9P5G5/VQ+Lj9ES3vbWwWk2luSc6PIuEw+6r58X/EzoN5P8g0xlca5JyyurjA5TOelW4xyVbM1P2y0vNrM2UchONikKpusxN7XGGKSsTj3lvruMfCOQ9ZsQistkh4qhFGf6aR7HmAblPXrjF3V9LjUi+3Bnx0B9q7oUill7tFeWBBy2vKzdFNPAgrgrlB9j5c0fXodh95YDANhb8ulhUdpQq+1qi+6KNv46RlWwxEicYZ1N75qn8/KtxlWG9oOs8EABMiwGdhbl8QUkGupW2TPBvLyN3nWrBzDnVWBmhk9BQDSAmK5xlXp8Btc8V4bCfV8v26NXjRryFZn42JNKKBMBJpCZUibG5Xe/FZIdUZ+fabnPwqwtkKCZjRcICn/chaQ1JvlB2rXIlm6A07xIrk653tDMZ2VEO0J3wOq3yhP8ZvUbY+2Vy2d55Jcr5UPT5Y1//8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Keh7YSCoCvZlEj8gPHf4o/0xgEvX00UbubpGvNWx7Azi5ZC0ucl50qYdYYGg?=
 =?us-ascii?Q?WqMDFqfnpAkpwkbmDsleTNz1wsh6DluE+XTwZkRGHJNBCtBKYJcwHDi4+QMn?=
 =?us-ascii?Q?TofRGZaOvOkVVUAo2yiRzowCwoCZrQ3nRge3aGhF3TDkxjOK/xEa7dbwBcAr?=
 =?us-ascii?Q?jfLRqb3tLWNWOBItgAiT2drvW4Z71/w2mO9N/uBn9FuXze2mVyg26b7AOJ7c?=
 =?us-ascii?Q?KOvXm3t8ALI7XG+/PSAztwcneL+LmAl39wJ6Wjo5OjJsFP2KU79XCtJq8VhW?=
 =?us-ascii?Q?lTJR3YKDub4rIE/x1DYi2/HxKwGe6pIeXRJvtc3hPhEraAPt8sBWta+1zaMu?=
 =?us-ascii?Q?+jN2BkwGvdpephE901sbMpdKvoFeJYJjh3feaB9VchYnANIzcN+20XxOKHLv?=
 =?us-ascii?Q?ITGDawExWLUxvmUOuvsaRGy+BmPwEei8CDAdelSLmxqa8JP0Xk7jIB0qstkz?=
 =?us-ascii?Q?u3Fb7qx0bqg3vT0G6bFlvPrAleMQ9BIPGtPbWwjhAVKfRScGzp38vYcJKHSW?=
 =?us-ascii?Q?f4Sc/9JFTFAJ/m5L5qZzMO89acC+cUtpyqunSECppWiSmpQ+pDZT2sf5TsdM?=
 =?us-ascii?Q?QECQ3oMvL+qNshzl0m6wsHk8fOQOWTUR8ywW6zZyV8LPnC6n0K7V2G75YfV+?=
 =?us-ascii?Q?YSzaqScSGtnDTnTzcMjzqtflYq/yL5InexkhWK2vsiXodyi7wb2fTzAN4zbQ?=
 =?us-ascii?Q?I0X14QjaZJuX7L+m1ubYVL8d2GcM/bzkDr879lBK94+LmqfUHnawrGwiwkrj?=
 =?us-ascii?Q?6cmcX7tSKSUB7IZmP9BFfhdMbBI+OHkWE7eyaO1tagEQJRCOQKA9NgO84VZt?=
 =?us-ascii?Q?hLhq0MbHohDlUbuXJ1/ZLwaODamlQL34Vvh7kvmfIKaM09ic13Whf5ozOeTj?=
 =?us-ascii?Q?J+d94mCCMJ7lQK6nw7I21etVN0Z7hnSoQ1A6vMA4c1fURA1qFC+hvq10V+KD?=
 =?us-ascii?Q?7g0zZEtXyTSBE6qfxRDVaRmOO7Yqy3RdaklTzvsnBoJHySaRYlLEOqsQBbyS?=
 =?us-ascii?Q?/A1xl48UCgDd6ZtTOMKxhitnC+wVS1cDUakFHt7pdWBsLoT50KYwsY4KruaU?=
 =?us-ascii?Q?LrMHa5yz2NOAM8/S6EEkhMOo5p7XlFPKDznaikMsffmkGU/86VPaiqeIf5GH?=
 =?us-ascii?Q?VS9fkxy11c/pRuqk9DJLExWvwB7ot/kJLYqST7a7I0q8eX967Q1bBQmXNI4k?=
 =?us-ascii?Q?Tv3lxGIdLuyxZImSNHdLwlZui5jgvFn5wL3fHTteys2C+UhiuZPuVx5P/b8l?=
 =?us-ascii?Q?16hCKSrR81bpgTMv8hSKbw/5txA8W5fe1IiGULCr3xxVHbnUfYxA/eLeX1ev?=
 =?us-ascii?Q?Ojts/Mb5iMA/PjmmQ8aWsilTD+0ZEvcqvLiloFHzApCpxpd+GQgBncPIcYlZ?=
 =?us-ascii?Q?Y76J8hyYUQxMj0AoX0QonQfmxB9BaBA4idsWGFt4PYZJvn+iCXM7Rey2AUFH?=
 =?us-ascii?Q?wPhE/ms+JcodcCsZVeQLJFVtYUP6HAO5iC2bL0A3fW3/0+3lp3Y+OavCGwGY?=
 =?us-ascii?Q?l5jtxQJruhsJnw6SFBYLaENN5i4UTvuMtRAGk1QqqJg8XnaWfSNN24/9k3aB?=
 =?us-ascii?Q?1MNnNnKirHmZZeSeBUyW2Oqp+eHa7fLFu0l+PivuSizEIyrogi7H7YEv3e2Y?=
 =?us-ascii?Q?lRtRknbd22f97XcE8OeMC5vWUR5TNdID3o3ACBiJg5swVPFKH1sa44EK5mIV?=
 =?us-ascii?Q?ZiO/kJzsjen2EkDjCw9p5mgCEZfynwR30N8yGFfjA37KDvXu6ZUP/zgfwzyQ?=
 =?us-ascii?Q?wLz2WIIPRabjZhxgfPscjrAeLSTRTMw=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cde77d4-a2da-41c5-7a78-08def1ce6852
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:16:35.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsHwlAyOcK3CyJSJf8JJqVYkXx0p104WSegAQ2hPej60mDUWEQqZ8mM2N3oTx2RfeApJYeQ4Q/XbcyqD8CSvHvJOwUHqWLMSwcxJUcVaJ80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0713

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
v10: Fix sashiko's valid comments and kdoc-FAILED

 net/tipc/core.c       |   3 ++
 net/tipc/core.h       |   4 ++
 net/tipc/name_distr.c | 106 ++++++++++++++++++++++++++++++++++---
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c |  64 ++++++++++++++++++-----
 net/tipc/name_table.h |   5 +-
 net/tipc/net.c        |   7 ++-
 net/tipc/node.c       | 118 ++++++++++++++++++++++++++++++++++++++++--
 net/tipc/node.h       |   1 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 282 insertions(+), 31 deletions(-)

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
index ba4f4906e13b..5865d7b00eec 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -146,9 +146,11 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
  * @dnode: node to be updated
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
+ *
+ * Return: 0 on success, 1 on failure
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
-			     u32 dnode, struct list_head *pls, u16 seqno)
+static int named_distribute(struct net *net, struct sk_buff_head *list,
+			    u32 dnode, struct list_head *pls, u16 seqno)
 {
 	struct publication *publ;
 	struct sk_buff *skb = NULL;
@@ -164,8 +166,9 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
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
@@ -195,6 +198,8 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
+
+	return 0;
 }
 
 /**
@@ -202,15 +207,19 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @net: the associated network namespace
  * @dnode: destination node
  * @capabilities: peer node's capabilities
+ *
+ * Return:
+ * 0 on success
+ * 1 on failure, workqueue needs to be scheduled
+ * -ENOBUFS on failure, no buffer space is available
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
 	struct sk_buff_head head;
 	u16 seqno;
 
-	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
@@ -218,9 +227,92 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
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
+
+	__skb_queue_head_init(&head);
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
+ * tipc_named_dist_cluster_scope - distribute all publications to specified node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ *
+ * Return:
+ * 0 on success
+ * -EINVAL on failure, insert duplicate publication or reach the max number of
+ *  supported publications
+ * -ENOBUFS on failure, no buffer space is available
+ */
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff_head head;
+	bool reinsert = false;
+	int err = 0;
+	u16 seqno;
+
+	spin_lock_bh(&tn->nametbl_lock);
+	seqno = nt->snd_nxt;
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	read_lock_bh(&nt->cluster_scope_lock);
+	if (unlikely(list_empty(&nt->cluster_scope)))
+		reinsert = true;
+	read_unlock_bh(&nt->cluster_scope_lock);
+	/* tipc_net_finalize() ---> tipc_nametbl_publish() has failed to insert
+	 * node self address publication into nt->cluster_scope due to memory
+	 * allocation failure. So, reinsert this publication. Note that it is
+	 * OK if concurrent threads are inserting the same publication because
+	 * duplicate publication will be rejected.
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
+		if (!tipc_nametbl_publish(net, &ua, &sk, tn->node_addr, &err))
+			return err;
+	}
+
+	__skb_queue_head_init(&head);
+	read_lock_bh(&nt->cluster_scope_lock);
+	/* If 'reinsert' is true, the corresponding publication was sent to
+	 * receivers. So, calling named_distribute() now will resend this
+	 * publication to the receivers. It is still OK because the duplicate
+	 * publication will be rejected by the receivers.
+	 */
+	if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno)) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return -ENOBUFS;
+	}
+	tipc_node_xmit(net, &head, dnode, 0);
+	read_unlock_bh(&nt->cluster_scope_lock);
+
+	return 0;
 }
 
 /**
@@ -299,7 +391,7 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	sk.node = node;
 
 	if (dtype == PUBLICATION) {
-		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
+		p = tipc_nametbl_insert_publ(net, &ua, &sk, key, NULL);
 		if (p) {
 			tipc_node_subscribe(net, &p->binding_node, node);
 			return true;
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
index 253c72d1366e..f5e8bc365d8b 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -251,11 +251,12 @@ static struct publication *tipc_publ_create(struct tipc_uaddr *ua,
  * tipc_service_create - create a service structure for the specified 'type'
  * @net: network namespace
  * @ua: address representing the service to be bound
+ * @err: output error code
  *
  * Allocates a single range structure and sets it to all 0's.
  */
 static struct tipc_service *tipc_service_create(struct net *net,
-						struct tipc_uaddr *ua)
+						struct tipc_uaddr *ua, int *err)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_service *service;
@@ -263,6 +264,8 @@ static struct tipc_service *tipc_service_create(struct net *net,
 
 	service = kzalloc_obj(*service, GFP_ATOMIC);
 	if (!service) {
+		if (err)
+			*err = -ENOBUFS;
 		pr_warn("Service creation failed, no memory\n");
 		return NULL;
 	}
@@ -329,7 +332,7 @@ static struct service_range *tipc_service_create_range(struct tipc_service *sc,
 
 static bool tipc_service_insert_publ(struct net *net,
 				     struct tipc_service *sc,
-				     struct publication *p)
+				     struct publication *p, int *err)
 {
 	struct tipc_subscription *sub, *tmp;
 	struct service_range *sr;
@@ -341,8 +344,11 @@ static bool tipc_service_insert_publ(struct net *net,
 
 	spin_lock_bh(&sc->lock);
 	sr = tipc_service_create_range(sc, p);
-	if (!sr)
+	if (!sr) {
+		if (err)
+			*err = -ENOBUFS;
 		goto  exit;
+	}
 
 	first = list_empty(&sr->all_publ);
 
@@ -353,6 +359,8 @@ static bool tipc_service_insert_publ(struct net *net,
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
+			if (err)
+				*err = -EINVAL;
 			goto exit;
 		}
 	}
@@ -478,19 +486,22 @@ static struct tipc_service *tipc_service_find(struct net *net,
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key)
+					     u32 key, int *err)
 {
 	struct tipc_service *sc;
 	struct publication *p;
 
 	p = tipc_publ_create(ua, sk, key);
-	if (!p)
+	if (!p) {
+		if (err)
+			*err = -ENOBUFS;
 		return NULL;
+	}
 
 	sc = tipc_service_find(net, ua);
 	if (!sc)
-		sc = tipc_service_create(net, ua);
-	if (sc && tipc_service_insert_publ(net, sc, p))
+		sc = tipc_service_create(net, ua, err);
+	if (sc && tipc_service_insert_publ(net, sc, p, err))
 		return p;
 	kfree(p);
 	return NULL;
@@ -760,24 +771,46 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 /* tipc_nametbl_publish - add service binding to name table
  */
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key)
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err)
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
+		if (err)
+			*err = -EINVAL;
 		goto exit;
 	}
 
-	p = tipc_nametbl_insert_publ(net, ua, sk, key);
+insert:
+	p = tipc_nametbl_insert_publ(net, ua, sk, key, err);
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
@@ -810,7 +843,10 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 
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
@@ -839,7 +875,7 @@ bool tipc_nametbl_subscribe(struct tipc_subscription *sub)
 	spin_lock_bh(&tn->nametbl_lock);
 	sc = tipc_service_find(sub->net, &ua);
 	if (!sc)
-		sc = tipc_service_create(sub->net, &ua);
+		sc = tipc_service_create(sub->net, &ua, NULL);
 	if (sc) {
 		spin_lock_bh(&sc->lock);
 		tipc_service_subscribe(sc, sub);
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..3a15dcfcc2cd 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -126,13 +126,14 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
 void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 			      struct tipc_uaddr *ua);
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key);
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err);
 void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 			   struct tipc_socket_addr *sk, u32 key);
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key);
+					     u32 key, int *err);
 struct publication *tipc_nametbl_remove_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..6b193b9bb234 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -138,7 +138,12 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
+	atomic_set(&tn->finalized, 1);
+	/* Wake up nodes waiting for distributing bulk of publications
+	 * if applicable.
+	 */
+	tipc_node_wakeup(net);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..97411c73ec51 100644
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
+	if (tipc_named_dist_cluster_scope(node->net, node->addr) == -ENOBUFS)
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
@@ -402,6 +461,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int rc = 0, err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -421,20 +481,44 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 
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
+
+		rc = tipc_named_node_up(net, node, n->capabilities);
+		/* Defer bulk distribution to workqueue */
+		if (rc > 0) {
+			atomic_set(&n->finalized, 0);
+			atomic_inc(&tn->node_wq_count);
+			atomic_set(&n->work_scheduled, 1);
+			tipc_node_get(n);
+			if (!schedule_work(&n->work)) {
+				atomic_dec(&tn->node_wq_count);
+				tipc_node_put(n);
+			}
+		}
+	}
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
-		tipc_nametbl_publish(net, &ua, &sk, sk.ref);
+		tipc_nametbl_publish(net, &ua, &sk, sk.ref, &err);
 	}
 	if (flags & TIPC_NOTIFY_LINK_DOWN) {
 		tipc_mon_peer_down(net, node, bearer_id);
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
+
+	/* Memory allocation has failed. Bring the node down to start over bulk
+	 * distribution when the first link is up again.
+	 */
+	if (rc < 0)
+		tipc_node_down(n);
+	else if (err == -ENOBUFS)
+		tipc_node_link_down(n, bearer_id, false);
 }
 
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
@@ -564,6 +648,9 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	INIT_WORK(&n->work, tipc_node_dist_bulk);
+	atomic_set(&n->work_scheduled, 0);
+	atomic_set(&n->finalized, 0);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -653,6 +740,21 @@ void tipc_node_stop(struct net *net)
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
@@ -801,6 +903,7 @@ static bool tipc_node_cleanup(struct tipc_node *peer)
 static void tipc_node_timeout(struct timer_list *t)
 {
 	struct tipc_node *n = timer_container_of(n, t, timer);
+	struct tipc_net *tn = tipc_net(n->net);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
 	int remains = n->link_cnt;
@@ -814,6 +917,11 @@ static void tipc_node_timeout(struct timer_list *t)
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
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..6b83bdfc439c 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2919,7 +2919,7 @@ static int tipc_sk_publish(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 		return -EADDRINUSE;
 	skaddr.ref = tsk->portid;
 	skaddr.node = tipc_own_addr(net);
-	p = tipc_nametbl_publish(net, ua, &skaddr, key);
+	p = tipc_nametbl_publish(net, ua, &skaddr, key, NULL);
 	if (unlikely(!p))
 		return -EINVAL;
 
-- 
2.43.0

