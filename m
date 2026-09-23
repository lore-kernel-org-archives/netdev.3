Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A959220E
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202954; cv=none; b=YcOTcYsJwdL2tAvNvrofjjHmjL3H/FPPJTGz0UkFtQ+1EWZagHJB/nsffbr7fZU7NCROw0M4lGs6pJQxiqwwlyUgsaW6A3UU/41lWnlnu6dr772pKhhWZj8w6JASBzRqiXGf1fkGN12NEUj6W7IcMK6Y366dILn9ADcjkJt1yAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202954; c=relaxed/simple;
	bh=0VKIlZFDfqRpSKsmLhc8/2GKooH7zp6i4EzKJUdys+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJLYStqdaeejAFLW9NWGBU+tDeCv6Q1If3CbqXf6wsl5AIoUzL4VycoS3HtSmAnWxkrvNH9edpT5T5k8AcsRO4Ulb8cJn4EU+OPZyyRMNgfVG5whvqAKYOD/qQ4qxHTBMA33sqsTAFb6BkYOvhQ0+TfaG/a77QFI0FEf+SQSTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwmkudUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwmkudUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7CF1F00AC9;
	Wed, 23 Sep 2026 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790202949;
	bh=Ef2bRiURDaubzcWeSWQDK9g6Ruim+TIu/jiZwvTnMfQ=;
	h=From:To:Cc:Subject:Date;
	b=lwmkudUgRqvvYhZ7tLlt748grXIBTJOTFDX98bm3zEfXnU8+u0yk4NfOo8XlR5xqp
	 +UwiyW+7ouS9/oazUcbzD9FUlOuzVXfXIcjlkbY68VWRgGTAYp2JJQFIgzFdLartf1
	 6qWj4r9RNrJ/XNBnGHIvajElekcINSaM+mjbrVcDsCMhND2OWDLWNcru54siA6Uput
	 0G1DTAGdDm5Yk1oW0iHxV8tp7W5YgTRSkQt0FKZZtoVS/1z4NHbG7ZtvPps/WPP5Qr
	 UVvcFVg1/r5xirojNepGukAQJpPL47M91z4uNHrmASz6rbfrhkU3EbFjqZ/OasJ3K7
	 ywSwl8D8Tx+cg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sdf.kernel@gmail.com
Subject: [PATCH net-next 1/2] net: use a single lockdep class for the netdev instance lock
Date: Wed, 23 Sep 2026 15:35:44 -0700
Message-ID: <20260923223545.3815583-1-kuba@kernel.org>
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

Keep all instance locks in the class from mutex_init() and let
the cmp_fn run. It allows nesting under rtnl_lock, which covers
the most common case.

The cmp function itself also its address gets compared by lockdep
so it can't be a static inline (that'd give each device type it's
own cmp_fn).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This is a fix for what was tripping up my recent loopback patch:

https://lore.kernel.org/20260921190452.1467853-1-kuba@kernel.org

Not marking for net since it's a false positive splat, which,
apparently, nobody is hitting.

CC: sdf.kernel@gmail.com
---
 include/net/netdev_lock.h | 18 ------------------
 net/core/dev.c            | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 9fb3e93857c3..8baa27266317 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -110,34 +110,16 @@ static inline int netdev_is_locked_ops_compat(const struct net_device *dev)
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
-
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
 	for (i = 0; i < (dev)->num_tx_queues; i++)		\
 		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
 				  &qdisc_xmit_lock_key);	\
diff --git a/net/core/dev.c b/net/core/dev.c
index c67900354fa6..bca7b267f937 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -568,6 +568,22 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 }
 #endif
 
+#ifdef CONFIG_PROVE_LOCKING
+static int netdev_lock_cmp_fn(const struct lockdep_map *a,
+			      const struct lockdep_map *b)
+{
+	if (a == b)
+		return 0;
+
+	/* Allow locking multiple devices only under rtnl_lock,
+	 * the exact order doesn't matter.
+	 * Note that upper devices don't lock their ops, so nesting
+	 * mostly happens in batched device removal for now.
+	 */
+	return lockdep_rtnl_is_held() ? -1 : 1;
+}
+#endif
+
 /*******************************************************************************
  *
  *		Protocol management and registration routines
@@ -12172,6 +12188,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 #endif
 
 	mutex_init(&dev->lock);
+	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);
 	netif_rx_mode_init(dev);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
-- 
2.55.0

