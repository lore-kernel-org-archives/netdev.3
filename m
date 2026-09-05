Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB349552B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620359; cv=none; b=gXFaOnEjIakgT5xAnrw1m5QkSknwfZTJ3IZPuvXVeHBYxCz4Y62bkYp25cTynTbB4ryzTf+DW1Z8hzzfzOoIp73kQJyPFFo5H8qwjwWnMw9J/Ac/L3EG55wnD00o7cqB3F829i4Pe2BrnbkM3+Opb0CjDLoXceHg/bH9rWLgjfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620359; c=relaxed/simple;
	bh=0P99CqiEWDa/4JbFaLBrkfdmXtAJQc30j25TNKwTmKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srsM5l17y+SUixkbpYH0DHY1SN5hKau39mnrrVSyvjchOg37GD51smFTh6WW1O5ptr66JbA4frJpNCNut6g+M3sCenmB1YGYowZVq9JTlev/U9OyHwUgyKhFJ3JqNoI7QzEPslUuryFwZg49NG+xo3uiDwoNQ5D/Mfmp7zmKgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JadUbGOO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JadUbGOO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d944747d41so21853065ad.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788620357; x=1789225157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDui/aq9750+Kjhoja6EZ3TY/aRQHZJAhe53B8/OnyM=;
        b=JadUbGOOTAHDvi6ddZ2kRNKHCaj23Tl6KzSIgqt5NqN5y0+Dle+XyEGyxtNSDG1YCX
         SVjvEZGxY8bLNQS5oZjfbn1dv2K92Lz3NmYvNCyTGKr3sgeBZa/KdX/tz5Rpk+iWHlqZ
         DEE+GNizlbjXEvc/3R4yfOQBVyrHWeuxQWXvmvTjT2KDXZuIo3P+7WVSxOnxyFoxLQfx
         wTT+ISmNIYCYOzrWmhQg3sRMQIFPJ+X61xKFGW8Q+O/7SW7KSFjsunaBrP38dc3Pyh+2
         lT7Ntkxik32UdbCvHlj1oO41Npkue0AHQEcJ9YD+Mu8HIJ3trTYShoBNzRQ/Cd4snTjf
         HQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788620357; x=1789225157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDui/aq9750+Kjhoja6EZ3TY/aRQHZJAhe53B8/OnyM=;
        b=rIuvS2+Rzkio0javw5cRq4zvDxlIqavt5q2fjBa7Ez23JLPnlc+7LKGU4L0ReAy4/A
         KqyUwQrhnqQ3bHzPySK/oJsnjvWlw+ufTAs9682VIbbA3+qKVrhvTzfcz6I/6d8TB2rl
         NO6VXwalX41pUwg3ixNcBVPQpYhNepCMKX6DRYgkMuPB9nh35x8FikGC2qTrkVKLzEHh
         cdiarWWuRezTw2JC4QRuGTB7x8a7zeW+OrlXW+16UwvUPsnwnHlDzWIxz/nGbnuCUqcY
         oCfnjonoFuB18cWqlkstQ66ab367oR9OkhJiQ0Q4MOWmCbzSdXYVgBema+WJMv5Sc91j
         cqag==
X-Gm-Message-State: AFuF++mJRJ5CDQidalTdwgIhkoJTuRhqz4JRaKFjGzDbgRT9/t9a3Ylt
	u71PlOqMZm9dg4Rd81MQRItRMUjpZ3loF6tikQF9jXheR98DsnlfBMJm7xznWixw
X-Gm-Gg: AYBFou3EvejUbUrOSh9x8yCkO+iQC1Dq8peS7Z1gF8q4/lGBa5ERFkxpCAY/xs2hEle
	jvysyWwr3cvH9RKDwdD/W7LxJfALcTZpuJu3bEbfNI+v74aZK91Dy2nLWWSeuYRBTnegkuaR52z
	qftWoaH+QS5/baZE78c21U6ATsBat8hqO5BiY2Q20P0qQLgFw6xu/FxyKi9jB6+zrbTlgGh9ZiK
	1jAMuYu3NZ4sj+tN++WErcH3Sn+yICQr/W7qZ1dDKzlqspJQPngRQpPs+mE6ZJ/hPhbuat0ZWj5
	ovWcsnZJR57dSa4+9mpFClXN2l+8xEIEew+7FfXwQIg9nT31bUv6G4VAJd1RPKGZzx0yk/fH8pf
	SJvhVqF5tfxuWpCN4tRjTt1NGxfF7nRnRZw6H2TmLRFuXEJGoeyCldVw4MHFwRLWKxga9bz60DD
	YXR94s5fA5F7rHpL4EEQ1NpDGLO/Gn11+s220s/r3v2AjmeqBNt8zklYM/b9IztpuW
X-Received: by 2002:a17:902:7204:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2db1248c3bdmr115408575ad.8.1788620356376;
        Sat, 05 Sep 2026 07:59:16 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14996a3asm22854595ad.46.2026.09.05.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:59:15 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: sam@mendozajonas.com,
	wongboonjhee52@gmail.com
Subject: [PATCH v4] net/ncsi: Fix Use-After-Free in NCSI channel and package removal
Date: Sat,  5 Sep 2026 22:59:02 +0800
Message-ID: <20260905145902.345090-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
ncsi_remove_package() remove objects from an RCU-protected linked list
using list_del_rcu() and immediately free them using kfree().

Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
readers traversing these lists under rcu_read_lock() (such as Netlink
dump handlers) can still hold a valid pointer to the object. When kfree()
executes, the reader is left holding a dangling pointer to freed memory,
resulting in a slab-use-after-free.

This patch fixes the issue by implementing a proper kref and RCU lifetime
model for NCSI objects. It replaces kfree() with kfree_rcu() / call_rcu()
to defer memory freeing until all pre-existing RCU readers have finished
their critical sections. It also introduces a kref for ncsi_dev_priv to
prevent the device structure from being freed while netlink handlers are
still operating on it. Concurrent lockless readers are now explicitly
protected with rcu_read_lock().

RCU read-side critical sections are added around lockless package and
channel traversals that may race with object removal. The KASAN
reproducer no longer reports the slab-use-after-free.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
v3 -> v4:
- Reworked NCSI object lifetime to pin the underlying net_device using
  dev_hold()/dev_put() inside ncsi_dev_get()/ncsi_dev_put(), preventing
  UAF if the driver unbinds while netlink handlers are active.
- Moved package/channel destruction and request sweeping into the
  ncsi_dev_release() kref callback to guarantee all asynchronous
  producers are fully stopped before teardown begins.
- Fixed pre-existing get_net() namespace leaks in all netlink handlers.
- Fixed RCU lock leaks on early returns in ncsi_check_hwa() and
  ncsi_set_channel_mask_nl().
- Unified channel_queue semantics by removing incorrect RCU usage and
  protecting traversals with ndp->lock.
- Extracted channel IDs inside the RCU read section in
  ncsi_update_tx_channel() to prevent pointer escapes.
- Fixed memory corruption in ncsi_vlan_rx_kill_vid() by using a
  temporary pointer for the freed VLAN object.

 net/ncsi/internal.h     |   8 +-
 net/ncsi/ncsi-aen.c     |   2 +
 net/ncsi/ncsi-manage.c  | 260 +++++++++++++++++++++++++++++++---------
 net/ncsi/ncsi-netlink.c |  69 ++++++++---
 net/ncsi/ncsi-rsp.c     |  17 ++-
 5 files changed, 275 insertions(+), 81 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..fbd90f270f5e 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu; /* RCU cleanup */
 };
 
 struct ncsi_package {
@@ -253,6 +254,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head      rcu; /* RCU cleanup */
 };
 
 struct ncsi_request {
@@ -315,6 +317,8 @@ struct vlan_vid {
 };
 
 struct ncsi_dev_priv {
+	struct rcu_head     rcu;             /* RCU cleanup */
+	struct kref         ref;
 	struct ncsi_dev     ndev;            /* Associated NCSI device     */
 	unsigned int        flags;           /* NCSI device flags          */
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
@@ -337,6 +341,7 @@ struct ncsi_dev_priv {
 	struct ncsi_channel *active_channel; /* Currently handled channel  */
 	struct list_head    channel_queue;   /* Config queue of channels   */
 	struct work_struct  work;            /* For channel management     */
+	bool                work_cancelled;  /* Work has been cancelled    */
 	struct packet_type  ptype;           /* NCSI packet Rx handler     */
 	struct list_head    node;            /* Form NCSI device list      */
 #define NCSI_MAX_VLAN_VIDS	15
@@ -406,7 +411,8 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 			   struct ncsi_package *np,
 			   struct ncsi_channel *disable,
 			   struct ncsi_channel *enable);
-
+struct ncsi_dev_priv *ncsi_dev_get(struct net_device *dev);
+void ncsi_dev_put(struct ncsi_dev_priv *ndp);
 /* Packet handlers */
 u32 ncsi_calculate_checksum(unsigned char *data, int len);
 int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca);
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 040a31557201..b88bbfd349cb 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -115,6 +115,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 		/* Return Tx to preferred channel */
 		ncsi_update_tx_channel(ndp, nc->package, NULL, nc);
 	} else if (has_link) {
+		rcu_read_lock();
 		NCSI_FOR_EACH_PACKAGE(ndp, np) {
 			NCSI_FOR_EACH_CHANNEL(np, tmp) {
 				/* Enable Tx on this channel if the current Tx
@@ -129,6 +130,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 				}
 			}
 		}
+		rcu_read_unlock();
 	}
 
 	/* Leave configured channels active in a multi-channel scenario so
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..ce99eff33c3c 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/rcupdate.h>
 
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
@@ -25,6 +26,12 @@
 LIST_HEAD(ncsi_dev_list);
 DEFINE_SPINLOCK(ncsi_dev_lock);
 
+static void ncsi_schedule_work(struct ncsi_dev_priv *ndp)
+{
+	if (!READ_ONCE(ndp->work_cancelled))
+		schedule_work(&ndp->work);
+}
+
 bool ncsi_channel_has_link(struct ncsi_channel *channel)
 {
 	return !!(channel->modes[NCSI_MODE_LINK].data[2] & 0x1);
@@ -35,17 +42,24 @@ bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
 {
 	struct ncsi_package *np;
 	struct ncsi_channel *nc;
+	unsigned long flags;
+	bool is_last = true;
 
-	NCSI_FOR_EACH_PACKAGE(ndp, np)
+	rcu_read_lock();
+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			if (nc == channel)
 				continue;
 			if (nc->state == NCSI_CHANNEL_ACTIVE &&
-			    ncsi_channel_has_link(nc))
-				return false;
+			    ncsi_channel_has_link(nc)) {
+				is_last = false;
+				goto out;
+			}
 		}
-
-	return true;
+	}
+ out:
+	rcu_read_unlock();
+	return is_last;
 }
 
 static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
@@ -62,6 +76,7 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 	}
 
 	nd->link_up = 0;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			spin_lock_irqsave(&nc->lock, flags);
@@ -75,12 +90,14 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 			if (ncsi_channel_has_link(nc)) {
 				spin_unlock_irqrestore(&nc->lock, flags);
 				nd->link_up = 1;
+				rcu_read_unlock();
 				goto report;
 			}
 
 			spin_unlock_irqrestore(&nc->lock, flags);
 		}
 	}
+	rcu_read_unlock();
 
 report:
 	nd->handler(nd);
@@ -242,28 +259,37 @@ struct ncsi_channel *ncsi_add_channel(struct ncsi_package *np, unsigned char id)
 	return nc;
 }
 
+static void ncsi_channel_rcu_free(struct rcu_head *head)
+{
+	struct ncsi_channel *nc = container_of(head, struct ncsi_channel, rcu);
+
+	kfree(nc->mac_filter.addrs);
+	kfree(nc->vlan_filter.vids);
+	kfree(nc);
+}
+
 static void ncsi_remove_channel(struct ncsi_channel *nc)
 {
 	struct ncsi_package *np = nc->package;
+	struct ncsi_dev_priv *ndp = np->ndp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&nc->lock, flags);
-
-	/* Release filters */
-	kfree(nc->mac_filter.addrs);
-	kfree(nc->vlan_filter.vids);
+	ncsi_stop_channel_monitor(nc);
 
+	spin_lock_irqsave(&nc->lock, flags);
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	spin_unlock_irqrestore(&nc->lock, flags);
-	ncsi_stop_channel_monitor(nc);
 
-	/* Remove and free channel */
+	spin_lock_irqsave(&ndp->lock, flags);
+	list_del_rcu(&nc->link);
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
 	spin_lock_irqsave(&np->lock, flags);
 	list_del_rcu(&nc->node);
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	call_rcu(&nc->rcu, ncsi_channel_rcu_free);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +352,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu(np, rcu);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -408,8 +434,12 @@ void ncsi_free_request(struct ncsi_request *nr)
 	driven = !!(nr->flags & NCSI_REQ_FLAG_EVENT_DRIVEN);
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	if (driven && cmd && --ndp->pending_req_num == 0)
-		schedule_work(&ndp->work);
+	if (driven && cmd) {
+		spin_lock_irqsave(&ndp->lock, flags);
+		if (--ndp->pending_req_num == 0 && !ndp->work_cancelled)
+			ncsi_schedule_work(ndp);
+		spin_unlock_irqrestore(&ndp->lock, flags);
+	}
 
 	/* Release command and response */
 	consume_skb(cmd);
@@ -552,6 +582,7 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 		if (ret)
 			goto error;
 
+		rcu_read_lock();
 		NCSI_FOR_EACH_CHANNEL(np, tmp) {
 			/* If there is another channel active on this package
 			 * do not deselect the package.
@@ -561,6 +592,7 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 				break;
 			}
 		}
+		rcu_read_unlock();
 		break;
 	case ncsi_dev_state_suspend_deselect:
 		ndp->pending_req_num = 1;
@@ -859,7 +891,10 @@ static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
 	struct ncsi_channel_mode *ncm;
 	struct ncsi_channel *channel;
 	struct ncsi_package *np;
+	unsigned long flags;
+	bool ret;
 
+	rcu_read_lock();
 	/* Check if any other channel has Tx enabled; a channel may have already
 	 * been configured and removed from the channel queue.
 	 */
@@ -869,29 +904,43 @@ static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
 		NCSI_FOR_EACH_CHANNEL(np, channel) {
 			ncm = &channel->modes[NCSI_MODE_TX_ENABLE];
 			if (ncm->enable)
-				return false;
+				goto out_false;
 		}
 	}
 
 	/* This channel is the preferred channel and has link */
-	list_for_each_entry_rcu(channel, &ndp->channel_queue, link) {
+	spin_lock_irqsave(&ndp->lock, flags);
+	list_for_each_entry(channel, &ndp->channel_queue, link) {
 		np = channel->package;
 		if (np->preferred_channel &&
 		    ncsi_channel_has_link(np->preferred_channel)) {
-			return np->preferred_channel == nc;
+			ret = np->preferred_channel == nc;
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			rcu_read_unlock();
+			return ret;
 		}
 	}
 
 	/* This channel has link */
-	if (ncsi_channel_has_link(nc))
+	if (ncsi_channel_has_link(nc)) {
+		spin_unlock_irqrestore(&ndp->lock, flags);
+		rcu_read_unlock();
 		return true;
+	}
 
-	list_for_each_entry_rcu(channel, &ndp->channel_queue, link)
+	list_for_each_entry(channel, &ndp->channel_queue, link)
 		if (ncsi_channel_has_link(channel))
-			return false;
+			goto out_false;
 
 	/* No other channel has link; default to this one */
+	spin_unlock_irqrestore(&ndp->lock, flags);
+	rcu_read_unlock();
 	return true;
+
+out_false:
+	spin_unlock_irqrestore(&ndp->lock, flags);
+	rcu_read_unlock();
+	return false;
 }
 
 /* Change the active Tx channel in a multi-channel setup */
@@ -904,6 +953,8 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 	struct ncsi_channel *nc;
 	struct ncsi_package *np;
 	int ret = 0;
+	u8 disable_id = 0, disable_package = 0;
+	u8 enable_id = 0, enable_package = 0;
 
 	if (!package->multi_channel && !ndp->multi_package)
 		netdev_warn(ndp->ndev.dev,
@@ -912,6 +963,7 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 	nca.req_flags = 0;
 
 	/* Find current channel with Tx enabled */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (disable)
 			break;
@@ -924,8 +976,14 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 				break;
 			}
 	}
+	if (disable) {
+		disable_id = disable->id;
+		disable_package = disable->package->id;
+	}
+	rcu_read_unlock();
 
 	/* Find a suitable channel for Tx */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (enable)
 			break;
@@ -949,8 +1007,13 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 				enable = nc;
 				break;
 			}
-		}
+			}
 	}
+	if (enable) {
+		enable_id = enable->id;
+		enable_package = enable->package->id;
+	}
+	rcu_read_unlock();
 
 	if (disable == enable)
 		return -1;
@@ -959,8 +1022,8 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 		return -1;
 
 	if (disable) {
-		nca.channel = disable->id;
-		nca.package = disable->package->id;
+		nca.channel = disable_id;
+		nca.package = disable_package;
 		nca.type = NCSI_PKT_CMD_DCNT;
 		ret = ncsi_xmit_cmd(&nca);
 		if (ret)
@@ -971,8 +1034,8 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 
 	netdev_info(ndp->ndev.dev, "NCSI: channel %u enables Tx\n", enable->id);
 
-	nca.channel = enable->id;
-	nca.package = enable->package->id;
+	nca.channel = enable_id;
+	nca.package = enable_package;
 	nca.type = NCSI_PKT_CMD_ECNT;
 	ret = ncsi_xmit_cmd(&nca);
 	if (ret)
@@ -1052,7 +1115,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		}
 		if (ret < 0) {
 			nd->state = ncsi_dev_state_config_clear_vids;
-			schedule_work(&ndp->work);
+			ncsi_schedule_work(ndp);
 		}
 
 		break;
@@ -1086,7 +1149,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			ret = clear_one_vid(ndp, nc, &nca);
 			if (ret) {
 				nd->state = ncsi_dev_state_config_svf;
-				schedule_work(&ndp->work);
+				ncsi_schedule_work(ndp);
 				break;
 			}
 			/* Repeat */
@@ -1096,7 +1159,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			ret = set_one_vid(ndp, nc, &nca);
 			if (ret) {
 				nd->state = ncsi_dev_state_config_ev;
-				schedule_work(&ndp->work);
+				ncsi_schedule_work(ndp);
 				break;
 			}
 			/* Repeat */
@@ -1253,6 +1316,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 	 */
 	found = NULL;
 	with_link = false;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (!(ndp->package_whitelist & (0x1 << np->id)))
 			continue;
@@ -1304,20 +1368,22 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 		if (with_link && !ndp->multi_package)
 			break;
 	}
+	rcu_read_unlock();
 
+	spin_lock_irqsave(&ndp->lock, flags);
 	if (list_empty(&ndp->channel_queue) && found) {
 		netdev_info(ndp->ndev.dev,
 			    "NCSI: No channel with link found, configuring channel %u\n",
 			    found->id);
-		spin_lock_irqsave(&ndp->lock, flags);
 		list_add_tail_rcu(&found->link, &ndp->channel_queue);
-		spin_unlock_irqrestore(&ndp->lock, flags);
 	} else if (!found) {
+		spin_unlock_irqrestore(&ndp->lock, flags);
 		netdev_warn(ndp->ndev.dev,
 			    "NCSI: No channel found to configure!\n");
 		ncsi_report_link(ndp, true);
 		return -ENODEV;
 	}
+	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	return ncsi_process_next_channel(ndp);
 }
@@ -1328,10 +1394,12 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 	struct ncsi_channel *nc;
 	unsigned int cap;
 	bool has_channel = false;
+	bool supported = true;
 
 	/* The hardware arbitration is disabled if any one channel
 	 * doesn't support explicitly.
 	 */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			has_channel = true;
@@ -1341,10 +1409,15 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 			    (cap & NCSI_CAP_GENERIC_HWA_MASK) !=
 			    NCSI_CAP_GENERIC_HWA_SUPPORT) {
 				ndp->flags &= ~NCSI_DEV_HWA;
-				return false;
+				supported = false;
+				goto out;
 			}
 		}
 	}
+out:
+	rcu_read_unlock();
+	if (!supported)
+		return false;
 
 	if (has_channel) {
 		ndp->flags |= NCSI_DEV_HWA;
@@ -1408,7 +1481,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		if (!ndp->active_package) {
 			/* No response */
 			nd->state = ncsi_dev_state_probe_dp;
-			schedule_work(&ndp->work);
+			ncsi_schedule_work(ndp);
 			break;
 		}
 		nd->state = ncsi_dev_state_probe_cis;
@@ -1416,7 +1489,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		    ndp->mlx_multi_host)
 			nd->state = ncsi_dev_state_probe_mlx_gma;
 
-		schedule_work(&ndp->work);
+		ncsi_schedule_work(ndp);
 		break;
 	case ncsi_dev_state_probe_mlx_gma:
 		ndp->pending_req_num = 1;
@@ -1620,6 +1693,7 @@ static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
 	unsigned long flags;
 	unsigned int n = 0;
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			spin_lock_irqsave(&nc->lock, flags);
@@ -1659,6 +1733,7 @@ static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
 		}
 	}
 
+	rcu_read_unlock();
 	return n;
 }
 
@@ -1667,26 +1742,27 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct ncsi_dev_priv *ndp;
 	unsigned int n_vids = 0;
 	struct vlan_vid *vlan;
-	struct ncsi_dev *nd;
 	bool found = false;
+	int ret;
 
 	if (vid == 0)
 		return 0;
 
-	nd = ncsi_find_dev(dev);
-	if (!nd) {
+	ndp = ncsi_dev_get(dev);
+	if (!ndp) {
 		netdev_warn(dev, "NCSI: No net_device?\n");
 		return 0;
 	}
 
-	ndp = TO_NCSI_DEV_PRIV(nd);
-
 	/* Add the VLAN id to our internal list */
+	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		n_vids++;
 		if (vlan->vid == vid) {
 			netdev_dbg(dev, "NCSI: vid %u already registered\n",
 				   vid);
+			rcu_read_unlock();
+			ncsi_dev_put(ndp);
 			return 0;
 		}
 	}
@@ -1694,12 +1770,17 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 		netdev_warn(dev,
 			    "tried to add vlan id %u but NCSI max already registered (%u)\n",
 			    vid, NCSI_MAX_VLAN_VIDS);
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return -ENOSPC;
 	}
+	rcu_read_unlock();
 
 	vlan = kzalloc_obj(*vlan);
-	if (!vlan)
+	if (!vlan) {
+		ncsi_dev_put(ndp);
 		return -ENOMEM;
+	}
 
 	vlan->proto = proto;
 	vlan->vid = vid;
@@ -1708,46 +1789,54 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	netdev_dbg(dev, "NCSI: Added new vid %u\n", vid);
 
 	found = ncsi_kick_channels(ndp) != 0;
-
-	return found ? ncsi_process_next_channel(ndp) : 0;
+	ret = found ? ncsi_process_next_channel(ndp) : 0;
+	ncsi_dev_put(ndp);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ncsi_vlan_rx_add_vid);
 
 int ncsi_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 {
 	struct vlan_vid *vlan, *tmp;
+	struct vlan_vid *found_vlan = NULL;
 	struct ncsi_dev_priv *ndp;
-	struct ncsi_dev *nd;
 	bool found = false;
+	int ret;
 
 	if (vid == 0)
 		return 0;
 
-	nd = ncsi_find_dev(dev);
-	if (!nd) {
+	ndp = ncsi_dev_get(dev);
+	if (!ndp) {
 		netdev_warn(dev, "NCSI: no net_device?\n");
 		return 0;
 	}
 
-	ndp = TO_NCSI_DEV_PRIV(nd);
-
 	/* Remove the VLAN id from our internal list */
+	rcu_read_lock();
 	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
 		if (vlan->vid == vid) {
 			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
 			list_del_rcu(&vlan->list);
+			found_vlan = vlan;
 			found = true;
-			kfree(vlan);
+			break;
 		}
+	rcu_read_unlock();
 
 	if (!found) {
 		netdev_err(dev, "NCSI: vid %u wasn't registered!\n", vid);
+		ncsi_dev_put(ndp);
 		return -EINVAL;
 	}
+	synchronize_rcu();
+	kfree(found_vlan);
 
 	found = ncsi_kick_channels(ndp) != 0;
 
-	return found ? ncsi_process_next_channel(ndp) : 0;
+	ret = found ? ncsi_process_next_channel(ndp) : 0;
+	ncsi_dev_put(ndp);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ncsi_vlan_rx_kill_vid);
 
@@ -1762,7 +1851,9 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	int i;
 
 	/* Check if the device has been registered or not */
+	rcu_read_lock();
 	nd = ncsi_find_dev(dev);
+	rcu_read_unlock();
 	if (nd)
 		return nd;
 
@@ -1782,6 +1873,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	ndp->package_whitelist = UINT_MAX;
 
 	/* Initialize private NCSI device */
+	kref_init(&ndp->ref);
 	spin_lock_init(&ndp->lock);
 	INIT_LIST_HEAD(&ndp->packages);
 	ndp->request_id = NCSI_REQ_START_IDX;
@@ -1826,7 +1918,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		ndp->package_probe_id = 0;
 		ndp->channel_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
-		schedule_work(&ndp->work);
+		ncsi_schedule_work(ndp);
 		return 0;
 	}
 
@@ -1842,6 +1934,7 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 	bool chained;
 	int old_state;
 	unsigned long flags;
+	rcu_read_lock();
 
 	/* Stop the channel monitor on any active channels. Don't reset the
 	 * channel state so we know which were active when ncsi_start_dev()
@@ -1860,6 +1953,7 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 				     old_state == NCSI_CHANNEL_INVISIBLE);
 		}
 	}
+	rcu_read_unlock();
 
 	netdev_dbg(ndp->ndev.dev, "NCSI: Stopping device\n");
 	ncsi_report_link(ndp, true);
@@ -1915,6 +2009,7 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	active = NULL;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			spin_lock_irqsave(&nc->lock, flags);
@@ -1932,6 +2027,7 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 		if (active)
 			break;
 	}
+	rcu_read_unlock();
 
 	if (!active) {
 		/* Done */
@@ -1948,27 +2044,77 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	nd->state = ncsi_dev_state_suspend;
-	schedule_work(&ndp->work);
+	ncsi_schedule_work(ndp);
 	return 0;
 }
 
-void ncsi_unregister_dev(struct ncsi_dev *nd)
+static void ncsi_dev_release(struct kref *ref)
 {
-	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_dev_priv *ndp;
 	struct ncsi_package *np, *tmp;
-	unsigned long flags;
+	int i;
 
-	dev_remove_pack(&ndp->ptype);
+	ndp = container_of(ref, struct ncsi_dev_priv, ref);
 
+	/* All producers have been stopped before the last reference is dropped. */
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		struct ncsi_request *nr = &ndp->requests[i];
+
+		timer_delete_sync(&nr->timer);
+		if (nr->used || nr->cmd || nr->rsp)
+			ncsi_free_request(nr);
+	}
+
+	kfree_rcu(ndp, rcu);
+}
+
+struct ncsi_dev_priv *ncsi_dev_get(struct net_device *dev)
+{
+	struct ncsi_dev_priv *ndp = NULL;
+	struct ncsi_dev *nd;
+
+	rcu_read_lock();
+	nd = ncsi_find_dev(dev);
+	if (nd) {
+		ndp = TO_NCSI_DEV_PRIV(nd);
+		/* Safely grab a reference while under RCU lock */
+		if (!kref_get_unless_zero(&ndp->ref))
+			ndp = NULL;
+		else
+			dev_hold(dev);
+	}
+	rcu_read_unlock();
+
+	return ndp;
+}
+
+void ncsi_dev_put(struct ncsi_dev_priv *ndp)
+{
+	if (ndp) {
+		dev_put(ndp->ndev.dev);
+		kref_put(&ndp->ref, ncsi_dev_release);
+	}
+}
+
+void ncsi_unregister_dev(struct ncsi_dev *nd)
+{
+	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	unsigned long flags;
+
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	spin_lock_irqsave(&ndp->lock, flags);
+	ndp->work_cancelled = true;
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
+	dev_remove_pack(&ndp->ptype);
 	disable_work_sync(&ndp->work);
 
-	kfree(ndp);
+	kref_put(&ndp->ref, ncsi_dev_release);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..a7094b124753 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -35,8 +35,6 @@ static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
 {
 	struct ncsi_dev_priv *ndp;
 	struct net_device *dev;
-	struct ncsi_dev *nd;
-	struct ncsi_dev;
 
 	if (!net)
 		return NULL;
@@ -47,9 +45,7 @@ static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
 		return NULL;
 	}
 
-	nd = ncsi_find_dev(dev);
-	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
-
+	ndp = ncsi_dev_get(dev);
 	dev_put(dev);
 	return ndp;
 }
@@ -175,13 +171,16 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 		return -ENODEV;
 
 	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		ncsi_dev_put(ndp);
 		return -ENOMEM;
+	}
 
 	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
 			  &ncsi_genl_family, 0, NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		kfree_skb(skb);
+		ncsi_dev_put(ndp);
 		return -EMSGSIZE;
 	}
 
@@ -190,9 +189,13 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		ncsi_dev_put(ndp);
 		return -EMSGSIZE;
 	}
+
+	rcu_read_lock();
 	rc = ncsi_write_package_info(skb, ndp, package_id);
+	rcu_read_unlock();
 
 	if (rc) {
 		nla_nest_cancel(skb, attr);
@@ -202,10 +205,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	ncsi_dev_put(ndp);
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -228,21 +233,24 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	if (!attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
+	ndp = ndp_from_ifindex(sock_net(skb->sk),
 			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
 
 	if (!ndp)
 		return -ENODEV;
 
 	package_id = cb->args[0];
+	rcu_read_lock();
 	package = NULL;
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
 
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return 0; /* done */
-
+	}
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
@@ -255,7 +263,9 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		rc = -EMSGSIZE;
 		goto err;
 	}
+
 	rc = ncsi_write_package_info(skb, ndp, package->id);
+
 	if (rc) {
 		nla_nest_cancel(skb, attr);
 		goto err;
@@ -266,9 +276,13 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 
 	cb->args[0] = package_id + 1;
 
+	rcu_read_unlock();
+	ncsi_dev_put(ndp);
 	return skb->len;
 err:
+	rcu_read_unlock();
 	genlmsg_cancel(skb, hdr);
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -289,7 +303,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp)
 		return -ENODEV;
@@ -297,11 +311,15 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
+
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return -ERANGE;
 	}
 
@@ -317,6 +335,8 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
+			ncsi_dev_put(ndp);
 			return -ERANGE;
 		}
 	}
@@ -337,6 +357,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		package->preferred_channel = NULL;
 	}
 	spin_unlock_irqrestore(&package->lock, flags);
+	rcu_read_unlock();
 
 	if (channel)
 		netdev_info(ndp->ndev.dev,
@@ -350,6 +371,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
@@ -365,7 +387,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp)
 		return -ENODEV;
@@ -376,6 +398,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	ndp->multi_package = false;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		spin_lock_irqsave(&np->lock, flags);
 		np->multi_channel = false;
@@ -383,18 +406,21 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		np->preferred_channel = NULL;
 		spin_unlock_irqrestore(&np->lock, flags);
 	}
+	rcu_read_unlock();
+
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
 	/* Update channel configuration */
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
 static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 {
-	struct ncsi_dev_priv *ndp;
+	struct ncsi_dev_priv *ndp = NULL;
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
@@ -427,7 +453,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 		goto out;
 	}
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp) {
 		ret = -ENODEV;
@@ -480,6 +506,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      ret);
 	}
 out:
+	ncsi_dev_put(ndp);
 	return ret;
 }
 
@@ -608,7 +635,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp)
 		return -ENODEV;
@@ -639,6 +666,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -663,21 +691,24 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp)
 		return -ENODEV;
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id) {
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return -ERANGE;
-
+	}
 	spin_lock_irqsave(&package->lock, flags);
 
 	channel = NULL;
@@ -690,6 +721,8 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			rcu_read_unlock();
+			ncsi_dev_put(ndp);
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -716,11 +749,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	}
 
 	spin_unlock_irqrestore(&package->lock, flags);
+	rcu_read_unlock();
 
 	/* Update channel configuration */
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..1fb73bc2e846 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -149,11 +149,13 @@ static int ncsi_rsp_handler_dp(struct ncsi_request *nr)
 		return -ENODEV;
 
 	/* Change state of all channels attached to the package */
+	rcu_read_lock();
 	NCSI_FOR_EACH_CHANNEL(np, nc) {
 		spin_lock_irqsave(&nc->lock, flags);
 		nc->state = NCSI_CHANNEL_INACTIVE;
 		spin_unlock_irqrestore(&nc->lock, flags);
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -1166,7 +1168,6 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 		 struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct ncsi_rsp_handler *nrh = NULL;
-	struct ncsi_dev *nd;
 	struct ncsi_dev_priv *ndp;
 	struct ncsi_request *nr;
 	struct ncsi_pkt_hdr *hdr;
@@ -1174,8 +1175,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	int payload, i, ret;
 
 	/* Find the NCSI device */
-	nd = ncsi_find_dev(orig_dev);
-	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
+	ndp = ncsi_dev_get(orig_dev);
 	if (!ndp) {
 		ret = -ENODEV;
 		goto err_free_skb;
@@ -1183,8 +1183,11 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 
 	/* Check if it is AEN packet */
 	hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
-	if (hdr->type == NCSI_PKT_AEN)
-		return ncsi_aen_handler(ndp, skb);
+	if (hdr->type == NCSI_PKT_AEN) {
+		ret = ncsi_aen_handler(ndp, skb);
+		ncsi_dev_put(ndp);
+		return ret;
+	}
 
 	/* Find the handler */
 	for (i = 0; i < ARRAY_SIZE(ncsi_rsp_handlers); i++) {
@@ -1199,7 +1202,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (!nrh) {
-		netdev_err(nd->dev, "Received unrecognized packet (0x%x)\n",
+		netdev_err(ndp->ndev.dev, "Received unrecognized packet (0x%x)\n",
 			   hdr->type);
 		ret = -ENOENT;
 		goto err_free_skb;
@@ -1264,9 +1267,11 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 
 out:
 	ncsi_free_request(nr);
+	ncsi_dev_put(ndp);
 	return ret;
 
 err_free_skb:
 	kfree_skb(skb);
+	ncsi_dev_put(ndp);
 	return ret;
 }
-- 
2.55.0

