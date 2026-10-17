Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1B214812;
	Sat, 17 Oct 2026 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202071; cv=none; b=t80RKxKdzgZhc3FInyc+cyZpy1BWvzAvbGxO1W6Hd5420TD4ub0KZh77yjizI0F9RqlEJ41r3TBX5AL6iM+k4og1aEfJ032fB4SKxeqYN1T5BmdWPgY+8wxyMBxv/j5P8WEEzmFMPWsYxyz9IahW/YH6YIK2i1ejFBHqVVITBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202071; c=relaxed/simple;
	bh=4EY5UqDQoVP28I8PxoGRhWu4pfs/TwbwsXLAgwGqbH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRxL8DeR3Pcuj149baiM1GHEKNRKNL+U90CYZ1LaGiFB/ao8Ql7W82+dUfrPBOnWIp7i6uIGh0vTJdrsV9vQ0xOWq2F3fwG8cutD2RtJn3Guc1pNq/sUplFEqWByXDD+GD5VQeGmBn10EpDKYA0QgRfg2xWbNyaCEluWF2qM9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QZvHHeit; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QZvHHeit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=A6
	yIrZq7tAk7cxdJ8XQZYPAxPVb5CEzRWJ+W0DjJyro=; b=QZvHHeitpCFvAHyz4g
	qbLQKM4Afii0+mGXN+KYF2bW8QtTjb1OjcUCmyB77lxT1I3SH3AJXFIhC7Zuz4kD
	+P2gMYx7YejCFyZhfkHH82vVe9/QpWtgkiH0tKMtLLztFWgTEWP1FOgflfvamP0B
	xWksZfW9dQonPIFxtmXISGvKk=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_+IM1dJqNLmHAg--.49298S2;
	Sat, 17 Oct 2026 09:53:18 +0800 (CST)
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
Subject: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_dev_priv in ncsi_unregister_dev()
Date: Sat, 17 Oct 2026 09:53:15 +0800
Message-ID: <20261017015315.415794-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_+IM1dJqNLmHAg--.49298S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw15Xw4rCw17JF15Zr43Wrg_yoWxAr1DpF
	W3KFy3J3yktryUWrWv9a1rWFy8Zr4DW3W7Wwnxt3ya9a15CryjqFyxtFWruF15ArZ7Ca42
	vay5WFWYvrs8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi_-B_UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-A7Hq2rS1Q4WzAAA3n

ncsi_unregister_dev() releases every package (which releases every
channel), unlinks the ncsi_dev_priv from the global ncsi_dev_list with
list_del_rcu(), disables the configuration work and frees the device
itself -- in that order.  Two defects:

  * kfree(ndp) runs immediately after list_del_rcu().  The netlink
    reporting paths resolve the device through ncsi_dev_list
    (ndp_from_ifindex()) and keep dereferencing it, starting with the
    ndp->package_num check at the entry of ncsi_write_package_info(),
    so a reader can be inside the freed allocation.

  * The packages and channels are freed before
    disable_work_sync(&ndp->work); the configuration worker
    (ncsi_dev_work, including set_one_vid()/clear_one_vid()) can be
    walking the very objects being freed, and the teardown has to
    race it instead of quiescing it first.

  writer: rmmod ftgmac100 -> ftgmac100_remove() -> ncsi_unregister_dev()
            -> ncsi_remove_package() ... -> kfree(ndp)
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()

Quiesce the work first, then release the packages, and defer the free
of the ncsi_dev_priv with kfree_rcu().  A corollary of the old
ordering: the ftgmac100 driver calls ncsi_stop_dev() right after
ncsi_unregister_dev() and used to read the already freed device.

Commit a0ffa68c70b3 ("net/ncsi: Disable the ncsi work before freeing
the associated structure") already added a disable_work_sync() before
the kfree(ndp), but its placement still releases the packages and
channels first, so the worker can walk those while they are being
freed, and it does nothing for the netlink readers.

Both defects are visible in KASAN.  The netlink reader, on the
ndp->package_num entry check of ncsi_write_package_info() -- a read of
size 4 at ndp+160; struct ncsi_dev_priv is 17700 bytes on arm32, hence
kmalloc-32k:

  BUG: KASAN: use-after-free in ncsi_write_package_info+0xf50/0xf84
  Read of size 4 at addr c9f100a0 by task poc_dump/62
  Call trace:
   ...
   kasan_report from ncsi_write_package_info+0xf50/0xf84
   ncsi_write_package_info from ncsi_pkg_info_nl+0x320/0x63c
   ncsi_pkg_info_nl from genl_family_rcv_msg_doit+0x218/0x2d8
   genl_family_rcv_msg_doit from genl_rcv_msg+0x578/0xb24
   genl_rcv_msg from netlink_rcv_skb+0x134/0x3c4
   netlink_rcv_skb from genl_rcv+0x24/0x34
   genl_rcv from netlink_unicast+0x884/0xac0
   netlink_unicast from netlink_sendmsg+0x62c/0xb98
   netlink_sendmsg from __sys_sendto+0x290/0x3e0
   __sys_sendto from sys_send+0x18/0x20
   sys_send from ret_fast_syscall+0x0/0x5c
  The buggy address belongs to the physical page:

(a page-level report: the freed pages had already been returned to the
buddy allocator, so no cache or object lines are printed).  The same
reader site also surfaces once the page has been recycled into another
cache -- the same free at a different stage of the page lifecycle:

  BUG: KASAN: slab-out-of-bounds in ncsi_write_package_info+0xf50/0xf84
  Read of size 4 at addr c9d700a0 by task poc_dump/70
  Call trace:
   ...
   kasan_report from ncsi_write_package_info+0xf50/0xf84
   ncsi_write_package_info from ncsi_pkg_info_nl+0x320/0x63c
   ...
   netlink_unicast from netlink_sendmsg+0x62c/0xb98
  The buggy address belongs to the object at c9d70000
   which belongs to the cache kmalloc-8k of size 8192
  The buggy address is located 160 bytes inside of
   allocated 8192-byte region [c9d70000, c9d72000)

And the corollary, in the rmmod task itself -- its stack documents the
very ordering this patch changes (ncsi_unregister_dev() has already
freed the device when unregister_netdev() closes it):

  BUG: KASAN: use-after-free in ncsi_stop_dev+0x398/0x3a0
  Read of size 4 at addr c9d480a8 by task poc_dump/55
  Call trace:
   ...
   kasan_report from ncsi_stop_dev+0x398/0x3a0
   ncsi_stop_dev from ftgmac100_stop+0x2dc/0x364 [ftgmac100]
   ftgmac100_stop [ftgmac100] from __dev_close_many+0x2d8/0x57c
   __dev_close_many from netif_close_many+0x264/0x5a4
   netif_close_many from unregister_netdevice_many_notify+0x87c/0x1f0c
   unregister_netdevice_many_notify from
    unregister_netdevice_queue+0x290/0x328
   unregister_netdevice_queue from unregister_netdev+0x18/0x68
   unregister_netdev from ftgmac100_remove+0x74/0x9c [ftgmac100]
   ftgmac100_remove [ftgmac100] from
    device_release_driver_internal+0x41c/0x5e0
   ...
   bus_remove_driver from sys_delete_module+0x308/0x438
   sys_delete_module from ret_fast_syscall+0x0/0x5c

Tested on an arm multi_v7 kernel (KASAN + SLUB + PREEMPT) running as a
QEMU ast2600-evb guest with a host-side NC-SI responder; with the
series applied the same rmmod hammering completes without KASAN
reports.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..5d315768409a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -316,6 +316,7 @@ struct vlan_vid {
 
 struct ncsi_dev_priv {
 	struct ncsi_dev     ndev;            /* Associated NCSI device     */
+	struct rcu_head     rcu;             /* Deferred free (kfree_rcu)  */
 	unsigned int        flags;           /* NCSI device flags          */
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
 #define NCSI_DEV_HWA		2            /* Enabled HW arbitration     */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..35e9dd85e044 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1960,6 +1960,11 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 
 	dev_remove_pack(&ndp->ptype);
 
+	/* Quiesce the configuration worker before releasing the packages
+	 * and channels it walks.
+	 */
+	disable_work_sync(&ndp->work);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1967,8 +1972,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
-	kfree(ndp);
+	kfree_rcu(ndp, rcu);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0

