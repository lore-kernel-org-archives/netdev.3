Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616243C07E
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042898; cv=none; b=SFygDzA68dGAw4bYQptRIDUNccBGtUg4xLhE1p1GzsIjl38TJPgqHE03me5lrP7n7XTRjjO4wAnRBtd11AEABQYx4EuV2zpTjXT/FQ1JlgO+GS/Lrkgg6RoF5fTCdqO9ZzaczONRKP0fba+qT3AvXOZepv4gXbIr5+WC5NIoFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042898; c=relaxed/simple;
	bh=8QH4Vs3EPyHFDe9FmLx6FO9ukIEa87Zjaonq8CWRufs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbrRvx8VR85WXZat/anA7GKMh5+jADpX3ZM6T61Aftn7gNYrlSfV4zWC6qj2lhTpsf3/Oc95RF45lYWiUOXGi8I9Olj5tH5W9xzLOgsiobl7RcVcoT9bmw6Tpc+x3itk0+POb6ElL75dEM9JsJgWjOxZ7MyoFpgZA0t1Mutf134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xsm5isH7; arc=none smtp.client-ip=91.218.175.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xsm5isH7"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8QH4Vs3EPyHFDe9FmLx6FO9ukIEa87Zjaonq8CWRufs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787042888; v=1; x=1787647688;
 b=xsm5isH7dYmAduQJZwM2LPG9t2W1VOFvUNbW73wku/8E0K1Gref7GCCap+FbJDbwcv5tx16Y
 qgAkvSOqSggiYKxO9KCIBQ1rYGwWwNY98XutkyAsljlc6l0K/7ofFNJNhR/VT71vXKt89hDr5D6
 +LBssTmGaVBDO9Le3AFJ8hK4=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.110.119] (203.175.12.240)
	by smtp.migadu.com with ESMTPS id e5463ac3d8899d14;
	Tue, 18 Aug 2026 08:48:08 +0000
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Tue, 18 Aug 2026 16:47:44 +0800
Subject: [PATCH net v3 1/2] bonding: convert unbalanced_load to per-cpu
 state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-bond_overflow-v3-1-e05d4dbc2fd8@kylinos.cn>
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

A later patch widens the bonding TLB tx counters from u32 to u64. The
unbalanced_load counter sits in the transmit hot path, and cross-CPU
synchronization of a u64 would introduce measurable overhead. Convert
unbalanced_load to a per-cpu counter first so that the subsequent
widening only touches per-cpu data local to each CPU.

Introduce struct unbalanced_load_stats to hold the per-cpu counter,
and move the aggregation into a helper, reset_unbalanced_load(), which
sums and clears all per-cpu instances.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_alb.c  | 25 ++++++++++++++++++-------
 drivers/net/bonding/bond_main.c |  9 +++++++++
 include/net/bond_alb.h          |  6 +++++-
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc18..d54d834cf72b 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1345,7 +1345,7 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 		/* unbalanced or unassigned, send through primary */
 		tx_slave = rcu_dereference(bond->curr_active_slave);
 		if (bond->params.tlb_dynamic_lb)
-			bond_info->unbalanced_load += skb->len;
+			this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
 	}
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
@@ -1529,6 +1529,21 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 	return bond_do_alb_xmit(skb, bond, tx_slave);
 }
 
+static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
+{
+	struct unbalanced_load_stats *p;
+	u32 total_bytes = 0;
+	int i;
+
+	for_each_possible_cpu(i) {
+		p = per_cpu_ptr(bond_info->unbalanced_load, i);
+		total_bytes += READ_ONCE(p->tx_bytes);
+		WRITE_ONCE(p->tx_bytes, 0);
+	}
+
+	return total_bytes / BOND_TLB_REBALANCE_INTERVAL;
+}
+
 void bond_alb_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
@@ -1570,12 +1585,8 @@ void bond_alb_monitor(struct work_struct *work)
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
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..9fb44e0031c8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5995,6 +5995,7 @@ static void bond_destructor(struct net_device *bond_dev)
 		destroy_workqueue(bond->wq);
 
 	free_percpu(bond->rr_tx_counter);
+	free_percpu(bond->alb_info.unbalanced_load);
 }
 
 void bond_setup(struct net_device *bond_dev)
@@ -6494,6 +6495,10 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	bond->alb_info.unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
+	if (!bond->alb_info.unbalanced_load)
+		goto wq_out;
+
 	bond->notifier_ctx = false;
 
 	spin_lock_init(&bond->stats_lock);
@@ -6511,6 +6516,10 @@ static int bond_init(struct net_device *bond_dev)
 		eth_hw_addr_random(bond_dev);
 
 	return 0;
+
+wq_out:
+	destroy_workqueue(bond->wq);
+	return -ENOMEM;
 }
 
 unsigned int bond_get_num_tx_queues(void)
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index e5945427f38d..3fabf4714dec 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -123,9 +123,13 @@ struct tlb_slave_info {
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
 	atomic_t		tx_rebalance_counter;
 	int			lp_counter;
 	/* -------- rlb parameters -------- */

-- 
2.55.0

