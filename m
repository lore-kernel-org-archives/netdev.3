Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BA3009CB
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396317; cv=none; b=HO4U+SarLvvQhFdIcdYw/bBeRJaSW/Cp1UbfW0Z8Iy2U6eLD+o7ZujwNG20jMWvhba/Y1HH/wCg+SxPgPkv6wgV0KJROhQvbDFT4I7ornmoj4gTGB5py1OVcjbbKfzFOMh+USXNnsPo0lpKveJ2NiMKWRcdO09nANeybvxkYA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396317; c=relaxed/simple;
	bh=6163441ET3yyIzOWPWSgOmjN0Hkq1BbrG+OBGsE2hYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXH2jMBblbnXPPJCzv0N1YjmATwOuWq8hkZbUVekU/kbXVdJihYwGE2XLIdBAM6fQV/DBJGBJBqjy+68X4YCjRzCeVv0r4Dd51JADIccS8j2UJRw6nPautlt/7K2wRfRESkZeDLSohTRDXys1WH8Eydz7yHhpfOpew+OqyMUedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQURgEfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQURgEfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFA1F000FF;
	Sat, 26 Sep 2026 04:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790396315;
	bh=nG74P4tQ+WrvmnkrqlBz4JJ0/5OSaeGohakSC5abLq4=;
	h=From:To:Cc:Subject:Date;
	b=FQURgEfGWk4MRVDgxDkwhEql1oXy9xcniws3UJ2Lcv70ebMFsvwY7SlJQ2oEkm9OW
	 pMgWk/ecUUXYp7u1Ix3iJIS4K3G4EF41eb7SARRRKZHPWm9TH+SSXjVDzgT75prBmh
	 y9VsnigdZTYD/RZuZNsgK0Pr47kr4LYtsMTwjudwNMh40uQyQRaW8Z02n8s0zOn/z5
	 qPn4iRaQKCkcfxvZLotVr13SYJU45qcOG9W9jzxiLLf1kU6NNNrVoQytItpIftwuKn
	 800y54tuMviY5IvNH1hYYEsP19ij0SyJ864kTj6FcS52nMckT17MqhHlMlWcoE+hq6
	 tNpISY4OAa1vg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] net: use two lockdep classes for the netdev instance lock
Date: Fri, 25 Sep 2026 21:18:31 -0700
Message-ID: <20260926041832.1649675-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_lockdep_set_classes() puts dev->lock in a separate lockdep class,
by type (netkit vs dummy etc), with the intent of keeping the instance
locks of individual devices as independent from each other as possible.
In practice it does the opposite. lockdep only calls the cmp_fn for locks
of the same class, so netdev_lock_cmp_fn() never gets a say when devices
from different classes are nested. Instead lockdep records a dependency
between the classes, and reports a circular locking problem as soon as
the nesting happens the other way round, e.g. when devices are unregistered
in a batch.

  ======================================================
  WARNING: possible circular locking dependency detected
  7.3.0-rc3+ #26 Not tainted
  ------------------------------------------------------
  kworker/u256:1/326 is trying to acquire lock:
  ff110000104fce28 (&dev_instance_lock_key#6){+.+.}-{4:4}, at:
  unregister_netdevice_many_notify+0x1141/0x1c30

  but task is already holding lock:
  ff110000127f2e28 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
  unregister_netdevice_many_notify+0x1141/0x1c30

  -> #1 (&dev_instance_lock_key#7){+.+.}-{4:4}:
         __lock_acquire+0x767/0xd60
         lock_acquire.part.0+0xd0/0x260
         __mutex_lock+0x17d/0x1f20
         unregister_netdevice_many_notify+0x1141/0x1c30
         default_device_exit_batch+0x3ee/0x520
         ops_undo_list+0x2cc/0x8a0
         cleanup_net+0x442/0x9c0
         process_one_work+0x951/0x1ab0
         worker_thread+0x5a6/0xd10
         kthread+0x339/0x430
         ret_from_fork+0x4a4/0x6f0
         ret_from_fork_asm+0x1a/0x30

  -> #0 (&dev_instance_lock_key#6){+.+.}-{4:4}:
         check_prev_add+0xeb/0xe60
         validate_chain+0x598/0x900
         __lock_acquire+0x767/0xd60
         lock_acquire.part.0+0xd0/0x260
         __mutex_lock+0x17d/0x1f20
         unregister_netdevice_many_notify+0x1141/0x1c30
         default_device_exit_batch+0x3ee/0x520
         ops_undo_list+0x2cc/0x8a0
         cleanup_net+0x442/0x9c0
         process_one_work+0x951/0x1ab0
         worker_thread+0x5a6/0xd10
         kthread+0x339/0x430
         ret_from_fork+0x4a4/0x6f0
         ret_from_fork_asm+0x1a/0x30

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&dev_instance_lock_key#7);
                                 lock(&dev_instance_lock_key#6);
                                 lock(&dev_instance_lock_key#7);
    lock(&dev_instance_lock_key#6);

   *** DEADLOCK ***

  locks held by kworker/u256:1/326: 6, last CPU#6:
   #0: ff11000001c2b540 ((wq_completion)netns){+.+.}-{0:0}, at:
  process_one_work+0x117c/0x1ab0
   #1: ffa0000001a3fd18 (net_cleanup_work){+.+.}-{0:0}, at:
  process_one_work+0x8ce/0x1ab0
   #2: ffffffff98f53288 (pernet_ops_rwsem){++++}-{4:4}, at:
  cleanup_net+0xc1/0x9c0
   #3: ffffffff98f6ede0 (rtnl_mutex){+.+.}-{4:4}, at:
  default_device_exit_batch+0x92/0x520
   #4: ff1100001321ae28 (&dev_instance_lock_key#7){+.+.}-{4:4}, at:
  unregister_netdevice_many_notify+0x1141/0x1c30

We can't put all devices in the same class, that'd be too permissive.
netdev_nl_queue_create_doit() and netdev_nl_bind_tx_doit() lock
a virtual device (netkit) before a physical device, without rtnl_lock.
We can never allow locking in the opposite order even under rtnl_lock.
cmp_fn cannot enforce this sort of rule: lockdep keys its chain cache on
the sequence of lock classes, so with a single class both orders hash
to the same chain and only whichever happens first is validated.

netdev_lock_cmp_fn() itself has another source of false-negatives.
lockdep calls it from within __lock_acquire(), with the recursion counter
already raised, so lock_is_held_type() always returns LOCK_STATE_UNKNOWN,
which means lockdep_rtnl_is_held() always returns true / held.
Use rtnl_is_locked(), which looks at the mutex directly and does
work from that context. We may still miss a bad case if some other
process is holding the lock, not us, but that's better than the
100% false negative rate of lockdep_rtnl_is_held().

One last thing, lockdep compares the address of the cmp function,
so it can't be a static inline - that would work similarly to having
separate classes, again. Move it to a source file.

Tested by nesting two instance locks from a module, one scenario per boot
since the first splat turns debug_locks off:

  first       second      rtnl      reported
  -----------------------------------------------------------
  virt->virt              no        recursive locking
  virt->virt              yes       -
  virt->phys              no        -
  virt->phys              yes       -
  phys->virt              no        - (records the edge)
  phys->virt              yes       - (records the edge)
  phys->phys              no        recursive locking
  phys->phys              yes       -
  virt->phys  phys->virt  no, no    circular dependency
  virt->phys  phys->virt  no, yes   circular dependency
  virt->phys  phys->virt  yes, no   circular dependency
  virt->phys  phys->virt  yes, yes  circular dependency
  phys->virt  virt->phys  no, no    circular dependency
  phys->virt  virt->phys  yes, yes  circular dependency
  virt->virt  virt->virt  yes, no   recursive locking
  phys->phys  phys->phys  yes, no   recursive locking

(netkit and dummy stood in for the virtual devices, virtio_net and
netdevsim for the physical ones.)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: https://lore.kernel.org/20260923223545.3815583-1-kuba@kernel.org
---
 include/net/netdev_lock.h | 20 +++-----------------
 net/core/dev.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 9fb3e93857c3..edd8cc2e2b36 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -110,34 +110,20 @@ static inline int netdev_is_locked_ops_compat(const struct net_device *dev)
 	return lockdep_rtnl_is_held();
 }
 
-static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
-				     const struct lockdep_map *b)
-{
-	if (a == b)
-		return 0;
-
-	/* Allow locking multiple devices only under rtnl_lock,
-	 * the exact order doesn't matter.
-	 * Note that upper devices don't lock their ops, so nesting
-	 * mostly happens in batched device removal for now.
-	 */
-	return lockdep_rtnl_is_held() ? -1 : 1;
-}
+void netdev_set_instance_lock_class(struct net_device *dev);
 
 #define netdev_lockdep_set_classes(dev)				\
 {								\
 	static struct lock_class_key qdisc_tx_busylock_key;	\
 	static struct lock_class_key qdisc_xmit_lock_key;	\
 	static struct lock_class_key dev_addr_list_lock_key;	\
-	static struct lock_class_key dev_instance_lock_key;	\
 	unsigned int i;						\
 								\
 	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
 	lockdep_set_class(&(dev)->addr_list_lock,		\
 			  &dev_addr_list_lock_key);		\
-	lockdep_set_class(&(dev)->lock,				\
-			  &dev_instance_lock_key);		\
-	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);	\
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING))			\
+		netdev_set_instance_lock_class(dev);		\
 	for (i = 0; i < (dev)->num_tx_queues; i++)		\
 		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
 				  &qdisc_xmit_lock_key);	\
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..a8eb382f40ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -568,6 +568,41 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 }
 #endif
 
+#ifdef CONFIG_PROVE_LOCKING
+static int netdev_lock_cmp_fn(const struct lockdep_map *a,
+			      const struct lockdep_map *b)
+{
+	if (a == b)
+		return 0;
+
+	/* @a and @b must be of same class - both virtual or physical.
+	 * cmp_fn won't be called for devices of different classes.
+	 *
+	 * For the same class only allow nesting under the protection
+	 * of rtnl_lock. Note that we can't use lockdep_rtnl_is_held()
+	 * here, it always answers UNKNOWN from within lockdep.
+	 */
+	return rtnl_is_locked() ? -1 : 1;
+}
+
+/* A virtual device can be locked before the physical device it leases
+ * queues from, see netdev_nl_queue_create_doit(). Keep the two kinds
+ * in separate classes so the dependency graph enforces the order;
+ * netdev_lock_cmp_fn() then only has to rule on same-class nesting.
+ */
+void netdev_set_instance_lock_class(struct net_device *dev)
+{
+	static struct lock_class_key netdev_virt_instance_lock_key;
+
+	if (dev->dev.parent)
+		return;
+
+	lockdep_set_class(&dev->lock, &netdev_virt_instance_lock_key);
+	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
+}
+EXPORT_SYMBOL_GPL(netdev_set_instance_lock_class);
+#endif
+
 /*******************************************************************************
  *
  *		Protocol management and registration routines
@@ -12183,6 +12218,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
+	/* see also netdev_set_instance_lock_class() */
+	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
 	netif_rx_mode_init(dev);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
-- 
2.55.0

