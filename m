Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37547381B02
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791264207; cv=fail; b=AFaG7eGOv1pZnaYXjKTW4O5XHgSo3hLM4vya2ehU0Ui2nnjNW5Fa3UbnRke1K3bRxXxxhM1T2DhhsB/2wG1TXw9sNcy6AQ60v6zy9Exgzqt6y3V6u02XlqQ1K386OPQkMNnz2GDcW+LTlO/6+tUpk7EteOmjBVzgEPUbJGM+LMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791264207; c=relaxed/simple;
	bh=NeKBUOHs0qCfs6L2Zi+FRAoVa0DBi1YdaokkvpI4V3E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tOkfrwv6vGSndvafSCMhdtipTvCfZzqzuEuAexopdyhsPKKdAWHKIhAywnrUQCWCSxe6ZAqiHC12YEch4jsBrxb+0FesoAhpgyjqWJfdd7Sky3Yk8f2VcIOi0GV5AsE46kmLm9Nasht/lLCk8Tn1W/n9Vbar168EXJJAD7bIfXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=KaoCSkXB; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="KaoCSkXB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmjXczq7FdCMyHdmxIUhyXNxuLubFbWqTZMPg2WQl8aVJG8JPvoFp6+zHaa/htmLA/ZNl5yk8c7QL8vJv6rEH14p64tbAA8Fg7IXLKrKSVcwG02DVh78rXuzL19RukiLt2Pdlfo8fDquBfSGmQoMHf3RfOTh4JYqN4rG6GDw44tjhzKElvS0aINJZXbwzlcxj7wBpu1qAp4Y/2lgCcn1wLuJKOyV0eUWN9G/du3aCTxS9WyBQ08/VpU9zlfnt7vLegg9JiO4WdUNpQItsOYqToxWCPqfO68FJjehH+xhRyY+kFU1rGd2qUaebF9fEUXvFVElTeVPEfsQ6uEpKfxNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff2+faAWpQiSes/Z3CvDYGeCiEoS/4kDPOsfom14Dec=;
 b=ReqEHQSLWPJsVNzncIlJ6lNKZ8db0Euxna2yDoVWwYSemuc353n0zCNFb07zaZ8Z8HXxBspOxj0t9EFrkZyUj9p50YHTJ7Yen7cpADNFadsdT8Bx6DpsPu7lpZ9+UaDXBXmYQFQLMfntM3h8hyhrwYuuQYWQwc+vzCiXN7e7lEj0GmBtheVYi/uCW3QKESc5pXZsoJ4PqzS3tMcmuiVG0clRq3dCMkpt2gqbsQiDDOge+Zstq+I1ZNNrjBS2EZWjbr9+VMx5tqJO6/UJIyWVcas+XWAzmBveRq/6JllYsdvAE858dOdBfjuLX16TdSMwRRLAy81BM8kJ0e/RMrZbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff2+faAWpQiSes/Z3CvDYGeCiEoS/4kDPOsfom14Dec=;
 b=KaoCSkXB9QFpmdCl1VMK3D5UYslDDwfKCkr+JC4wwVqIp5rqaURA253O/okaWDYEFuY1sI0YWIPsMvRBCatVK7IRERR9KqjsOqkMPiAwq0WrD9XD3WbzvAtuBeaO9r72WH5ST4JnbyKIVFfle5/9Xb1xsjf9e27vrum0REDFtuIqZCzEKtOSknohXnrVQTJegr29OF5GkoTbm8Vh9M2mAZppZ/IRCIta8AgFiiyQqS7NFsXdgIjgoqcXKRSZA9khYL7BJ9mgG36yoDzxabG8O7GEyf7PQw3akP/IyJiD/PCDGqgvyIZ24mK3pIxT4MtueaK5G0Ks0YJI2pXMt7pGjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PA6P189MB3744.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:516::18)
 by AM7P189MB0980.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 05:23:20 +0000
Received: from PA6P189MB3744.EURP189.PROD.OUTLOOK.COM
 ([fe80::17d7:78c3:2473:8aaa]) by PA6P189MB3744.EURP189.PROD.OUTLOOK.COM
 ([fe80::17d7:78c3:2473:8aaa%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 05:23:19 +0000
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
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] tipc: fix several race conditions caused by tipc_node_write_unlock()
Date: Tue,  6 Oct 2026 12:21:30 +0700
Message-ID: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::18) To DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:617::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6P189MB3744:EE_|AM7P189MB0980:EE_
X-MS-Office365-Filtering-Correlation-Id: c616050b-94b4-4549-5add-08df2369ee81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|4022899009|376014|7416014|23010399003|5023799004|56012099006|11063799006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+feK62ObGK1goGsx1TpDO9lVcJ1WJfVYZoMg2kZPPC2356LxvpNsVWk7OUFSt/6r3CymQfzGgLHp1liuyJfoN8WejTk7ib/uFVktzm9vNONCDSqVETTWdfidFIw0fOhBV650Y0D35fOBtSq1TwjO6fBH8oCQOpegOKn/zRXD5N2nZO54kQmmxMPax/173ywUWhMEjSHQwm5XDLoJ1pAjyOvXR9jWlVXAMyMbuNdBQUFv0VFzyBrUmH4J47zd88VQQ1DeJG2/8vwOplmTfnMQU46L6g3CS9/UpIG9PCb1amq0VaFLvSfERExkbu+4+905sjscpGi7Wq2qC4Mr4HI/8isySOU4fJdexwO2a95LL37YIiqobQWu32Ia1LAe4U+Ih7jT6mD5n5+5EjF1MQRjLIc9fejpbJx984rWHdh0LIqNPvzmRmkspRlji1lHEm5k88MtOw6ZV3WyySCAaS9HxzATxsQE0I8ji0zJwexEacSN+OxnIVXYzFqHjchKZG2EenRZ5N8yaIPKN6B6gQRFz9ti+AkPF+NmYQ1v7PJ2KM3c4KCPjElZCLUeHhyTF/0TubVME9EaPwmgZJ8JtZwRM2KDNnSKIx0v3kWm0ojU6C7aizHJvnWehkyCvbICi0gK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6P189MB3744.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(4022899009)(376014)(7416014)(23010399003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVgdeJba7RtXbOCy7pk3Y76WVBKwwUly9goyvLW/Pb5PFVu/ktUQjVNHwHHW?=
 =?us-ascii?Q?rvO6WQx5YxjhDJ+zgTJMCxOp3nPqFaF/L2RKxwCkcVu8JJaW+TMAP5IMAfog?=
 =?us-ascii?Q?kS3/wnwKQuJB1Xn7fuAqA8dPfBFqxQfDnHhnm/ku181Eg0nuX+nI2l6Y5VDY?=
 =?us-ascii?Q?Gx18ZaNKTj3r8pJdsfPIBVwy3rig6xMhuNW+K0xgf4cP6MuSbhtQTtMx6l8T?=
 =?us-ascii?Q?YMqJj0Rbxrv7Ss6XTJajRm1GjUYz7rM6Mr2LzZkhLdM0CSVdMVMMtQXG5WtU?=
 =?us-ascii?Q?d8UCWj1ubBe2JeCqHzhXo9JsMayxlYed/WrQYHw63oELHcRAzXZHDzDZ45YA?=
 =?us-ascii?Q?PYKzeAwidUuy5iVRsj8bsbnZH5QxC2xw0PsZMESWKXedX+OVLUdolEyGDOU2?=
 =?us-ascii?Q?pOeEoeXElYu+ltUzKIB2dNQqouuhakhDw1N74mWwbGxvyr+0V8TL+OHjWzoO?=
 =?us-ascii?Q?HJ6sRYb6jZ0KscQAQts4dnAUVZqutVUJrX0QNwa1EzrT743tlNIq2dtwbirw?=
 =?us-ascii?Q?g6+pNrPGAfRUR7dPRnd/9YAtReTPV91ZzSmE8ZLvxK0C92yOrjfcIhek7FG8?=
 =?us-ascii?Q?ggVs1ptHTaugmdZBaFbg7LjJS/nA3vg+CcoOVAg0+Lc/jtKVMTKZVJMGTGjU?=
 =?us-ascii?Q?waWCONtMUneirZ8s0erNY48p/B0NCJgnz1AvYG+6Fdd9ztbJIPFyZjvqaSyj?=
 =?us-ascii?Q?sgI/3S7LlEt6qHKtND7RjjTXQdTDwCWvdJFigQv+pZCdpzYIbfEXgcnFOqa6?=
 =?us-ascii?Q?pjmRH1hrmCahlzXw1bwuJPMY8wm0FPVezPNMnnoLVY+4ojj3YVP6ufDw+JKJ?=
 =?us-ascii?Q?YhJLwwVMQYPX5RWlqK+hssUWY5IcRnpL3KQzKNgrQMwP0WcZoCWABI7BUVNd?=
 =?us-ascii?Q?nAEF6/rtIpGizuMv7W3n7mp/ipazoM0XyKkWdd09HmpmeY4vweoh+iBDfsKY?=
 =?us-ascii?Q?x5iKwlR5BN3bo2qZoJJbDbr5PHOaLJx+1w2DT32ZZILIGtISsA7duuhxARDa?=
 =?us-ascii?Q?wPmo5t515C6u3asrhP00avMe6sQrGz5Cia629vTdb9yWXln+ZQvV0aEOMhbx?=
 =?us-ascii?Q?OHxUpdqbkUh2+nWE9jzYGOmBS+UJT8lYJCg3srt/Dn45bJotYnTBgswJIRZ8?=
 =?us-ascii?Q?PaG/f1lFQwG2cn1m3Pi5mL80HxBAzVFlhZD5m/ySvtMcHU13sGgmAJofCDMr?=
 =?us-ascii?Q?QhhrPrG3KPS8jgGlzVwqNhfTHKQFP7h2M5hDHyqq3dpDz1m7W5Z1HVGz600A?=
 =?us-ascii?Q?M0zkkj6MiEz/ldvPcejvxvPGyJhA+jbE7BaOp2lWZKTeVtLM+nyStJhvzUS7?=
 =?us-ascii?Q?oRkpZfG80gV/A/OiWoWUopRysX7JgDk8y2J4Xlojp6DW4oAa207tWZJcs/BY?=
 =?us-ascii?Q?VZEUzePaP6yHOATZDVAcyuRDb4PyRIFQ/W4CZUyzdgzY5JitF1ffFzsILwvM?=
 =?us-ascii?Q?pQUuwQ6r2nzrh/aBlxjwLcuzXdYgqqdnH63jvsfnXuNkJVItJJkABNfrPuxj?=
 =?us-ascii?Q?3B3z1G50T+qVfGtDWzBCSzCUGO6nXEcYJ//6wTylft86hJctFJ43u/psjgJw?=
 =?us-ascii?Q?38fV86geZ5+Me7ZL9s20C9nKZtvoXXMj28EIEHv/lxtK49swSOFHpyAVUxNg?=
 =?us-ascii?Q?L26cRhR7CoDPdiN+/405ynYrbm/3024Z3FrRCDQMreQWMlRDMnYM87Bw6Wic?=
 =?us-ascii?Q?A/ezq7w8M/nIYRPBMRRSAZK01Mkz5lr1+0MWtNVU8IuDt+Uh4EzHVooZ5iNI?=
 =?us-ascii?Q?d0E7qruLxOfpBYnaIuoKAbaDk1gHG7Z+BVMiz7IxFNN+wfvyHIzEvrWEHS8Z?=
X-MS-Exchange-AntiSpam-MessageData-1: NYvZ5PWx/sh10REI8JHxvJ6uUNYvTPdYVQM=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: c616050b-94b4-4549-5add-08df2369ee81
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:23:19.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+oF0b5jgBkFd6jvfm3Brl+CISB8MLf3c4B0ZkuR6g7EjVVmxeIn+BxpE/vqAnnwE0Aj8Mtmz+zqTIicYQyglAWbzdUqQ03jMHlGTcFojFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0980

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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610060355.bPzTfoXZ-lkp@intel.com/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v2: Address build warnings detected by kernel test robot and remove unused
variable in tipc_named_node_up() detected by sashiko.
v1: https://lore.kernel.org/netdev/20261005041053.22695-1-tung.quang.nguyen@est.tech/

 net/tipc/name_distr.c | 32 +++++++++--------
 net/tipc/name_distr.h |  7 ++--
 net/tipc/name_table.c | 25 ++++++-------
 net/tipc/name_table.h |  6 ++--
 net/tipc/net.c        |  8 +++--
 net/tipc/node.c       | 84 +++++++++++++++++++------------------------
 net/tipc/node.h       |  4 +--
 net/tipc/socket.c     | 24 +++++++++----
 8 files changed, 97 insertions(+), 93 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..dcb15de42a9e 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -202,15 +202,15 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
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
-	struct sk_buff_head head;
 	u16 seqno;
 
-	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
@@ -218,8 +218,7 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	named_distribute(net, xmitq, dnode, &nt->cluster_scope, seqno);
 	read_unlock_bh(&nt->cluster_scope_lock);
 }
 
@@ -227,12 +226,11 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
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
@@ -243,14 +241,14 @@ static void tipc_publ_purge(struct net *net, struct publication *p, u32 addr)
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
@@ -258,7 +256,7 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 	struct publication *publ, *tmp;
 
 	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
-		tipc_publ_purge(net, publ, addr);
+		tipc_publ_purge(net, publ);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests--;
@@ -272,12 +270,14 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
  * @i: location of item in the message
  * @node: node address
  * @dtype: name distributor message type
+ * @publ_list: list of remote publications of a specific node
  *
  * tipc_nametbl_lock must be held.
  * Return: the publication item if successful, otherwise NULL.
  */
 static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
-				u32 node, u32 dtype)
+				u32 node, u32 dtype,
+				struct list_head *publ_list)
 {
 	struct publication *p = NULL;
 	u32 lower = ntohl(i->lower);
@@ -301,13 +301,13 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
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
@@ -367,11 +367,12 @@ static struct sk_buff *tipc_named_dequeue(struct sk_buff_head *namedq,
  * tipc_named_rcv - process name table update messages sent by another node
  * @net: the associated network namespace
  * @namedq: queue to receive from
+ * @publ_list: list of remote publications of a specific node
  * @rcv_nxt: store last received seqno here
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
index 6fda36ab1766..9ae3190ff6ea 100644
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
+ * @skb: name distribution message needs to be sent
+ * @rc_dests: the number of replicast destinations
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

