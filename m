Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC88547043
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427308; cv=none; b=cRI7DEm/JDJ5QgQViUvZdBSK8bxmjH4cUD4N+ugv0MC+hFhokMA+6bcFV4wBISoaS5gghhRZ/zA5HUBZbCSxYu4UFYsP794MMqrox4R3HLIwnY94br6UzwCDXQANWXn7NftwxI3iTpArSe+TsLNQt8U1Sk58NSR2wtj4oeBb7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427308; c=relaxed/simple;
	bh=IKwfsDiuV6BhTMTlaomAPEptlFo4l5MZYTu258Q1LzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dby8+lYWDzKBYyok8CzClGVbbEe5K4Qct8EeT71AFWBCmpkZ4KP6qzJMIXbjD3SrLtzmT9mOuG7KDc9MOV9f5Du0IuCvzXK5634F1tkVw5k72fnryksb1oMr8jtOf1Qo3HnvHo7FbaQSjC8RuCt79FD6XnyAXt5aaTTP+DUXtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RzvL/WXj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RzvL/WXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lH
	OhNIKvMsjdma9C31zw3OGlHoePDC3ey8DumwKMlg8=; b=RzvL/WXjCwDPfZf7p1
	VEzYkEXvcwAKqZgFrhCTOsd187FZ2+MPo7wQtUF2iAVr3HXY3DAIbqkRi1BUyprU
	DQovNx9OYKHsdao3unw5ru40PV4T+N75e9vEBbnu1QwuEfQQvGAnQeIX/iZR1XzM
	2i/SzOcoVuZ2HOJXXB34/zY7w=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAXH6+wAsdqdDtgDA--.20832S2;
	Thu, 08 Oct 2026 10:40:48 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maheshb@google.com,
	razor@blackwall.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net v3] bonding: 3ad: select a port when the TX array is empty
Date: Thu,  8 Oct 2026 10:40:31 +0800
Message-ID: <20261008024031.16224-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAXH6+wAsdqdDtgDA--.20832S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw15tFy7Aw48uF43Zw1fWFg_yoWfuF4fpF
	W5JFWrArWDAry2vw17Ja18Cws3uw4fZa1agryrG34UAFs8XFyfua12g3WFvFyUCrZ3CFy7
	Xr4Yg3s09F4qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbID7UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BE5CGrHArGbZAAA3t

From: Yun Lu <luyun@kylinos.cn>

This issue was observed on a machine in real use. During 802.3ad
bring-up in production, packets were dropped even though the bond's
carrier was up and LACP had enabled ports for distribution. The
transmit path only consults usable_slaves and returns no slave when
the array is NULL or its count is zero.

LACP port eligibility and the TX array are updated separately. The
state machine enables ports and updates carrier before scheduling
slave_arr_work to rebuild and publish the array. The worker requires
RTNL and retries if rtnl_trylock() fails, so RTNL contention can
prolong the interval in which eligible ports exist but the cached
array is empty.

Add a fallback for 802.3ad when the usable array is empty and carrier
is up. Walk the RCU-protected slave list and use ports whose
aggregator is active and which pass bond_slave_can_tx(), without
taking mode_lock or changing LACP state. In 802.3ad mode the
per-slave active flag is set only by the mux machine for ports of the
active aggregator, so these lockless reads identify distributable
ports with the same criteria bond_update_slave_arr() applies when
building the array.

Fix the aggregator object at the first eligible port so counting and
selection use members of the same object. The object pointer is used
only for comparison within the caller's RCU section. Count eligible
members, then select with the existing hash modulo that count in
slave-list order. This preserves the array path's mapping when the
eligible set is stable. Recheck eligibility in the second pass and
use the first member of the pinned object if the selected index is no
longer reachable. Ports of any other aggregator object are never
used; the fallback drops the packet instead.

Use the fallback for skb transmission and ndo_get_xmit_slave queries
with all_slaves=false. For broadcast_neighbor ARP/ND packets, replicate
to all eligible members of the selected object. Keep the nonempty array
selection unchanged and defer hashing until an eligible set is found.

Persistent empty states with carrier up still incur one lockless list
walk per dropped packet. XDP transmit and ndo_sk_get_lower_dev use
separate frame and socket hashing interfaces. Their fallback handling
needs separate implementation and validation, so this fix leaves their
array-based selection unchanged.

Tested on x86-64 KVM against a two-port LACP peer. With array
publication deferred by a test-only gate, UDP, ARP and ND all left
through ports selected by the fallback while both arrays were NULL,
and the same UDP flows kept their port mapping after the array was
published. All 16 bonding selftests passed without the test-only
modifications.

Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
Changes in v3:
- Drop the pending latch and all TX-path locking (the mode_lock trylock
  and the netpoll guard); the fallback is now lockless.
- Pin one aggregator object per transmit, by pointer comparison within
  the RCU section, for both hash selection and broadcast replication.
  Never select across aggregator objects.
- Replicate broadcast_neighbor packets to all eligible members of the
  pinned object instead of sending a single copy.
- Defer hashing until the fallback finds a non-empty eligible set.
- Read aggregator is_active with READ_ONCE.

v2: https://lore.kernel.org/all/20260918090137.66515-1-luyun_611@163.com/

Changes in v2:
- Track unpublished array updates with a boolean latch, limiting fallback
  locking and list walks to the asynchronous update window.
- Use spin_trylock_bh() so recursive TX keeps the existing drop or NULL
  behavior instead of deadlocking on mode_lock.
- Use the first eligible port if eligibility changes between the two list
  walks.
- Apply the fallback to ndo_get_xmit_slave and broadcast-neighbor skb
  transmission. Keep control-path readers on the published array and leave
  XDP for a separate follow-up patch.
- Document why hash calculation is deferred until the array count is known.

v1: https://lore.kernel.org/netdev/20260915090207.110987-1-luyun_611@163.com/

Testing: two-port LACP bring-up on x86-64 KVM, injected state changes,
and an unsynchronized peer with no eligible port. A test-only kernel
modification deferred usable_slaves and all_slaves publication from bond
creation; with both arrays NULL after convergence, UDP used one eligible
port and ARP/ND reached both. Releasing the gate and repeating the same
UDP flows preserved port mapping. Test-only hooks injected eligibility
shrink and active aggregator changes between selection passes and during
broadcast; these synthetic cases passed.

All 16 bonding selftests passed without the test-only modifications.

At 32 ports, paired KVM measurements showed about 0.4 us/attempt
additional thread CPU time in the persistent-empty-array case. Timings
include userspace overhead.

 drivers/net/bonding/bond_main.c | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index de2489c3d9bf..2fed71d7586b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5233,11 +5233,11 @@ static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
 	unsigned int count;
 	u32 hash;
 
-	hash = bond_xmit_hash(bond, skb);
 	count = slaves ? READ_ONCE(slaves->count) : 0;
 	if (unlikely(!count))
 		return NULL;
 
+	hash = bond_xmit_hash(bond, skb);
 	slave = slaves->arr[hash % count];
 	return slave;
 }
@@ -5289,9 +5289,60 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 	return false;
 }
 
-/* Use this Xmit function for 3AD as well as XOR modes. The current
- * usable slave array is formed in the control path. The xmit function
- * just calculates hash and sends the packet out.
+/* Called with RCU held and only in 802.3ad mode. */
+static const struct aggregator *bond_3ad_tx_eligible_agg(struct slave *slave)
+{
+	const struct aggregator *agg;
+
+	agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
+	if (!agg || !READ_ONCE(agg->is_active) || !bond_slave_can_tx(slave))
+		return NULL;
+
+	return agg;
+}
+
+/* Called with RCU held when the usable slave array is empty. */
+static struct slave *bond_3ad_xmit_fallback(struct bonding *bond,
+					    struct sk_buff *skb)
+{
+	const struct aggregator *agg = NULL, *slave_agg;
+	struct slave *slave, *first = NULL;
+	struct list_head *iter;
+	unsigned int count = 0, target;
+
+	if (!netif_carrier_ok(bond->dev))
+		return NULL;
+
+	bond_for_each_slave_rcu(bond, slave, iter) {
+		slave_agg = bond_3ad_tx_eligible_agg(slave);
+		if (!slave_agg)
+			continue;
+		if (!agg)
+			agg = slave_agg;
+		if (slave_agg == agg)
+			count++;
+	}
+
+	if (!count)
+		return NULL;
+
+	target = bond_xmit_hash(bond, skb) % count;
+	bond_for_each_slave_rcu(bond, slave, iter) {
+		if (bond_3ad_tx_eligible_agg(slave) != agg)
+			continue;
+		if (!first)
+			first = slave;
+		if (!target)
+			return slave;
+		target--;
+	}
+
+	return first;
+}
+
+/* Use this Xmit function for 3AD as well as XOR modes. The usable
+ * slave array is formed in the control path; 3AD can use current state
+ * while the array is empty.
  */
 static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
@@ -5302,6 +5353,8 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 
 	slaves = rcu_dereference(bond->usable_slaves);
 	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+	if (unlikely(!slave) && BOND_MODE(bond) == BOND_MODE_8023AD)
+		slave = bond_3ad_xmit_fallback(bond, skb);
 	if (likely(slave))
 		return bond_dev_queue_xmit(bond, skb, slave->dev);
 
@@ -5327,6 +5380,35 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		slaves = rcu_dereference(bond->usable_slaves);
 
 	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+	if (!slaves_count && !all_slaves &&
+	    BOND_MODE(bond) == BOND_MODE_8023AD &&
+	    netif_carrier_ok(bond_dev)) {
+		const struct aggregator *agg = NULL, *slave_agg;
+		struct list_head *iter;
+		struct slave *slave;
+
+		bond_for_each_slave_rcu(bond, slave, iter) {
+			struct sk_buff *skb2;
+
+			slave_agg = bond_3ad_tx_eligible_agg(slave);
+			if (!slave_agg)
+				continue;
+			if (!agg)
+				agg = slave_agg;
+			if (slave_agg != agg)
+				continue;
+
+			skb2 = skb_clone(skb, GFP_ATOMIC);
+			if (!skb2) {
+				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
+						    bond_dev->name, __func__);
+				continue;
+			}
+
+			if (bond_dev_queue_xmit(bond, skb2, slave->dev) == NETDEV_TX_OK)
+				xmit_suc = true;
+		}
+	}
 	for (i = 0; i < slaves_count; i++) {
 		struct slave *slave = slaves->arr[i];
 		struct sk_buff *skb2;
@@ -5432,6 +5514,9 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
 		else
 			slaves = rcu_dereference(bond->usable_slaves);
 		slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+		if (unlikely(!slave) && !all_slaves &&
+		    BOND_MODE(bond) == BOND_MODE_8023AD)
+			slave = bond_3ad_xmit_fallback(bond, skb);
 		break;
 	case BOND_MODE_BROADCAST:
 		break;

base-commit: 6e0022b5ae3dc5b833af0fcc1578dc20a1d6bc71
-- 
2.43.0

