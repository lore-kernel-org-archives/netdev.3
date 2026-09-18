Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A244B44C1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722151; cv=none; b=ht0SfcrQsH6NrMgERfZIqE5H917zQQRV6CdRgzPp0p+CNd/GHSTOogOMQsEeJBx0bNkQy6hoODolFwDqyh1DxucbtnSF72Zb2HLFCuKl9kTrkATFWqi/4B+ZhHdi7PtMJCejurdenQvZvxlJCo5WtESQ6gDOIy3Vy62nzYKOdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722151; c=relaxed/simple;
	bh=ZLyFAvhIDdcq84Mlf7ON/ygReKedjkcEscAH0a+L6AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERKAh+uZlHPpMSFDrfhokVzF8bYtr3utQQhpvpHV2L8Pwu+gs6BPs3d1xcfChuXk/fvd9jPQb2G46655ZHV70dFw5256ZDifzOgdIEXE6e/28kwMt501nteqQ+Ve8uiVgUzGgnr9ObGZ+VqleBqd1zZGhov0f8LiNT5E8iVVm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oqhOkqjK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oqhOkqjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ac
	k3R/fzFl4wxjIal9q8kBU4WJGwcwMdfjPGQzZjYTc=; b=oqhOkqjKhFxIDYzCXs
	ngWigl6q0qb+oMPGxVn9kD0Ikzb/gkvGe/o0GMXlV6D6RyyLsiQR8CiNrEreKp42
	bRwQ7X86OT2TOIwxcAMgbhrG7qde6U3aW1nOO9t/4+kMoT6+GVfVUD42KopwsdW9
	ziCZGJHj+AfBtJtxI8owaUqyk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDH6N7x_axqkpX0BA--.153S2;
	Fri, 18 Sep 2026 17:01:41 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net v2] bonding: 3ad: select a port when the TX array is empty
Date: Fri, 18 Sep 2026 17:01:37 +0800
Message-ID: <20260918090137.66515-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH6N7x_axqkpX0BA--.153S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4fCw1DCrykWFyrCr4fAFb_yoW3uF1DpF
	W5KFyrAr4DAF17tF17tF409an5u34xXFsFqrW5G34DAFs8tF1UCrW2gFy0vrW5JrZ5CFy7
	XF4293sY9F4jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYksgUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BaCUWqs-faAAQAA3l

From: Yun Lu <luyun@kylinos.cn>

During 802.3ad bond bring-up, the state machine can enable a port before
slave_arr_work publishes the updated usable_slaves array. Packets are
dropped in this window even though the active aggregator has ports that
are eligible for transmission. RTNL contention can extend the window.

Track the unpublished array update with a boolean latch. It is set before
the state machine releases mode_lock, left set while the worker retries,
and cleared after a successful update or work cancellation. The state
machine and array worker use the same ordered workqueue, so a later update
cannot race with the worker clearing the latch.

If an skb transmit or ndo_get_xmit_slave query finds an empty usable array
while the latch is set, select a port directly from the active aggregator.
Use spin_trylock_bh() so recursive TX retains the existing drop or NULL
behavior instead of deadlocking. The latch also avoids taking mode_lock and
walking the slave list during persistent empty-array states such as LACP
non-convergence.

Use the same eligibility and list order as the array path. If eligibility
changes between the counting and selection passes, use the first eligible
port found by the second pass. Cover broadcast-neighbor packets by sending
one through the fallback until normal array-based broadcasting resumes.

Defer hash calculation until after the array count check so the normal and
fallback paths each calculate it only once.

Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
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

 drivers/net/bonding/bond_3ad.c  |  2 +
 drivers/net/bonding/bond_main.c | 85 +++++++++++++++++++++++++++++++--
 include/net/bonding.h           |  1 +
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index b8e4b4d68dd6..1fe499ade439 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2614,6 +2614,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
+	if (update_slave_arr)
+		WRITE_ONCE(bond->slave_arr_update_pending, true);
 	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a9bff7663eec..1144281912d3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4339,6 +4339,7 @@ void bond_work_cancel_all(struct bonding *bond)
 	cancel_delayed_work_sync(&bond->ad_work);
 	cancel_delayed_work_sync(&bond->mcast_work);
 	cancel_delayed_work_sync(&bond->slave_arr_work);
+	WRITE_ONCE(bond->slave_arr_update_pending, false);
 	cancel_delayed_work_sync(&bond->peer_notify_work);
 }
 
@@ -5093,6 +5094,8 @@ static void bond_slave_arr_handler(struct work_struct *work)
 		pr_warn_ratelimited("Failed to update slave array from WT\n");
 		goto err;
 	}
+	/* bond->wq is ordered, so no newer request can race this clear. */
+	WRITE_ONCE(bond->slave_arr_update_pending, false);
 	return;
 
 err:
@@ -5233,11 +5236,11 @@ static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
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
@@ -5289,9 +5292,67 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 	return false;
 }
 
-/* Use this Xmit function for 3AD as well as XOR modes. The current
- * usable slave array is formed in the control path. The xmit function
- * just calculates hash and sends the packet out.
+/* Called with RCU and bond->mode_lock held. */
+static bool bond_3ad_slave_is_eligible(struct slave *slave)
+{
+	const struct aggregator *agg;
+
+	agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
+	return agg && agg->is_active && bond_slave_can_tx(slave);
+}
+
+/* Called with RCU held. */
+static struct slave *bond_3ad_xmit_fallback(struct bonding *bond, u32 hash)
+{
+	struct slave *selected = NULL;
+	unsigned int eligible = 0;
+	unsigned int target;
+	struct list_head *iter;
+	struct slave *slave;
+
+	/* Limit the list walk to the array-update window. */
+	if (!netif_carrier_ok(bond->dev) ||
+	    !READ_ONCE(bond->slave_arr_update_pending))
+		return NULL;
+
+	/* TX may recurse while mode_lock is already held. */
+	if (unlikely(netpoll_tx_running(bond->dev)) ||
+	    !spin_trylock_bh(&bond->mode_lock))
+		return NULL;
+
+	if (!READ_ONCE(bond->slave_arr_update_pending))
+		goto out;
+
+	bond_for_each_slave_rcu(bond, slave, iter)
+		if (bond_3ad_slave_is_eligible(slave))
+			eligible++;
+
+	if (!eligible)
+		goto out;
+
+	target = hash % eligible;
+	bond_for_each_slave_rcu(bond, slave, iter) {
+		if (!bond_3ad_slave_is_eligible(slave))
+			continue;
+
+		if (!selected)
+			selected = slave;
+
+		if (!target) {
+			selected = slave;
+			break;
+		}
+		target--;
+	}
+
+out:
+	spin_unlock_bh(&bond->mode_lock);
+	return selected;
+}
+
+/* Use this Xmit function for 3AD as well as XOR modes. The usable slave
+ * array is formed in the control path. In 3AD mode, fall back to the current
+ * port state while an empty array update is pending.
  */
 static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
@@ -5302,6 +5363,8 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 
 	slaves = rcu_dereference(bond->usable_slaves);
 	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+	if (unlikely(!slave) && BOND_MODE(bond) == BOND_MODE_8023AD)
+		slave = bond_3ad_xmit_fallback(bond, bond_xmit_hash(bond, skb));
 	if (likely(slave))
 		return bond_dev_queue_xmit(bond, skb, slave->dev);
 
@@ -5327,6 +5390,16 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		slaves = rcu_dereference(bond->usable_slaves);
 
 	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
+	if (!slaves_count && !all_slaves &&
+	    BOND_MODE(bond) == BOND_MODE_8023AD) {
+		struct slave *slave;
+
+		slave = bond_3ad_xmit_fallback(bond,
+					       bond_xmit_hash(bond, skb));
+		if (slave)
+			return bond_dev_queue_xmit(bond, skb, slave->dev);
+	}
+
 	for (i = 0; i < slaves_count; i++) {
 		struct slave *slave = slaves->arr[i];
 		struct sk_buff *skb2;
@@ -5432,6 +5505,10 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
 		else
 			slaves = rcu_dereference(bond->usable_slaves);
 		slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+		if (!slave && !all_slaves &&
+		    BOND_MODE(bond) == BOND_MODE_8023AD)
+			slave = bond_3ad_xmit_fallback(bond,
+						       bond_xmit_hash(bond, skb));
 		break;
 	case BOND_MODE_BROADCAST:
 		break;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 598d56b1bc97..3ab8ca1c57bf 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -220,6 +220,7 @@ struct bonding {
 	struct   slave __rcu *primary_slave;
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
+	bool     slave_arr_update_pending; /* 802.3ad update not yet published */
 	bool     force_primary;
 	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
-- 
2.43.0

