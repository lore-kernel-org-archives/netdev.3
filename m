Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8F370D7C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503377; cv=fail; b=FbREMHbnwT5iho3BoQ1eHVrJYJ/0WrZRLUN2Nt3+d+legBfOn8UL7RCvA1neUymwljXrKSmwVsUzAOmMA5xpCPdJxm1DTPOi/2yxT5LIWBP+WE4j0OfJ0E0QpDxDcV/DXhzrPP2Ro58Mzi9q7myW2MWhrRKWM9+i7xle+5KqxfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503377; c=relaxed/simple;
	bh=q5AlhSiztFIa6xiyf3V1AGc5hXhvctZNQBNPatcR9/A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZxNFsr19xUXp2Zt6224GbBumNQl98t3IaY3FDtqBhtKjvEwMhcxgzyybuIKndIQ5i/CqjkaH1uVg3ll1l+VUeO5XLFpemitR205XsgdnVvW2Kp5aeioOgvaO3Ls00J60zDojd14B7KYfyn1fz7RltjbQeZVtrHiQ8T798rhJPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=U//Zhwvf; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="U//Zhwvf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/uGGFZJV/O4k+dpaOsumIMX7xKGTYHnOzdOxci8DooOauwq/QR9F+jq26RhCftPt0+UBgj5z5R/NDRo2dfUuZyENxc7yuOHjGxglab53k+lMHydKfEg5Mtskqn33uTCkuUGBHC6zZ1RDD4mCaT0tLeJ+Eu/UhAVM6FDPVkXgiQZOrY0MrRvzj6rkWsMY0/FXJROSSo7wk1/uKV5yD6uwnLwdIKA0VUsDX5H0iIaMf8JHi0IysipiJGvL3PBW6ih41vs04IsVIEiLL59E8mrO6XjP7HwkNRwl1aR+6IqFLajcEwQusZgSADbGjb1c+vZ27AoXxRF52gP4E+/hNEMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B5sA8lutaX1AGrVoy7Szz7e1naFkr8vkUqL6pKWJkk=;
 b=J7HodD5ENE5zS5/y3YxPh3vZWj0GNuDPRKrPajCqnJ5pBtHXei+NrJ0QkHT41f9nW7zzXjCzEP/3FjWnN8GUgJomF280UxjpZGLqXS8K4E77nmXcnBX5Q8hh6FpkvTZn3EK4d7v0cakc7r5dtTdZaFD+rjGsITk52Vm6Gms0Uh9ccalpycO6yREmybdcaYWsivzw54u8GAuCBAuXar/4fnWEfizPBS9tZVOJ5bj7WmAUuPPqzMMN63ecIM0ahqJGXqNVU8iq8ahrmCEnQgKxHg6A/A47enoo5YOcDNvNkXc+/yG//NhiODZEWzEbPW60w1z5EvoFbjsVgeB/MCWyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B5sA8lutaX1AGrVoy7Szz7e1naFkr8vkUqL6pKWJkk=;
 b=U//Zhwvf1gsjSMTZrkZAUxR3EcUBMJplZVf/lm9nb1kV2+cv0obj7Lp4MOZBcQ9eLD5GT49DFOEEX5FWgQZ2rBHZP5D+D/ewi1566pHr6m4Secl0nZL/1hqLfJJkMJoUDGPjbW5z2DhQXQKr6/8mMqJZTlXdM9IpeVkruJ9mVSH3KceGeHYJqPM+atrIy14bF7yUz7YabPOaQV0Dnbu4PuMyXYzXSF8//JfokH8od5Xf9pF+VGw0DrSpjEBba5TBeEUSliensfUYdgZUS+aIqXPtCS56TeS+yBnETmenukNCOZkT8aV3ZLvnmKvx18zMwiMtkA3/XcjEDnu0CMl63w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU4P189MB3498.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Wed, 12 Aug 2026 02:56:09 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.001; Wed, 12 Aug 2026
 02:56:09 +0000
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
Subject: [PATCH net v12] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Wed, 12 Aug 2026 09:55:17 +0700
Message-ID: <20260812025559.71701-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:d10:31::19) To DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:3a6::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|DU4P189MB3498:EE_
X-MS-Office365-Filtering-Correlation-Id: b910470d-bc21-43be-7997-08def81d41f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	zpAJcahN/pVa86SAFeKVLPi3Swm30daQcTliOfLpnr8ev6gI4I+MAmmCGm8XH1qqWeWZfRbuh3Ob41OCVHAMrsTu5PiK0K+xesBOsUFLU/0y0LBwsud9vQe8iFsV3hmapNGRPtR3JxUin5VrU82UiDDVPQArCppa1M9Vjj3Ixsjd8ntWw2VCcGEQEni0CA0H/1q/seloAFP/s2oJRdGmthoBwk6DMVIOVoLAAqzWhFKs0DsKirNPBOFXSL/4HsZ62JjirQEtZaz+vwDsgDuJGZSi+R9eYfTYW2Az4bP2JP3OkGr+dzAmFybNytkDT41nJaR/iSksQGEAfDurUAQOdg6dSTtexSinLI7Q/Zqtismim/lFAgeOKvgyqRRBXwCokCrZ9V2xC7gQBuANCvyxLpjelODutwN/Qi2Hp0xz39mmJVdNrhYL3u1L/IPm9CwGcUC/KoUDKDrL+VqCgymxmJZLzYGjjAiShkXkyyBdRBHXYvEDfNS6qP0MhAOhOZOAZAKde0JajkQc+2FqE+PInT/U+R8rB12klaSXXhGuRLK4jSvL5tnWn0ti4naLOa35sYQuufGXkO8OjAkFgz4yZClPY4jbIwjQJwLd5AFxQd0XZYHk+vMy/Gov0F+/JL9LYXnGWRGmGOm7+mBUVoX3m8wbFJfefTAWA+DcG3KKAhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F0qgXalAdd/6KN4b1N3bJnTWs2teDTUxytz/5g7C6jjk7nCs6DnUh4NOqQem?=
 =?us-ascii?Q?e3cFj9/Pj4ZUbWyltM8KDu7099nRylfn1lFUB/PTwxZ2HFP4QHzxnHB0KXVb?=
 =?us-ascii?Q?XezCFuXmJPRxoOtMljJwHwZSAKUcN+vrnR7kisLxLljLghvAs5blDInDehkm?=
 =?us-ascii?Q?Hv6i0oyJIMVam8TZGk5jZuKoPQfA4tBrvuYbANtM/7xKz3vduQCcBH8RnS4M?=
 =?us-ascii?Q?1MbFLgjD9SYMd705YFyuKfU4QM7LtHqmzksxvCv3qZMgLDDF6rIHMkaD0np/?=
 =?us-ascii?Q?NnLkQRJpUR8pW4kUKnaHy+kG8KUE3fG/2iqtAzKpxSdf6pmdEoW3C1tJBOS1?=
 =?us-ascii?Q?jMZNmvJGZ+qGTUCKGGag1UIvzAg/ZaiM8/mGioSxrA/Z+FV955C/j/SEA4mK?=
 =?us-ascii?Q?QUdczkf3TGyoD7T2XDvHODDcrLn+YOCaaYn09y8z1M3GaNDAm/mpmr9RHedK?=
 =?us-ascii?Q?gY5sFfI0qPVyhLjAc7D0K6qwj5CdAgvucVuCN1pS4G4Ya6HbIMLzlPE9+Sbl?=
 =?us-ascii?Q?bXVN721+BZN01MSn+2RUcdr0lO2LycTp33JD3ge7TUeSZq2IqSYO51fy502G?=
 =?us-ascii?Q?q+KZO3ddJYj4MmO71fA37GzfigDbv0tENNhyyREjpJkifuAMboYtgqbqVp5f?=
 =?us-ascii?Q?oOcE8G1ezfDN6inaq1LMO0j1CBUYy5iOhSp35RROJfLA7JUIwcqVz5x6TnJ+?=
 =?us-ascii?Q?q6HmUC6feRYu0tT3biYImTxXjJefS8XaGUN5qeuG2LH/YIudXT49vTPSfazk?=
 =?us-ascii?Q?76AgKRUzQYHXaY3a/7JB0JKgYUkq3lOzSGClFCRfoPHDN3px37yXhf/vEZec?=
 =?us-ascii?Q?Z0qKxr6Cy7gBcQp69beh4By2WBxQs0cvW5ao2Qr+SXJLztVEsBS1WIxaojs6?=
 =?us-ascii?Q?Gw8T6zzOVhLLXfshqSVcajgFEK2AbIFCWsIVrfZCpvB2VPxe/Pxcr1fwyexB?=
 =?us-ascii?Q?ifkol0EDjM3wxH5ycmhHKs0oCZkYmCMQp4oSTdXqpXJeKk3n3ZAykvdoJWyo?=
 =?us-ascii?Q?DcCExpmw/O7b33HCBZP/JaF+fAjQ5xxGZF9NJ13GF6AG01e+rDk7ak/B/xyf?=
 =?us-ascii?Q?EdKu+pSK4MIY2F6YUCWPqLHIKf/D/NG7Lilh7TzUU3JiAs1TIzwtQoutgHHk?=
 =?us-ascii?Q?aoFj4TB2Eo9gqXYUqDI9AWAQu0rAc/rcEP3jDYsbpTaQm5zDaTqcThYeaZcR?=
 =?us-ascii?Q?lXTrU8RaOrUjyxbasNbQtFqXuuB6Pb/yXlkbYB9fry+Par1HRDfWHSMJPjTV?=
 =?us-ascii?Q?XrbuTCY/eb6APq9LKlf5Q5W0Mz+Z5TsuvDR28O+UM976i+t0giQ2/am01wSc?=
 =?us-ascii?Q?QQeeufkHyjcB9YPu4QYTZ3lHMIgBejhoKiglpux88WUV3gBR+nLmLL28VVBa?=
 =?us-ascii?Q?rWkt1PVVxGcWOoAJSQnOJPNfhbdXcaUc/UmqpohnhjlfVmwyNNbzG6xHcvwk?=
 =?us-ascii?Q?jI+JQDWhM08futa5wRxoTTmNDQdM18W1MGxdFDQc6otH/4er4LqotBWJvWXT?=
 =?us-ascii?Q?QZ7VjMgZST/JZcVl2OW7RDjjo5BdGvpjbhMpV7EGBAk+7egpg6ctgTMFtX+Q?=
 =?us-ascii?Q?AmfuTFrQRYxk96vNw3/JrJz1NEN/1LIYn18hRtR36e+0321S5DxAZib7eB7B?=
 =?us-ascii?Q?7iaja/4maP5Y0biPQI2kOv3oJf8tddk0clR+rgRWhZRfLSbl4ZFfzIkJbSmr?=
 =?us-ascii?Q?zBl9D6OzPUMdaIF7AtmfSr6F6hPgQS9kPga9P0b3KfE6/zU9Dum182KHzGEX?=
 =?us-ascii?Q?h4LHu9WrdKDVy9oNqIQMjD8MUD/8KvIgW+v1j14TVHnWlf+pFeTgrDLtGL9f?=
X-MS-Exchange-AntiSpam-MessageData-1: bUmBhs00iPkaScUzQCy+xW1HZbJI1vFZBP8=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b910470d-bc21-43be-7997-08def81d41f9
X-MS-Exchange-CrossTenant-AuthSource: DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:56:09.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQQ7lZgWEJZOd5KKEyxexWq5FF5eEdzBHpb50uL0af95cgz+NqM3LiNQVkBcQ4ttF3waKKswXi6DUub+yMSRtUQQgbRQKsYlljHyBgebgPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB3498

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
and topology server) to be inserted into the name table unconditionally.

Fix the second issue by checking for the node's self-address publication on each
node-up or node-timeout event. If the publication does not exist, insert it into
the name table and publish it to the other nodes. If the insertion fails due to
a memory allocation error, force the node down and restart the insertion
process.

Fixes: a5e7ac5ce134 ("tipc: fix regression bug where node events are not being generated")
Reported-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v12: address sashiko's valid findings and 'make htmldocs' error.

 net/tipc/core.c       |   3 +
 net/tipc/core.h       |   6 ++
 net/tipc/name_distr.c | 114 ++++++++++++++++++++++++++++++++-----
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c | 127 ++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_table.h |   6 +-
 net/tipc/net.c        |  11 +++-
 net/tipc/node.c       |  46 +++++++++++++--
 net/tipc/node.h       |   1 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 282 insertions(+), 37 deletions(-)

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
index ba4f4906e13b..060c42d8fda5 100644
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
@@ -195,6 +197,82 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
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
+	/* Node's self address is not set yet */
+	if (!atomic_read(&tn->node_addr_set)) {
+		/* Defer the distribution to node's timer */
+		tipc_node_set_dist_bulk(net, dnode);
+		return 0;
+	}
+
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
+		if (tipc_node_xmit(net, &head, dnode, 0) == -ENOBUFS)
+			rc = -ENOBUFS;
+	}
+
+	return rc;
 }
 
 /**
@@ -202,25 +280,32 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
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
+		if (tipc_node_xmit(net, &head, dnode, 0) == -ENOBUFS)
+			rc = -ENOBUFS;
+	}
 
-	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
-	read_unlock_bh(&nt->cluster_scope_lock);
+	return rc;
 }
 
 /**
@@ -416,5 +501,6 @@ void tipc_named_reinit(struct net *net)
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
index 253c72d1366e..3bb0ce783dbd 100644
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
+	if (!sr) {
+		if (err)
+			*err = -ENOBUFS;
 		goto  exit;
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
 
@@ -490,8 +493,12 @@ struct publication *tipc_nametbl_insert_publ(struct net *net,
 	sc = tipc_service_find(net, ua);
 	if (!sc)
 		sc = tipc_service_create(net, ua);
-	if (sc && tipc_service_insert_publ(net, sc, p))
+	spin_lock_bh(&sc->lock);
+	if (sc && tipc_service_insert_publ(net, sc, p, NULL)) {
+		spin_unlock_bh(&sc->lock);
 		return p;
+	}
+	spin_unlock_bh(&sc->lock);
 	kfree(p);
 	return NULL;
 }
@@ -760,24 +767,44 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
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
@@ -786,8 +813,81 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 
 	if (skb)
 		tipc_node_broadcast(net, skb, rc_dests);
+	else if (p && (p->scope == TIPC_CLUSTER_SCOPE) && err)
+		*err = -ENOBUFS;
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
+
+	spin_lock_bh(&sc->lock);
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
@@ -810,7 +910,10 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 
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
@@ -899,7 +1002,6 @@ int tipc_nametbl_init(struct net *net)
 
 	INIT_LIST_HEAD(&nt->node_scope);
 	INIT_LIST_HEAD(&nt->cluster_scope);
-	rwlock_init(&nt->cluster_scope_lock);
 	tn->nametbl = nt;
 	spin_lock_init(&tn->nametbl_lock);
 	return 0;
@@ -919,6 +1021,7 @@ static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 	rbtree_postorder_for_each_entry_safe(sr, tmpr, &sc->ranges, tree_node) {
 		list_for_each_entry_safe(p, tmp, &sr->all_publ, all_publ) {
 			tipc_service_remove_publ(sr, &p->sk, p->key);
+			list_del(&p->binding_node);
 			kfree_rcu(p, rcu);
 		}
 		rb_erase_augmented(&sr->tree_node, &sc->ranges, &sr_callbacks);
@@ -949,6 +1052,8 @@ void tipc_nametbl_stop(struct net *net)
 			tipc_service_delete(net, service);
 		}
 	}
+	tn->nt_stop = true;
+	tn->nt_self_node_exist = false;
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	/* TODO: clear tn->nametbl, implement proper RCU rules ? */
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..e7a2c50f099c 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -97,7 +97,6 @@ struct publication {
  * @cluster_scope: all local publications with cluster scope
  *               - used by name_distr to send bulk updates to new nodes
  *               - used by name_distr during re-init of name table
- * @cluster_scope_lock: lock for accessing @cluster_scope
  * @local_publ_count: number of publications issued by this node
  * @rc_dests: destination node counter
  * @snd_nxt: next sequence number to be used
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
 					     u32 key);
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
index 683a136e53ef..ca4a8fcca644 100644
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
@@ -345,6 +347,15 @@ static struct tipc_node *tipc_node_find(struct net *net, u32 addr)
 	return node;
 }
 
+void tipc_node_set_dist_bulk(struct net *net, u32 addr)
+{
+	struct tipc_node *node;
+
+	node = tipc_node_find(net, addr);
+	if (node)
+		atomic_set(&node->dist_bulk, 1);
+}
+
 /* tipc_node_find_by_id - locate specified node object by its 128-bit id
  * Note: this function is called only when a discovery request failed
  * to find the node by its 32-bit id, and is not time critical
@@ -393,6 +404,14 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
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
@@ -402,6 +421,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int rc = 0, err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -425,16 +445,24 @@ static void tipc_node_write_unlock(struct tipc_node *n)
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
@@ -564,6 +592,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	atomic_set(&n->dist_bulk, 0);
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -803,7 +832,8 @@ static void tipc_node_timeout(struct timer_list *t)
 	struct tipc_node *n = timer_container_of(n, t, timer);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-	int remains = n->link_cnt;
+	int remains = 0;
+	int dist_rc = 0;
 	int bearer_id;
 	int rc = 0;
 
@@ -814,6 +844,9 @@ static void tipc_node_timeout(struct timer_list *t)
 		return;
 	}
 
+	if (atomic_xchg(&n->dist_bulk, 0))
+		dist_rc = tipc_named_distribute(n->net, n->addr);
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
+		/* Force the node down in case the redistribution failed */
+		if ((rc & TIPC_LINK_DOWN_EVT) || (dist_rc == -ENOBUFS))
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

