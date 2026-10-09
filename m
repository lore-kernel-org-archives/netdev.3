Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A864DAFB2;
	Fri,  9 Oct 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552068; cv=none; b=Sw1jcoW3vVaB2kjFxsQ6fYPjIKZoh3KJD40Nz1+sRnbCdGwMIbaJILMy7Oa+hTtUFsWeWmOSeSX22Yp2DOTBGvgsrmGSpUWFJVYbJ7rByUtQXNkK27mHQsVvWSBxmdIrihQAWyXAdcTLTMOx0gw5wdmH6sVp65X2h58fK6pvelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552068; c=relaxed/simple;
	bh=AUj7OySEVuzLrRKTI2/u/OTDShpb6BsJbutuegVE7Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMqm2uQof/uHisLbo9RjYoOZdlBtymNvyPPvWYDbmYZmg858+d2e8FC3D7X6qiYDuXFbMO/GjqGmfaN0eKT95K0xYabEw3DI+7U9/cBjI4fJHu6McHGd3d/tA4qR9KXjevaNc82Nn79pV9r4eLY+myjVKKan7fMFOBXvqUI8K/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QRE7GzXF; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QRE7GzXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UJ
	R/c+njOjwBClCYT0vYB+8OCVlBHF2A3nn7qINygic=; b=QRE7GzXFD+fn0WZci7
	wH594ex4QlL7GMMwU0Gc/nPjtUQYPtMby8rrAZ8Nm4RlYWdtuWg7yphhioTUtFe5
	AUWiyXBkFd34gxDGe7W79ETj1WCivx5ey7yNQi9B3blQsqt7ixQgE8UOgO+AJNy9
	SdcdBZBVCs6qhsT6c1omMhQ68=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3P_wX6shqSb62DQ--.56277S2;
	Fri, 09 Oct 2026 21:20:24 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v1] ncsi: Fix use-after-free in the device unregister path
Date: Fri,  9 Oct 2026 21:20:21 +0800
Message-ID: <20261009132021.39611-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P_wX6shqSb62DQ--.56277S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy8ArW3Cr48tr1fKw15Jwb_yoWrGw1fpF
	W3GryrKw48JF1FgFZ5WrWrWF15Xr4kW3Wjg39rKw4Sya9xGryUZryrAay09Fy5GFZ7Ca1a
	vr4YgF4a9rW8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc0eXUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3xiNcWrI6hh-CgAA3e

ncsi_unregister_dev() tears the NCSI device down in this order:

	dev_remove_pack(&ndp->ptype);

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);
	...
	disable_work_sync(&ndp->work);

	kfree(ndp);

ncsi_remove_package() and ncsi_remove_channel() remove the objects
with list_del_rcu() and free them with an immediate kfree().  Two
concurrent users are not covered by this sequence:

  1. The NCSI state machine work (ndp->work) iterates the package and
     channel lists (NCSI_FOR_EACH_PACKAGE/NCSI_FOR_EACH_CHANNEL, which
     are list_for_each_entry_rcu) while configuring channels, holding
     neither ndp->lock nor np->lock across the iteration.
     disable_work_sync() runs only after all packages have been freed,
     so it does not prevent the work from walking the lists over freed
     objects.

  2. RCU readers of the published lists.  list_del_rcu() removes the
     entry for subsequent readers, but the following bare kfree() is
     not covered by any grace period, so a reader that has already
     obtained the node pointer (e.g. a list_for_each_entry_rcu
     iteration in flight) dereferences freed memory when it resumes.

The ordering is reachable on BMC systems: ftgmac100_remove() calls
ncsi_unregister_dev() before unregister_netdev(), i.e. before
ncsi_stop_dev() has stopped the state machine, so the work is still
active while the packages are freed.  Device removal concurrent with
the NCSI configuration cycle or a netlink query triggers the race.

Fix this in two parts:

  - stop the state machine work before freeing the packages and
    channels instead of after;
  - free the package and channel objects with kfree_rcu() so that
    readers covered by an RCU read-side critical section do not
    access freed memory.

Fixes: e6f44ed6d04d ("net/ncsi: Package and channel management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 2 ++
 net/ncsi/ncsi-manage.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c9d1f22c16a..461469cc2600 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu_head;
 };
 
 struct ncsi_package {
@@ -253,6 +254,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head      rcu_head;
 };
 
 struct ncsi_request {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 1d63958c4429..39ac7075cd1b 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	kfree_rcu(nc, rcu_head);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu(np, rcu_head);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -1958,6 +1958,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	struct ncsi_package *np, *tmp;
 	unsigned long flags;
 
+	disable_work_sync(&ndp->work);
+
 	dev_remove_pack(&ndp->ptype);
 
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
@@ -1967,8 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0

