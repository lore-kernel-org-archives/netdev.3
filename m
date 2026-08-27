Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9A3C76A6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829275; cv=fail; b=WfK3QI/ENXErwS3NwGRQrGvpHrs80Gyzhg4VYQrXaYJZXPXZi/0DNHSMMLQHrlaKOwGFjblE+4rzGUsahOkgHiwrHd9iKedlz/aa/oTFs/BgJOE4RCipchpoH5B4XXfUGW8R3lHRX0cQOKnHbmVvzNwh+2RX630Hf5xm3wLVitM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829275; c=relaxed/simple;
	bh=CEoLQdekSa+5FKdFkbtafm/R7KmxTsK8bGMo9SdK/hc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fYs9aq+ORb1RsybYv/rra/xrJ87F6LSlF8iSocbxRTXcOhMsOv24PZbsC787alxlqnuUn8fREGrZ58bF0ojOtcc90+4Faa/IQbyv/0nYvYUdzRydeyF7pZ9vdfAmfo+Rnh5rh74l2cAzbLR4XNmqHjS8vU3dMPqpax+Hz0aan8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RhO5xH05; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RhO5xH05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy/GQdoyjg4fM19tSvSkSoZU3jFuekrB+Tic4RkNSGBXu0yzM8QQ5NCrmj32UhS41dzgHX6zkZ12IEuwz6MV6nFjk7m07ilibKOzX4LuO3WR5qEwrHxKZDt8X7vcWAE89VM+8Bz4kTTgMW33oCD4QV6M04xfPH89CJTjY4STL6NwMQJaWBYgdtI+LAjBO14P/HhCWd8/+fnRL9M+LalPwJFwDW5KF6hCRoObYZLPu8aYl1Dt/LQIGhdln7RniWN+ifAeME97dSsHwNhNwO//jVzVglG5dciJNlcrpvptE/GmXMwmhkLKtphh0FUXkduP0sj6HF2W/GWmRuqciiR2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J78uukPKtxcNlXwl1V1/IhqvYRND3xgjztjCciNcFcU=;
 b=zJqYujbRqOMSEYKaxK9sXOgI/qddVw+T27T4xnI5LkvbP+ZjPvt7OoghsMYJfLRM5IMvEJ/D/oo1KrSCvyqcTFIM6dDjz/Wzq14Rvkn4kUo3/FdV764H9ufcCab/ctDmogTA99YwuzGBDTQDOavHoKk1mzk76HbFcbCVPblsKNPhhNYdtPSRl/nUyc0WUBON6WwNfnEjeaI18dH/DB5WFenLJDrwVtthLw/FJuIhiRU3xdvEc32wA55ol55OJ/yIVaj7R5S2tfPPguoKe4Akjdh/p4SFU3Br0SrGMUGTCU/c41AuxFYTItsQUPG/zXThLZpqN68B1c/fN42OSKUfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J78uukPKtxcNlXwl1V1/IhqvYRND3xgjztjCciNcFcU=;
 b=RhO5xH05Sx4eKy6RMKB4AZrnOAs8OSELgQ4SM+v8uEndvFVnb55LS4h7bhMcAlE6yLmiKRnDVd/LAxB4uXJXGXLQPWMdoSwOYaDuDiFZ8ZJHqV7vxQke06yv/hAVKYic0hEoNa0lKs5EoPErUOmlRE5xJeQF9Z2UmBrbj2GnP+1b55rIo9SrAyCbT4pOlxeelc96Jy9/QUv4VwKKcyr/EkoNxfPqq7pTfqIgJOc5nOr3AXFH3ge6M9yifLekh/uVK8AKhk9WXyT0/7BPno6Gshxx4d/dCyufJvWEvHy0WlKZtYnZZAu8XKtdlp9th5e/98WkMtJ5d5bBeexZa2ys5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB1064.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:168::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 11:14:28 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 11:14:27 +0000
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
Subject: [PATCH net v17] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Thu, 27 Aug 2026 18:13:46 +0700
Message-ID: <20260827111418.164957-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0078.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::7) To GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:63::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB1988:EE_|DB8P189MB1064:EE_
X-MS-Office365-Filtering-Correlation-Id: 49758e75-d62e-41c7-f106-08df042c5bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|7416014|376014|11063799006|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4OEJPvcfUMaz3nbXT9aa3XFX3aOUynlWmt59igNM/9nbmA2SOqE3IeEUDsrv5L/mcLlWiECSWeoaS+hzKU57x/7w6uhl/1LjJtEKVzktnrqEp3BT8DLGplUPsEj623kMmGYJY47hn5K7/Rcu2KAo6WX3OSsdQY8qbugzYGNcylLTkBCItoy7/fenv3jxA98mWrSnAIB0IEBGRZ/Ptyo3zojQ+3vS23zZQ5dW9MmcIoBOHcNybic51qDxhIYvVC8+ufhwoOnPTnfs3jf6Y7WXsfhx10VkKAe+RFsXRHagI2t7EklJBkQnBARRgIa9kE/au9xfwWcTASZsZA0PXk7ztpKh0fpD4jItOyYfn6pyHroVh9+uYw1KGsLwxG1goXIpvLcQOF2+grSO+NBt8dr+bxpMCehxP5a8qOVrbI8ntQmI0Fyrbbz/Z2LsvG8znmZpd64jcisDMRbbFZP9MlhyKfI2MHnHbL01P57XzpHGewVdIcHq43OiM3QwSIZaadeBna/Q9q2iMWSQBWrDB6lcwPFkjRLDnP8KG/H5TtLJVzmziVBdH1/j232B5pCjHrz5y3Ifz0Il+Ocf/CULvD3C/aGhK2a89OmhbRLF0fPgGoWYpPiShhPf1UbtjBuaCZ40za53PEbNszCArgISZOnRwK23jpEWoa8eK/4V/tFWYiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(7416014)(376014)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjcYXVTpBB2zVF5hP4LlfpK8YK0EAgcVV76ugcZHtNDPmTIqBa8W98ruiXNY?=
 =?us-ascii?Q?qbxj8qEEGysU6y0TMlDlpnT//p2SO8SMLnPYq7J7UdYH+Ka6SmRmfXB51VeE?=
 =?us-ascii?Q?tsX49ABrwF+WmrawpSC1KZh6fea5CJVUOS72QwubONtMJ8+NH6gvlTMSnY6f?=
 =?us-ascii?Q?JseekRua80nx+cfyigsFZR5Llj7Hwrn/htY8vritTgKdOP1Llg9UWrIoZoHX?=
 =?us-ascii?Q?Jf5o0jenLboaEzHewnSkTCK8zJxxIfI1As0R7aWZmEiEhBuOYZhXsbI5J/V+?=
 =?us-ascii?Q?SFl7/uG8lH9VW+xgmx9ydAn7nJXtuwfTprMLkN7aaRxu4KuxmAm41G+MfgNw?=
 =?us-ascii?Q?CxE62Bs+FCldN/C5kbmTjPjKRbyTBqPOObi0Ut9tKRnI8yV1HAOjxRbkUZm6?=
 =?us-ascii?Q?xCj4FVL+N5RokxVIzcm2vp8fn/F7/wBFIDJpP/KpW9Y1+rnI0WaSxQ8ohUXL?=
 =?us-ascii?Q?yjBHOOi7IynXazh9Y7xT1Q/Wr+AbMeiWBivKh7Jr0JQqfU/zYiIkmSgoa/Xr?=
 =?us-ascii?Q?hqggCwwsPtukKibYr2IMOGn4i7ZOBX0TkQhaCjyilSbuQqQhCiQO9DRVM5wE?=
 =?us-ascii?Q?UF7sRIUwErabxG+qi/pl0Lac0kFs+cnPREl8wiUDJjARotSss2o50IMThMQK?=
 =?us-ascii?Q?DrxbBhgeDfnULZwl0Bt0x5OVT2oDTHQYo93j4FmJVKJnAY4QnIWlV0ocOfr3?=
 =?us-ascii?Q?UX5LgCwRQLCrNf4cNgfhtE4gwMqSEs/dDhL2Jg2LxhTE2zkDLJPmXhjkkQSv?=
 =?us-ascii?Q?LyRQGDrR3T9ylbi8PegTKA6aFd05canTyzAii9f+HETqZEOykz8eT6B5sG3U?=
 =?us-ascii?Q?LcKq3Stlsk1mOdYJTYfqrSnoPNlZKBurxeQYX3fdaNF2lUpxZKFluvvMKTb3?=
 =?us-ascii?Q?3tgz4eAj8Gv7LR/WnkuDAgcNEpyKjDSYMCwbLiV/0wCUY8liaKUclnxsMBq5?=
 =?us-ascii?Q?tJtyVU4F/Oncbxw39KtdbbhNgvPcDy8qKOR3eGNyVArH2fPNzHB47ix1c5Ri?=
 =?us-ascii?Q?5XwozUzioilnGtPbO/L/DzFuZgmp+lnjAK0mZq3ciNhtBO/OfG7G/TkYpRAj?=
 =?us-ascii?Q?Goq23YqauvSc/cPNzYCbO8ohMMHP9n/Tmbp/tX94gvthEnq9mB05ABNM+iWt?=
 =?us-ascii?Q?w9GFS35Mc7hxM6kQU+ibdcMwvigO+p8pF3o+6h1mkhxYrQdl3wPlufBHB6hT?=
 =?us-ascii?Q?wai3aZ+/v+1+sAmEe5QYRHHXgGOXWbTsuwz4LimVG7YFxnk3YQt9EaIgm7CG?=
 =?us-ascii?Q?qx6Mr1V3kkp4Kw5wGhdtXpsLnN9Umrwjoz32am6K7qRj7M/Pk6NyWfjxKo7/?=
 =?us-ascii?Q?RJNmAknlVcpAD1225NF6eg/oS1Gdk6NRVl6wMFfC9i9uo8pXB5enM29pPDrK?=
 =?us-ascii?Q?Nj/fgcLTqN337G4+W8PxAB73a6fm3QRbxIJi2EPeeuV7dMgQsmgceS42BCt1?=
 =?us-ascii?Q?s/4ttZUXbKl3E51G5BPNKcjdpMZMsxD3OwRcWJWtNHzJHiHCoRDD93fbch8V?=
 =?us-ascii?Q?SeaQ9Pctq8WPQYKxzuFuP1F0aNdD2W4vXOwj5CS8+jg2gtozpxUmYGM6TcuO?=
 =?us-ascii?Q?mnDI77QHYUo6M2HF3Wp2qnwgXG8txcNp7XX4y9UH/Mb9/d5JQpxTgIvZZGBR?=
 =?us-ascii?Q?EfjcJ4sOlLj+LJrKqXUbwXIz5TZ7wE9YdtC+mDmNcfUpo70TcGKeB4gZoPp6?=
 =?us-ascii?Q?yrcd7kplIpFSZ3EYCKJkug8zLMwtBIRmK1AYeN8tgZzR/giqWxsD05udPKxz?=
 =?us-ascii?Q?E+rwK8G37zqu6cEq2U/p2p8CZ8Mll4+mzdBGWUlUrvkHwNHIl+BRZ/Xk3wl2?=
X-MS-Exchange-AntiSpam-MessageData-1: aHBmkU6/T5bhZWJ9vWrkn3jj4NDe1FNvQd4=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 49758e75-d62e-41c7-f106-08df042c5bca
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 11:14:27.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFv/Gf2NNVZMJazX0Ad4qEEa0mZO2ikNwYni3llcH0pwLmp85jBo0N7amowRn+skpOgZmj/3dkofmwTRJu9ASgClHcA2nI1n6BALcftrsTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1064

User-space applications can bind a large number of service addresses to
one or more sockets. Each binding of a local-scope service address inserts
one entry (publication) into the TIPC name table. If the number of these
publications exceeds TIPC_MAX_PUBL (65535), protocol service types
(such as node state and link state) are no longer inserted into the name
table. This causes two issues:

1. User-space applications subscribing to node or link up/down events
   stop receiving notifications.

2. A NULL pointer dereference can occur:

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

   If 'tipc_nametbl_publish()' (Thread 1) fails because the number of
   local publications reaches TIPC_MAX_PUBL, list (Thread 2) will be empty. As a
   result, NULL is passed to 'buf_msg()', leading to a NULL pointer dereference.

Fix these issues by allowing protocol service types (node state, link state,
and topology server) to be inserted into the name table unconditionally.
This ensures that users subscribing to these types always receive
notifications. In addition, the maximum number of local user publications is
reduced to (TIPC_MAX_PUBL - 1). This ensures that the maximum bulk size
calculated in tipc_link_set_queue_limits() remains valid.

Fixes: a5e7ac5ce134 ("tipc: fix regression bug where node events are not being generated")
Reported-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v17: Only fix original issue reported by Xiang Mei. Other pre-existing issues
     (including sashiko's findings) will be addressed via separate
     patches.

 net/tipc/name_table.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

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
-- 
2.43.0

