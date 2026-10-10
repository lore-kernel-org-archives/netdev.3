Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382322F388;
	Sat, 10 Oct 2026 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601743; cv=none; b=dfOmEt3ln6uRkXYRDyD4FJsT2pF/QTXdH/4WDuyM995Hlzf4XRHgzpznGpdjFOSjS8Sy6lfFoI7x55ou5ARL5dE7bnEcWzffjqA/MpUF67tMr8nEMnwCGH4IaSKI1WNVhr/wjjKzd7K+Uvriqt5dBAV5H5XUc0baQ7umHYo2bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601743; c=relaxed/simple;
	bh=UY9pIxtzuzR1RHp6HalHcWc50/Xrbe8zAg5saPFQ9ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEOP7Ug2knOQEr5OWlvrlRgmNkiKnNu56QS0DbruXfTkOgImj2psWkawQMTGIaRQaTQ5fcKKwnG0aWKZlBsgrA4vcsZYtUI2HK66YafYnH1z+kGlV7Oo7RNpccSjhn5B+kfci3VnzpUVH8Kls2T617ZaUoiapBvDHlLKsFYK3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=StwUFeVb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="StwUFeVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bl
	0/OK23/ZmJx+GgTgDElJlW6WWTrZNhXJXcWxcjsdI=; b=StwUFeVbrjNyTjjwju
	1TUWh6JmJ6SIgynS1olfLXgY3PHWC8pIVXjcgjCrDyP0Hka9S3YMBASrPU/FpI4k
	kbTMyCQYl6hTgKvvLaNlyxRmjN8CGzKlqHoSwx2lBViraFvONYigOiA9RFnYiT0Y
	usXz6H8fXvFfpbd9Kmg7lBxIU=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3f6kmrMlqouuJDg--.62217S2;
	Sat, 10 Oct 2026 11:08:23 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fercerpav@gmail.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v2] ncsi: Fix use-after-free in the VLAN id list removal
Date: Sat, 10 Oct 2026 11:08:20 +0800
Message-ID: <20261010030820.91563-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f6kmrMlqouuJDg--.62217S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykKw4Uuw13CFWUGw4kJFb_yoW5Gw15pF
	ZxKFy3Jw4UJr1xua97tF4Fgry5JrWkWw47Gryvgws3JasIqr12qFy3Jay293yFyrZ5C3ZF
	qrWqgw15ur4DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRjXdUUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-AdBJWrJrCcpcgAA3s

ncsi_vlan_rx_kill_vid() removes an entry from the NCSI VLAN list with:

	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
		if (vlan->vid == vid) {
			list_del_rcu(&vlan->list);
			found = true;
			kfree(vlan);
		}

The list is published with list_add_rcu(), so readers traverse it
under rcu_read_lock().  The writer holds only the RTNL, which does not
exclude those readers.  list_for_each_entry_safe() protects the writer
iteration itself, not concurrent readers.

The reader is set_one_vid(), invoked from the NCSI channel
configuration state machine (ndp->work) while sending the "Set VLAN
Filter" command:

	rcu_read_lock();
	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
		vid = vlan->vid;
		...
	}
	rcu_read_unlock();

An RCU read-side critical section only protects objects released via
call_rcu()/kfree_rcu(); it does not protect against the immediate
kfree() above.  If the state machine work has already obtained the
list entry pointer and is then scheduled out while another CPU removes
the VLAN id, the resumed iteration reads the freed node and follows
the ->next pointer of reused memory.

This is reachable on BMC systems using NCSI when a VLAN id is deleted
(ip link / rtnetlink) concurrently with an NCSI configuration cycle.

Fix this by adding an rcu_head to struct vlan_vid and releasing the
node with kfree_rcu().

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 21acf63013ed ("net/ncsi: Configure VLAN tag filter")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..2c9d1f22c16a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -312,6 +312,7 @@ struct vlan_vid {
 	struct list_head list;
 	__be16 proto;
 	u16 vid;
+	struct rcu_head rcu_head;
 };
 
 struct ncsi_dev_priv {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..1d63958c4429 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1737,7 +1737,7 @@ int ncsi_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
 			list_del_rcu(&vlan->list);
 			found = true;
-			kfree(vlan);
+			kfree_rcu(vlan, rcu_head);
 		}
 
 	if (!found) {
-- 
2.43.0

