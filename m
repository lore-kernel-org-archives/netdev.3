Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE430E82B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201598; cv=none; b=eaLyTEJQrs38kE8ZAl9sOd8eDpKRwgGkiEj19I1kkYK0P11ZxOgsIgfHlWnRV7QlLQeLKp+yJE7aoLVu06rPLAne00etTGn7Qb7TahvQribon2VwjFK+THdW7zZq7ueQWYZlfgt9B/BR57me2KXP8I2Rm0c/R0OpSohdGhPxzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201598; c=relaxed/simple;
	bh=NnxJn7iu9PTgNV36nRh/hgK00nvli6uUgw5GvZA2zVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3t0SgEwBv8hVXPGHCKHst6Ghws5tR/TMij2c7tA38x1Q5DNFX1gZOlP6FClJa7Ii12wTXhJh66uJ14+A7YYn5TiGDIB+5P8dxcRaJVNYkn2FmiHBxtsCwfia7fthAMwJXNYWYebmgBj/+AEkA1077H/SfODtIlOZqCVBalXUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfRBEejL; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfRBEejL"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4c276e1c7so635020a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791201595; x=1791806395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbsJh2+kTuJ8jg2I7k3oElHIli4suqsPkih2WPC5/5Y=;
        b=DfRBEejL2j/BxRvPrJuHwDzicbAGch5Vg1kBa19xhsr3ZkohQRx5ndAK+bmF22KbhV
         wDdSNj3YgPjTZtt8yiuf47HVnw/RocvQ/JC1RuSXDGa8U6oPk94PekUb6j61JinkkB1c
         snjqY0wMlkDCZj/P5TAaELLStT6awi3zfDFXP7/wobEDi5WaU87WFLBcD6KZe/OVlmbJ
         T0/22THpMbybQRAfphfSTUFEsBPVyflZYK89nBsv+PEg+mn1AjdXya4NW9ifTJr0NxCb
         8RFUl1aXqMNgAh/Qg0DKnu0tSxy9VIE44zQl1qfiKNZtvsNVwRFNRTw83q9jYk9ui5MQ
         K29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201595; x=1791806395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbsJh2+kTuJ8jg2I7k3oElHIli4suqsPkih2WPC5/5Y=;
        b=z7Vu6MHsVh8+yuGC0+5vD9WmY6SDpQZJhwzlVVRm5X1IGoR8Q6uUBvpvARp21cm5aJ
         uFJpGlGoLyLBLsCadGlgI4YtxVo+WPF27taxCd/zFq9KSF1483zZa7ztDgOE2Pod1Tsa
         OEBmC4w34LPnffmEtvufGYuQvJ6Fs6Gq9P8wKSTGVpBKdLHEMVJcNnuwRqdqwIQQPzeu
         2D27lbiYTxEnlUru8/1KU5fqJSvy02KtWWhiNL/6Jgv+yTbyW+Ws8j/LOFKqcc4SIcTm
         N9qaqaKx7hzC2OQiTmOXOzBsfzmQRxtfI3gMcsXM6HnnOaIhZChH+FjLVLuoEQg3rafu
         t/AQ==
X-Gm-Message-State: AFq9FYKH/PPMPi0kKE1kqAxAvU52ZpsFMHlMwVPIKfdIqF1gxtB5JAqD
	S1ugy+lWJBQ2jtdXRD/LignqSd2NJ2+2nih0VsC637tSpP+f1y2rEhjIgrtN22b+
X-Gm-Gg: AYBFou1eCYjwjBK14/5+B8z9ZlqT+jKxSocnppUM+vQvaG5C6XVgJ5VwT1glt0zpuM1
	VJcHidZ97mugZZSukirKI6vAu3HT0eFFraTgwfkPzclw3VuDLlsrqN6I8vSw41+ppEuUIeMYiMB
	9hped8uKuZadU8pkj6LRCd1Zq/7zUV1lQUCcTZ4mCgj+eI6iB8BgH+hWgs25aVXEDTl9w+GgwnE
	MhhJwr3RoxD6LxlVf6go6sNG4/YC6uJQ4nHDiICHOVdER/f9/PuGxawTndDbRa+PYMWIjbDpBw0
	96dAgYOgAQGyxLN7iisttCP9oQQkLwI7qpstp91F1fjipWVUhyr6oGAW9Hc/Ysl8ATA0aMLaG06
	CJs022J1+bITL4wfeJrbJvjt8Ji9mQghutnRl1AGCfUhWcCYaERkFRJh4IOgGMkMtJQiysB1s7S
	Kld1x3ImA5KfiwiVBU2nVnC2zyv9byFeZLb/iEK8rqb78z4aZpG118DOLIkFYuUzG3O2mj
X-Received: by 2002:a17:90b:3e86:b0:3a1:66fd:94af with SMTP id 98e67ed59e1d1-3a6ce7f67b5mr4114381a91.37.1791201595307;
        Mon, 05 Oct 2026 04:59:55 -0700 (PDT)
Received: from fedora ([116.88.36.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d65d85csm10831064a91.4.2026.10.05.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:59:54 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	wongboonjhee52@gmail.com
Subject: [PATCH v8] net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu
Date: Mon,  5 Oct 2026 19:59:44 +0800
Message-ID: <20261005115944.1397670-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCSI device teardown can free packages and channels while RCU readers,
including Netlink handlers, are still using them. Unlink the device from
the global list and wait for RCU readers before freeing its state.

Protect Netlink lookups and VLAN callbacks against concurrent teardown.
Synchronously stop channel-monitor timers before freeing their channels,
including when a timer callback has already cleared the enabled flag.
Remove VLAN entries with RCU-safe list deletion and deferred freeing.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")

Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
v7 -> v8:
- Stop channel monitors and requests synchronously, free outstanding requests and VLAN entries, and keep ftgmac100 teardown ordered around unregister_netdev().
- Recheck channel state and queue membership after stopping the monitor; serialize queue dequeue/state changes to avoid duplicate insertion.
- Protect VLAN channel traversal with RCU read-side sections; handle non-contiguous package IDs and initialize the VLAN selection value.
- Fix Netlink error paths and use borrowed socket network namespaces.

 drivers/net/ethernet/faraday/ftgmac100.c |  10 +-
 net/ncsi/internal.h                      |   1 +
 net/ncsi/ncsi-aen.c                      |  21 ++-
 net/ncsi/ncsi-manage.c                   | 162 +++++++++++++++++------
 net/ncsi/ncsi-netlink.c                  | 101 +++++++++-----
 5 files changed, 218 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6d2fe5c2f390..193f5147ef7a 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2094,8 +2094,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 err:
 	ftgmac100_phy_disconnect(netdev);
-	if (priv->ndev)
+	if (priv->ndev) {
 		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+	}
 	return err;
 }
 
@@ -2107,9 +2109,11 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	netdev = platform_get_drvdata(pdev);
 	priv = netdev_priv(netdev);
 
-	if (priv->ndev)
-		ncsi_unregister_dev(priv->ndev);
 	unregister_netdev(netdev);
+	if (priv->ndev) {
+		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+	}
 
 	/* There's a small chance the reset task will have been re-queued,
 	 * during stop, make sure it's gone before we free the structure.
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..d9f0eadc7a24 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -310,6 +310,7 @@ enum {
 
 struct vlan_vid {
 	struct list_head list;
+	struct rcu_head rcu;
 	__be16 proto;
 	u16 vid;
 };
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 040a31557201..c4025e7f2cf2 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -93,8 +93,16 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
 			ncsi_stop_channel_monitor(nc);
+			spin_lock_irqsave(&nc->lock, flags);
+			if (nc->state != NCSI_CHANNEL_ACTIVE) {
+				spin_unlock_irqrestore(&nc->lock, flags);
+				return 0;
+			}
+			nc->state = NCSI_CHANNEL_INACTIVE;
+			spin_unlock_irqrestore(&nc->lock, flags);
 			spin_lock_irqsave(&ndp->lock, flags);
-			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+			if (list_empty(&nc->link))
+				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 			spin_unlock_irqrestore(&ndp->lock, flags);
 			return ncsi_process_next_channel(ndp);
 		}
@@ -158,12 +166,15 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 
 	ncsi_stop_channel_monitor(nc);
 	spin_lock_irqsave(&nc->lock, flags);
-	nc->state = NCSI_CHANNEL_INVISIBLE;
+	if (nc->state != NCSI_CHANNEL_ACTIVE) {
+		spin_unlock_irqrestore(&nc->lock, flags);
+		return 0;
+	}
+	nc->state = NCSI_CHANNEL_INACTIVE;
 	spin_unlock_irqrestore(&nc->lock, flags);
-
 	spin_lock_irqsave(&ndp->lock, flags);
-	nc->state = NCSI_CHANNEL_INACTIVE;
-	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+	if (list_empty(&nc->link))
+		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
 	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..266b1c4209ba 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
@@ -24,6 +25,7 @@
 
 LIST_HEAD(ncsi_dev_list);
 DEFINE_SPINLOCK(ncsi_dev_lock);
+static DEFINE_MUTEX(ncsi_dev_mutex);
 
 bool ncsi_channel_has_link(struct ncsi_channel *channel)
 {
@@ -152,7 +154,8 @@ static void ncsi_channel_monitor(struct timer_list *t)
 
 		spin_lock_irqsave(&ndp->lock, flags);
 		nc->state = NCSI_CHANNEL_ACTIVE;
-		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+		if (list_empty(&nc->link))
+			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 		spin_unlock_irqrestore(&ndp->lock, flags);
 		ncsi_process_next_channel(ndp);
 		return;
@@ -182,13 +185,10 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&nc->lock, flags);
-	if (!nc->monitor.enabled) {
-		spin_unlock_irqrestore(&nc->lock, flags);
-		return;
-	}
 	nc->monitor.enabled = false;
 	spin_unlock_irqrestore(&nc->lock, flags);
 
+	/* The callback may have cleared enabled and still be running. */
 	timer_delete_sync(&nc->monitor.timer);
 }
 
@@ -640,7 +640,7 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	unsigned long flags;
 	int i, index;
 	void *bitmap;
-	u16 vid;
+	u16 vid = 0;
 
 	if (list_empty(&ndp->vlan_vids))
 		return -1;
@@ -1567,13 +1567,12 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
 		goto out;
 	}
 
+	spin_lock(&nc->lock);
 	list_del_init(&nc->link);
-	spin_unlock_irqrestore(&ndp->lock, flags);
-
-	spin_lock_irqsave(&nc->lock, flags);
 	old_state = nc->state;
 	nc->state = NCSI_CHANNEL_INVISIBLE;
-	spin_unlock_irqrestore(&nc->lock, flags);
+	spin_unlock(&nc->lock);
+	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	ndp->active_channel = nc;
 	ndp->active_package = nc->package;
@@ -1618,11 +1617,13 @@ static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
 	struct ncsi_channel *nc;
 	struct ncsi_package *np;
 	unsigned long flags;
+	bool kicked;
 	unsigned int n = 0;
 
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			spin_lock_irqsave(&nc->lock, flags);
+			spin_lock_irqsave(&ndp->lock, flags);
+			spin_lock(&nc->lock);
 
 			/* Channels may be busy, mark dirty instead of
 			 * kicking if;
@@ -1639,23 +1640,30 @@ static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
 						   nc);
 					nc->reconfigure_needed = true;
 				}
-				spin_unlock_irqrestore(&nc->lock, flags);
+				spin_unlock(&nc->lock);
+				spin_unlock_irqrestore(&ndp->lock, flags);
 				continue;
 			}
 
-			spin_unlock_irqrestore(&nc->lock, flags);
+			spin_unlock(&nc->lock);
+			spin_unlock_irqrestore(&ndp->lock, flags);
 
 			ncsi_stop_channel_monitor(nc);
-			spin_lock_irqsave(&nc->lock, flags);
-			nc->state = NCSI_CHANNEL_INACTIVE;
-			spin_unlock_irqrestore(&nc->lock, flags);
-
 			spin_lock_irqsave(&ndp->lock, flags);
-			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+			spin_lock(&nc->lock);
+			kicked = false;
+			if (nc->state == NCSI_CHANNEL_ACTIVE &&
+			    list_empty(&nc->link)) {
+				nc->state = NCSI_CHANNEL_INACTIVE;
+				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+				kicked = true;
+				n++;
+			}
+			spin_unlock(&nc->lock);
 			spin_unlock_irqrestore(&ndp->lock, flags);
 
-			netdev_dbg(nd->dev, "NCSI: kicked channel %p\n", nc);
-			n++;
+			if (kicked)
+				netdev_dbg(nd->dev, "NCSI: kicked channel %p\n", nc);
 		}
 	}
 
@@ -1669,37 +1677,49 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 	struct vlan_vid *vlan;
 	struct ncsi_dev *nd;
 	bool found = false;
+	int ret;
 
 	if (vid == 0)
 		return 0;
 
+	mutex_lock(&ncsi_dev_mutex);
+	rcu_read_lock();
 	nd = ncsi_find_dev(dev);
+	rcu_read_unlock();
 	if (!nd) {
 		netdev_warn(dev, "NCSI: No net_device?\n");
-		return 0;
+		ret = 0;
+		goto out_unlock;
 	}
 
 	ndp = TO_NCSI_DEV_PRIV(nd);
 
 	/* Add the VLAN id to our internal list */
+	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		n_vids++;
 		if (vlan->vid == vid) {
 			netdev_dbg(dev, "NCSI: vid %u already registered\n",
 				   vid);
-			return 0;
+			rcu_read_unlock();
+			ret = 0;
+			goto out_unlock;
 		}
 	}
+	rcu_read_unlock();
 	if (n_vids >= NCSI_MAX_VLAN_VIDS) {
 		netdev_warn(dev,
 			    "tried to add vlan id %u but NCSI max already registered (%u)\n",
 			    vid, NCSI_MAX_VLAN_VIDS);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto out_unlock;
 	}
 
 	vlan = kzalloc_obj(*vlan);
-	if (!vlan)
-		return -ENOMEM;
+	if (!vlan) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	vlan->proto = proto;
 	vlan->vid = vid;
@@ -1707,47 +1727,66 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 
 	netdev_dbg(dev, "NCSI: Added new vid %u\n", vid);
 
+	rcu_read_lock();
 	found = ncsi_kick_channels(ndp) != 0;
+	rcu_read_unlock();
 
-	return found ? ncsi_process_next_channel(ndp) : 0;
+	ret = found ? ncsi_process_next_channel(ndp) : 0;
+out_unlock:
+	mutex_unlock(&ncsi_dev_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ncsi_vlan_rx_add_vid);
 
 int ncsi_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 {
-	struct vlan_vid *vlan, *tmp;
+	struct vlan_vid *vlan;
 	struct ncsi_dev_priv *ndp;
 	struct ncsi_dev *nd;
 	bool found = false;
+	int ret;
 
 	if (vid == 0)
 		return 0;
 
+	mutex_lock(&ncsi_dev_mutex);
+	rcu_read_lock();
 	nd = ncsi_find_dev(dev);
+	rcu_read_unlock();
 	if (!nd) {
 		netdev_warn(dev, "NCSI: no net_device?\n");
-		return 0;
+		ret = 0;
+		goto out_unlock;
 	}
 
 	ndp = TO_NCSI_DEV_PRIV(nd);
 
 	/* Remove the VLAN id from our internal list */
-	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list)
 		if (vlan->vid == vid) {
 			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
 			list_del_rcu(&vlan->list);
 			found = true;
-			kfree(vlan);
+			kfree_rcu(vlan, rcu);
+			break;
 		}
+	rcu_read_unlock();
 
 	if (!found) {
 		netdev_err(dev, "NCSI: vid %u wasn't registered!\n", vid);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
+	rcu_read_lock();
 	found = ncsi_kick_channels(ndp) != 0;
+	rcu_read_unlock();
 
-	return found ? ncsi_process_next_channel(ndp) : 0;
+	ret = found ? ncsi_process_next_channel(ndp) : 0;
+out_unlock:
+	mutex_unlock(&ncsi_dev_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ncsi_vlan_rx_kill_vid);
 
@@ -1762,14 +1801,21 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	int i;
 
 	/* Check if the device has been registered or not */
+	mutex_lock(&ncsi_dev_mutex);
+	rcu_read_lock();
 	nd = ncsi_find_dev(dev);
-	if (nd)
+	rcu_read_unlock();
+	if (nd) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return nd;
+	}
 
 	/* Create NCSI device */
 	ndp = kzalloc_obj(*ndp, GFP_ATOMIC);
-	if (!ndp)
+	if (!ndp) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return NULL;
+	}
 
 	nd = &ndp->ndev;
 	nd->state = ncsi_dev_state_registered;
@@ -1810,6 +1856,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 			ndp->mlx_multi_host = true;
 	}
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return nd;
 }
 EXPORT_SYMBOL_GPL(ncsi_register_dev);
@@ -1956,19 +2003,56 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc;
+	struct vlan_vid *vlan, *vlan_tmp;
 	unsigned long flags;
+	int i;
 
-	dev_remove_pack(&ndp->ptype);
-
-	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
-		ncsi_remove_package(np);
-
+	mutex_lock(&ncsi_dev_mutex);
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
+	mutex_unlock(&ncsi_dev_mutex);
 
+	dev_remove_pack(&ndp->ptype);
+
+	/* Wait for readers that found this device before it was unlinked. */
+	synchronize_rcu();
 	disable_work_sync(&ndp->work);
 
+	/* Stop channel monitors before releasing request state. */
+	list_for_each_entry(np, &ndp->packages, node) {
+		list_for_each_entry(nc, &np->channels, node)
+			ncsi_stop_channel_monitor(nc);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		struct ncsi_request *nr = &ndp->requests[i];
+
+		timer_delete_sync(&nr->timer);
+		if (!nr->used)
+			continue;
+
+		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN && nr->cmd) {
+			struct ncsi_cmd_pkt *cmd = (struct ncsi_cmd_pkt *)
+				skb_network_header(nr->cmd);
+
+			ncsi_find_package_and_channel(ndp,
+						      cmd->cmd.common.channel,
+						      &np, &nc);
+			ncsi_send_netlink_timeout(nr, np, nc);
+		}
+		ncsi_free_request(nr);
+	}
+
+	list_for_each_entry_safe(vlan, vlan_tmp, &ndp->vlan_vids, list) {
+		list_del_rcu(&vlan->list);
+		kfree_rcu(vlan, rcu);
+	}
+
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..1d9c8a3ef877 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -100,11 +100,6 @@ static int ncsi_write_package_info(struct sk_buff *skb,
 	bool found;
 	int rc;
 
-	if (id > ndp->package_num - 1) {
-		netdev_info(ndp->ndev.dev, "NCSI: No package with id %u\n", id);
-		return -ENODEV;
-	}
-
 	found = false;
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (np->id != id)
@@ -169,19 +164,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(genl_info_net(info),
-			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
-		return -ENODEV;
-
 	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(genl_info_net(info),
+			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
 	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
 			  &ncsi_genl_family, 0, NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 
@@ -190,6 +190,7 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package_id);
@@ -202,10 +203,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	rcu_read_unlock();
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -228,32 +231,39 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	if (!attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(skb->sk),
 			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
 
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = cb->args[0];
 	package = NULL;
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
-		if (np->id == package_id)
+		if (np->id >= package_id &&
+		    (!package || np->id < package->id))
 			package = np;
 
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return 0; /* done */
+	}
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
-		rc = -EMSGSIZE;
-		goto err;
+		rcu_read_unlock();
+		return -EMSGSIZE;
 	}
 
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
-		rc = -EMSGSIZE;
-		goto err;
+		genlmsg_cancel(skb, hdr);
+		rcu_read_unlock();
+		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package->id);
 	if (rc) {
@@ -264,11 +274,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	nla_nest_end(skb, attr);
 	genlmsg_end(skb, hdr);
 
-	cb->args[0] = package_id + 1;
+	cb->args[0] = package->id + 1;
 
-	return skb->len;
+	rc = skb->len;
+	rcu_read_unlock();
+	return rc;
 err:
 	genlmsg_cancel(skb, hdr);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -289,10 +302,13 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -302,6 +318,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			package = np;
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
 		return -ERANGE;
 	}
 
@@ -317,6 +334,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 	}
@@ -350,6 +368,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -365,10 +384,13 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	/* Reset any whitelists and disable multi mode */
 	spin_lock_irqsave(&ndp->lock, flags);
@@ -389,6 +411,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -398,6 +421,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
+	bool rcu_locked = false;
 	u32 package_id;
 	u32 channel_id;
 	int len, ret;
@@ -427,10 +451,14 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 		goto out;
 	}
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	rcu_locked = true;
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp) {
 		ret = -ENODEV;
+		rcu_read_unlock();
+		rcu_locked = false;
 		goto out;
 	}
 
@@ -480,6 +508,8 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      ret);
 	}
 out:
+	if (rcu_locked)
+		rcu_read_unlock();
 	return ret;
 }
 
@@ -608,10 +638,13 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
@@ -639,6 +672,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -663,10 +697,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -675,8 +712,10 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return -ERANGE;
+	}
 
 	spin_lock_irqsave(&package->lock, flags);
 
@@ -690,6 +729,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -721,6 +761,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.55.0

