Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076213D8BD;
	Mon, 19 Oct 2026 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373888; cv=none; b=IrxDCYUBJVOQpRFJMJ34u9rDvovpqfv3rbRcwc5tP/P9t7StP3M6KdpnfMglAuT4jEYNJ4TTRzSW5X0lTcCWti6yTWeYlkDmKxocRUcXBEOdfiO+WxptGm4F9mukUrZ/Fp772E92LnnDoyq++DUq8RnEGldFy4xwlWRZbj9GijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373888; c=relaxed/simple;
	bh=ljwi3zkBL0CWPJQETI88XsqWvddOmZlPW//n/XmLJVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9TKKtc+wtOyAOVwU7ZbPl600h/1M/plNp8lp/ZbUpCIRSWoRWZuRpqHrs1B3SQGJOPcUflgdDI/kPFNTFaGY1NMHhzqybwzD1U9NW5knKZERUslWP4p1g+F3S9v6/J8nE2QG3BAy1ZEqDOvrN7Ftn6H4Eiv99IHRJFTZ/+nqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D2YA+bL2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D2YA+bL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dQ
	Sy07/Z3KzGq8VBZfw5dQqUQm3UjIvOL14CUKMnEnI=; b=D2YA+bL2rdEcBKkilZ
	v/fbjC7RaJxMPt9X6OBKptvoXApBEoFSHeADD9ybrl9eIuJnpXbhq06hWL7stx2/
	dc2KwKbG/0cN1Nr5uY+m+SC1h8/76yE84OX0l0BYel3nMPXprVHUTBwVxwq2yJze
	EcSGfPtUsBgNH6W9lSbIrQwTA=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXb0IsdNVqwsjJAg--.21603S2;
	Mon, 19 Oct 2026 09:36:46 +0800 (CST)
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
Subject: [PATCH net v2] net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()
Date: Mon, 19 Oct 2026 09:36:40 +0800
Message-ID: <20261019013640.449965-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXb0IsdNVqwsjJAg--.21603S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1rCF47ZFy7AFykuw4DArb_yoWrWF1DpF
	W3KFy5G3yvyryUWr97uFWruFy5Zr4fur1UK3sagw4Syas8Wry0qryIyayY9Fy5Krs7ua1a
	vr4UW3yavFWUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRjQ6LUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3w44HGrVdC4rgQAA36

ncsi_remove_package() unlinks the package from ndp->packages with
list_del_rcu() and then frees it with kfree(), after having released
all of its channels.  The generic netlink package info walkers iterate
the same list with the list_for_each_entry_rcu() based
NCSI_FOR_EACH_PACKAGE() and dereference the package in the loop body:

    rc = nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);

None of the NCSI genl handlers enters an RCU read-side critical
section: genl doit and dumpit callbacks run under genl_mutex and
cb_mutex, not under rcu_read_lock(), and ncsi_unregister_dev() takes
neither.  A reader that is preempted mid-walk -- or one that has
resolved the device and then sleeps in the genlmsg_new(GFP_KERNEL)
allocation of ncsi_pkg_info_nl() -- has no protection at all when the
teardown frees the package under it.

The race needs no real NC-SI hardware and is reachable by an
unprivileged user, as NCSI_CMD_PKG_INFO has no GENL_ADMIN_PERM:

  writer: rmmod ftgmac100
            -> ftgmac100_remove() -> ncsi_unregister_dev()
            -> ncsi_remove_package() -> kfree(np)
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()

ftgmac100_remove() calls ncsi_unregister_dev() before
unregister_netdev(), so the netdev, and with it the genl entry point,
stays reachable during the whole window.

KASAN report (arm multi_v7, QEMU ast2600-evb, KASAN + SLUB + PREEMPT,
four threads looping PKG_INFO doit/dump while cycling insmod/rmmod):

  BUG: KASAN: slab-use-after-free in ncsi_write_package_info+0xe3c/0xf84
  Read of size 1 at addr c69e2580 by task poc_dump/69
  The buggy address belongs to the object at c69e2580
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes inside of
   freed 64-byte region [c69e2580, c69e25c0)

The read is the u8 np->id feeding the nla_put_u32() above;
sizeof(struct ncsi_package) is 60 bytes, so it lands in kmalloc-64,
and with no VLAN churn in this mode the only size-1 read at offset 0
of that cache on this path is np->id.

Free the package with kfree_rcu() so that it survives the grace
period, and give struct ncsi_package an rcu_head.

This is the free side of the fix for the package object.  The read
side -- rcu_read_lock() around the device resolution and the list
walks of all NCSI genl handlers -- is the companion series "net/ncsi:
fix use-after-free of ncsi_channel in ncsi_remove_channel()"; the
parent ncsi_dev_priv is deferred by the companion series "net/ncsi:
fix use-after-free of ncsi_dev_priv in ncsi_unregister_dev()".  The
race is closed by the three series together; each one keeps its own
Fixes: tag so they can be backported independently.

Found by a Coccinelle rule matching kfree() immediately after
list_del_rcu(); the code inspection and the fix were LLM-assisted,
and the race was confirmed at runtime with KASAN as above.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dc..cb41953 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -253,6 +253,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head         rcu;
 };
 
 struct ncsi_request {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0..237e041 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -326,7 +326,8 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	/* Netlink walkers may still hold the package */
+	kfree_rcu(np, rcu);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
-- 
2.43.0

