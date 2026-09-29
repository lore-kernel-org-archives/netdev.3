Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3794393DF0
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709347; cv=none; b=LxKUzz5JIM/+nMeaYppgdHhTsnvbvPDU0gINBEFPdzeRj6VNaTuAzQnKBHuzrJRNs0cQSL+U5cX3nwaBF7+PcegAd7Y9hIPZ+7tJFrhnbcbJ9NVtbEtXxMvgKOg7HQHJrWV8n4J6pnSugvcMM5iFOyrUVeKij6B+w5Pd5H9rwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709347; c=relaxed/simple;
	bh=lP9sNv6go1mS9Hyd/+qyghLN4HwQv7O6R4HAFfMopIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMSRy/QNWfLZo1xs5BhrSO6N5Ag1iJzWlFTnu5iEBcBuvTOdBYl7wu4+6YgXTnVmTqmdQi4Gh+vF5h6n1Ct1ZGar2z6pqfikccGCQ9LPpKqXN4vHoa7/oyjL9NEECmNvvbcz4rk35MMvrS0jk3rhLEq3d4ME1U3uJF813i1U9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPC0bGfq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPC0bGfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C2D1F000FF;
	Tue, 29 Sep 2026 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709345;
	bh=FPoIoO9Lv/92sMUQ+DCUGnVxdnO/wqqnmccb5Ac0jJI=;
	h=From:To:Cc:Subject:Date;
	b=VPC0bGfqd7IZPRrOI2/rYe7U367QKWKZ6AHlcrpzzGECXFe2f1Dye0mJE5ob11lNT
	 K4gIERDCyVvVr8U+4F5TQFTE06IewygmO394tO7he306zisDQBeFOnZrltAxUaTpqU
	 Aa4G9GYV1zm76BVYWv3Y2uRsCGhinSL4c27V/BnSzkJFo0X0PKNUgI7R87taDWrZQ4
	 8gdJCHCa6dbL5ButFmLFFK0YAP03BqSN5J7Poa3T9euSZtVUpFfLcGhTZIYe9UMJjQ
	 izE3fx7aDz03c9jORInWyx5VqR4Lq7ZON020CZj9tPJK9rgiSF6Nvgcd/aRUxgCUYo
	 YOWzZGUlyjudw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	razor@blackwall.org,
	dw@davidwei.uk
Subject: [PATCH net-next] net: only give queue leasing devices a separate instance lock class
Date: Tue, 29 Sep 2026 12:15:43 -0700
Message-ID: <20260929191543.3295633-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b6f74dff6d26 ("net: use two lockdep classes for the netdev
instance lock") put every device without a parent in the virtual class.
It also restricted the locking order for the virtual class, because
queue leasing has hard requirements on the exact order.

This bites us back on bond, which is "virtual" and needs to be taken
before taking the locks of the lowers. NIPA hit the following on the
new test I recently posted for XDP+bond:

  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  python3/18635 is trying to acquire lock:
  ff11000120b8ce30 (&dev->lock){+.+.}-{4:4}, at:
  netdev_put_lock+0x2d/0x1a0

  but task is already holding lock:
  ff110001ef77ae30 (&netdev_virt_instance_lock_key){+.+.}-{4:4}, at:
  netdev_put_lock+0x2d/0x1a0

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (&netdev_virt_instance_lock_key){+.+.}-{4:4}:
         __mutex_lock+0x1ae/0x1f10
         xdp_set_features_flag+0x2b/0x50
         bond_xdp_set_features+0x1eb/0x360
         bond_netdev_event+0x13f/0x300
         notifier_call_chain+0xae/0x300
         call_netdevice_notifiers+0x70/0xa0
         bnxt_xdp_set+0x2f6/0x620
         netif_xdp_propagate+0x503/0xc60
         dev_xdp_propagate+0xa1/0x230
         bond_xdp_set+0x234/0x700
         dev_xdp_install+0x592/0xd70
         dev_xdp_attach+0x355/0xf50
         dev_change_xdp_fd+0x176/0x210
         do_setlink.isra.0+0x220d/0x2b20
         rtnl_newlink+0x9f1/0x11b0

  -> #0 (&dev->lock){+.+.}-{4:4}:
         __mutex_lock+0x1ae/0x1f10
         netdev_put_lock+0x2d/0x1a0
         netdev_nl_queue_create_doit+0x801/0x1a70
         genl_family_rcv_msg_doit+0x206/0x300

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&netdev_virt_instance_lock_key);
                                 lock(&dev->lock);
                                 lock(&netdev_virt_instance_lock_key);
    lock(&dev->lock);

Let's narrow down the "virtual" class to only the devices which
can actually create a queue. More LoC and complexity, but that
is what we actually care about here. The rest needs to nest
under rtnl_lock, which bond does (famous last words?)

Take the instance locks in two passes, first the netkits then
the rest (matching the queue leasing order).
An alternative would be to make sure the close list is sorted
correctly from the start (queue head/tail appropriately in
unregister_netdevice_queue()). I think it works but feels
a little more fragile. Happy to change, tho.

netdev_can_create_queue() will now be used on paths where we
genuinely handle non-netkit, so we can't always set the extack.
Unfortunately, the (recently) added tracepoint in extack fires
even when extack is NULL.

Fixes: b6f74dff6d26 ("net: use two lockdep classes for the netdev instance lock")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: razor@blackwall.org
CC: dw@davidwei.uk
---
 net/core/dev.c           | 48 ++++++++++++++++++++++------------------
 net/core/netdev_queues.c | 31 ++++++++++++++------------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a8eb382f40ca..f225906f7b6f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -575,7 +575,7 @@ static int netdev_lock_cmp_fn(const struct lockdep_map *a,
 	if (a == b)
 		return 0;
 
-	/* @a and @b must be of same class - both virtual or physical.
+	/* @a and @b are of same lock class.
 	 * cmp_fn won't be called for devices of different classes.
 	 *
 	 * For the same class only allow nesting under the protection
@@ -589,12 +589,13 @@ static int netdev_lock_cmp_fn(const struct lockdep_map *a,
  * queues from, see netdev_nl_queue_create_doit(). Keep the two kinds
  * in separate classes so the dependency graph enforces the order;
  * netdev_lock_cmp_fn() then only has to rule on same-class nesting.
+ * Other virtual devices stay in the default class.
  */
 void netdev_set_instance_lock_class(struct net_device *dev)
 {
 	static struct lock_class_key netdev_virt_instance_lock_key;
 
-	if (dev->dev.parent)
+	if (!netdev_can_create_queue(dev, NULL))
 		return;
 
 	lockdep_set_class(&dev->lock, &netdev_virt_instance_lock_key);
@@ -12465,19 +12466,31 @@ static void netif_close_many_and_unlock(struct list_head *close_head)
 	}
 }
 
-static void netif_close_many_and_unlock_cond(struct list_head *close_head)
+/* Handle one class of ops-locked devices. Since close requires the lock
+ * we need to be careful about which classes we allow to nest.
+ */
+static void netdev_lock_ops_close_many(struct list_head *head,
+				       struct list_head *close_head,
+				       bool leasing)
 {
-#ifdef CONFIG_LOCKDEP
-	/* We can only track up to MAX_LOCK_DEPTH locks per task.
-	 *
-	 * Reserve half the available slots for additional locks possibly
-	 * taken by notifiers and (soft)irqs.
-	 */
-	unsigned int limit = MAX_LOCK_DEPTH / 2;
+	struct net_device *dev;
 
-	if (lockdep_depth(current) > limit)
-		netif_close_many_and_unlock(close_head);
+	list_for_each_entry(dev, head, unreg_list) {
+		if (!(dev->flags & IFF_UP) || !netdev_need_ops_lock(dev) ||
+		    netdev_can_create_queue(dev, NULL) != leasing)
+			continue;
+		list_add_tail(&dev->close_list, close_head);
+		netdev_lock(dev);
+
+#ifdef CONFIG_LOCKDEP
+		/* We can only track up to MAX_LOCK_DEPTH locks per task.
+		 * Reserve half the available slots for additional locks
+		 * possibly taken by notifiers and (soft)irqs.
+		 */
+		if (lockdep_depth(current) > MAX_LOCK_DEPTH / 2)
+			netif_close_many_and_unlock(close_head);
 #endif
+	}
 }
 
 bool unregister_netdevice_queued(const struct net_device *dev)
@@ -12517,15 +12530,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	}
 
 	/* If device is running, close it first. Start with ops locked... */
-	list_for_each_entry(dev, head, unreg_list) {
-		if (!(dev->flags & IFF_UP))
-			continue;
-		if (netdev_need_ops_lock(dev)) {
-			list_add_tail(&dev->close_list, &close_head);
-			netdev_lock(dev);
-		}
-		netif_close_many_and_unlock_cond(&close_head);
-	}
+	netdev_lock_ops_close_many(head, &close_head, true); /* queue leasing */
+	netdev_lock_ops_close_many(head, &close_head, false); /* the rest */
 	netif_close_many_and_unlock(&close_head);
 	/* ... now go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index f5558b12877c..27cb6397bdd4 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -61,21 +61,24 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 bool netdev_can_create_queue(const struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
-	if (dev->dev.parent) {
-		NL_SET_ERR_MSG(extack, "Device is not a virtual device");
-		return false;
-	}
-	if (!dev->queue_mgmt_ops ||
-	    !dev->queue_mgmt_ops->ndo_queue_create) {
-		NL_SET_ERR_MSG(extack, "Device does not support queue creation");
-		return false;
-	}
+	const char *msg = NULL;
+
 	if (dev->real_num_rx_queues < 1 ||
-	    dev->real_num_tx_queues < 1) {
-		NL_SET_ERR_MSG(extack, "Device must have at least one real queue");
-		return false;
-	}
-	return true;
+	    dev->real_num_tx_queues < 1)
+		msg = "Device must have at least one real queue";
+	if (!dev->queue_mgmt_ops ||
+	    !dev->queue_mgmt_ops->ndo_queue_create)
+		msg = "Device does not support queue creation";
+	if (dev->dev.parent)
+		msg = "Device is not a virtual device";
+
+	/* callers with extack=NULL are not from uAPI and don't want to trigger
+	 * the extack tracepoint.
+	 */
+	if (msg && extack)
+		NL_SET_ERR_MSG_FMT(extack, "%s", msg);
+
+	return !msg;
 }
 
 bool netdev_can_lease_queue(const struct net_device *dev,
-- 
2.55.0

