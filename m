Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538F2652AF;
	Mon, 27 Jul 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122905; cv=none; b=edsDTOV3De4TrepudauxUjFvqXFrp1aR8XwCbA9ue1cw5NlGmJay+EIkDinPAv1016XhXBp8G00qx1u2VY7XEnkcl4/Z3W+MOxbMdqqmOozqXFgTY66VXYwcIc02umqXnwvF1LgctF8gKDHJIUU8Ab5mIKuJjTUXz4XmCrV/Hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122905; c=relaxed/simple;
	bh=wyVDaLR/PrSCbGlHQZxDOK6nI8DPGWG3FO0vlLI75pc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VsnxC5dyU/053bVV1kX+pkjFlsy4NDhGBTHEQPK4CX1BnoCDNETgpLQ7IXKtAvJlEjRUmA37+UOXxJvtNkxPdKI3cc0x6NQM5RBudmhdMx4lyLXfw5V7PehE2s+7zqU8fqw1CIwDoV0y+9fPcoG/Dp5i+txE0xp0yRC28eMCnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqcAXxIi; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqcAXxIi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785122891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFbMdmMKhaJGAqF2GyL/87PKqTfoNbmO+rF32yVLsu0=;
	b=YqcAXxIiDR77e3mv9G33Z1o5yiIllxVzNAst/uhNH5zy7jiSKScWhYCG2S8cIzzdTQ2FY7
	HmV0B/R08lPx3ye5ggVp/wtlrRETYyqLY2c7AVJ+0gaLkpGD8qXu8LEbrPFrrXmly/KWIR
	w91mOV9t/zG6WdGVK8J7FhRPlAcx5zQ=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Taegu Ha <hataegu0826@gmail.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ppp: convert chan_sem to a mutex
Date: Mon, 27 Jul 2026 11:28:00 +0800
Message-ID: <20260727032802.4090-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

chan_sem's read-side lock is taken under another mutex, so there is no
benefit in keeping it as an rwsem. Replace the rwsem with a mutex.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index cacc4c3a37d2..08bb89765487 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -39,7 +39,6 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/spinlock.h>
-#include <linux/rwsem.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
@@ -176,7 +175,7 @@ struct channel {
 	struct ppp_file	file;		/* stuff for read/write/poll */
 	struct list_head list;		/* link in all/new_channels list */
 	struct ppp_channel *chan;	/* public channel data structure */
-	struct rw_semaphore chan_sem;	/* protects `chan' during chan ioctl */
+	struct mutex chan_sem;		/* protects `chan' during chan ioctl */
 	spinlock_t	downl;		/* protects `chan', file.xq dequeue */
 	struct ppp __rcu *ppp;		/* ppp unit we're connected to */
 	struct net	*chan_net;	/* the net channel belongs to */
@@ -788,12 +787,12 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 
 		default:
-			down_read(&pch->chan_sem);
+			mutex_lock(&pch->chan_sem);
 			chan = pch->chan;
 			err = -ENOTTY;
 			if (chan && chan->ops->ioctl)
 				err = chan->ops->ioctl(chan, cmd, arg);
-			up_read(&pch->chan_sem);
+			mutex_unlock(&pch->chan_sem);
 		}
 		goto out;
 	}
@@ -2922,7 +2921,7 @@ int ppp_register_net_channel(struct net *net, struct ppp_channel *chan)
 #ifdef CONFIG_PPP_MULTILINK
 	pch->lastseq = -1;
 #endif /* CONFIG_PPP_MULTILINK */
-	init_rwsem(&pch->chan_sem);
+	mutex_init(&pch->chan_sem);
 	spin_lock_init(&pch->downl);
 	spin_lock_init(&pch->upl);
 
@@ -3005,11 +3004,11 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	 * the channel's start_xmit or ioctl routine before we proceed.
 	 */
 	ppp_disconnect_channel(pch);
-	down_write(&pch->chan_sem);
+	mutex_lock(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
 	pch->chan = NULL;
 	spin_unlock_bh(&pch->downl);
-	up_write(&pch->chan_sem);
+	mutex_unlock(&pch->chan_sem);
 
 	pn = ppp_pernet(pch->chan_net);
 	spin_lock_bh(&pn->all_channels_lock);
@@ -3600,6 +3599,7 @@ static void ppp_release_channel(struct channel *pch)
 		pr_err("ppp: destroying undead channel %p !\n", pch);
 		return;
 	}
+	mutex_destroy(&pch->chan_sem);
 	call_rcu(&pch->rcu, ppp_release_channel_free);
 }
 
-- 
2.43.0

