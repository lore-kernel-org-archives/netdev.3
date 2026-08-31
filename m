Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480D233944
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788141080; cv=none; b=KGsgww3dgYzBYB2REZs8oPJ/aQJLq3J8x/ga37gbne8XIBaVAwLOoyHfHmrOy9r097lXbEfe6rZEW9wV80Gk9MMQt4OzUcFOdyOK8XC/vE1WRmm/tZ7maO+y2+D1QWId0Qzsk0bZP+dvP3yxA3r/jrMZFb4CBDupvhHrRv7t37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788141080; c=relaxed/simple;
	bh=JOLAm5ESOM8f8gJhqwr289xLY4hGB0mV5Xk6vgP9dAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQorkNGVAGYL9hPlmw0zdjSJshlZ/k357p2+qmipMhtZF/lqCmpuI/uD3cdlyZ5yIs1JmKrR6No2BlxGzB/sKTKAMcf4LGGzqqQ5RC3p9i9GPjjhgJSpV16I84Q2Xk42/ru+2w/7/WyeQMBbILBy3/j0tuAT/W7gMrUX0vskeT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hnVYVYBE; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hnVYVYBE"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JOLAm5ESOM8f8gJhqwr289xLY4hGB0mV5Xk6vgP9dAQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788141075; v=1; x=1788745875;
 b=hnVYVYBEZWKnL7RukdDLt335PKnxrosd5/i8iHI8lZxXSL3bhq9ta/kAePFyy/lzVO0x2MXN
 1JGDjEg+FOInbHfTda/oVNkE9qeoqZiyYqcK2C2FN/bXtXE2We30zEBNnenmyRna5vAcyD7zC+X
 XFzQlCd8m40+07bq2bldeb78=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 08d21d258b7a308c;
	Mon, 31 Aug 2026 01:51:15 +0000
X-Mizu-Trace-ID: 08d21d258b7a308c
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 31 Aug 2026 09:50:59 +0800
Subject: [PATCH net v6 1/2] bonding: convert unbalanced_load to per-cpu
 state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-bond_overflow-v6-1-ffb0ed1f7268@kylinos.cn>
References: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
In-Reply-To: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

A later patch widens the bonding TLB tx counters from u32 to u64. The
unbalanced_load counter sits in the transmit hot path, and cross-CPU
synchronization of a u64 would introduce measurable overhead. Convert
unbalanced_load to a per-cpu counter first so that the subsequent
widening only touches per-cpu data local to each CPU.

Introduce struct unbalanced_load_stats to hold the per-cpu counter,
and move the aggregation into a helper, reset_unbalanced_load(), which
sums all per-cpu instances. Use the delta of current total load vs
variable prev_total_unbalanced to calculate the loading.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c | 37 ++++++++++++++++++++++++++++++-------
 include/net/bond_alb.h         |  7 ++++++-
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc18..0afed2c39231 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -133,6 +133,10 @@ static int tlb_initialize(struct bonding *bond)
 	if (!new_hashtbl)
 		return -ENOMEM;
 
+	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
+	if (!bond_info->unbalanced_load)
+		goto out;
+
 	spin_lock_bh(&bond->mode_lock);
 
 	bond_info->tx_hashtbl = new_hashtbl;
@@ -143,6 +147,10 @@ static int tlb_initialize(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 
 	return 0;
+
+out:
+	kfree(new_hashtbl);
+	return -ENOMEM;
 }
 
 /* Must be called only after all slaves have been released */
@@ -154,6 +162,8 @@ static void tlb_deinitialize(struct bonding *bond)
 
 	kfree(bond_info->tx_hashtbl);
 	bond_info->tx_hashtbl = NULL;
+	free_percpu(bond_info->unbalanced_load);
+	bond_info->prev_total_unbalanced = 0;
 
 	spin_unlock_bh(&bond->mode_lock);
 }
@@ -1345,7 +1355,7 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 		/* unbalanced or unassigned, send through primary */
 		tx_slave = rcu_dereference(bond->curr_active_slave);
 		if (bond->params.tlb_dynamic_lb)
-			bond_info->unbalanced_load += skb->len;
+			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
 	}
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
@@ -1529,6 +1539,23 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 	return bond_do_alb_xmit(skb, bond, tx_slave);
 }
 
+static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
+{
+	struct unbalanced_load_stats *p;
+	u32 delta, total_bytes = 0;
+	int i;
+
+	for_each_possible_cpu(i) {
+		p = per_cpu_ptr(bond_info->unbalanced_load, i);
+		total_bytes += READ_ONCE(p->tx_bytes);
+	}
+
+	delta = total_bytes - bond_info->prev_total_unbalanced;
+	bond_info->prev_total_unbalanced = total_bytes;
+
+	return delta / BOND_TLB_REBALANCE_INTERVAL;
+}
+
 void bond_alb_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
@@ -1570,12 +1597,8 @@ void bond_alb_monitor(struct work_struct *work)
 	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
 		bond_for_each_slave_rcu(bond, slave, iter) {
 			tlb_clear_slave(bond, slave, 1);
-			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
-				SLAVE_TLB_INFO(slave).load =
-					bond_info->unbalanced_load /
-						BOND_TLB_REBALANCE_INTERVAL;
-				bond_info->unbalanced_load = 0;
-			}
+			if (slave == rcu_access_pointer(bond->curr_active_slave))
+				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
 		}
 		atomic_set(&bond_info->tx_rebalance_counter, 0);
 	}
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index e5945427f38d..6fb09b4fc7e2 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -123,9 +123,14 @@ struct tlb_slave_info {
 			 */
 };
 
+struct unbalanced_load_stats {
+	u32			tx_bytes;
+};
+
 struct alb_bond_info {
 	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
-	u32			unbalanced_load;
+	struct unbalanced_load_stats __percpu	*unbalanced_load;
+	u32			prev_total_unbalanced;
 	atomic_t		tx_rebalance_counter;
 	int			lp_counter;
 	/* -------- rlb parameters -------- */

-- 
2.55.0

