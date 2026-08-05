Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FB3F39E4
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946463; cv=fail; b=elyoqYZ2xXX9cZm04Dlex7sgLzuRzfy1M8+cyuZ6af+781SlSQ5XwlXyRLeQ4j6B5mqP9e8FlCoDaHHIH2eHKuDai8E/Iky/awBOJhZ0qwOJptJlE+HOZGL0LY8Umw58XNkQE/dP5CVUGerE1DOb7wGukXSQkqPg7S6p43COVYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946463; c=relaxed/simple;
	bh=1Az6FhYoBtX52wzTTcG4XeVvnGAiVF74ql3zm86zafo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lwsBSia83vWqN8nzTpByfhtKgyUD9cNJugCQMYC8lr7wjgb+Si3mvS2liP/mREifVhd4e9C/l+7pGS9poj4fhbrikSYBaqD9X0boBYzIr4yNGP8EZrXB5oco7SUIDNfNPBpwi0muS1YUfjdrfKm99pLBH+NfIs6687olWBdXEUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Zj5vmq0M; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Zj5vmq0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNWnuoo4su2OCqNemEwoV2lHtNt8uuCNmchjRj3s7pD0tCiIF2AP18u+iw/e27upX8QzL6St2AuiCvMcSYO3fyu/FxZ4JS/XjOlCMDVdFEkFcpUeLSGuVUX3bn/GtIjoHxPU32stpnHCQEIR5khhF4tz9kncqk8NlXsWJHCirJKJy+O0qx+nCBITzhWFZGrI1hrEwEG9Kh3q1QYU1x6XTMSBkl/Ooj/LE2WE2uxh+bXQnVMiilCCgSPRfT5Y1rymxbE8v/ZmsP/f+S7ux3nZzyhyNEBPS0Efoi75otLat193AYafxJo7W8Fv+nLEkFbhV5VwwGiPIrjrYjpXw5ywjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcVRerY3Oj9t4xxG3vJJsD62AAsqTbyvP8NNxLydEvE=;
 b=yjrF9RraQoWOW0XsZxeQjsTwuZMICG3TP3dNtori7bS2Gr0jq4dWksW73tZPJIRGEZPJ2HRc7egtH4KB+p4Y3n0ovG8oOc+qh95pbK5LX1d97mNGl/GDCm6uB+emGjh4L5zReGa5RB44WQrAxe1OEgInARLkJi6qs4rcoulnDTGj+XNX2EfhEHq7Xig/sRfq00It08uhYGuPFy/9Zc2Cna32cJi0peW1wL19siAxlnJ9CkPH5vtRS+uV8o4x78je6g6hCxsQMQL2E4aKEcSfCl5keWol3ehxpIHqhSMBLMDZP+kSctB8bVLwpZfiD129cVya/bV216OgsMdY+WFPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcVRerY3Oj9t4xxG3vJJsD62AAsqTbyvP8NNxLydEvE=;
 b=Zj5vmq0Mk+jxK1BfDzprN9QGFcBBpR2LCu1uuW1cePj5Y1AEHxsWLKoV6i3dRS1JPM0P/OqmtTCcRUKhXau3VU2cRWHOGyFqr5N2C0w/LRpiCBlXZM9tRPUqO9jw1Q3Dn0GurOHIeB8qqIM+iDfLDv29kfJFiI8qhS4TeHRAuRAMvozhruHGckN7tCTo2sbOXbj0eygU3mb6/lGDIbMbc7QK7qicI46wWqLQgOJC8/WYTAhHOnEw1SMydk6Vib75KKZCYZSNJQP4762W38VKAYzteuIr/WTGEHDSLTv8GOI579Exf9PxVxrurcQga8ORrnrCflR2E+Bra9Dfseuy7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM4P189MB3548.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.16; Wed, 5 Aug 2026 16:14:09 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0315.001; Wed, 5 Aug 2026
 16:14:08 +0000
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
Subject: [PATCH net v11] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Wed,  5 Aug 2026 23:13:09 +0700
Message-ID: <20260805161356.193230-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|AM4P189MB3548:EE_
X-MS-Office365-Filtering-Correlation-Id: da94398a-3d9d-4642-9555-08def30c941f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|6133799003|11063799006|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oozPg4PSGklktQFsso/nGRDktRGDZFG/+F7AqCTg0qu4amgbPLYzBaqE9dMUNoyAlKHzhP9RBGuectx0FAXhCJDmWaOzzYFZ1FKj5NMBOUa1OCVD9NN0fxtn8r+Pi3x61Q24XaBjN6hdblfCYlYE22EXL1UncuDwNThnISGGkdxKQrWZCI8Fx5eb6fXNFNPvz1YprFRNY47HUagNOkuimMX2S0V7GzNQqVEsNxxsKxIip+GT9k/QmWutzqQcWXTFywiRSZS5ThfeyqP+5/f1QbWABaYBcgq5wKHGWGzQBxoIZ+IyDxZiuZQF0P17kryuCDUgSdJqiC1MGI8B08bGCD7fAX29UmBsdKCRt103bD2EmBojKvkN3OgmycbiGeznrnZbv3VM9+lLrICN759kxtmP6r8cyCdCmwRqkFk6tVlJwaY/QknHUWNS8nHNMIiTMZt4gYYpDRVlIwjQ8nPuLFoYkDfG8uSE8eZXxT3vvWfBXZPqG3HGtsTRiHVLGXKPMovZP7t2QArozFYBiMIOl0shDna5K8In/5a35rGaP184DnVsgDUV0gx16xKm1jsHgf94SzViGI9zN4s29ZM6hRiXFnusArzcBLS/MlevJ4SDv0VnGwijcegHdfNHQCb8vIR0bhXlUaFz5cv3MTGMhwgqPtFkHZ+xlGwd9OuDB+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVRhWGf1kpiLFTxnNDROc2OtGWPlv7hT4QqJwcEm5qPRT0OCozEq0h38pck+?=
 =?us-ascii?Q?/E7znlYrTWfAmfpsTOF8xuZbYZInpXvpT9nyhqLdHL+i0QgVXKOFJmyK0pMT?=
 =?us-ascii?Q?v8MOXh82kbQpP5KD+rH2d8QgfGJf8KL+pK4yzZV6f+zT4AkLE1jRIPRqKmc/?=
 =?us-ascii?Q?mJowFbDXeyiZ00bK7IwpWgzf09jlvqNG2oBQZ5P4en/3niYlraefoakS73JQ?=
 =?us-ascii?Q?vo6TmhiS10J8MrLQ+RxucMw01U5tq9vgh0/TUmTKGzmXvMNHmbHZ0WfHDpiW?=
 =?us-ascii?Q?zPR4jxVdkXmKJi91i2dPMleDkLyu7bUce0J4PwqWTBb1FxzomzcqhQ/2O1K/?=
 =?us-ascii?Q?keWyUxytvPVx5lRcr2shWZV4zuvIa5MmDCvSTy/VgZsryECeqVm9FXt9zbMQ?=
 =?us-ascii?Q?MUKp/tzNo/M3jTOz57xhFIv4hWUntXYtjxI/J+oCLmGYXqPQBJuePbz3Pt8c?=
 =?us-ascii?Q?EogxfnSDD2bCdh2KeJXPVOLMsjkk2IiPcVfTA8BaCRaS2QzSJQ8J20fgIgM5?=
 =?us-ascii?Q?AozJYDo4MtmoUeaMvOe9RWD8xm+YWa2eXGpYb12xRNT5A2y/bCq8E6BfL/dM?=
 =?us-ascii?Q?i2KUpUu1FHEtsD4yimJD+jya79XaV/EkCP5ke6zmXIG0hUzSOSrP2lufQ9VB?=
 =?us-ascii?Q?KuYmpiRcF1FEZnPVJIOWs+hmk4jN/lDsloOdA2ixwAOjP1qWCgZnO4a6gfDQ?=
 =?us-ascii?Q?c8WKZh9Plm7DiyGh+UB+7Oz8r1zM4YVrSAxcQnVvRQCeiK4H9EOsIgieT4E4?=
 =?us-ascii?Q?8DHlWihL9uK45d1KkQllbzi0xk+qSG+p6cbxSwXsn6+HTEh89W7GqSt8duvx?=
 =?us-ascii?Q?vxcRoyCVPiXFI+jf6tPUUl0XO9t8kXCZWi7aSaJa6g+EwUTHWBKb5ti65ZMr?=
 =?us-ascii?Q?bED8QXWuAnGFfatFdgoTcFa/DHVyOp32FuG75eKTZRnzxM9kpk/tOvbL8Zo+?=
 =?us-ascii?Q?OEKtgyoGBDOqhpClyxCa2HuCX6kWcC0GuK9Nl0XaJrVX7TlyHNNkV1eWt/gG?=
 =?us-ascii?Q?AQCUqAA/XeLg8ahgQyXttsTZegMmXMsBl8zneuCAJtO1ts6zh7zDUfiSDn/I?=
 =?us-ascii?Q?TIU8S2vsB1iS3SJoP4c0iYd4p7SByN3GterAjo43KDVWEK66YYTMgetv9CvJ?=
 =?us-ascii?Q?ON/XQtFxKCvTK1TRTVCeO2yCo26zdUSetR0RKK8D5i4hGkjpk6j9iVzWjApv?=
 =?us-ascii?Q?M55KBmwn2em6aKtkNrYE5XHiLkBBrVmFFe5vNz+tbKoEztt85a+rFIHjuTxu?=
 =?us-ascii?Q?Kr0ZZq6xShCTY3dtXr/Ma6ZWT7uqfsU6QhnTZrpL9XVSHetJ9z9jiwdJK43X?=
 =?us-ascii?Q?dyg7FnbXX1MGaZSsuLigM7sP2nKo5REMvRbjb8IIgnERAQn+lR6Tw2NSJuEq?=
 =?us-ascii?Q?yrUxYQvHIwyfQRhKyxQutf6/drkrAgbmJNLEsRvqXThazCNmMPIybBJ3kfvR?=
 =?us-ascii?Q?99bta/xl74E+E1o7vmbhUjBtM+HJFz/Os8V1wTPssoMkNGl1KYfk4fedh+aE?=
 =?us-ascii?Q?TXQYa0wMe6LoD9ryycy5C2+181K4DWBiKhosrFZRDCr7hycY9pniHw6ERi8y?=
 =?us-ascii?Q?0vHVPoG7qN2IYIV6EDg4SazgJ27MI2Hp+xAolbjJ1Umpmre59eszCUHL4Eoy?=
 =?us-ascii?Q?oDnnmlPQlvfl3iQWFsTXM2fxsgwnkfwW+w1SMUF2gGRk93T7AunrDy8Bg1+z?=
 =?us-ascii?Q?KS5qy6vAqLw3MsGdbvRxcFposZ4Ct25Pit5GeaQ6vWVXPcyR+4ndXfo6kK2s?=
 =?us-ascii?Q?/XgY/qiZLb46Epm3mXP4JiVxd/RdyU+wxuQJlxqtnbf6/l9sWtpb16jjJEdv?=
X-MS-Exchange-AntiSpam-MessageData-1: yT6yaZosTzI4DJ2+dhAeUhPusfezynDFV8s=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: da94398a-3d9d-4642-9555-08def30c941f
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:14:08.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8tjJpcyyiEeSUq88sTT8fyBstLNG3Kq9cRHLu4fqNbzZx6MsXHRHrLabIB6eSiVwjWeOQDys0Mio7rk2xouxtNoo8e1rKez0vdShpu/IgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3548

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
that node's timer if the cluster-scope list is still empty. The timer
also retries 'tipc_nametbl_publish()' if it fails in 'tipc_net_finalize()'
(Thread 1).

Fixes: a5e7ac5ce134 ("tipc: fix regression bug where node events are not being generated")
Reported-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v11: Remove node's workqueue and use node's timer to redistribute
     publications to address sashiko's valid comments.

 net/tipc/core.c       |   1 +
 net/tipc/core.h       |   2 +
 net/tipc/name_distr.c | 106 +++++++++++++++++++++++++++++++++++++++---
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c |  68 +++++++++++++++++++++------
 net/tipc/name_table.h |   5 +-
 net/tipc/net.c        |   8 +++-
 net/tipc/node.c       |  50 +++++++++++++++++---
 net/tipc/node.h       |   1 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 211 insertions(+), 35 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..9e81be4f01cf 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	atomic_set(&tn->finalized, 0);
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..97562cdf6060 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,8 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* flag to enable node's timer to redistribute publications if any */
+	atomic_t finalized;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..c9dc1e7d7450 100644
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
+ * 1 on failure, node's timer needs to redistribute publications
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
index 253c72d1366e..1242e0fd380b 100644
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
@@ -786,8 +819,10 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 
 	if (skb)
 		tipc_node_broadcast(net, skb, rc_dests);
-	return p;
+	else if (p && (p->scope == TIPC_CLUSTER_SCOPE) && err)
+		*err = -ENOBUFS;
 
+	return p;
 }
 
 /**
@@ -810,7 +845,10 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 
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
@@ -839,7 +877,7 @@ bool tipc_nametbl_subscribe(struct tipc_subscription *sub)
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
index 7e65d0b0c4a8..7b4e829c8244 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -125,8 +125,8 @@ int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 
 static void tipc_net_finalize(struct net *net, u32 addr)
 {
-	struct tipc_net *tn = tipc_net(net);
 	struct tipc_socket_addr sk = {0, addr};
+	struct tipc_net *tn = tipc_net(net);
 	struct tipc_uaddr ua;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
@@ -138,7 +138,11 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	/* Redistribute bulk of publications via node timer if
+	 * tipc_nametbl_publish() fails.
+	 */
+	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
+	atomic_set(&tn->finalized, 1);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..aa26139ecc91 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,7 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @dist_bulk: flag to redistribute cluster scope publications
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
@@ -393,6 +395,14 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
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
@@ -402,6 +412,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int rc = 0, err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -421,20 +432,34 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 
 	write_unlock_bh(&n->lock);
 
-	if (flags & TIPC_NOTIFY_NODE_DOWN)
+	if (flags & TIPC_NOTIFY_NODE_DOWN) {
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
+		atomic_set(&n->dist_bulk, 0);
+	}
 
-	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+	if (flags & TIPC_NOTIFY_NODE_UP) {
+		rc = tipc_named_node_up(net, node, n->capabilities);
+		/* Defer bulk distribution to node timer */
+		if (rc > 0)
+			atomic_set(&n->dist_bulk, 1);
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
@@ -564,6 +589,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	atomic_set(&n->dist_bulk, 0);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -801,9 +827,11 @@ static bool tipc_node_cleanup(struct tipc_node *peer)
 static void tipc_node_timeout(struct timer_list *t)
 {
 	struct tipc_node *n = timer_container_of(n, t, timer);
+	struct tipc_net *tn = tipc_net(n->net);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-	int remains = n->link_cnt;
+	int dist_rc = 0;
+	int remains = 0;
 	int bearer_id;
 	int rc = 0;
 
@@ -814,6 +842,11 @@ static void tipc_node_timeout(struct timer_list *t)
 		return;
 	}
 
+	if (atomic_read(&tn->finalized) && atomic_read(&n->dist_bulk)) {
+		dist_rc = tipc_named_dist_cluster_scope(n->net, n->addr);
+		atomic_set(&n->dist_bulk, 0);
+	}
+
 #ifdef CONFIG_TIPC_CRYPTO
 	/* Take any crypto key related actions first */
 	tipc_crypto_timeout(n->crypto_rx);
@@ -825,6 +858,7 @@ static void tipc_node_timeout(struct timer_list *t)
 	 */
 	tipc_node_read_lock(n);
 	n->keepalive_intv = 10000;
+	remains = n->link_cnt;
 	tipc_node_read_unlock(n);
 	for (bearer_id = 0; remains && (bearer_id < MAX_BEARERS); bearer_id++) {
 		tipc_node_read_lock(n);
@@ -835,11 +869,13 @@ static void tipc_node_timeout(struct timer_list *t)
 			tipc_node_calculate_timer(n, le->link);
 			rc = tipc_link_timeout(le->link, &xmitq);
 			spin_unlock_bh(&le->lock);
-			remains--;
+			if (dist_rc != -ENOBUFS)
+				remains--;
 		}
 		tipc_node_read_unlock(n);
 		tipc_bearer_xmit(n->net, bearer_id, &xmitq, &le->maddr, n);
-		if (rc & TIPC_LINK_DOWN_EVT)
+		/* Force node down in case the redistribution failed */
+		if ((rc & TIPC_LINK_DOWN_EVT) || (dist_rc == -ENOBUFS))
 			tipc_node_link_down(n, bearer_id, false);
 	}
 	mod_timer(&n->timer, jiffies + msecs_to_jiffies(n->keepalive_intv));
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

