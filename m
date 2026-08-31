Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5B1C6FF5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788141084; cv=none; b=RZ27Th40mxcTplUT5TQoC2/hk58EJpItXYNotP8StaPZJyHJOO3FjknWKpYAvLYJAhbpMOFHQvFsYDrWVYUmbTiHHoZHsTWIhjEVOAM/AvD2Lyy0XOJQV+D87aWyJenbKSPJoxp7z1+JmZ6E0X3kRlqiJ0tFl0x/DQQYw1/XcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788141084; c=relaxed/simple;
	bh=ekLujLISHTeUuLWCvrCYMs8wrq6fjaWRhr8nJe6szX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI8QmVMTv6j6jFnndt5L/6/eC5E1718rDA5YljN+7GqGmkgSVHiZ6vqwkoGbuExzCrSkdj+EjLFvyKqYWBfvjQdUrbcP/uJ90NQ9yl6JKVnQHdPGrwzlUHnsatC9nu2wd1RKdyQGr07O0n2WuMbRd+hLmLlFsiLI+difT0KdQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWsbk+dC; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWsbk+dC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ekLujLISHTeUuLWCvrCYMs8wrq6fjaWRhr8nJe6szX0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788141080; v=1; x=1788745880;
 b=RWsbk+dChnPKpjJwQ+29g72KpJxMopLoxs3bwF9LeyZojC07SqLFnZdUhegjDLHhfKeI7WnT
 gB+m4f7TfGaIVkEb1uox6LjxZK7P1gNgc3UOP6qtPOKQbF1HY/fATwyaW3AQd8HE/+ajmjOCokZ
 FYDikPe2ikWzjHera1DqoCRs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bd47afa49e248a18;
	Mon, 31 Aug 2026 01:51:20 +0000
X-Mizu-Trace-ID: bd47afa49e248a18
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 31 Aug 2026 09:51:00 +0800
Subject: [PATCH net v6 2/2] bonding: fix u32 overflow in compute_gap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-bond_overflow-v6-2-ffb0ed1f7268@kylinos.cn>
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

The TLB load-tracking fields tx_bytes, load_history, load, and
unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
over the 10-second rebalance interval the byte counters wrap, causing
compute_gap() to produce incorrect gap values and mis-select slaves.
Such speeds are common on modern NICs under heavy traffic.

Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
unbalanced_load_stats against tearing on 32-bit architectures, and
div_u64() for the 64-bit divisions. The tx_bytes and load_history
are protected in spin_lock. Also protect the slave load writing in
bond_alb_monitor() with spin_lock in case of tear on 32-bit.

For compute_gap(), we still use s64 arithmetic throughout, so we can
preserve the existing calculation logic. This order of magnitude is
sufficiently large, there is no need to worry about overflow for now.

Detected by AI code review.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c | 46 ++++++++++++++++++++++++++++++------------
 include/net/bond_alb.h         | 11 +++++-----
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 0afed2c39231..bbe9a6985f90 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -6,6 +6,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/pkt_sched.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
 static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
 {
 	if (save_load) {
-		entry->load_history = 1 + entry->tx_bytes /
-				      BOND_TLB_REBALANCE_INTERVAL;
+		entry->load_history = 1 + div_u64(entry->tx_bytes,
+				      BOND_TLB_REBALANCE_INTERVAL);
 		entry->tx_bytes = 0;
 	}
 
@@ -133,7 +134,7 @@ static int tlb_initialize(struct bonding *bond)
 	if (!new_hashtbl)
 		return -ENOMEM;
 
-	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
+	bond_info->unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
 	if (!bond_info->unbalanced_load)
 		goto out;
 
@@ -170,8 +171,10 @@ static void tlb_deinitialize(struct bonding *bond)
 
 static long long compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	u32 raw_speed = READ_ONCE(slave->speed);
+
+	return ((s64)raw_speed << 20) - /* Convert to bits per sec */
+	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
@@ -1354,8 +1357,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 	if (!tx_slave) {
 		/* unbalanced or unassigned, send through primary */
 		tx_slave = rcu_dereference(bond->curr_active_slave);
-		if (bond->params.tlb_dynamic_lb)
-			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
+		if (bond->params.tlb_dynamic_lb) {
+			struct unbalanced_load_stats *pcpu_load;
+
+			pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
+			u64_stats_update_begin(&pcpu_load->syncp);
+			u64_stats_add(&pcpu_load->tx_bytes, skb->len);
+			u64_stats_update_end(&pcpu_load->syncp);
+		}
 	}
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
@@ -1539,21 +1548,27 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 	return bond_do_alb_xmit(skb, bond, tx_slave);
 }
 
-static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
+static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
 {
+	u64 delta, tx_bytes, total_bytes = 0;
 	struct unbalanced_load_stats *p;
-	u32 delta, total_bytes = 0;
+	unsigned int start;
 	int i;
 
 	for_each_possible_cpu(i) {
 		p = per_cpu_ptr(bond_info->unbalanced_load, i);
-		total_bytes += READ_ONCE(p->tx_bytes);
+		do {
+			start = u64_stats_fetch_begin(&p->syncp);
+			tx_bytes = u64_stats_read(&p->tx_bytes);
+		} while (u64_stats_fetch_retry(&p->syncp, start));
+
+		total_bytes += tx_bytes;
 	}
 
 	delta = total_bytes - bond_info->prev_total_unbalanced;
 	bond_info->prev_total_unbalanced = total_bytes;
 
-	return delta / BOND_TLB_REBALANCE_INTERVAL;
+	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
 }
 
 void bond_alb_monitor(struct work_struct *work)
@@ -1597,8 +1612,13 @@ void bond_alb_monitor(struct work_struct *work)
 	if (atomic_read(&bond_info->tx_rebalance_counter) >= BOND_TLB_REBALANCE_TICKS) {
 		bond_for_each_slave_rcu(bond, slave, iter) {
 			tlb_clear_slave(bond, slave, 1);
-			if (slave == rcu_access_pointer(bond->curr_active_slave))
-				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
+			if (slave == rcu_access_pointer(bond->curr_active_slave)) {
+				u64 new_load = reset_unbalanced_load(bond_info);
+
+				spin_lock_bh(&bond->mode_lock);
+				SLAVE_TLB_INFO(slave).load = new_load;
+				spin_unlock_bh(&bond->mode_lock);
+			}
 		}
 		atomic_set(&bond_info->tx_rebalance_counter, 0);
 	}
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 6fb09b4fc7e2..32f1981033e4 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -57,12 +57,12 @@ struct tlb_client_info {
 				 * packets to a Client that the Hash function
 				 * gave this entry index.
 				 */
-	u32 tx_bytes;		/* Each Client accumulates the BytesTx that
+	u64 tx_bytes;		/* Each Client accumulates the BytesTx that
 				 * were transmitted to it, and after each
 				 * CallBack the LoadHistory is divided
 				 * by the balance interval
 				 */
-	u32 load_history;	/* This field contains the amount of Bytes
+	u64 load_history;	/* This field contains the amount of Bytes
 				 * that were transmitted to this client by
 				 * the server on the previous balance
 				 * interval in Bps.
@@ -118,19 +118,20 @@ struct tlb_slave_info {
 			 * are the entries that were assigned to use this
 			 * slave for transmit.
 			 */
-	u32 load;	/* Each slave sums the loadHistory of all clients
+	u64 load;	/* Each slave sums the loadHistory of all clients
 			 * assigned to it
 			 */
 };
 
 struct unbalanced_load_stats {
-	u32			tx_bytes;
+	u64_stats_t		tx_bytes;
+	struct u64_stats_sync	syncp;
 };
 
 struct alb_bond_info {
 	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
 	struct unbalanced_load_stats __percpu	*unbalanced_load;
-	u32			prev_total_unbalanced;
+	u64			prev_total_unbalanced;
 	atomic_t		tx_rebalance_counter;
 	int			lp_counter;
 	/* -------- rlb parameters -------- */

-- 
2.55.0

