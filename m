Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2912C0294
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173467; cv=fail; b=hhkHshifpNXoxCEgh8BISLOoZWMueCZzlaMRGAShrLGFfNvIYpAbV6G5ps2KC4K5ECL4iT7bXsm0ctQQ2V93SVbILXQroMZflKl69nbbLR7Erz9am/MolXsHQTOmbi6QzhFwcOZhHUSCjFRjJ/MTlnCEelZ3gKZGTwxm2+YVO3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173467; c=relaxed/simple;
	bh=KF0xaD6Jr5JPzSpbR+1u3/tpR3oGkyjPSeMalIVVyy0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TqafmZN9ObPCDkXQ1/CsmMWYYCImYGt1XgmfwOTRMUj9cZE+ZhUPUF2I0W1l/8/0GEDWiMc/mkGuHccCMWfFVG4IpdgNV2BcO4dlQ/X4y7Ni4Cm8uC5P35Fw/ZxpMdkAWLVkgUoDmSLLwX8iBsajqNHp0hMKdUOiHfDxxHqrwGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RLDIKXH/; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RLDIKXH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws5nCzxri6zzKMfE7juJAZ3IPX0ZCN6/jfXlq39q6u0607+Z/QxfcQQafE6jKspqsxKlLKeeRfzqUDX2xLJ4/A8MiCbDlN0/8VjcYfkbMgkOG5Y1zGJkfS9gX2h0gfJTPWRP1VqGYYUO1Eei3dAXrvZ6x3xN0W5W4qm8EHAaxRtWbDi0JTKakifVBLuNzJqzRY8bZrjtat9/28FRRwdcfgfLmy9+QQxADUEqXN+5v355MD9P4g4whGBxaQIoMTwRFcB5ABCkeUjGWfn2mUQ1YHq28+M+HHAXsY3Rju/v5vfBIs+pnxVJVojvrwUl1NFzbQJMLqUlEqNCpPHeEh7n8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7fJa6f5TxFPW12ZKInCwY8LPgSK38sHgBTung1fcxo=;
 b=gmIEeA8cNAzkwVBBKLXZyg6KMD2yplyO1ZuuGvA3AavkpNzj+H0aeOwLiMYEujK+URtUg2BIPgPEm2GPWlOAm+aU9uMfgo9XlA6uobopENwUl9cFQ0t6bkHWzaBc1aeVyaQIQOodehJIuUf777+OinXG5HBX23LihwTBzPX6TK1UsDllR4muWqGEfVOuQFrdcL9rTVvSG4KCIZY5tEGxaznRLh4vFRtVocMfrX+MSCBAog1DsMX+VvBLsPqyv+0ch6fltdtc4CobiL7Fk3zMgRlJCeGC/3HA8A1IbzkeW836nI3/F1JQf4FR0Lg/rGt8ccHXewB12vsQWMVzX/1Ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7fJa6f5TxFPW12ZKInCwY8LPgSK38sHgBTung1fcxo=;
 b=RLDIKXH/jPXPYeVAKRonPilAShY0dqxJUInRjKTlRgAl/G7MQbjLhrky2y5TBkqUU9RoUTy+inpHejNxqY9ZsYiMvxforgHAqGdjjFO/K8OpZIxlCsi0zPKpfm4H2/izwQqsx/CrBd+0QW+6/GT9YlxRpZP6bEnkWRe7ZRTUesNdWtC0tP2oUjocQD8BTuJCUIMpHSwzbgnX/HxWGKONCYsPmgMPNlEuKDv0G/W6EUIumirklH9g7V8vcL6Yk1xPyFxtmqX8p9Xqqv2jVoo1VSM9LYog0geGb1B3bzTXyQgJsafzU7HqfOpuOCdj9a+k/p0FZq06fAu6HAE0K8Z4mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PR3P189MB1147.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:11:02 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:11:02 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net] tipc: fix several race conditions caused by tipc_node_write_unlock()
Date: Mon,  5 Oct 2026 11:10:23 +0700
Message-ID: <20261005041053.22695-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:617::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4P189MB3750:EE_|PR3P189MB1147:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b24243-6bd4-4c50-3b06-08df2296ab2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|4022899009|376014|23010399003|11063799006|5023799004|56012099006|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8LScmJzWANZiKO57aoKFvB4seVYfujEf3amqyCrgokzv2JOXsUMyrdC/tvuyjouiarC8nS2IgdyPHrH5vb0sE9awf/sxs8CWQUFjDLJ3jaT8BYcooEK8VXksNks+dFTh9JFuxpBokCfr+iVOaDCXK9BWpUDGp62ktZ0PJCHrWtKXSCRvpzNRafJTUGb/IAHOr2Ix1zxoj/X4ItCMknJM+jqNomVl5M5TQYVJklpIKXd0So6EYi1y4JtQLk100hVWfJrhuS33G1gqVCtmq8b8MGQWb1tcwvSAIbclj1TU2Fz2i0xzvWT5v6q6m8AN5dlbNGMlzX6g82KOsi3uJnD6sw9+5blR8/Qax6PDwcdKQWYBS76+Zw0h/eLMp8Aoul/4LOMJpyhoONeOGWbY6PltCfiAGiij+qrvTmBLT4yYYOwAMZ3FeOGbVWaw572fQHdC01wAtI+BGzzK+Cvn3FGzTpwOe5rXiOUosr9GDstrd6pYogV1sO0eLP+pwmxf/EUvn1c8PjLTGMTjfoPTz51dCQ4CpvvMje7vi9j+G4Zbhs989x3OOGlECLZsCR3ilPpuKlzeg5ogyekKSouqcD5ZQf6cGvqcuNLs2waJRnccmZMKitHNsvc9qBVINnyFnil+lORlyBCGMBjpswRr1VSKF2eiCscPSo+u50jaRU/R3Ho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(4022899009)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WC/tPF+AkesdymTqOQ6XPKMAIbCpKetXsI2AgZZ3VFB/Sif6ISh5DO9Xaqyo?=
 =?us-ascii?Q?2vjChfIICVcR7j/qx5ibhTSRUKGTwVzWWxiVKr+JvXuuoNHK26YAg33paCBu?=
 =?us-ascii?Q?etyGBK829lQbzfz7HysmakUVsZZHD3/OJYzUnE4kVQzOtQd4JOCbw7qM/YFu?=
 =?us-ascii?Q?5um+4PP8Z4O0Z02A2BaQh522U7md49b8umBwPv8dAQq9Bcm59hkIMMKEdD6t?=
 =?us-ascii?Q?Jtj6oLlSsvKFsJ1P5P6Qj5YpMmuFE46p2hvsA0Ya/KyZkwBpavOXQshFfacS?=
 =?us-ascii?Q?684814npOi/wmPDAN1Jx3MkjuArt04FNd+YTcmHrBTYkkhoKEFr3ftvzrQa4?=
 =?us-ascii?Q?ecybohuNww7UFfhJ8DeTZg929G2CKcUo1ms5FZgWHnlYKKPlntlh9Ki+p8Bt?=
 =?us-ascii?Q?pNCCpMGHS7X3kk67F8Je7+bGA4rfSWxaIIGHPfeNJXphjQaOOixucWnbSumm?=
 =?us-ascii?Q?hp/5UE6kztKNl98xsgETfXu63qqeFc280FFcxP3cZho+uzKlgknYuhFkMbrh?=
 =?us-ascii?Q?M48/H9w5ThjohR59tGW0RLgpoC57Vz3jTI+6s7bobNT6Ooy6O2944BuRp87O?=
 =?us-ascii?Q?GDkSRtwzo7AVcqhQ5hzFsrbTI88w6HWcqAnj7w/VxdGfsnLq/arKP58kSnHq?=
 =?us-ascii?Q?dQmZi8ZXsOha1NGcd5HlJCRn2+k0DckuHf8u7hppOcS82wUMP7Lkq12plBnB?=
 =?us-ascii?Q?1TFfB3HeAvtULO8oa3JF383Mw+DL1FRn4CoOlTwHMOgj+khTurIowdrgxleR?=
 =?us-ascii?Q?630H52EJ0sNJW6Oi7/i9ynB93DlCI1MlbbdERIpu3riZ8zLDnaeVLLI+pNxm?=
 =?us-ascii?Q?CzBpDuqYHvJ6o8sKRa6fR9GDfX5KPi/T53z//BLxhpQlCaccc6PWKKDNeSJw?=
 =?us-ascii?Q?WzjXW+XmRMm3d2S2VskpWtpRtNAKbwfYJX0LeBvjIJqT+Z1LcnDvfs5wRw48?=
 =?us-ascii?Q?qib8n1MrBTnzlomM2bq3qC5Szn1CRDkHoytug4IwPvgSz8qtIF2dQIc2kI+k?=
 =?us-ascii?Q?+iQNl9oxpnnMd16koKniBwmnRLOINIpYgWpGm7vvMXGw18vfzJAfH0Zk6/OI?=
 =?us-ascii?Q?m5tGbAS3whyBk2T/Us1q0UUwpsTRJVW33Abzv0RnnIMX7zjJnVWGbNyoq4oT?=
 =?us-ascii?Q?pUjV5uxP70YyTlciDLXt9PDFcoakbaYjJuRsr7/JK2cTb2fJiL0N3LzdUPza?=
 =?us-ascii?Q?jCC53TwvZzZLoeJ+l66lLftHWETBNuSgtT9JZomxknRz0weiV5YDpg54+MIi?=
 =?us-ascii?Q?93kmvg4Hv0D0KO7gIrsXbGuAc79G+7Bzit6+9RLSYOwf0ftMm2bdOmCXFZIe?=
 =?us-ascii?Q?LRky8F9ZBs6okBmLasidJH+ud1mYsu+Sgkz+0zVtaHb/jst0uQUPZlgOwHLa?=
 =?us-ascii?Q?rGFnYsrRFzAFxXv/ycazkioCnK3SpXo5vCFGhsgSv6xXPJ44VJ4U+sOh66UW?=
 =?us-ascii?Q?mtDwe0wTiylqQ6G8ZgAAqPcb73N4LioNEFJs/GarpsPjgkeVSGsbm1OhrybX?=
 =?us-ascii?Q?iUKvzuTT1D6nqpcdGrgyPWY//yl+5+4gwVUmO8+vUQWvaNPeIq0SfpK3EvuX?=
 =?us-ascii?Q?0C4hs6Iyb5WVsLmTfY1gHa6hKdEdavqewFFC1seo7GAiyQF17K8tFzs9SjhY?=
 =?us-ascii?Q?qfGeSOrr4amXeQg4ZFmCQfYynbrIU5VnkE6kapokv7CvYbiXSue4esIwI1CB?=
 =?us-ascii?Q?LxWE2xJ3zngvgygPM155KE7uWw/smX+Oc0+IcHoeiQsS7Bi9smfpG3SFMa10?=
 =?us-ascii?Q?XT0AjsihPe5oJ0QEYmHmTnVP7zkg5fg9XBMMKRVRKP5YOIjM7Vyvr2qhOW1q?=
X-MS-Exchange-AntiSpam-MessageData-1: 0363DwW4asDpy4iGp3QwSQoIXg7q8ULndrQ=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b24243-6bd4-4c50-3b06-08df2296ab2f
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 04:11:02.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do1FGq+CgZW4I2kqp66KocGuFI3oObDFiPWmsvSUlTdmSQm0Pnk5/HveB+M9bshuyju6Z+Lz0UaCmISgcpWCYvj50PmuUAoYihYLb6TKqD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1147

tipc_node_write_unlock() releases the node lock after resetting n->action_flags.
This creates a window for several race conditions:

- A race between link-up and link-down events can occur when the
link-down thread is interrupted before removing a publication from
nt->cluster_scope, and the link-up event inserts a publication into
nt->cluster_scope.

- A race can occur between a tipc_rcv() thread that adds or removes
publications to or from node->publ_list and a node-down thread that
removes publications from node->publ_list. The latter thread traverses
node->publ_list without proper lock protection.

These race conditions can result in various use-after-free issues.

Fix these race conditions by:

1. Holding the node lock during link-up/link-down and node-up/node-down
   events.
2. Removing the node lookup and node lock from
   tipc_node_subscribe() and tipc_node_unsubscribe().
3. Holding the node lock before calling tipc_named_rcv() from
   tipc_node_bc_rcv() and tipc_rcv().
4. Moving tipc_node_broadcast() from tipc_nametbl_publish() and
   tipc_nametbl_withdraw() to tipc_node_write_unlock().
5. Moving tipc_node_xmit() from tipc_named_node_up() to
   tipc_node_write_unlock().

Fixes: 5405ff6e15f4 ("tipc: convert node lock to rwlock")
Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Closes: https://lore.kernel.org/netdev/20261001182924.3928331-2-nicoyip.dev@gmail.com/
Closes: https://lore.kernel.org/netdev/20261001182924.3928331-3-nicoyip.dev@gmail.com/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_distr.c | 28 ++++++++-------
 net/tipc/name_distr.h |  7 ++--
 net/tipc/name_table.c | 25 ++++++-------
 net/tipc/name_table.h |  6 ++--
 net/tipc/net.c        |  8 +++--
 net/tipc/node.c       | 84 +++++++++++++++++++------------------------
 net/tipc/node.h       |  4 +--
 net/tipc/socket.c     | 24 +++++++++----
 8 files changed, 95 insertions(+), 91 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..cf5125212521 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -202,8 +202,10 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @net: the associated network namespace
  * @dnode: destination node
  * @capabilities: peer node's capabilities
+ * @xmitq: list of skbs need to be sent
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities,
+			struct sk_buff_head *xmitq)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
@@ -218,8 +220,7 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	named_distribute(net, xmitq, dnode, &nt->cluster_scope, seqno);
 	read_unlock_bh(&nt->cluster_scope_lock);
 }
 
@@ -227,12 +228,11 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
  * tipc_publ_purge - remove publication associated with a failed node
  * @net: the associated network namespace
  * @p: the publication to remove
- * @addr: failed node's address
  *
  * Invoked for each publication issued by a newly failed node.
  * Removes publication structure from name table & deletes it.
  */
-static void tipc_publ_purge(struct net *net, struct publication *p, u32 addr)
+static void tipc_publ_purge(struct net *net, struct publication *p)
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct publication *_p;
@@ -243,14 +243,14 @@ static void tipc_publ_purge(struct net *net, struct publication *p, u32 addr)
 	spin_lock_bh(&tn->nametbl_lock);
 	_p = tipc_nametbl_remove_publ(net, &ua, &p->sk, p->key);
 	if (_p)
-		tipc_node_unsubscribe(net, &_p->binding_node, addr);
+		tipc_node_unsubscribe(&_p->binding_node);
 	spin_unlock_bh(&tn->nametbl_lock);
 	if (_p)
 		kfree_rcu(_p, rcu);
 }
 
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
-		      u32 addr, u16 capabilities)
+		      u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
@@ -258,7 +258,7 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 	struct publication *publ, *tmp;
 
 	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
-		tipc_publ_purge(net, publ, addr);
+		tipc_publ_purge(net, publ);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests--;
@@ -277,7 +277,8 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
  * Return: the publication item if successful, otherwise NULL.
  */
 static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
-				u32 node, u32 dtype)
+				u32 node, u32 dtype,
+				struct list_head *publ_list)
 {
 	struct publication *p = NULL;
 	u32 lower = ntohl(i->lower);
@@ -301,13 +302,13 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	if (dtype == PUBLICATION) {
 		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
 		if (p) {
-			tipc_node_subscribe(net, &p->binding_node, node);
+			tipc_node_subscribe(&p->binding_node, publ_list);
 			return true;
 		}
 	} else if (dtype == WITHDRAWAL) {
 		p = tipc_nametbl_remove_publ(net, &ua, &sk, key);
 		if (p) {
-			tipc_node_unsubscribe(net, &p->binding_node, node);
+			tipc_node_unsubscribe(&p->binding_node);
 			kfree_rcu(p, rcu);
 			return true;
 		}
@@ -371,7 +372,7 @@ static struct sk_buff *tipc_named_dequeue(struct sk_buff_head *namedq,
  * @open: last bulk msg was received (FIXME)
  */
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
-		    u16 *rcv_nxt, bool *open)
+		    struct list_head *publ_list, u16 *rcv_nxt, bool *open)
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct distr_item *item;
@@ -386,7 +387,8 @@ void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		item = (struct distr_item *)msg_data(hdr);
 		count = msg_data_sz(hdr) / ITEM_SIZE;
 		while (count--) {
-			tipc_update_nametbl(net, item, node, msg_type(hdr));
+			tipc_update_nametbl(net, item, node,
+					    msg_type(hdr), publ_list);
 			item++;
 		}
 		kfree_skb(skb);
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..14c008ab8644 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,11 +69,12 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities,
+			struct sk_buff_head *xmitq);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
-		    u16 *rcv_nxt, bool *open);
+		    struct list_head *publ_list, u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
-		      u32 addr, u16 capabilities);
+		      u16 capabilities);
 
 #endif
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 6fda36ab1766..da306d178d56 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -760,15 +760,14 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 /* tipc_nametbl_publish - add service binding to name table
  */
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key)
+					 struct tipc_socket_addr *sk, u32 key,
+					 struct sk_buff **skb, u32 *rc_dests)
 {
 	struct name_table *nt = tipc_name_table(net);
 	u32 max_user_pub = TIPC_MAX_PUBL - 1;
 	struct tipc_net *tn = tipc_net(net);
 	struct publication *p = NULL;
-	struct sk_buff *skb = NULL;
 	bool protocol_type = false;
-	u32 rc_dests;
 
 	if (ua->sr.type == TIPC_NODE_STATE || ua->sr.type == TIPC_LINK_STATE ||
 	    ua->sr.type == TIPC_TOP_SRV)
@@ -797,14 +796,12 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 		 */
 		if (!protocol_type)
 			nt->local_publ_count++;
-		skb = tipc_named_publish(net, p);
+		*skb = tipc_named_publish(net, p);
 	}
-	rc_dests = nt->rc_dests;
+	*rc_dests = nt->rc_dests;
 exit:
 	spin_unlock_bh(&tn->nametbl_lock);
 
-	if (skb)
-		tipc_node_broadcast(net, skb, rc_dests);
 	return p;
 
 }
@@ -815,15 +812,16 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
  * @ua: service address/range being unbound
  * @sk: address of the socket being unbound from
  * @key: target publication key
+ * skb: name distribution message needs to be sent
+ * rc_dests: the number of replicast destinations
  */
 void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
-			   struct tipc_socket_addr *sk, u32 key)
+			   struct tipc_socket_addr *sk, u32 key,
+			   struct sk_buff **skb, u32 *rc_dests)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
-	struct sk_buff *skb = NULL;
 	struct publication *p;
-	u32 rc_dests;
 
 	spin_lock_bh(&tn->nametbl_lock);
 
@@ -833,15 +831,12 @@ void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 		    p->sr.type != TIPC_LINK_STATE &&
 		    p->sr.type != TIPC_TOP_SRV)
 			nt->local_publ_count--;
-		skb = tipc_named_withdraw(net, p);
+		*skb = tipc_named_withdraw(net, p);
 		list_del_init(&p->binding_sock);
 		kfree_rcu(p, rcu);
 	}
-	rc_dests = nt->rc_dests;
+	*rc_dests = nt->rc_dests;
 	spin_unlock_bh(&tn->nametbl_lock);
-
-	if (skb)
-		tipc_node_broadcast(net, skb, rc_dests);
 }
 
 /**
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..6cbc9da17464 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -126,9 +126,11 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
 void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 			      struct tipc_uaddr *ua);
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key);
+					 struct tipc_socket_addr *sk, u32 key,
+					 struct sk_buff **skb, u32 *rc_dests);
 void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
-			   struct tipc_socket_addr *sk, u32 key);
+			   struct tipc_socket_addr *sk, u32 key,
+			   struct sk_buff **skb, u32 *rc_dests);
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..1e445c5abc0f 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -125,9 +125,11 @@ int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 
 static void tipc_net_finalize(struct net *net, u32 addr)
 {
-	struct tipc_net *tn = tipc_net(net);
 	struct tipc_socket_addr sk = {0, addr};
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff *skb = NULL;
 	struct tipc_uaddr ua;
+	u32 rc_dests;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
 		   TIPC_NODE_STATE, addr, addr);
@@ -138,7 +140,9 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	tipc_nametbl_publish(net, &ua, &sk, addr, &skb, &rc_dests);
+	if (skb)
+		tipc_node_broadcast(net, skb, rc_dests);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index d7cbfa786c13..182c6dbfa49d 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -397,44 +397,50 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	__releases(n->lock)
 {
 	struct tipc_socket_addr sk;
+	struct sk_buff *skb = NULL;
+	struct sk_buff_head xmitq;
 	struct net *net = n->net;
-	u32 flags = n->action_flags;
-	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	u32 rc_dests;
 
-	if (likely(!flags)) {
+	if (likely(!n->action_flags)) {
 		write_unlock_bh(&n->lock);
 		return;
 	}
 
+	__skb_queue_head_init(&xmitq);
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_NODE_SCOPE,
 		   TIPC_LINK_STATE, n->addr, n->addr);
 	sk.ref = n->link_id;
 	sk.node = tipc_own_addr(net);
 	node = n->addr;
 	bearer_id = n->link_id & 0xffff;
-	publ_list = &n->publ_list;
-
-	n->action_flags &= ~(TIPC_NOTIFY_NODE_DOWN | TIPC_NOTIFY_NODE_UP |
-			     TIPC_NOTIFY_LINK_DOWN | TIPC_NOTIFY_LINK_UP);
 
-	write_unlock_bh(&n->lock);
+	if (n->action_flags & TIPC_NOTIFY_NODE_DOWN)
+		tipc_publ_notify(net, &n->publ_list, n->capabilities);
 
-	if (flags & TIPC_NOTIFY_NODE_DOWN)
-		tipc_publ_notify(net, publ_list, node, n->capabilities);
+	if (n->action_flags & TIPC_NOTIFY_NODE_UP)
+		tipc_named_node_up(net, node, n->capabilities, &xmitq);
 
-	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
-
-	if (flags & TIPC_NOTIFY_LINK_UP) {
+	if (n->action_flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
-		tipc_nametbl_publish(net, &ua, &sk, sk.ref);
+		tipc_nametbl_publish(net, &ua, &sk, sk.ref, &skb, &rc_dests);
 	}
-	if (flags & TIPC_NOTIFY_LINK_DOWN) {
+	if (n->action_flags & TIPC_NOTIFY_LINK_DOWN) {
 		tipc_mon_peer_down(net, node, bearer_id);
-		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
+		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref, &skb, &rc_dests);
 	}
+
+	n->action_flags &= ~(TIPC_NOTIFY_NODE_DOWN | TIPC_NOTIFY_NODE_UP |
+			     TIPC_NOTIFY_LINK_DOWN | TIPC_NOTIFY_LINK_UP);
+	write_unlock_bh(&n->lock);
+
+	if (!skb_queue_empty(&xmitq))
+		tipc_node_xmit(net, &xmitq, node, 0);
+
+	if (skb)
+		tipc_node_broadcast(net, skb, rc_dests);
 }
 
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
@@ -653,40 +659,14 @@ void tipc_node_stop(struct net *net)
 	spin_unlock_bh(&tn->node_list_lock);
 }
 
-void tipc_node_subscribe(struct net *net, struct list_head *subscr, u32 addr)
+void tipc_node_subscribe(struct list_head *subscr, struct list_head *publ_list)
 {
-	struct tipc_node *n;
-
-	if (in_own_node(net, addr))
-		return;
-
-	n = tipc_node_find(net, addr);
-	if (!n) {
-		pr_warn("Node subscribe rejected, unknown node 0x%x\n", addr);
-		return;
-	}
-	tipc_node_write_lock(n);
-	list_add_tail(subscr, &n->publ_list);
-	tipc_node_write_unlock_fast(n);
-	tipc_node_put(n);
+	list_add_tail(subscr, publ_list);
 }
 
-void tipc_node_unsubscribe(struct net *net, struct list_head *subscr, u32 addr)
+void tipc_node_unsubscribe(struct list_head *subscr)
 {
-	struct tipc_node *n;
-
-	if (in_own_node(net, addr))
-		return;
-
-	n = tipc_node_find(net, addr);
-	if (!n) {
-		pr_warn("Node unsubscribe rejected, unknown node 0x%x\n", addr);
-		return;
-	}
-	tipc_node_write_lock(n);
 	list_del_init(subscr);
-	tipc_node_write_unlock_fast(n);
-	tipc_node_put(n);
 }
 
 int tipc_node_add_conn(struct net *net, u32 dnode, u32 port, u32 peer_port)
@@ -1917,10 +1897,14 @@ static void tipc_node_bc_rcv(struct net *net, struct sk_buff *skb, int bearer_id
 		tipc_node_mcast_rcv(n);
 
 	/* Handle NAME_DISTRIBUTOR messages sent from 1.7 nodes */
-	if (!skb_queue_empty(&n->bc_entry.namedq))
+	if (!skb_queue_empty(&n->bc_entry.namedq)) {
+		tipc_node_write_lock(n);
 		tipc_named_rcv(net, &n->bc_entry.namedq,
+			       &n->publ_list,
 			       &n->bc_entry.named_rcv_nxt,
 			       &n->bc_entry.named_open);
+		tipc_node_write_unlock_fast(n);
+	}
 
 	/* If reassembly or retransmission failure => reset all links to peer */
 	if (rc & TIPC_LINK_DOWN_EVT)
@@ -2198,10 +2182,14 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 	if (unlikely(rc & TIPC_LINK_DOWN_EVT))
 		tipc_node_link_down(n, bearer_id, false);
 
-	if (unlikely(!skb_queue_empty(&n->bc_entry.namedq)))
+	if (unlikely(!skb_queue_empty(&n->bc_entry.namedq))) {
+		tipc_node_write_lock(n);
 		tipc_named_rcv(net, &n->bc_entry.namedq,
+			       &n->publ_list,
 			       &n->bc_entry.named_rcv_nxt,
 			       &n->bc_entry.named_open);
+		tipc_node_write_unlock_fast(n);
+	}
 
 	if (unlikely(!skb_queue_empty(&n->bc_entry.inputq1)))
 		tipc_node_mcast_rcv(n);
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..3599e48457bb 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -103,8 +103,8 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list, u32 dnode,
 int tipc_node_distr_xmit(struct net *net, struct sk_buff_head *list);
 int tipc_node_xmit_skb(struct net *net, struct sk_buff *skb, u32 dest,
 		       u32 selector);
-void tipc_node_subscribe(struct net *net, struct list_head *subscr, u32 addr);
-void tipc_node_unsubscribe(struct net *net, struct list_head *subscr, u32 addr);
+void tipc_node_subscribe(struct list_head *subscr, struct list_head *publ_list);
+void tipc_node_unsubscribe(struct list_head *subscr);
 void tipc_node_broadcast(struct net *net, struct sk_buff *skb, int rc_dests);
 int tipc_node_add_conn(struct net *net, u32 dnode, u32 port, u32 peer_port);
 void tipc_node_remove_conn(struct net *net, u32 dnode, u32 port);
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..dda247db0e60 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2906,23 +2906,27 @@ static void tipc_sk_timeout(struct timer_list *t)
 
 static int tipc_sk_publish(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 {
-	struct sock *sk = &tsk->sk;
-	struct net *net = sock_net(sk);
+	struct net *net = sock_net(&tsk->sk);
 	struct tipc_socket_addr skaddr;
+	struct sk_buff *skb = NULL;
 	struct publication *p;
+	u32 rc_dests;
 	u32 key;
 
-	if (tipc_sk_connected(sk))
+	if (tipc_sk_connected(&tsk->sk))
 		return -EINVAL;
 	key = tsk->portid + tsk->pub_count + 1;
 	if (key == tsk->portid)
 		return -EADDRINUSE;
 	skaddr.ref = tsk->portid;
 	skaddr.node = tipc_own_addr(net);
-	p = tipc_nametbl_publish(net, ua, &skaddr, key);
+	p = tipc_nametbl_publish(net, ua, &skaddr, key, &skb, &rc_dests);
 	if (unlikely(!p))
 		return -EINVAL;
 
+	if (skb)
+		tipc_node_broadcast(net, skb, rc_dests);
+
 	list_add(&p->binding_sock, &tsk->publications);
 	tsk->pub_count++;
 	tsk->published = true;
@@ -2934,13 +2938,19 @@ static int tipc_sk_withdraw(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 	struct net *net = sock_net(&tsk->sk);
 	struct publication *safe, *p;
 	struct tipc_uaddr _ua;
+	struct sk_buff *skb;
 	int rc = -EINVAL;
+	u32 rc_dests;
 
 	list_for_each_entry_safe(p, safe, &tsk->publications, binding_sock) {
+		skb = NULL;
 		if (!ua) {
 			tipc_uaddr(&_ua, TIPC_SERVICE_RANGE, p->scope,
 				   p->sr.type, p->sr.lower, p->sr.upper);
-			tipc_nametbl_withdraw(net, &_ua, &p->sk, p->key);
+			tipc_nametbl_withdraw(net, &_ua, &p->sk, p->key,
+					      &skb, &rc_dests);
+			if (skb)
+				tipc_node_broadcast(net, skb, rc_dests);
 			continue;
 		}
 		/* Unbind specific publication */
@@ -2952,7 +2962,9 @@ static int tipc_sk_withdraw(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 			continue;
 		if (p->sr.upper != ua->sr.upper)
 			break;
-		tipc_nametbl_withdraw(net, ua, &p->sk, p->key);
+		tipc_nametbl_withdraw(net, ua, &p->sk, p->key, &skb, &rc_dests);
+		if (skb)
+			tipc_node_broadcast(net, skb, rc_dests);
 		rc = 0;
 		break;
 	}
-- 
2.43.0

