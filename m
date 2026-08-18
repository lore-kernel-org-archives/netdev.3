Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42AB443E22
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042900; cv=none; b=B463YTKkaiBKkoWEsDOgSunlrKk+k00WOJCSGROlK986Ok1P9hGzfkDcSuslmPzex+oPNcnKJSXTKVgGou199kbtiYUlFAcEgjY63Wzg9DPDEmEpz66FO+3RrCxy7jAUwdVbMi4R/admGK4AouHGkerPm5Cam9HrwJTuOYhZkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042900; c=relaxed/simple;
	bh=FhibvI8n+f6tpPj6C6nyP1Mbhp8+pxN7yzMbG0Dwipg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cakwmt7eK0aymbR/SIO16lTnHF0+ub/nquCZ6YI5LH+R6HMhmk4RFq5SfwecnEq0Oe0aPEyGV+OymZALaHr19XWqt5mtJLfvBWLppN9tF2uUDLACV5ffDO0I+MrVi17xMasqI3TloALWjqCRK6d5R8HMYe8yvFYjIkom2q7DqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=feunZEaE; arc=none smtp.client-ip=91.218.175.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="feunZEaE"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FhibvI8n+f6tpPj6C6nyP1Mbhp8+pxN7yzMbG0Dwipg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787042896; v=1; x=1787647696;
 b=feunZEaESShFJhAyVnB4jmGDfIuQCUZFPaqlykPsdSREvM/7/ik9nFL0KmQlg7JJqQJnUDW+
 IzuDVqr29pYOgp2GirxcpXYiSldyQrkdFhhZKx7IUpYK0vWwR/rZik6ae9r7DH8P5nz1mzBN4He
 7JVk1ODWnPxz3hTu6YnkEoTM=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (203.175.12.240)
	by smtp.migadu.com with ESMTPS id 1d20c1b81865f820;
	Tue, 18 Aug 2026 08:48:16 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Tue, 18 Aug 2026 16:47:45 +0800
Subject: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
In-Reply-To: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
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
div_u64() for the 64-bit divisions. The tx_bytes, load, and load_history
are protected in spin_lock.

Rework compute_gap() to use u64 arithmetic throughout. Return 0 when the
speed is unknown or the slave is already overloaded.

Detected by AI code review.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c  | 56 ++++++++++++++++++++++++++++++-----------
 drivers/net/bonding/bond_main.c |  2 +-
 include/net/bond_alb.h          |  9 ++++---
 3 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index d54d834cf72b..659a77323444 100644
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
 
@@ -158,25 +159,35 @@ static void tlb_deinitialize(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
-static long long compute_gap(struct slave *slave)
+static u64 compute_gap(struct slave *slave)
 {
-	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
-	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
+	u32 raw_speed = READ_ONCE(slave->speed);
+	u64 speed = (u64)raw_speed;
+
+	/* It's meaningless to compare gap on unknown speed NIC */
+	if (raw_speed == (u32)SPEED_UNKNOWN)
+		return 0;
+
+	/* skip slave which is over loaded */
+	if ((speed << 20) <= (SLAVE_TLB_INFO(slave).load << 3))
+		return 0;
+
+	return (speed << 20) - /* Convert to Megabit per sec */
+	       (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
 }
 
 static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
 {
 	struct slave *slave, *least_loaded;
 	struct list_head *iter;
-	long long max_gap;
+	u64 max_gap = 0;
 
 	least_loaded = NULL;
-	max_gap = LLONG_MIN;
 
 	/* Find the slave with the largest gap */
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		if (bond_slave_can_tx(slave)) {
-			long long gap = compute_gap(slave);
+			u64 gap = compute_gap(slave);
 
 			if (max_gap < gap) {
 				least_loaded = slave;
@@ -1344,8 +1355,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
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
@@ -1529,19 +1546,28 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 	return bond_do_alb_xmit(skb, bond, tx_slave);
 }
 
-static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
+static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
 {
 	struct unbalanced_load_stats *p;
-	u32 total_bytes = 0;
+	u64 tx_bytes, total_bytes = 0;
+	unsigned int start;
 	int i;
 
 	for_each_possible_cpu(i) {
 		p = per_cpu_ptr(bond_info->unbalanced_load, i);
-		total_bytes += READ_ONCE(p->tx_bytes);
-		WRITE_ONCE(p->tx_bytes, 0);
+		do {
+			start = u64_stats_fetch_begin(&p->syncp);
+			tx_bytes = u64_stats_read(&p->tx_bytes);
+		} while (u64_stats_fetch_retry(&p->syncp, start));
+
+		u64_stats_update_begin(&p->syncp);
+		u64_stats_set(&p->tx_bytes, 0);
+		u64_stats_update_end(&p->syncp);
+
+		total_bytes += tx_bytes;
 	}
 
-	return total_bytes / BOND_TLB_REBALANCE_INTERVAL;
+	return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
 }
 
 void bond_alb_monitor(struct work_struct *work)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9fb44e0031c8..4c4d9bf71e0c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6495,7 +6495,7 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
-	bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
+	bond->alb_info.unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
 	if (!bond->alb_info.unbalanced_load)
 		goto wq_out;
 
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 3fabf4714dec..51c083c76115 100644
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
@@ -118,13 +118,14 @@ struct tlb_slave_info {
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

-- 
2.55.0

