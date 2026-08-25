Received: from mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271C2264B0
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619737; cv=none; b=gTAAcE7eXRDlSxQAh1u7bldT7ZVDvjF1/C3cIr6mIYDTv43haVl4TpfClHB5ABGxiiazN2Ti+Vo8BG+MHCrQQ3b3Pfh5j/AA4cmdR2Kv2jiI2GrxE7d3kgBQIwWjGqnk4XKd+e5q3CVwogTQp1TPX0/hShiQsOEDz3X/DXd2vMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619737; c=relaxed/simple;
	bh=3a4PcnHD7u8Wq4orrSoAnJVt3hFxlSKRLkAu/ZIAt6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxPC7m5v4SE6AHsHWZtRDQ5dyTT9dtRohkQcPkCfi7KSG7w2xS8OhjwuIHLFhdbZY2hm3JAmfemiNxZWvSa8lJDD4wBItkUk0YZDZ+US+NpXy/XGKao1pz7HbDr8y6tSqtJ60ZL7cTNCFKSK2mpzrvQd1vGVqoV3dVoWEBNpP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZEpY3I+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZEpY3I+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3a4PcnHD7u8Wq4orrSoAnJVt3hFxlSKRLkAu/ZIAt6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787619733; v=1; x=1788224533;
 b=OZEpY3I+Hcr7sT0Juyg2pGWFxhfzs+BoSNZfHfCCw0mbWBZcyibRPcorBePWOkFFEbKnH0jk
 bppX6x4ifzbpqTjUx1MKU1JNEWjP0whi4xWsnl0pzRsS3bSGZo/UcoVar0knkpxyjJEclxF6fPr
 CBtKBSSyJDOmlwxqm7eiLotg=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.147)
	by smtp.migadu.com with ESMTPS id a00b9d744bbf61d2;
	Tue, 25 Aug 2026 01:02:13 +0000
X-Mizu-Trace-ID: a00b9d744bbf61d2
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Tue, 25 Aug 2026 09:01:30 +0800
Subject: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
In-Reply-To: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
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

Rework compute_gap() to use s64 arithmetic throughout. Return LLONG_MIN
when the speed is unknown.

Detected by AI code review.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c | 52 ++++++++++++++++++++++++++++++------------
 include/net/bond_alb.h         | 11 +++++----
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 0afed2c39231..9a43a1f47893 100644
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
 
@@ -170,8 +171,14 @@ static void tlb_deinitialize(struct bonding *bond)
 
 static long long compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	u32 raw_speed = READ_ONCE(slave->speed);
+
+	/* It's meaningless to compare gap on unknown speed NIC */
+	if (raw_speed == (u32)SPEED_UNKNOWN)
+		return LLONG_MIN;
+
+	return ((s64)raw_speed << 20) - /* Convert to bits per sec */
+	       ((s64)SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
@@ -188,7 +195,7 @@ static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
 		if (bond_slave_can_tx(slave)) {
 			long long gap = compute_gap(slave);
 
-			if (max_gap < gap) {
+			if (!least_loaded || max_gap < gap) {
 				least_loaded = slave;
 				max_gap = gap;
 			}
@@ -1354,8 +1361,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
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
@@ -1539,21 +1552,27 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
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
@@ -1597,8 +1616,13 @@ void bond_alb_monitor(struct work_struct *work)
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

