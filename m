Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C738E8D8;
	Fri,  9 Oct 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551556; cv=none; b=MGKBM1TmX+PRnNiuvITispM6+zEVJjZix4gP3jFKH0eeF1Q/7da/oumwhE0nex8duRjhH44Zr8o7beOd4+3H0uk8YviBBaqGnnAfv2MkHJUNKqITeA1NMNoaSeLHzNDoiAhDv3Lfld5XmczNqzuoQ6QRyqJ1y7sVdkmIB1apVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551556; c=relaxed/simple;
	bh=fynUVCWaH1xFa0ZIB33shZp//TWYKM3TLw0VGAFjpso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn3ol1QVWkXGxxXfW/Ud/XbrrwOhKPr32CU2VfJtcb4bZtc6m2Nzu3liZY/M0PmmLgg7oQ8vM5tD+DTHZAXCxc2PDGMK7lKUAwXaABkooXQPw4DuA764nvX6kitpqggtYxlB8L2mNks6pr4aXaR6oIuJwgf7Rd4SoyCvG+DVgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=acz2E5v0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="acz2E5v0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=87
	vPQwuEibJT6KUaROqL3T8HD0smC6XR4lmh555cwuU=; b=acz2E5v0sL2pmJhxX8
	UWNjy/ldMTA49Z1uePrvKI+gg2vMLkzkLu9VqTDwOJEv6m9xZTOJptYf52ljlTjp
	DR1BO6bILP/yd5FjC89VIikVZmbuMi/945mldBBJ0ezT/hsXSirwrjWFRuDGIVak
	6qGP++4ubRtMi9cEPtkmfkQq0=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnCbAW6Mhq_ufiDQ--.17231S2;
	Fri, 09 Oct 2026 21:11:51 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v1] ncsi: Fix use-after-free in the VLAN id list removal
Date: Fri,  9 Oct 2026 21:11:46 +0800
Message-ID: <20261009131146.38586-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnCbAW6Mhq_ufiDQ--.17231S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw43tF18WFy5tr15trW3Awb_yoW8KF47pF
	ZxKFy3Jw4UJr1xua92qF4SgryrJrWkWw47WF92gws3Jasaqr12vFyfCay2v3yrZFWkC3ZF
	qrWqgr15ur4DX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-zVUUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3xcM72rI6BdZAgAA3t

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

