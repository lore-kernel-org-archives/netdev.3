Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD93B6C1C;
	Mon, 17 Aug 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951532; cv=none; b=AmYqmkDgilojLHV5RmlakQC48Wn0UOT+G/unctA0eioENtHI0fbaBAC9SVliUQeEUIYOUHu3a56GHytOxtqhqi3XGIj4Wg3OXhBAf2F7FCed5Rt6Yl1QG1J2fR374okP+bVpJuMhzFCjm2cxyf9xT8K/1xC9fbRTO4jGMiNFnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951532; c=relaxed/simple;
	bh=I1fKViDF2COPprkJsh/3lHFutEehfbbb0veJXck+SFo=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=jdcB79mBdV8OUHzdl4lfoTAm7UCw0ReHEET0LbkQs6OIWQkxEzkCRJYMaJ1PBwU1VEyymX6IcTtWI1MptUUczBrj+yqTc5HYhozx4+mWTFEf7ng9A33QggmXfcN9acNOc8EGzjsCxs4HC7nh2wDhclVwhLTpIuP1xjb7pNAaKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=AGQZbF8e; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="AGQZbF8e"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1786950612; h=from:subject:to:date:message-id;
	bh=I1fKViDF2COPprkJsh/3lHFutEehfbbb0veJXck+SFo=;
	b=AGQZbF8ej8UVGqEfRaQhHugrZ3bwsUmrR5jE6L6s9WyIuF4FimnpJY6DPXbfDsxo7SspdWEbglg
	P/IFE2wwXuazN+rvRGhvrWIZ6Y3irI/P/WiaPqRwKGrURGKFQY8snxbYLQctX//3Ykpn0UL4C/e4r
	/zdDB0IrWpDBGpmh+zpyZBl+6zwZUgVs14lahcGZ9lnWw9jbVBbdrE25YJceh9BeaxZuIDm8WpO9K
	k5EfMkC92a3g8wBkGEaYI6VI1Xewbyu9XORJ8AXx4yNH8xsfcocHXsF327vN4m2OjK4+kvJQPJl0N
	WVVdicxRQqQCfBcRVabf9hyvgq+ciPDVLfnA==
Received: from localhost.localdomain (192.168.0.250) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 17 Aug
 2026 10:10:11 +0300
From: Aleksandr Khromov <haa@amicon.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<rrv@amicon.ru>, <haa@amicon.ru>
Subject: [PATCH net] slip: fix use-after-free in sl_sync()
Date: Mon, 17 Aug 2026 10:09:52 +0300
Message-ID: <20260817070952.1155579-1-haa@amicon.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)

slip_devs[] stores bare net_device pointers and takes no reference on
them.  sl_sync() and sl_alloc() walk that table from slip_open() under
rtnl_lock(), while an entry is dropped by sl_free_netdev(), which
sl_setup() installs as dev->priv_destructor.

priv_destructor is called from netdev_run_todo(), and netdev_run_todo()
deliberately runs with the RTNL semaphore released so that it can sleep
while waiting for the device refcount to drop:

	/* Snapshot list, allow later requests */
	list_replace_init(&net_todo_list, &list);

	__rtnl_unlock();
	...
		if (dev->priv_destructor)
			dev->priv_destructor(dev);	/* slip_devs[i] = NULL */
		if (dev->needs_free_netdev)
			free_netdev(dev);
		...
		/* Free network device */
		kobject_put(&dev->dev.kobj);

So rtnl_lock() does not serialise slip_open() against the teardown at
all.  sl_sync() can load slip_devs[i] while the entry is still published
and dereference it after netdev_run_todo() has run the destructor and
released the device:

  CPU0 (slip_open)                 CPU1 (slip_close)
                                   unregister_netdev()
                                     rtnl_unlock()
                                       netdev_run_todo()
                                         __rtnl_unlock()
  rtnl_lock()
  sl_sync()
    dev = slip_devs[i]
                                         priv_destructor(dev)
                                           slip_devs[i] = NULL
                                         kobject_put(&dev->dev.kobj)
                                           /* dev is freed */
    sl = netdev_priv(dev)
    if (sl->tty || sl->leased)     /* use-after-free */

  BUG: KASAN: use-after-free in sl_sync drivers/net/slip/slip.c:730 [inline]
  BUG: KASAN: use-after-free in slip_open+0xef4/0x1210 drivers/net/slip/slip.c:806
  Read of size 1 at addr ffff8880712dac71 by task syz-executor.2/6506

  CPU: 2 PID: 6506 Comm: syz-executor.2 Not tainted 6.1.134-syzkaller-00260-g0c8fc3469765 #0
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
  Call Trace:
   sl_sync drivers/net/slip/slip.c:730 [inline]
   slip_open+0xef4/0x1210 drivers/net/slip/slip.c:806
   tty_ldisc_open+0xa2/0x120 drivers/tty/tty_ldisc.c:433
   tty_set_ldisc+0x324/0x720 drivers/tty/tty_ldisc.c:564
   tiocsetd drivers/tty/tty_io.c:2428 [inline]
   tty_ioctl+0x5f0/0x1530 drivers/tty/tty_io.c:2712

  Allocated by task 6502:
   alloc_netdev_mqs+0x98/0xfe0 net/core/dev.c:10719
   sl_alloc drivers/net/slip/slip.c:756 [inline]
   slip_open+0x36d/0x1210 drivers/net/slip/slip.c:817
   tty_ldisc_open+0xa2/0x120 drivers/tty/tty_ldisc.c:433
   tty_set_ldisc+0x324/0x720 drivers/tty/tty_ldisc.c:564

  Freed by task 6497:
   device_release+0xa2/0x240 drivers/base/core.c:2507
   kobject_put+0x179/0x280 lib/kobject.c:729
   netdev_run_todo+0x6c8/0xef0 net/core/dev.c:10509
   slip_close+0x166/0x1c0 drivers/net/slip/slip.c:906
   tty_ldisc_close+0x113/0x1a0 drivers/tty/tty_ldisc.c:456
   tty_ldisc_kill+0x94/0x160 drivers/tty/tty_ldisc.c:614
   tty_ldisc_release+0xe3/0x2b0 drivers/tty/tty_ldisc.c:782
   tty_release+0xbcc/0xe70 drivers/tty/tty_io.c:1860

Commit e58c19124189 ("slip: Fix use-after-free Read in slip_open") fixed
a different source of stale entries - a device left in slip_devs[] after
slip_open() freed it on the registration error path - and does not
address this race, which is why the report survives it.

The same missing exclusion also lets sl_free_netdev() clear a slot that
sl_alloc() has already reused for another channel, silently dropping a
live device from the table.  sl_sync() then stops at that NULL entry, and
the next sl_alloc() hands out the same index again, so
register_netdevice() fails with -EEXIST because the slN interface is
still registered.

Give slip_devs[] its own mutex and take it on both sides.  A mutex rather
than a spinlock, because sl_sync() calls dev_close() inside the loop.
Holding it across the dereference is enough: the device is released by
the kobject_put() that follows the destructor, so sl_free_netdev() blocks
until sl_sync() is done, and a destructor that already ran leaves NULL
behind for sl_sync() to find.  sl_free_netdev() now also clears the slot
only if it still refers to its own device.

Taking rtnl_lock() inside sl_free_netdev() instead would deadlock: the
destructor is also invoked with RTNL already held, both from the error
unwind of register_netdevice() and directly from the error path of
slip_open() itself.

Lock order is rtnl -> slip_devs_lock everywhere; nothing takes RTNL while
holding the new mutex, so there is no inversion.

Reproduced on x86_64 with several threads looping over
open("/dev/ptmx") + ioctl(TIOCSETD, N_SLIP) + close().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 5342b77c4123 ("slip: Clean up create and destroy")
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
---
 drivers/net/slip/slip.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 6865d32..119bb3c 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -96,6 +96,12 @@
 
 static struct net_device **slip_devs;
 
+/* Serialises access to slip_devs[] and to the slip channels it points at.
+ * RTNL is not enough: sl_free_netdev() is the priv_destructor and therefore
+ * runs from netdev_run_todo(), which deliberately drops the RTNL semaphore.
+ */
+static DEFINE_MUTEX(slip_devs_lock);
+
 static int slip_maxdev = SL_NRUNIT;
 module_param(slip_maxdev, int, 0);
 MODULE_PARM_DESC(slip_maxdev, "Maximum number of slip devices");
@@ -635,7 +641,13 @@ static void sl_free_netdev(struct net_device *dev)
 {
 	int i = dev->base_addr;
 
-	slip_devs[i] = NULL;
+	mutex_lock(&slip_devs_lock);
+	/* Only drop our own entry: the slot may already have been reused by
+	 * sl_alloc() for a different channel.
+	 */
+	if (slip_devs[i] == dev)
+		slip_devs[i] = NULL;
+	mutex_unlock(&slip_devs_lock);
 }
 
 static const struct net_device_ops sl_netdev_ops = {
@@ -721,6 +733,7 @@ static void sl_sync(void)
 	struct net_device *dev;
 	struct slip	  *sl;
 
+	mutex_lock(&slip_devs_lock);
 	for (i = 0; i < slip_maxdev; i++) {
 		dev = slip_devs[i];
 		if (dev == NULL)
@@ -732,6 +745,7 @@ static void sl_sync(void)
 		if (dev->flags & IFF_UP)
 			dev_close(dev);
 	}
+	mutex_unlock(&slip_devs_lock);
 }
 
 
@@ -743,19 +757,24 @@ static struct slip *sl_alloc(void)
 	struct net_device *dev = NULL;
 	struct slip       *sl;
 
+	mutex_lock(&slip_devs_lock);
 	for (i = 0; i < slip_maxdev; i++) {
 		dev = slip_devs[i];
 		if (dev == NULL)
 			break;
 	}
 	/* Sorry, too many, all slots in use */
-	if (i >= slip_maxdev)
+	if (i >= slip_maxdev) {
+		mutex_unlock(&slip_devs_lock);
 		return NULL;
+	}
 
 	sprintf(name, "sl%d", i);
 	dev = alloc_netdev(sizeof(*sl), name, NET_NAME_UNKNOWN, sl_setup);
-	if (!dev)
+	if (!dev) {
+		mutex_unlock(&slip_devs_lock);
 		return NULL;
+	}
 
 	dev->base_addr  = i;
 	sl = netdev_priv(dev);
@@ -772,6 +791,7 @@ static struct slip *sl_alloc(void)
 	timer_setup(&sl->outfill_timer, sl_outfill, 0);
 #endif
 	slip_devs[i] = dev;
+	mutex_unlock(&slip_devs_lock);
 	return sl;
 }
 
@@ -1329,6 +1349,7 @@ static void __exit slip_exit(void)
 			msleep_interruptible(100);
 
 		busy = 0;
+		mutex_lock(&slip_devs_lock);
 		for (i = 0; i < slip_maxdev; i++) {
 			dev = slip_devs[i];
 			if (!dev)
@@ -1341,16 +1362,19 @@ static void __exit slip_exit(void)
 			}
 			spin_unlock_bh(&sl->lock);
 		}
+		mutex_unlock(&slip_devs_lock);
 	} while (busy && time_before(jiffies, timeout));
 
 	/* FIXME: hangup is async so we should wait when doing this second
 	   phase */
 
 	for (i = 0; i < slip_maxdev; i++) {
+		mutex_lock(&slip_devs_lock);
 		dev = slip_devs[i];
+		slip_devs[i] = NULL;
+		mutex_unlock(&slip_devs_lock);
 		if (!dev)
 			continue;
-		slip_devs[i] = NULL;
 
 		sl = netdev_priv(dev);
 		if (sl->tty) {
-- 
2.48.1

