Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFA3876B8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205375; cv=none; b=Nkt8nRO7XnZm1p/FVgSI/24+Up5TnRICNhmmlTJmxgEavxdMxmpiihKsnSAhU9+ZuDmb142G8q/cjAcGEimynE/j+w/EEoIsWmasM1dPFMEm0itNaYjNVMaJpR5PmRcKVBSxKfrGz2TYdDDSjOQvpTR01COID6MubQOR6umR1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205375; c=relaxed/simple;
	bh=Yyt0kO2zJ1JirMOwK56pHnm/TWr/UmxyxweM7ZJg9/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjnKbvKrUk/C/zB7MK68ZxXnYLgiXJLoxnejoQoagniwqnhwYubrCInmvUv7Ni2+Slz3RywBwqiLavb+4tJ0iKcfuaqXDhqjZwkErcxjUMCqzZM+Dxt5fQRCPwXH3NrIGao3rua2Wtb8LkhHhXJ6NFXvSNJmq77YTaQAgVovx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6hHe2YM; arc=none smtp.client-ip=91.218.175.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6hHe2YM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yyt0kO2zJ1JirMOwK56pHnm/TWr/UmxyxweM7ZJg9/s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787205369; v=1; x=1787810169;
 b=E6hHe2YMyWsjEZfishaYRt9b7JN5w5KY7G/y06JzFmeZcQPUgeIq/o8U5zsnmeWYNkfriftU
 ZKddQ5TXEdct2GtRlNzkcs0jiDaOue7rD9MPybkitRSelaJtFs3xcjzgcJ8P1UwqfrHi75AZoJk
 FdCx4/MHKhw1ZrZcQhB/Fqz8=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (216.236.36.152)
	by smtp.migadu.com with ESMTPS id 1234f702a62e50bb;
	Thu, 20 Aug 2026 05:56:09 +0000
X-Mizu-Trace-ID: 1234f702a62e50bb
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 20 Aug 2026 13:55:52 +0800
Subject: [PATCH net v4 1/2] bonding: convert unbalanced_load to per-cpu
 state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-bond_overflow-v4-1-805ba0d3efb6@kylinos.cn>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
In-Reply-To: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
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

