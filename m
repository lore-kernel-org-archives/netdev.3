Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA2391E55;
	Sat, 10 Oct 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619151; cv=none; b=kcWiBddLvNZvyV2I+ZoeBU9WS0Cy3+0tWckfaFHfTGTI5Nh7dmZz8UVTOShmPjVnTR265XM4oGDZiDEUCja+jaMdsmGaup5ysFERW2SZoDgBy9vaPCxS10HGz01zLXaCnKL3J/BfIacyEANu501ztwyYgOJY8+7ot0tfx9XRkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619151; c=relaxed/simple;
	bh=041B+7DCE8HmFhQCjiaDIIl7UD9Hq2Yi34UR4dJk/0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgq8IxgbK95t0PZ3s0w97egsFEVc5eVpLWqftSts6jhWL/1XXbCYJy/5cDYS8EQkQjH4PZjQEwYTgm2h4aZO9x1L+nvKw6FbrByczF3JdYOCk7uhUl8pMiavKCGdKirv+4FljUFLY7mvg0ZoAaQJkwaEoPfsmXGh3tkw8T+8XEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3i+WXKq; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3i+WXKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4e
	oySCwjQ7bRcafrGH+oTg1MumxaBMFbyBAUUpdJI04=; b=E3i+WXKqmGtStZxzUv
	10GepF+R5g+VZpyC9NEEyE0Heh6I92vOnSG7zU6xBGsN4P7lNwdXQgVLgtGmVus/
	prr/0bBmWs1Pbyg+sklkaW7oM47/1Q0XxTKD+kBqtsGoii12RBbr1d8If/jobvY9
	Q7j5hXM1YE6gPWeB+JN58NSeQ=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3N40m8Mlq6MIiDQ--.21817S2;
	Sat, 10 Oct 2026 15:58:31 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v2] ncsi: Fix use-after-free in the device unregister path
Date: Sat, 10 Oct 2026 15:58:28 +0800
Message-ID: <20261010075828.5724-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N40m8Mlq6MIiDQ--.21817S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFy8ArW3Cr48tr1fKw15Jwb_yoWrAr4xpF
	W3GFy5Kw48JF1FgFZ5WrWrWF15Xr4kW3Wjg39rKw4SyasxGryUZryfAayj9Fy5GFZ7Ca1a
	vr4YgFWa9rW8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U01v-UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+wdSNmrJ8CeIYgAA3G

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

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: e6f44ed6d04d ("net/ncsi: Package and channel management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 2 ++
 net/ncsi/ncsi-manage.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..362c3c69d087 100644
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
index 54d0df0a9efe..05dcd732effa 100644
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

