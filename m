Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781432F76D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947089; cv=fail; b=gWfTh/mmPk6yVLQEQY2Rw+gdpueHAaVN4+1tvTYK1cHnauRXzDhb/YYokxnthem4sOoQ8MFEqouYS1QFQ7/34ppTYEnOYw41/jj8+GtOAEAaWtXf2CA6hnrcKSUVy5xd0oB4Ewudz35paGhto9K6vnQHRCLOS3vsgFCpEM9BtZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947089; c=relaxed/simple;
	bh=Qs3TAuuiP59BibNBTR3FGdulwBtNtpNk6zbemDwfgBU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B3vqVLF63DmdNtvLbb20TC1K+xQ7QIY8Rzmdhl+QeXxO/DR/h8G+/Ua3V1p9l/IxCf61MzhzkEmZda/KqAsrqK6See0WB32BNgQM0siKkF4JonlF73cinU3TiewKVzZcS6ayfkeDUvKW3ajrfjqvX8wmC3M+QLtd1od5emT7Kig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=QPLl6J0W; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="QPLl6J0W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up52UNW51evuH4KO1Cwq1Y896y/wno4hyBtsS/Wqm+2+1MUaPX4u7j3yb9x4OtMiyyS9f8iSKUbGNW4V4V0bgEjqhkgvmnsNv14Qgc1rZcfPTjTXmlyhpuruTVXKOAs31abN8HX+t36mDeXdW3LVCkCeCDD2iZyEsug+4kjLj/jLHkjfUBLRjOlprb4MlnOPektGa/46Zh4MVDDJKncQwyWDIzLz7chaG61o6Y+hmPX1rABEU57p82BOZ5pu7A+lg1JCE0DtFx7sJJkTgbsJeWeWNEIdIt/5BMT4nYeH2PnA31+L6HdAcsj63+HVtaN0a8doVOXEAgcTDJEcilGasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WSwPBTxgNu3iI7ja5e+2K0+vb04+1tXfuyPDrNtlfk=;
 b=MAQCsDzIbXZXdH6gTONmIHy50mIAzmRfZakD9EvPxO5SB48KNv5OMotpawG6SbMmWDE0gghvX9+PXNsWl7/zFlf5MnSaqPtEMFj90bERU0vHx0xakVs/4HfY/vUemEehrKm9Ztbl7Wb3z3SIo2OlR2lqAjB5pqfXXHYt/EWhCks/HMY3N6OIJrC3xutnLQZ5u1MIZrcrBlg2G9Zry2YHodT1nEStFuB+SpoPEBf8FyevfMaOACTwA8Emnok82syIKI5Cfo0vYWsr+c2ug3Qmw4Jx/1gt5kOz4/QlsFFDUc+mTwaumcQ8i5nKEF0FRogpv5c8foGLd7k3IK0ndDhRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WSwPBTxgNu3iI7ja5e+2K0+vb04+1tXfuyPDrNtlfk=;
 b=QPLl6J0W2YE5/z4htZq9uH7XnRXyth2Ypa197cXgErLuIecXHrsIBwPu1CxjURAR8eg/olYi2lJvBNpVAuQtBaizGBAU2pHL3UYD0VOuAb3xDhaiWEko4LH6nIubAw4VKzCWEh1JWSZzRw0TP5h24yss9r4u8Z1maV2Fmd4Zq/P1dpxV+Qce5rAB6u8Ncl1NPq65bkGe6mbJ/F5fo9qfnGNtSy5u/Q3WpoMayNviMFJXpgZUvjPOvKwWur/E77lfN4ex27SfJtD1XHkhbl7qITwlOs21EpRp2zJ8Sz4HzjrxiNoCvJeEVDE+FLA/B6uiGhLGaHRaYLVRprEXTsOZjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PR3P189MB1068.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Mon, 17 Aug 2026 06:11:23 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.004; Mon, 17 Aug 2026
 06:11:22 +0000
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
Subject: [PATCH net v14] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Mon, 17 Aug 2026 13:09:58 +0700
Message-ID: <20260817061115.84471-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|PR3P189MB1068:EE_
X-MS-Office365-Filtering-Correlation-Id: 69630728-cf14-4361-fdfd-08defc265c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|10070799003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vU1f6Gw8rDHrTInORP3BXPtpZ67Hjuwwm7hBQ6LBZnI8EO01Qa+Lx9v162u5vFoxoiPODJO408xEtqCtCYiJKK4aUXaRpwU8cipNrVhsxz/B9taxImBKBfbL2yDABWDZh+k4xzYF0N5N/HhLJjwhpBPz+6uz75ukKjzYjxfYYF0DSXaxyarLMSyiSYcUpJxuARQPdcU+9rIeyilqbRq21adOo1grdPxv6HdOtOZ99veFWsks1/jB4tc1uAOieRRlwh2XvFhxPg55qesnlI3vURlpVTpyv4DWyULWIjfYkRiRANc04ogdrN0ar3jmNd+TRVT1xdGICJ2yL2yrQRBHFRhbYta9WR1/uw25h7FC5b7roLqh+VzJtEQMoQRypBrC0Ql2GAdF6A7Nt131hnku3U9ZdEP58edrThF1eW37liU+ho1xu338mmt1M8JcTX0YvfZcHUWqLCKVujotoF1zdhkkyGhJQh+EWNuyJcXvswrb4ua3IFEU+eWbAtP1DA9oQUWpKfFaNUGcNZLhIN5BH/Cgw8puksDbEmYKPshvh8FFgtWfqpFCb4lGQiRjNzcmRTpXjJUI4sPT+pj6S/qtM9WktWkwM5LPrZvQsitLYp++LR2RMgaxpH/IXTRL3CmId0VthE/mwYhrKNkG4vJ8Rwg1TccJYhJHzHOsRj50EZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUTNasa2Tt6BjDppvnsGUMfYdsUrk6QWjvixkRoTo1mhzJoVAZmAC/xsewWx?=
 =?us-ascii?Q?ZFDQ8Ou1N/4+SSUQq2p1MsU4Fkt7mn6N8f4L6THfHHH+OoTu916iS00U0vdF?=
 =?us-ascii?Q?BQ9nHf56ltYyADZuwdDbZxw8EE+JMkdWo6GNbco81D5gDbRe3TP9ccEsGa96?=
 =?us-ascii?Q?GhkJSIR9Q70ZXhFTq1ltIHdEO6zfE+zNjXvZ0viI5d4tqeSfTRMXl8F68Zi4?=
 =?us-ascii?Q?nOldjY5xx8mwpEJaGUpzeENuM6ELHN5++hwfOxOL9HoAg+X1z56JBZsa8l1H?=
 =?us-ascii?Q?dCivQKw4U3wK45LeximXmzYjJD54GJHRW84d5+enDYUAq9KnyZamEwLxuq6Z?=
 =?us-ascii?Q?bokolAn6gK9UbAaZ0ak1jPzChWtqBEf7EvkkBUyG4todk0pDmEFJVLKoGB9C?=
 =?us-ascii?Q?p7pIjkTl+WbpcPC5LNEcIH+EF//Qmx54+P2AeqV3xLC2xRqyxr7UVcZ12hei?=
 =?us-ascii?Q?Fs9xxMqg4mU2KKbhXOYYHB7w0TZsSC605rTK3VjQOkX7OplcJv95fuiiRxBI?=
 =?us-ascii?Q?vhDIwOTk69oUttviNcgbBUocpJdaOmYquE14yKX+RCfF8KJEKz971HD43jLH?=
 =?us-ascii?Q?yfhyZppTe87UcIfBoj+0/+un82Xy9TUZ8liKxzORvrWMUTi+ugwOzKVbS5Zs?=
 =?us-ascii?Q?RPT6mLoEyeNPNT9QCj8+plz3tT4nm8JDPUA2Cc8qLBOWUq9flxJoULoJsjG1?=
 =?us-ascii?Q?oAlfDzYJ/tnS8xPSdORkqF2c91PIBx2+RAhL/O+OwUltjhwdaOa6bRaQmTDo?=
 =?us-ascii?Q?d1Jz8L3Zqyn/tJNWvW+7UJwTLYnqAoko3Ls3WoC4WcHjUNHk4ohvDytnHx79?=
 =?us-ascii?Q?VtNPbVM0GRihdbm4WdMiqTfyQ3fw5T14bqg7iM3uY/0JHQ2Cd7lWn8zebn14?=
 =?us-ascii?Q?TopiZBKSTUqmHedAkVzuf7v0pxP6UVfX5pmFZmel9j2sVdpQAJcvpLYbDN0c?=
 =?us-ascii?Q?iq494RnkC6KokHm6tg8YWIRNCvN3MqXm2I10afF7hxq7MY1ZC70ZmJsfMA7r?=
 =?us-ascii?Q?zir7SZ6K6NjBIaW9fbYY2jYpX1wiJS9mduAo0KCDCGUMmYMVhOJZ6OdoCmAL?=
 =?us-ascii?Q?9XB1rFo6/rgsh8pDLttILAWacimepDNVG2hn85hYHFwj6uXXHRYZQEa8jda4?=
 =?us-ascii?Q?rlJj8NTlAbKAy0FV3uPkmB9ZnL0RqHj0pHhXRavaSWXCX6YevCl351vQ3w+/?=
 =?us-ascii?Q?oOcdmPX43yXEWRmfL1JFf0MU4YPzXucxSbnCNvR00MNJ0UmNzz3sHaCuTW6B?=
 =?us-ascii?Q?bOta91TcWi606hx0X+UZpvy5FfOtsOBKVyMRgSnRf81DLf49NUsiXJeoO7oi?=
 =?us-ascii?Q?KV4/IrGqh3R2ub7OCyANQ7qTk3G+LVdr/i50EZpbDc7ikPfCI5cq1JIqxSZz?=
 =?us-ascii?Q?O2SLipIEXXuFvujYRgHc9K7dwWiOLNayCZXduwGZprMN5c2ZbPQp7KdjSG9G?=
 =?us-ascii?Q?6mVsJD567Hixtmnm7pOG7OPGq2ih1UIMJohwt3oMKUDjPU90Xwo5olOSQ7Az?=
 =?us-ascii?Q?qGvkARYPWuizufL+LuxqEfFLxu6We46wvA2C6726xWDNUWOop1xTP4VZCnB2?=
 =?us-ascii?Q?rUNbyRjIKmTTyo0JlGGY7Oi4I8NeNZiwSYAjdwL4zcnzSuqgVpD+4xFaFvkC?=
 =?us-ascii?Q?Ikw/p78aaCSuiwUF5F6BswugfLteO7Ol1NoQ34icbFFUKROGnYb0Ni/T4Qbc?=
 =?us-ascii?Q?X4+QUftz03gts0vXM1HpO/zfTYWiEJCswDw40TQKrQ7kqVsJOb5apPxF6hZu?=
 =?us-ascii?Q?8OheMqZsftRUaVnhzKE0f1nhwh6SBm8efN2NTKwNTn0hL4O1U1sOvFJpfLfx?=
X-MS-Exchange-AntiSpam-MessageData-1: np2beJlfwKkD+MdU+4FSPYVHTzPjbhpsSw8=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 69630728-cf14-4361-fdfd-08defc265c86
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:11:22.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 814sAXVad2cyC0iVzzqWSYx9HWcVTJZeKSOwa2HOUx6GD9WkdEepK30RTtv+lCDdnj8LH38I0SFSddnaFFOKY1FAV8I5ZDJqCZYhaf7qB5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1068

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

Fix the first issue by allowing protocol service types (node state, link state,
and topology server) to be inserted into the name table unconditionally. On a
link-up event, if the link-state publication cannot be inserted due to a memory
allocation error, force the link down and restart the insertion process.

Fix the second issue by checking for the node's self-address publication on each
node-up or node-timeout event. If the publication does not exist, insert it into
the name table and publish it to the other nodes. If the insertion fails due to
a memory allocation error, force the node down and restart the insertion
process.

To facilitate the implementation, four major changes are made:
- Remove cluster_scope_lock, which protects the name table's cluster_scope list.
  Use nametbl_lock instead to protect the list from races when multiple threads
  concurrently call tipc_named_publish(), tipc_named_withdraw(), and
  tipc_named_node_up().
- Move the sc->lock acquisition out of tipc_service_insert_publ() and into its
  callers.
- Add an output parameter (*err) to tipc_nametbl_publish() to detect memory
  allocation errors.
- Add three fields (nt_stop, nt_self_node_exist, and node_addr_set) to struct
  tipc_net to synchronize the insertion and deletion of the node's self-address
  publication.

Fixes: a5e7ac5ce134 ("tipc: fix regression bug where node events are not being generated")
Reported-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v14: Add more comments to tipc_nametb_insert_self_node_pub() to answer
     sashiko's questions. Check other error codes returned by
     tipc_node_xmit() in tipc_named_node_up() and
     tipc_named_distribute() to address sashiko's finding.

 net/tipc/core.c       |   3 +
 net/tipc/core.h       |   6 ++
 net/tipc/name_distr.c | 128 +++++++++++++++++++++++++----
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c | 186 ++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_table.h |  10 +--
 net/tipc/net.c        |  11 ++-
 net/tipc/node.c       |  48 +++++++++--
 net/tipc/node.h       |   1 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 353 insertions(+), 45 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..0f1d3ddeae09 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,9 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	tn->nt_stop = false;
+	tn->nt_self_node_exist = false;
+	atomic_set(&tn->node_addr_set, 0);
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..975b1d48186e 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,12 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* Flag to indicate that the node's address is set */
+	atomic_t node_addr_set;
+	/* The name table has stopped working */
+	bool nt_stop;
+	/* Node's self address publication is available in the name table */
+	bool nt_self_node_exist;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..83e3ed8f2c51 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -95,9 +95,7 @@ struct sk_buff *tipc_named_publish(struct net *net, struct publication *p)
 		list_add_tail_rcu(&p->binding_node, &nt->node_scope);
 		return NULL;
 	}
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_add_tail(&p->binding_node, &nt->cluster_scope);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	skb = named_prepare_buf(net, PUBLICATION, ITEM_SIZE, 0);
 	if (!skb) {
 		pr_warn("Publication distribution failure\n");
@@ -121,9 +119,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
 	struct distr_item *item;
 	struct sk_buff *skb;
 
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_del(&p->binding_node);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	if (p->scope == TIPC_NODE_SCOPE)
 		return NULL;
 
@@ -146,9 +142,14 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
  * @dnode: node to be updated
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
-			     u32 dnode, struct list_head *pls, u16 seqno)
+static int named_distribute(struct net *net, struct sk_buff_head *list,
+			    u32 dnode, struct list_head *pls, u16 seqno)
 {
 	struct publication *publ;
 	struct sk_buff *skb = NULL;
@@ -164,8 +165,9 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 			skb = named_prepare_buf(net, PUBLICATION, msg_rem,
 						dnode);
 			if (!skb) {
+				__skb_queue_purge(list);
 				pr_warn("Bulk publication failure\n");
-				return;
+				return -ENOBUFS;
 			}
 			hdr = buf_msg(skb);
 			msg_set_bc_ack_invalid(hdr, true);
@@ -195,6 +197,90 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
+
+	return 0;
+}
+
+/**
+ * __tipc_named_distribute - build a list of publications need to be distributed
+ * @net: the associated network namespace
+ * @dnode: destination node
+ * @head: list of publications
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
+ */
+static int __tipc_named_distribute(struct net *net, u32 dnode,
+				   struct sk_buff_head *head)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+
+	/* Name table has been deleted after namespace teardown or
+	 * TIPC module exit.
+	 */
+	if (unlikely(tn->nt_stop))
+		return 0;
+
+	/* Node's self-address is not set yet */
+	if (!atomic_read(&tn->node_addr_set)) {
+		/* Defer the distribution to node's timer */
+		tipc_node_set_dist_bulk(net, dnode);
+		return 0;
+	}
+
+	/* Previous call to tipc_nametb_insert_self_node_pub() was successful.
+	 * The node's self-address publication was added to 'nt->cluster_scope'.
+	 * So, 'nt->cluster_scope' is not empty now. Go to distribution.
+	 */
+	if (tn->nt_self_node_exist)
+		goto distribute;
+
+	if (tipc_nametb_insert_self_node_pub(net))
+		return -ENOBUFS;
+
+	tn->nt_self_node_exist = true;
+
+distribute:
+	if (named_distribute(net, head, dnode,
+			     &nt->cluster_scope, nt->snd_nxt) == -ENOBUFS)
+		return -ENOBUFS;
+
+	return 0;
+}
+
+/**
+ * tipc_named_distribute - distribute all publications to specified node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
+ */
+int tipc_named_distribute(struct net *net, u32 dnode)
+{
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff_head head;
+	int rc = 0;
+
+	__skb_queue_head_init(&head);
+	spin_lock_bh(&tn->nametbl_lock);
+	rc = __tipc_named_distribute(net, dnode, &head);
+	spin_unlock_bh(&tn->nametbl_lock);
+	if (!rc && !skb_queue_empty(&head)) {
+		rc = tipc_node_xmit(net, &head, dnode, 0);
+		/* The link is congested after the list is inserted into the
+		 * link's send queue. Return 0, as this is normal.
+		 */
+		if (rc == -ELINKCONG)
+			rc = 0;
+	}
+
+	return rc;
 }
 
 /**
@@ -202,25 +288,36 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @net: the associated network namespace
  * @dnode: destination node
  * @capabilities: peer node's capabilities
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
 	struct sk_buff_head head;
-	u16 seqno;
+	int rc = 0;
 
 	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
-	seqno = nt->snd_nxt;
+
+	rc = __tipc_named_distribute(net, dnode, &head);
 	spin_unlock_bh(&tn->nametbl_lock);
+	if (!rc && !skb_queue_empty(&head)) {
+		rc = tipc_node_xmit(net, &head, dnode, 0);
+		/* The link is congested after the list is inserted into the
+		 * link's send queue. Return 0, as this is normal.
+		 */
+		if (rc == -ELINKCONG)
+			rc = 0;
+	}
 
-	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
-	read_unlock_bh(&nt->cluster_scope_lock);
+	return rc;
 }
 
 /**
@@ -299,7 +396,7 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	sk.node = node;
 
 	if (dtype == PUBLICATION) {
-		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
+		p = tipc_nametbl_insert_publ(net, &ua, &sk, key, NULL);
 		if (p) {
 			tipc_node_subscribe(net, &p->binding_node, node);
 			return true;
@@ -416,5 +513,6 @@ void tipc_named_reinit(struct net *net)
 	list_for_each_entry_rcu(p, &nt->cluster_scope, binding_node)
 		p->sk.node = self;
 	nt->rc_dests = 0;
+	tn->nt_stop = false;
 	spin_unlock_bh(&tn->nametbl_lock);
 }
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..2043096ae967 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,11 +69,12 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 		      u32 addr, u16 capabilities);
+int tipc_named_distribute(struct net *net, u32 dnode);
 
 #endif
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 253c72d1366e..beed40a21368 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -329,7 +329,7 @@ static struct service_range *tipc_service_create_range(struct tipc_service *sc,
 
 static bool tipc_service_insert_publ(struct net *net,
 				     struct tipc_service *sc,
-				     struct publication *p)
+				     struct publication *p, int *err)
 {
 	struct tipc_subscription *sub, *tmp;
 	struct service_range *sr;
@@ -339,10 +339,12 @@ static bool tipc_service_insert_publ(struct net *net,
 	bool res = false;
 	u32 key = p->key;
 
-	spin_lock_bh(&sc->lock);
 	sr = tipc_service_create_range(sc, p);
-	if (!sr)
-		goto  exit;
+	if (!sr) {
+		if (err)
+			*err = -ENOBUFS;
+		goto exit;
+	}
 
 	first = list_empty(&sr->all_publ);
 
@@ -353,6 +355,8 @@ static bool tipc_service_insert_publ(struct net *net,
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
+			if (err)
+				*err = -EEXIST;
 			goto exit;
 		}
 	}
@@ -371,7 +375,6 @@ static bool tipc_service_insert_publ(struct net *net,
 	if (!res)
 		pr_warn("Failed to bind to %u,%u,%u\n",
 			p->sr.type, p->sr.lower, p->sr.upper);
-	spin_unlock_bh(&sc->lock);
 	return res;
 }
 
@@ -478,20 +481,33 @@ static struct tipc_service *tipc_service_find(struct net *net,
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
 		sc = tipc_service_create(net, ua);
-	if (sc && tipc_service_insert_publ(net, sc, p))
-		return p;
+
+	if (sc) {
+		spin_lock_bh(&sc->lock);
+		if (tipc_service_insert_publ(net, sc, p, err)) {
+			spin_unlock_bh(&sc->lock);
+			return p;
+		}
+		spin_unlock_bh(&sc->lock);
+	} else if (err) {
+		*err = -ENOBUFS;
+	}
+
 	kfree(p);
 	return NULL;
 }
@@ -760,26 +776,55 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
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
+	int error = 0;
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
 
-	p = tipc_nametbl_insert_publ(net, ua, sk, key);
+insert:
+	p = tipc_nametbl_insert_publ(net, ua, sk, key, &error);
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
+		/* Local-scope publication is not published (skb is NULL), only
+		 * cluster-cope one is.
+		 */
+		if (!skb && p->scope == TIPC_CLUSTER_SCOPE && err)
+			*err = -ENOBUFS;
+	} else if ((error == -ENOBUFS) && err) {
+		*err = -ENOBUFS;
 	}
+
 	rc_dests = nt->rc_dests;
 exit:
 	spin_unlock_bh(&tn->nametbl_lock);
@@ -787,7 +832,102 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 	if (skb)
 		tipc_node_broadcast(net, skb, rc_dests);
 	return p;
+}
+
+/**
+ * tipc_nametb_insert_self_node_pub - insert publication of node's self address
+ * @net: network namespace
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
+ */
+int tipc_nametb_insert_self_node_pub(struct net *net)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+	struct tipc_socket_addr sk;
+	struct service_range *sr;
+	struct tipc_service *sc;
+	bool sc_created = false;
+	struct publication *p;
+	struct tipc_uaddr ua;
+	int err = 0;
+
+	sk.ref = 0;
+	sk.node = tn->node_addr;
+	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
+		   TIPC_NODE_STATE, tn->node_addr, tn->node_addr);
+	sc = tipc_service_find(net, &ua);
+	if (!sc) {
+		sc = tipc_service_create(net, &ua);
+		if (!sc)
+			return -ENOBUFS;
+		sc_created = true;
+	}
 
+	spin_lock_bh(&sc->lock);
+	/* Check whether a range exists in the name table with
+	 * lower == tn->node_addr, upper == tn->node_addr, and type
+	 * TIPC_NODE_STATE (0). If 'sr' is not NULL, this range exists
+	 * due to a previous call to tipc_nametb_insert_self_node_pub()
+	 * or tipc_net_finalize().
+	 *
+	 * Note that user applications can only insert types greater than
+	 * or equal to 64 (TIPC_RESERVED_TYPES), as enforced by tipc_bind().
+	 * Remote nodes also only send protocol publications with type
+	 * TIPC_NODE_STATE (0), with both lower and upper set to the remote
+	 * node's address. These ranges cannot be the same as this node's
+	 * range because a remote node's address must differ from this
+	 * node's address (tn->node_addr).
+	 *
+	 * Therefore, tipc_update_nametbl() cannot build and insert a remote
+	 * publication with the same type (0) and range
+	 * (lower == tn->node_addr, upper == tn->node_addr) as this node's
+	 * self-address publication in the name table.
+	 *
+	 * Because the combination of type 0 and
+	 * (lower == tn->node_addr, upper == tn->node_addr) is unique in the
+	 * name table, it is not necessary to check sk.node, sk.ref, key, or
+	 * cluster_scope membership.
+	 */
+	sr = tipc_service_find_range(sc, &ua);
+	/* 1. tipc_net_finalize_work() is not scheduled because of namespace
+	 *    teardown.
+	 * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
+	 *    to insert node self address publication into nt->cluster_scope
+	 *    due to memory allocation failure.
+	 * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
+	 *    executed yet.
+	 */
+	if (!sr) {
+		p = tipc_publ_create(&ua, &sk, tn->node_addr);
+		if (!p)
+			goto error;
+
+		if (!tipc_service_insert_publ(net, sc, p, &err) &&
+		    (err == -ENOBUFS)) {
+			kfree(p);
+			goto error;
+		}
+
+		list_add_tail(&p->binding_node, &nt->cluster_scope);
+		goto exit;
+error:
+		if (sc_created) {
+			hlist_del_init_rcu(&sc->service_list);
+			spin_unlock_bh(&sc->lock);
+			kfree_rcu(sc, rcu);
+			return -ENOBUFS;
+		}
+
+		spin_unlock_bh(&sc->lock);
+		return -ENOBUFS;
+	}
+exit:
+	spin_unlock_bh(&sc->lock);
+	return 0;
 }
 
 /**
@@ -810,7 +950,10 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 
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
@@ -899,7 +1042,6 @@ int tipc_nametbl_init(struct net *net)
 
 	INIT_LIST_HEAD(&nt->node_scope);
 	INIT_LIST_HEAD(&nt->cluster_scope);
-	rwlock_init(&nt->cluster_scope_lock);
 	tn->nametbl = nt;
 	spin_lock_init(&tn->nametbl_lock);
 	return 0;
@@ -912,6 +1054,7 @@ int tipc_nametbl_init(struct net *net)
  */
 static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 {
+	struct tipc_net *tn = tipc_net(net);
 	struct service_range *sr, *tmpr;
 	struct publication *p, *tmp;
 
@@ -919,6 +1062,15 @@ static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 	rbtree_postorder_for_each_entry_safe(sr, tmpr, &sc->ranges, tree_node) {
 		list_for_each_entry_safe(p, tmp, &sr->all_publ, all_publ) {
 			tipc_service_remove_publ(sr, &p->sk, p->key);
+			/* tipc_nametbl_withdraw() does not delete
+			 * 'p->binding_node' with type TIPC_NODE_STATE and
+			 * range [tn->node_addr, tn->node_addr] from
+			 * 'tn->cluster_scope'. So, delete it here.
+			 */
+			if (p->sr.type == TIPC_NODE_STATE &&
+			    p->sr.lower == tn->node_addr &&
+			    p->sr.upper == tn->node_addr)
+				list_del(&p->binding_node);
 			kfree_rcu(p, rcu);
 		}
 		rb_erase_augmented(&sr->tree_node, &sc->ranges, &sr_callbacks);
@@ -949,6 +1101,8 @@ void tipc_nametbl_stop(struct net *net)
 			tipc_service_delete(net, service);
 		}
 	}
+	tn->nt_stop = true;
+	tn->nt_self_node_exist = false;
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	/* TODO: clear tn->nametbl, implement proper RCU rules ? */
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..4390e79a4660 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -97,8 +97,7 @@ struct publication {
  * @cluster_scope: all local publications with cluster scope
  *               - used by name_distr to send bulk updates to new nodes
  *               - used by name_distr during re-init of name table
- * @cluster_scope_lock: lock for accessing @cluster_scope
- * @local_publ_count: number of publications issued by this node
+ * @local_publ_count: the number of user's publications issued by this node
  * @rc_dests: destination node counter
  * @snd_nxt: next sequence number to be used
  */
@@ -107,7 +106,6 @@ struct name_table {
 	struct hlist_head services[TIPC_NAMETBL_SIZE];
 	struct list_head node_scope;
 	struct list_head cluster_scope;
-	rwlock_t cluster_scope_lock;
 	u32 local_publ_count;
 	u32 rc_dests;
 	u32 snd_nxt;
@@ -126,13 +124,15 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
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
+int tipc_nametb_insert_self_node_pub(struct net *net);
 struct publication *tipc_nametbl_remove_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..7a2c1e67aca3 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -110,11 +110,14 @@ static void tipc_net_finalize(struct net *net, u32 addr);
 
 int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 {
+	struct tipc_net *tn = tipc_net(net);
+
 	if (tipc_own_id(net)) {
 		pr_info("Cannot configure node identity twice\n");
 		return -1;
 	}
 	pr_info("Started in network mode\n");
+	atomic_set(&tn->node_addr_set, 0);
 
 	if (node_id)
 		tipc_set_node_id(net, node_id);
@@ -125,8 +128,8 @@ int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 
 static void tipc_net_finalize(struct net *net, u32 addr)
 {
-	struct tipc_net *tn = tipc_net(net);
 	struct tipc_socket_addr sk = {0, addr};
+	struct tipc_net *tn = tipc_net(net);
 	struct tipc_uaddr ua;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
@@ -138,7 +141,11 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	atomic_set(&tn->node_addr_set, 1);
+	/* Redistribute bulk of publications via node-up event or node's timer
+	 * if tipc_nametbl_publish() fails.
+	 */
+	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..f1eee674a678 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,7 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @dist_bulk: flag to redistribute cluster-scope publications
  */
 struct tipc_node {
 	u32 addr;
@@ -145,6 +146,7 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
 	struct tipc_crypto *crypto_rx;
 #endif
+	atomic_t dist_bulk;
 };
 
 /* Node FSM states and events:
@@ -345,6 +347,17 @@ static struct tipc_node *tipc_node_find(struct net *net, u32 addr)
 	return node;
 }
 
+void tipc_node_set_dist_bulk(struct net *net, u32 addr)
+{
+	struct tipc_node *node;
+
+	node = tipc_node_find(net, addr);
+	if (node) {
+		atomic_set(&node->dist_bulk, 1);
+		tipc_node_put(node);
+	}
+}
+
 /* tipc_node_find_by_id - locate specified node object by its 128-bit id
  * Note: this function is called only when a discovery request failed
  * to find the node by its 32-bit id, and is not time critical
@@ -393,6 +406,14 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
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
 static void tipc_node_write_unlock(struct tipc_node *n)
 	__releases(n->lock)
 {
@@ -402,6 +423,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int rc = 0, err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -425,16 +447,24 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
 
 	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+		rc = tipc_named_node_up(net, node, n->capabilities);
 
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
@@ -564,6 +594,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	atomic_set(&n->dist_bulk, 0);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -803,7 +834,8 @@ static void tipc_node_timeout(struct timer_list *t)
 	struct tipc_node *n = timer_container_of(n, t, timer);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-	int remains = n->link_cnt;
+	int remains = 0;
+	int dist_rc = 0;
 	int bearer_id;
 	int rc = 0;
 
@@ -814,6 +846,9 @@ static void tipc_node_timeout(struct timer_list *t)
 		return;
 	}
 
+	if (atomic_xchg(&n->dist_bulk, 0))
+		dist_rc = tipc_named_distribute(n->net, n->addr);
+
 #ifdef CONFIG_TIPC_CRYPTO
 	/* Take any crypto key related actions first */
 	tipc_crypto_timeout(n->crypto_rx);
@@ -825,6 +860,7 @@ static void tipc_node_timeout(struct timer_list *t)
 	 */
 	tipc_node_read_lock(n);
 	n->keepalive_intv = 10000;
+	remains = n->link_cnt;
 	tipc_node_read_unlock(n);
 	for (bearer_id = 0; remains && (bearer_id < MAX_BEARERS); bearer_id++) {
 		tipc_node_read_lock(n);
@@ -835,11 +871,13 @@ static void tipc_node_timeout(struct timer_list *t)
 			tipc_node_calculate_timer(n, le->link);
 			rc = tipc_link_timeout(le->link, &xmitq);
 			spin_unlock_bh(&le->lock);
-			remains--;
+			if (dist_rc < 0)
+				remains--;
 		}
 		tipc_node_read_unlock(n);
 		tipc_bearer_xmit(n->net, bearer_id, &xmitq, &le->maddr, n);
-		if (rc & TIPC_LINK_DOWN_EVT)
+		/* Force the node down in case the redistribution failed */
+		if ((rc & TIPC_LINK_DOWN_EVT) || dist_rc < 0)
 			tipc_node_link_down(n, bearer_id, false);
 	}
 	mod_timer(&n->timer, jiffies + msecs_to_jiffies(n->keepalive_intv));
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..0f777cfe7c01 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -128,4 +128,5 @@ int tipc_nl_node_set_key(struct sk_buff *skb, struct genl_info *info);
 int tipc_nl_node_flush_key(struct sk_buff *skb, struct genl_info *info);
 #endif
 void tipc_node_pre_cleanup_net(struct net *exit_net);
+void tipc_node_set_dist_bulk(struct net *net, u32 addr);
 #endif
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

