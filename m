Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FE29B8E1;
	Mon, 19 Oct 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373909; cv=none; b=E2HLgcZ6ozaIDT9TglNkjGt4HnDstNScjWPb+nZr8JGh2WoJcZONO23j35IHfuXJjQqxZmbsDfGCRGdm34mzTwEqoj64iaqow0x/JYOsvVRKSfmu6W5t9K5FXmPBX5zJ0sSAcefP1s9N2TWkQfimrQMLZDOjVXIwjDQMiIMyl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373909; c=relaxed/simple;
	bh=xZp69AcqqcLYdgTjDKNCo6arObT7ZYaZKk2Uqmy/dbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d97o96I1ZWwtj3ZbreTLplsqm1y72xmSCjz/qFxFK2Tmet2vexlbHFlXE85AC8oZ0J6KTmdn3jT7N1aqEiYBxEESK020XZHWOVUs66XM6T4eOgxHOC9eTg/zImO3j8Ke7YMrUgVzcQ70wKszxCXFzm5Mg2SYy3O4e2AKdBzWKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HjnntV9y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HjnntV9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C1
	hlcy8uosj/hXxugJg3frVYFqDhWTyUwRZR33eXhdo=; b=HjnntV9yRRunbt4eM3
	B52dNuBqX/ZXpKtEOMQy9VR7TMGRl3bJrnvybbptxKfMoRJRHlHVeP00KUpjUBNq
	K4EKS+NfTp7PVqxvLhNb12H4MAQ0Bfnc4xDKZ30OZq6FKuC4oO9VCBxfeX0sY6+L
	bONlg3G4K05MUe55PscafdUac=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn14ZldNVqANBiBA--.31905S2;
	Mon, 19 Oct 2026 09:37:41 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gwshan@linux.vnet.ibm.com,
	joel@jms.id.au
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v2 1/2] net/ncsi: fix use-after-free of ncsi_dev_priv in ncsi_unregister_dev()
Date: Mon, 19 Oct 2026 09:37:39 +0800
Message-ID: <20261019013739.450017-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn14ZldNVqANBiBA--.31905S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF1fJr18AF48Ar1rWF1DAwb_yoW7Kr4DpF
	W3Ja43K3ykZr1jgrZ3Zr43uF1rXrs7Zw17C3sIgw4aya45G34jvryIyay09Fy5GFZ7Ga12
	vr4DWws09rs8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziiL08UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3wZGKmrVdGYvugAA3N

ncsi_unregister_dev() releases every package and channel, unlinks the
device from the global ncsi_dev_list with list_del_rcu() and
immediately frees it with kfree().  The generic netlink handlers
resolve the device through that list (ndp_from_ifindex() ->
ncsi_find_dev()) and walk ndp->packages with no lock and no RCU
protection, so a reader that overlaps the teardown dereferences freed
memory.  NCSI_CMD_PKG_INFO has no GENL_ADMIN_PERM, so an
unprivileged user can race it against rmmod of the driver:

  writer: rmmod ftgmac100
            -> ftgmac100_remove() -> ncsi_unregister_dev() -> kfree(ndp)
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()

The genlmsg_new(GFP_KERNEL) allocation between the resolution and the
walk makes the window wide enough to hit even without preemption.

KASAN report (arm multi_v7, QEMU ast2600-evb, KASAN + SLUB + PREEMPT):

  BUG: KASAN: use-after-free in ncsi_write_package_info+0xf50/0xf84
  Read of size 4 at addr c9f100a0 by task poc_dump/62

which is ndp->package_num at offset 160, the bounds check at the
entry of ncsi_write_package_info(); the page had already been
returned to the buddy allocator.  A second capture of the same access
shows the object as an 8K kmalloc region still in the slab.

Two kernel-side users keep running into the objects as well:

  * The per-channel monitor timers keep running while the removal
    loop frees the packages: ncsi_remove_channel() stops the monitor
    only of the channel it is about to free, so the monitor of a
    channel on a later package can fire concurrently with the loop.

  * Every outstanding request has a one second timeout timer in
    ndp->requests[].  dev_remove_pack() has already cut off the
    responses, so these timers are all certain to fire, and
    ncsi_request_timeout() would run on an ndp that the deferred
    free has already released, with the timer_list still linked into
    the timer wheel.  Their command and response skbs leak.

Quiesce everything that walks the objects before releasing them, and
defer the final free:

    dev_remove_pack(&ndp->ptype);   no more responses
    disable_work_sync(&ndp->work);  worker cannot re-arm monitors
    stop every channel monitor;
    ncsi_free_request() every used request
                                     (deletes its timer, frees skbs);
    ncsi_remove_package() loop;
    list_del_rcu(&ndp->node);
    kfree_rcu(ndp, rcu);

The rcu_head sits at the head of struct ncsi_dev_priv because
kfree_rcu() requires its offset to be below 4096 and the structure is
about 17 KB on arm32 (requests[256]).

This is the free side of the fix for the device object: the packages
and channels are deferred by the companion series "net/ncsi: fix
use-after-free of ncsi_package in ncsi_remove_package()" and
"net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()",
which also adds the rcu_read_lock() to the genl readers.  The driver
side that walks the released objects from ftgmac100_stop() during
unregister_netdev() is fixed by the second patch of this series.

Found by a Coccinelle rule matching kfree() immediately after
list_del_rcu(); the code inspection and the fix were LLM-assisted,
and the race was confirmed at runtime with KASAN as above.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    |  4 ++++
 net/ncsi/ncsi-manage.c | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index cb41953..3630ee4 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -317,6 +317,10 @@ struct vlan_vid {
 
 struct ncsi_dev_priv {
 	struct ncsi_dev     ndev;            /* Associated NCSI device     */
+	/* RCU deferred free; must sit near the head of the struct as
+	 * kfree_rcu() requires the offset to be below 4096
+	 */
+	struct rcu_head     rcu;
 	unsigned int        flags;           /* NCSI device flags          */
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
 #define NCSI_DEV_HWA		2            /* Enabled HW arbitration     */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 237e041..70cb31e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1956,11 +1956,42 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_request *nr;
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc;
 	unsigned long flags;
+	bool used;
+	int i;
 
 	dev_remove_pack(&ndp->ptype);
 
+	/* Quiesce everything that walks the packages and channels
+	 * before releasing them.  The monitors are stopped after the
+	 * worker so that ncsi_configure_channel() cannot re-arm them.
+	 */
+	disable_work_sync(&ndp->work);
+	NCSI_FOR_EACH_PACKAGE(ndp, np)
+		NCSI_FOR_EACH_CHANNEL(np, nc)
+			ncsi_stop_channel_monitor(nc);
+
+	/* With the Rx handler gone no response can complete an
+	 * outstanding request any more.  Free every request so that
+	 * its timer is deleted and its command and response skbs are
+	 * released; otherwise ncsi_request_timeout() would fire on
+	 * @ndp after the deferred free below, with the timer still
+	 * linked into the timer wheel.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		nr = &ndp->requests[i];
+
+		spin_lock_irqsave(&ndp->lock, flags);
+		used = nr->used;
+		spin_unlock_irqrestore(&ndp->lock, flags);
+
+		if (used)
+			ncsi_free_request(nr);
+	}
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1968,8 +1999,7 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
-	kfree(ndp);
+	/* Netlink readers may still hold the device */
+	kfree_rcu(ndp, rcu);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0

