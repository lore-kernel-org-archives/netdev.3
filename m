Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BA3F39E4;
	Fri,  4 Sep 2026 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544865; cv=none; b=e7OWCIAftqnRB8s5CmrX4fvWGCuPBSRpnkfHQPEBfEvzlFX+fsd6Q8LBVvpUDxUwTx7NK5pn7duOS0/WL8lgabCQGUYS5bFijSjrOS6404jRZKTriu9xpDfY17Yr6DQ5/B3yf6ZYnEPz5R0exQYzy1hPF5Uo/hCL9NOtOKyws7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544865; c=relaxed/simple;
	bh=IyV4SeHzlGQh/XTrkjNBkEM1WrROfiZ2BH4a1VtThAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ni9kDUgTCjqfNIiI/+mDr8FzTvdQRuvgZw73gTobqkfE8q5Z/FL+MZ1A2avsVZ/EkXx5O/QSlkpPi7QCQaSKZIUkwJSSY6DGTh/fFVy6DewRIInUeXyNeuoQOV39iS25D6WX1o1ntF2yMVe5e/gg9q5v73I0wdH9sROGwnkrFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOQms9UY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOQms9UY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7971F00A3D;
	Fri,  4 Sep 2026 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544862;
	bh=Sh4pM9P10ktTurWhj1Ao4Irjykp6UovFXYEZeKiGJ3c=;
	h=From:To:Cc:Subject:Date;
	b=iOQms9UYSodcECCBoYxOpngCu1awd0x7Oca9IG4wmg4vlpxDKIlE/DhgQAID8ZNcK
	 tQ8Jj44QRdzJUDcx/WPQlBdU7DPYYLt80jKNwSf5FwLUL+LZnMXCXvnxB2x7F8EHDj
	 tSNMOldqDe5aMI/mr3KubNV8mDjWwjUAqWy/+9HvHYBx9SFpXwlmiJ0HB81CuzZN+/
	 HHjTYqsgCk30ZIh3UMHVZdqu27vG6qwnd3iwT85WjNVYeggG6vuyY3GKaphXkjZlV3
	 Gdky5JulPZ6VCYJ2xw4N33aoU6OeRW/Rn1NNiIr4G7vNvpPcyqIeRKDwl4hdk0+hM/
	 0eNEglWxFjZiw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] net: run netdev work under the ops-compat lock
Date: Fri,  4 Sep 2026 11:00:58 -0700
Message-ID: <20260904180058.3803849-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_work_proc() took rtnl_lock() for the whole batch, forcing
even ops-locked drivers onto rtnl just to run their rx_mode / ndo_work
callbacks. Take the per-device ops-compat lock instead: the instance
lock for ops-locked drivers, rtnl_lock for the rest. That's what the
callbacks already assert (e.g. netif_rx_mode_run() asserts
netdev_assert_locked_ops_compat()), and non-ops-locked work
such as vlan ndo_work keeps rtnl, since its compat lock resolves
to rtnl anyway.

Without this adding more uses of ndo_work, for cases which don't
need rtnl_lock feels like a step back.

We can drop the comment about the extra ref now, with the relocking
it's a necessity.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: rdunlap@infradead.org
CC: sdf@fomichev.me
CC: kuniyu@google.com
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/netdevices.rst | 14 ++++++++++----
 include/linux/netdevice.h               |  5 ++++-
 net/core/netdev_work.c                  | 15 ++-------------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index db71d4283032..aac33497813f 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -292,15 +292,21 @@ struct net_device synchronization rules
 	in process context.
 
 ndo_set_rx_mode_async:
-	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements queue management or shaper API.
+	Synchronization: netdev instance lock for "ops locked" drivers,
+	rtnl_lock() semaphore for all other drivers.
 	Context: process (from a work queue)
 	Notes: Async version of ndo_set_rx_mode which runs in process
 	context. Receives snapshots of the unicast and multicast address lists.
 
 ndo_change_rx_flags:
-	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements queue management or shaper API.
+	Synchronization: netdev instance lock for "ops locked" drivers,
+	rtnl_lock() semaphore for all other drivers.
+
+ndo_work:
+	Synchronization: netdev instance lock for "ops locked" drivers,
+	rtnl_lock() semaphore for all other drivers.
+	Context: process (from a work queue)
+	Notes: Runs deferred work scheduled with netdev_work_sched().
 
 ndo_setup_tc:
 	Locking depends on ``tc_setup_type``. For most types the callback
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8454646d6a45..17b8fb8e94fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1135,13 +1135,16 @@ struct netdev_net_notifier {
  *				struct netdev_hw_addr_list *uc,
  *				struct netdev_hw_addr_list *mc);
  *	Async version of ndo_set_rx_mode which runs in process context
- *	with rtnl_lock and netdev_lock_ops(dev) held. The uc/mc parameters
+ *	under the netdev instance lock for "ops locked" drivers, or
+ *	rtnl_lock for all other drivers. The uc/mc parameters
  *	are snapshots of the address lists - iterate with
  *	netdev_hw_addr_list_for_each(ha, uc). Return 0 on success or a
  *	negative errno to request a retry via the core backoff.
  *
  * void (*ndo_work)(struct net_device *dev, unsigned long events);
  *	Run deferred work scheduled with netdev_work_sched(@events).
+ *	Runs in process context under the netdev instance lock for "ops
+ *	locked" drivers, or rtnl_lock for all other drivers.
  *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index e721a06d58df..c99967907e18 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -3,7 +3,6 @@
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
-#include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <net/netdev_lock.h>
@@ -129,8 +128,6 @@ static void netdev_work_run(struct net_device *dev, unsigned long events,
 
 static void netdev_work_proc(struct work_struct *work)
 {
-	rtnl_lock();
-
 	while (true) {
 		unsigned long events = 0, core = 0;
 		netdevice_tracker tracker;
@@ -143,16 +140,10 @@ static void netdev_work_proc(struct work_struct *work)
 		}
 		dev = list_first_entry(&netdev_work_list, struct net_device,
 				       work_node);
-		/* Take a temporary reference so @dev can't be freed while we
-		 * drop the lock to grab its ops lock; the work reference is
-		 * only released once we claim the work below.
-		 * The re-locking dance is to ensure that ops lock is enough
-		 * to ensure canceling work is not racy with dequeue.
-		 */
 		netdev_hold(dev, &tracker, GFP_ATOMIC);
 		spin_unlock_bh(&netdev_work_lock);
 
-		netdev_lock_ops(dev);
+		netdev_lock_ops_compat(dev);
 		spin_lock_bh(&netdev_work_lock);
 		if (!list_empty(&dev->work_node)) {
 			list_del_init(&dev->work_node);
@@ -169,10 +160,8 @@ static void netdev_work_proc(struct work_struct *work)
 		spin_unlock_bh(&netdev_work_lock);
 
 		netdev_work_run(dev, events, core);
-		netdev_unlock_ops(dev);
+		netdev_unlock_ops_compat(dev);
 
 		netdev_put(dev, &tracker);
 	}
-
-	rtnl_unlock();
 }
-- 
2.55.0

