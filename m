Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242503;
	b=4zjcjXw9MKdDlkUrphr/i3sAKGvFfRPFZQRP3/ANAcj49N4avkIOV/sJfxWLLsT5V4o6
	 42rJZrkSMdSzeQVrksfpmiLyVJrul+ZhkFfPHdW2tkeazy2xZ2CfODR3C1HOaGDkBZTWK
	 u0uKM/Sz+59KvJZEkxFKyMtgYVTphwwGCD3aNXiFHVlE595JKNUQF+k7eFNvGLQbTKM2U
	 sH1mCm/QRpy79X48oOjFyg2Ukpo0WeWtuiBg4KZ3KCRFQKC2q1D9U/kMizt6C9kEdCXn+
	 1hG/I+VzWseUbEvQSTPOxzH92ZpcinClfF01P2hZLzY3GAamCFdEt97cIfeX2+IWUcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242503;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HEq4Jj61Ut7T6iCIHykSxWuio60z3Qv+b3hJIk40gUY=;
	b=uGe9VqIIU6WQ8ZGjoEApfyCooB4gKzS00nLLe+CcB1O9cVpGKi780Zbkog4ND36uBZ4W
	 h4eSTdX28d81N45vMKy4HfKq/Xfa7SlMySdTl/t3Ll7bV+cqcpYGlOu2G6YyaHmmnvjh5
	 /OLJlw6d3lXxFK+DoT+Xx0uwnjU/o49FV6TlVKmh4OdtHGlhoRV40rsUwfvbVbDYYO1bW
	 yvDwL6id6IXFnYUfsziU+FmjDTqG9UQOKyF4P+WP3i2zVYvTGx3mcZfXUduHNyeo/RlmI
	 JZjGPWUChzuSwDLuk4BIa1X9w5urlJ0yOaq5m5nleXhV/tCjeHytV0HAIJb76GOvFMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XilHLtcd;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789D606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5789D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XilHLtcd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HE
	q4Jj61Ut7T6iCIHykSxWuio60z3Qv+b3hJIk40gUY=; b=XilHLtcdes+AKFweS3
	agBuGqtFHbP061SliHyAWrHz6YR4DFgRr8uw4zbKosF3Wsu2X+PoBZEgrN8nIfFs
	6R3Op6dTYGY4+4NOdNPGecFkPQknr9uDjdskMLoxwgQyCg/Uw8K4gqwf+WD8wDeI
	yhR2z4aQm1FCj95KDMrFCm3yU=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXn4RdteJqPV17Dg--.31995S2;
	Thu, 29 Oct 2026 10:54:23 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	hangbin.liu@linux.dev
Subject: [PATCH net v4] bonding: 3ad: update transmit arrays without waiting for RTNL
Date: Thu, 29 Oct 2026 10:54:11 +0800
Message-ID: <20261029025411.1087287-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn4RdteJqPV17Dg--.31995S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF48CFWftrW5uFW3Jw18Krg_yoW8GFyUWo
	WxXw4fWr18tF1jy34DArnrCFZ2qFWkCryayr45Grn8uF1kXw12yF43J345CFy7XF1F9r4F
	v34kJa90qaykJ3Wfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7ku4UUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wHYp2ritWFa4wAA3w

From: Yun Lu <luyun@kylinos.cn>

During 802.3ad bring-up, packets can be dropped despite carrier being up
and LACP having enabled ports for distribution. This was observed on a
machine in real use.

The LACP worker enables ports before queuing slave_arr_work to rebuild
usable_slaves. The transmit path keeps using that array, which can remain
empty while the array worker retries rtnl_trylock(). Unrelated RTNL
contention can therefore prolong the packet loss.

Use a per-bond mutex to serialize array writers with lower-list changes.
Rebuild the arrays directly from the LACP worker after releasing
mode_lock and RCU, and remove the retry worker's RTNL dependency. Retain
delayed work to retry allocation failures.

New slaves become visible in the lower list before all fallible setup
has finished. Exclude them from both arrays until that setup, including
XDP propagation, succeeds. Retry failed final updates for running bonds.
Also rebuild broadcast arrays on open and retry failed open updates.
Protect the peer-notification array reader with RCU now that RTNL no
longer excludes writers. Updating the shared arrays also covers XDP and
lower-device queries without changing their selection rules.

An RTNL-holding test module and userspace LACP peers reproduced the
blocked update and verified array publication and packet delivery before
RTNL release with this fix. All 16 bonding selftests passed.

Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---

Changes in v4:
- Replace the TX fallback with synchronous control-path array updates
  using a per-bond mutex, following Paolo's and Jay's suggestions.
- Serialize array writers with lower-list link/unlink and exclude new
  slaves until all fallible enslave setup, including XDP, has completed.
- Retain allocation-failure retries, retry failed enslave/open updates,
  rebuild broadcast arrays on open, and protect the peer-notification
  array reader with RCU.

v3: https://lore.kernel.org/all/20261008024031.16224-1-luyun_611@163.com/

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

 drivers/net/bonding/bond_3ad.c  |  4 +-
 drivers/net/bonding/bond_main.c | 91 +++++++++++++++++++++------------
 include/net/bonding.h           | 10 ++--
 3 files changed, 67 insertions(+), 38 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index d91533b80996..c260e2e45205 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2616,8 +2616,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
-	if (update_slave_arr)
-		bond_slave_arr_work_rearm(bond, 0);
+	if (update_slave_arr && bond_update_slave_arr(bond, NULL))
+		bond_slave_arr_work_rearm(bond, 1);
 
 	if (should_notify_rtnl && rtnl_trylock()) {
 		bond_slave_state_notify(bond);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 09aa45d71fab..c3d97983916b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1175,7 +1175,6 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
 /* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct bond_up_slave *usable;
 	struct slave *slave = NULL;
 
 	if (!bond->send_peer_notif ||
@@ -1189,8 +1188,14 @@ static bool bond_should_notify_peers(struct bonding *bond)
 	 * It is safe to only check bond mode here.
 	 */
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
-		usable = rcu_dereference_rtnl(bond->usable_slaves);
-		if (!usable || !READ_ONCE(usable->count))
+		struct bond_up_slave *usable;
+		bool can_notify;
+
+		rcu_read_lock();
+		usable = rcu_dereference(bond->usable_slaves);
+		can_notify = usable && READ_ONCE(usable->count);
+		rcu_read_unlock();
+		if (!can_notify)
 			return false;
 	} else {
 		slave = rcu_dereference_rtnl(bond->curr_active_slave);
@@ -1714,19 +1719,22 @@ static int bond_master_upper_dev_link(struct bonding *bond, struct slave *slave,
 	lag_upper_info.tx_type = type;
 	lag_upper_info.hash_type = bond_lag_hash_type(bond, type);
 
+	mutex_lock(&bond->slave_arr_lock);
 	err = netdev_master_upper_dev_link(slave->dev, bond->dev, slave,
 					   &lag_upper_info, extack);
-	if (err)
-		return err;
+	if (!err)
+		slave->dev->flags |= IFF_SLAVE;
+	mutex_unlock(&bond->slave_arr_lock);
 
-	slave->dev->flags |= IFF_SLAVE;
-	return 0;
+	return err;
 }
 
 static void bond_upper_dev_unlink(struct bonding *bond, struct slave *slave)
 {
+	mutex_lock(&bond->slave_arr_lock);
 	netdev_upper_dev_unlink(slave->dev, bond->dev);
 	slave->dev->flags &= ~IFF_SLAVE;
+	mutex_unlock(&bond->slave_arr_lock);
 }
 
 static void slave_kobj_release(struct kobject *kobj)
@@ -2332,10 +2340,17 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	/* Publish only after all fallible setup, including XDP, is complete. */
+	mutex_lock(&bond->slave_arr_lock);
+	new_slave->array_ready = true;
+	mutex_unlock(&bond->slave_arr_lock);
+
 	/* broadcast mode uses the all_slaves to loop through slaves. */
 	if (bond_mode_can_use_xmit_hash(bond) ||
-	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
-		bond_update_slave_arr(bond, NULL);
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST) {
+		if (bond_update_slave_arr(bond, NULL) && netif_running(bond_dev))
+			bond_slave_arr_work_rearm(bond, 1);
+	}
 
 	bond_xdp_set_features(bond_dev);
 
@@ -4399,8 +4414,11 @@ static int bond_open(struct net_device *bond_dev)
 			static_branch_inc(&bond_bcast_neigh_enabled);
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST) {
+		if (bond_update_slave_arr(bond, NULL))
+			bond_slave_arr_work_rearm(bond, 1);
+	}
 
 	return 0;
 }
@@ -5068,35 +5086,26 @@ static netdev_tx_t bond_xmit_activebackup(struct sk_buff *skb,
 	return bond_tx_drop(bond_dev, skb);
 }
 
-/* Use this to update slave_array when (a) it's not appropriate to update
- * slave_array right away (note that update_slave_array() may sleep)
- * and / or (b) RTNL is not held.
+/* Retry array updates which failed, or defer them from atomic context.
+ * bond_update_slave_arr() may sleep but does not require RTNL.
  */
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay)
 {
 	queue_delayed_work(bond->wq, &bond->slave_arr_work, delay);
 }
 
-/* Slave array work handler. Holds only RTNL */
+/* Retry failed array updates; the builder acquires slave_arr_lock. */
 static void bond_slave_arr_handler(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    slave_arr_work.work);
 	int ret;
 
-	if (!rtnl_trylock())
-		goto err;
-
 	ret = bond_update_slave_arr(bond, NULL);
-	rtnl_unlock();
 	if (ret) {
 		pr_warn_ratelimited("Failed to update slave array from WT\n");
-		goto err;
+		bond_slave_arr_work_rearm(bond, 1);
 	}
-	return;
-
-err:
-	bond_slave_arr_work_rearm(bond, 1);
 }
 
 static void bond_skip_slave(struct bond_up_slave *slaves,
@@ -5128,7 +5137,10 @@ static void bond_set_slave_arr(struct bonding *bond,
 {
 	struct bond_up_slave *usable, *all;
 
-	all = rtnl_dereference(bond->all_slaves);
+	lockdep_assert_held(&bond->slave_arr_lock);
+
+	all = rcu_dereference_protected(bond->all_slaves,
+					lockdep_is_held(&bond->slave_arr_lock));
 	rcu_assign_pointer(bond->all_slaves, all_slaves);
 	kfree_rcu(all, rcu);
 
@@ -5137,7 +5149,8 @@ static void bond_set_slave_arr(struct bonding *bond,
 		return;
 	}
 
-	usable = rtnl_dereference(bond->usable_slaves);
+	usable = rcu_dereference_protected(bond->usable_slaves,
+					   lockdep_is_held(&bond->slave_arr_lock));
 	rcu_assign_pointer(bond->usable_slaves, usable_slaves);
 	kfree_rcu(usable, rcu);
 }
@@ -5153,20 +5166,25 @@ static void bond_reset_slave_arr(struct bonding *bond)
  * (b) BOND_MODE_XOR
  * (c) (BOND_MODE_TLB || BOND_MODE_ALB) && tlb_dynamic_lb == 0
  *
- * The caller is expected to hold RTNL only and NO other lock!
+ * Acquires slave_arr_lock to stabilize membership and serialize writers.
+ * The caller must be in sleepable context without mode_lock or RCU held.
  */
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
 {
 	struct bond_up_slave *usable_slaves = NULL, *all_slaves = NULL;
 	struct slave *slave;
 	struct list_head *iter;
+	unsigned int count;
 	int agg_id = 0;
 	int ret = 0;
 
 	might_sleep();
+	mutex_lock(&bond->slave_arr_lock);
 
-	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
-	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
+	/* Enslave counts before committing; release unlinks before uncounting. */
+	count = READ_ONCE(bond->slave_cnt);
+	usable_slaves = kzalloc_flex(*usable_slaves, arr, count);
+	all_slaves = kzalloc_flex(*all_slaves, arr, count);
 	if (!usable_slaves || !all_slaves) {
 		ret = -ENOMEM;
 		goto out;
@@ -5189,7 +5207,7 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
 	}
 	rcu_read_lock();
 	bond_for_each_slave(bond, slave, iter) {
-		if (skipslave == slave)
+		if (skipslave == slave || !slave->array_ready)
 			continue;
 
 		all_slaves->arr[all_slaves->count++] = slave;
@@ -5211,17 +5229,21 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
 	rcu_read_unlock();
 
 	bond_set_slave_arr(bond, usable_slaves, all_slaves);
-	return ret;
+	goto out_unlock;
 out:
 	if (ret != 0 && skipslave) {
-		bond_skip_slave(rtnl_dereference(bond->all_slaves),
+		bond_skip_slave(rcu_dereference_protected(bond->all_slaves,
+							  lockdep_is_held(&bond->slave_arr_lock)),
 				skipslave);
-		bond_skip_slave(rtnl_dereference(bond->usable_slaves),
+		bond_skip_slave(rcu_dereference_protected(bond->usable_slaves,
+							  lockdep_is_held(&bond->slave_arr_lock)),
 				skipslave);
 	}
 	kfree_rcu(all_slaves, rcu);
 	kfree_rcu(usable_slaves, rcu);
 
+out_unlock:
+	mutex_unlock(&bond->slave_arr_lock);
 	return ret;
 }
 
@@ -5994,6 +6016,7 @@ void bond_setup(struct net_device *bond_dev)
 	struct bonding *bond = netdev_priv(bond_dev);
 
 	spin_lock_init(&bond->mode_lock);
+	mutex_init(&bond->slave_arr_lock);
 	bond->params = bonding_defaults;
 
 	/* Initialize pointers */
@@ -6073,7 +6096,9 @@ static void bond_uninit(struct net_device *bond_dev)
 	mutex_destroy(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
+	mutex_lock(&bond->slave_arr_lock);
 	bond_set_slave_arr(bond, NULL, NULL);
+	mutex_unlock(&bond->slave_arr_lock);
 
 	list_del_rcu(&bond->bond_list);
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 598d56b1bc97..90f7ace7be59 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -23,6 +23,7 @@
 #include <linux/etherdevice.h>
 #include <linux/reciprocal_div.h>
 #include <linux/if_link.h>
+#include <linux/mutex.h>
 
 #include <net/bond_3ad.h>
 #include <net/bond_alb.h>
@@ -75,7 +76,7 @@
  * @pos:	current slave
  * @iter:	list_head * iterator
  *
- * Caller must hold RTNL
+ * Caller must hold RTNL or slave_arr_lock to stabilize the lower list.
  */
 #define bond_for_each_slave(bond, pos, iter) \
 	netdev_for_each_lower_private((bond)->dev, pos, iter)
@@ -177,6 +178,7 @@ struct slave {
 	u32    speed;
 	u16    queue_id;
 	u8     perm_hwaddr[MAX_ADDR_LEN];
+	bool   array_ready; /* Enslave complete; protected by slave_arr_lock. */
 	int    prio;
 	struct ad_slave_info *ad_info;
 	struct tlb_slave_info tlb_info;
@@ -210,8 +212,8 @@ struct bond_ipsec {
 };
 
 /*
- * Here are the locking policies for the two bonding locks:
- * Get rcu_read_lock when reading or RTNL when writing slave list.
+ * Slave list changes hold RTNL and slave_arr_lock. Readers hold RCU,
+ * RTNL, or slave_arr_lock when only stabilizing the lower list.
  */
 struct bonding {
 	struct   net_device *dev; /* first - useful for panic debug */
@@ -220,6 +222,8 @@ struct bonding {
 	struct   slave __rcu *primary_slave;
 	struct   bond_up_slave __rcu *usable_slaves;
 	struct   bond_up_slave __rcu *all_slaves;
+	/* Protects the lower list, array_ready and both TX arrays. */
+	struct mutex slave_arr_lock;
 	bool     force_primary;
 	bool     notifier_ctx;
 	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
-- 
2.43.0

