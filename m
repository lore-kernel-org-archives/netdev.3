Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF92367B60
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785094; cv=none; b=YwomlzEI6TSHgRAVbIlFjzIDcwxC9mpuyBgbboX8cxBiiYTtKDfBp0cK8HQOoNhf1ygvILwVy/+pIh//1nKBLKcAhhmmds2cibcc+pDLCp99Emkil/APyPGzuazmB30e34GA1JZPDyXcgCF22xbwp1D9e7nCKfHTr1Eo7pKTTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785094; c=relaxed/simple;
	bh=Lnpl8QkNrNnJXHNnW30vJHk7Gb3yHrhHJLxs2uLzIS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRqSgB/hkt4d5WR/Enb7noBu3LJAJoRmBm+MGw942jNH8NN17kDNpchX0dbkC8eMvCdMTgiDck4gTX3VVMmCBL97u+ER6whpkEl2x/kDbc6GgusQqnslQurF6V/QY0scNM33RSUnWjPf0en2u2lfoAixQrYb9btaa0DppNNMNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+K94cug; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+K94cug"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso639325a91.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791785091; x=1792389891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lq1g9tbRNoRmlpmv+DYsr8gVEEolEwzNV4RTVW+b/7s=;
        b=n+K94cug21Nz3l+svE3YUpbxgmLNir7JV1rLQlEwm91G10a2VM+gJYDqVxgZ/ChjV4
         xBsr32Gs5iVu4Ud2CGVxIzrcus1DESJxS15TrMlrl1xuqV9lGEUgafu2tdConuBGe0M/
         mC8MC3M/kVKuJoWurxa67EIGbIGyKdrPitATiD3Ic1fSWwTrEyc+84boHbqLJBhwNiuY
         Yzc1Qf71RTZ5IXucKWV/YM/j9TaaYk6umFvySaz7s6+cyEwMzNoKXYusrLeA/EPJH+xM
         9KEJKL8E/Qpd7N/nMpGtKWJ/FJ523FWCYqMltnpEHa+NVWm0qsMm3zW22e3QSjgEvA7u
         hdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791785091; x=1792389891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lq1g9tbRNoRmlpmv+DYsr8gVEEolEwzNV4RTVW+b/7s=;
        b=WxF0+WNhosMLb25U/xKnoQqFh0ermZbt8qD4+cYoafYX10Eroc5wKFoaALfT6L8L/9
         kLXHdaNNPCjzeHTLNkS7npvPf1KmSq6HsbjbPx7Kf4/mXgI3/lesbIYv/Tifex7Hbs/r
         Tzenkwr1adWV/64U8lgcnir8qNpf0241gT9MrntdnU3aLv/SBuBvUIs+czsgJYWbQspz
         dvRyQXhBC2CCM9h4MsEmzmlWoFcCggl2KRUNcB2eWL4BA6krkGfCX1x3R2A1MWc8gdE9
         gsY9zGV3XPxqhaQ4oNsiuPJXxIPxyVilgKjZPK4Y2LP4FS+RZVw79AIDXaVMy0ULsoXf
         vUlA==
X-Gm-Message-State: AFq9FYL+zpu3dO0y4UPCXHALGxSCxzZnNVxdr0mVpUkDqxKGHf2w+Qdr
	3ze/UMXGhk8696BuSkzLbdf7l//dA1EhLPtMjNHWy3XKxmr1Xng639VUpyV+YEVB
X-Gm-Gg: AYBFou3jXWDjqDF+hZIUj4k0gknkOGpeQl7drvSjg7luyoQf+uPeybRsDBj85iHVLPq
	Uvwt3GPSI2vMm4knhjjl2WLk9KjpRqtEMkKCLTLzWPT+G/eTz1vRHc7CoCG6v0wfSkEPreWKU2J
	e1MZvQXl7jqv/d8eZ1Gu+SRmRnVEW9kOMCOsuq+5VfDMIOI3nCQQkS+eqdDDu/Ua5j4iB6TPrE8
	ibVQkzVBIfouGc9LnH7kak5aP5XgdUaSvKTYeSDTHWjmwnK8myfmQ290wVGtW8oywRnL732vnDp
	yxQ9yhMkzx8VLZJ5MRgQtW0XHiQcVhJ+lOQv7pF70TL3u5o5/YXTIS2x+gaykNCjhlqUgyF7yO9
	n5IoORS2JcBb6z9Ev174n9GDoRjOq3YQWOsxLcVXtOgzMmw5H+k/9XVeplxruMDN7bvcCmYZdEF
	aPJDJWz1YcKezT0reokQTBplzwGVGqXGXXBkKhqlvEJM8SYYJwo8RVsNtbIGPDEMyhEJyzhA==
X-Received: by 2002:a17:90b:314e:b0:3a4:cb6d:aca9 with SMTP id 98e67ed59e1d1-3ab3acdda28mr6371170a91.64.1791785091293;
        Sun, 11 Oct 2026 23:04:51 -0700 (PDT)
Received: from fedora ([116.88.36.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32c0f59bsm9286062a91.0.2026.10.11.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:04:50 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: [PATCH v10] net/ncsi: Fix use-after-free in NCSI teardown
Date: Mon, 12 Oct 2026 14:04:34 +0800
Message-ID: <20261012060434.1974740-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlink NCSI devices from the global list and wait for RCU readers before
freeing packages and channels. Protect read-only Netlink package-info
lookups with RCU; serialize mutating Netlink and VLAN operations with
teardown using ncsi_dev_mutex. Stop channel monitors and request timers
synchronously.

Remove the leaked network-namespace references from the Netlink handlers.
Allow PKG_INFO to handle sparse package IDs by removing the package_num
range check and advancing dump cursors across gaps. Avoid cancelling a
NULL generic-Netlink header, and read timeout package IDs from the skb
network header. Initialize VLAN ID selection, free pending requests and
VLAN entries at unregister, and guard channel queue additions against
duplicates. Keep channel state and queue transitions under a consistent
ndp-before-channel lock order, and preserve the suspend path for
single-channel link loss.

Split ftgmac100 NCSI removal into preparation and final cleanup. Before
unregister_netdev(), remove NCSI lookups and packet reception, then drain
work and timers. Keep the NCSI allocation alive through
unregister_netdev() because ndo_stop() still calls ncsi_stop_dev(); free
NCSI state after unregister_netdev() returns.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")

Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c |  10 +-
 include/net/ncsi.h                       |   9 +
 net/ncsi/internal.h                      |   5 +
 net/ncsi/ncsi-aen.c                      |  32 ++-
 net/ncsi/ncsi-manage.c                   | 271 +++++++++++++++++------
 net/ncsi/ncsi-netlink.c                  | 111 +++++++---
 6 files changed, 332 insertions(+), 106 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6d2fe5c2f390..f45388810570 100644
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
 
@@ -2108,8 +2110,12 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	priv = netdev_priv(netdev);
 
 	if (priv->ndev)
-		ncsi_unregister_dev(priv->ndev);
+		ncsi_unregister_dev_prepare(priv->ndev);
 	unregister_netdev(netdev);
+	if (priv->ndev) {
+		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+	}
 
 	/* There's a small chance the reset task will have been re-queued,
 	 * during stop, make sure it's gone before we free the structure.
diff --git a/include/net/ncsi.h b/include/net/ncsi.h
index e886358207aa..049c02b61169 100644
--- a/include/net/ncsi.h
+++ b/include/net/ncsi.h
@@ -37,6 +37,11 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 				   void (*notifier)(struct ncsi_dev *nd));
 int ncsi_start_dev(struct ncsi_dev *nd);
 void ncsi_stop_dev(struct ncsi_dev *nd);
+/*
+ * Remove NCSI lookups and packet reception before unregistering the netdev.
+ * The object remains valid until ncsi_unregister_dev() completes teardown.
+ */
+void ncsi_unregister_dev_prepare(struct ncsi_dev *nd);
 void ncsi_unregister_dev(struct ncsi_dev *nd);
 #else /* !CONFIG_NET_NCSI */
 static inline int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
@@ -64,6 +69,10 @@ static inline void ncsi_stop_dev(struct ncsi_dev *nd)
 {
 }
 
+static inline void ncsi_unregister_dev_prepare(struct ncsi_dev *nd)
+{
+}
+
 static inline void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 }
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..8a53e6ccbd9a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -6,6 +6,8 @@
 #ifndef __NCSI_INTERNAL_H__
 #define __NCSI_INTERNAL_H__
 
+#include <linux/mutex.h>
+
 enum {
 	NCSI_CAP_BASE		= 0,
 	NCSI_CAP_GENERIC	= 0,
@@ -310,12 +312,14 @@ enum {
 
 struct vlan_vid {
 	struct list_head list;
+	struct rcu_head rcu;
 	__be16 proto;
 	u16 vid;
 };
 
 struct ncsi_dev_priv {
 	struct ncsi_dev     ndev;            /* Associated NCSI device     */
+	bool                unregister_prepared;
 	unsigned int        flags;           /* NCSI device flags          */
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
 #define NCSI_DEV_HWA		2            /* Enabled HW arbitration     */
@@ -367,6 +371,7 @@ struct ncsi_cmd_arg {
 
 extern struct list_head ncsi_dev_list;
 extern spinlock_t ncsi_dev_lock;
+extern struct mutex ncsi_dev_mutex;
 
 #define TO_NCSI_DEV_PRIV(nd) \
 	container_of(nd, struct ncsi_dev_priv, ndev)
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 040a31557201..c3614f064864 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -64,7 +64,8 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	/* Update the link status */
 	lsc = (struct ncsi_aen_lsc_pkt *)h;
 
-	spin_lock_irqsave(&nc->lock, flags);
+	spin_lock_irqsave(&ndp->lock, flags);
+	spin_lock(&nc->lock);
 	ncm = &nc->modes[NCSI_MODE_LINK];
 	old_data = ncm->data[2];
 	data = ntohl(lsc->status);
@@ -79,7 +80,8 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 
 	chained = !list_empty(&nc->link);
 	state = nc->state;
-	spin_unlock_irqrestore(&nc->lock, flags);
+	spin_unlock(&nc->lock);
+	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	if (state == NCSI_CHANNEL_INACTIVE)
 		netdev_warn(ndp->ndev.dev,
@@ -94,7 +96,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
 			ncsi_stop_channel_monitor(nc);
 			spin_lock_irqsave(&ndp->lock, flags);
-			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+			spin_lock(&nc->lock);
+			if (nc->state == NCSI_CHANNEL_ACTIVE &&
+			    list_empty(&nc->link))
+				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+			spin_unlock(&nc->lock);
 			spin_unlock_irqrestore(&ndp->lock, flags);
 			return ncsi_process_next_channel(ndp);
 		}
@@ -148,22 +154,28 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	if (!nc)
 		return -ENODEV;
 
-	spin_lock_irqsave(&nc->lock, flags);
+	spin_lock_irqsave(&ndp->lock, flags);
+	spin_lock(&nc->lock);
 	if (!list_empty(&nc->link) ||
 	    nc->state != NCSI_CHANNEL_ACTIVE) {
-		spin_unlock_irqrestore(&nc->lock, flags);
+		spin_unlock(&nc->lock);
+		spin_unlock_irqrestore(&ndp->lock, flags);
 		return 0;
 	}
-	spin_unlock_irqrestore(&nc->lock, flags);
+	spin_unlock(&nc->lock);
+	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	ncsi_stop_channel_monitor(nc);
-	spin_lock_irqsave(&nc->lock, flags);
-	nc->state = NCSI_CHANNEL_INVISIBLE;
-	spin_unlock_irqrestore(&nc->lock, flags);
-
 	spin_lock_irqsave(&ndp->lock, flags);
+	spin_lock(&nc->lock);
+	if (nc->state != NCSI_CHANNEL_ACTIVE || !list_empty(&nc->link)) {
+		spin_unlock(&nc->lock);
+		spin_unlock_irqrestore(&ndp->lock, flags);
+		return 0;
+	}
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+	spin_unlock(&nc->lock);
 	spin_unlock_irqrestore(&ndp->lock, flags);
 	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..f84e7da098fe 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
@@ -24,6 +25,8 @@
 
 LIST_HEAD(ncsi_dev_list);
 DEFINE_SPINLOCK(ncsi_dev_lock);
+/* Serializes NCSI device lookups and mutations with teardown. */
+DEFINE_MUTEX(ncsi_dev_mutex);
 
 bool ncsi_channel_has_link(struct ncsi_channel *channel)
 {
@@ -64,21 +67,25 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 	nd->link_up = 0;
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			spin_lock_irqsave(&nc->lock, flags);
+			spin_lock_irqsave(&ndp->lock, flags);
+			spin_lock(&nc->lock);
 
 			if (!list_empty(&nc->link) ||
 			    nc->state != NCSI_CHANNEL_ACTIVE) {
-				spin_unlock_irqrestore(&nc->lock, flags);
+				spin_unlock(&nc->lock);
+				spin_unlock_irqrestore(&ndp->lock, flags);
 				continue;
 			}
 
 			if (ncsi_channel_has_link(nc)) {
-				spin_unlock_irqrestore(&nc->lock, flags);
+				spin_unlock(&nc->lock);
+				spin_unlock_irqrestore(&ndp->lock, flags);
 				nd->link_up = 1;
 				goto report;
 			}
 
-			spin_unlock_irqrestore(&nc->lock, flags);
+			spin_unlock(&nc->lock);
+			spin_unlock_irqrestore(&ndp->lock, flags);
 		}
 	}
 
@@ -98,12 +105,14 @@ static void ncsi_channel_monitor(struct timer_list *t)
 	unsigned long flags;
 	int state, ret;
 
-	spin_lock_irqsave(&nc->lock, flags);
+	spin_lock_irqsave(&ndp->lock, flags);
+	spin_lock(&nc->lock);
 	state = nc->state;
 	chained = !list_empty(&nc->link);
 	enabled = nc->monitor.enabled;
 	monitor_state = nc->monitor.state;
-	spin_unlock_irqrestore(&nc->lock, flags);
+	spin_unlock(&nc->lock);
+	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	if (!enabled)
 		return;		/* expected race disabling timer */
@@ -151,8 +160,11 @@ static void ncsi_channel_monitor(struct timer_list *t)
 		spin_unlock_irqrestore(&nc->lock, flags);
 
 		spin_lock_irqsave(&ndp->lock, flags);
+		spin_lock(&nc->lock);
 		nc->state = NCSI_CHANNEL_ACTIVE;
-		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+		if (list_empty(&nc->link))
+			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+		spin_unlock(&nc->lock);
 		spin_unlock_irqrestore(&ndp->lock, flags);
 		ncsi_process_next_channel(ndp);
 		return;
@@ -182,13 +194,10 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
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
 
@@ -640,7 +649,7 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	unsigned long flags;
 	int i, index;
 	void *bitmap;
-	u16 vid;
+	u16 vid = 0;
 
 	if (list_empty(&ndp->vlan_vids))
 		return -1;
@@ -1238,7 +1247,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_channel *nc, *found, *hot_nc;
 	struct ncsi_channel_mode *ncm;
-	unsigned long flags, cflags;
+	unsigned long flags;
 	struct ncsi_package *np;
 	bool with_link;
 
@@ -1260,11 +1269,13 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 			if (!(np->channel_whitelist & (0x1 << nc->id)))
 				continue;
 
-			spin_lock_irqsave(&nc->lock, cflags);
+			spin_lock_irqsave(&ndp->lock, flags);
+			spin_lock(&nc->lock);
 
 			if (!list_empty(&nc->link) ||
 			    nc->state != NCSI_CHANNEL_INACTIVE) {
-				spin_unlock_irqrestore(&nc->lock, cflags);
+				spin_unlock(&nc->lock);
+				spin_unlock_irqrestore(&ndp->lock, flags);
 				continue;
 			}
 
@@ -1285,10 +1296,8 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 			 * so they will have AENs enabled.
 			 */
 			if (with_link || np->multi_channel) {
-				spin_lock_irqsave(&ndp->lock, flags);
 				list_add_tail_rcu(&nc->link,
 						  &ndp->channel_queue);
-				spin_unlock_irqrestore(&ndp->lock, flags);
 
 				netdev_dbg(ndp->ndev.dev,
 					   "NCSI: Channel %u added to queue (link %s)\n",
@@ -1296,7 +1305,8 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 					   ncm->data[2] & 0x1 ? "up" : "down");
 			}
 
-			spin_unlock_irqrestore(&nc->lock, cflags);
+			spin_unlock(&nc->lock);
+			spin_unlock_irqrestore(&ndp->lock, flags);
 
 			if (with_link && !np->multi_channel)
 				break;
@@ -1305,19 +1315,24 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 			break;
 	}
 
+	spin_lock_irqsave(&ndp->lock, flags);
 	if (list_empty(&ndp->channel_queue) && found) {
 		netdev_info(ndp->ndev.dev,
 			    "NCSI: No channel with link found, configuring channel %u\n",
 			    found->id);
-		spin_lock_irqsave(&ndp->lock, flags);
-		list_add_tail_rcu(&found->link, &ndp->channel_queue);
-		spin_unlock_irqrestore(&ndp->lock, flags);
+		spin_lock(&found->lock);
+		if (found->state == NCSI_CHANNEL_INACTIVE &&
+		    list_empty(&found->link))
+			list_add_tail_rcu(&found->link, &ndp->channel_queue);
+		spin_unlock(&found->lock);
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
@@ -1567,13 +1582,12 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
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
@@ -1615,14 +1629,49 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
 static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
+	struct ncsi_channel *batch[NCSI_MAX_CHANNEL];
+	struct ncsi_channel *last = NULL;
 	struct ncsi_channel *nc;
 	struct ncsi_package *np;
 	unsigned long flags;
-	unsigned int n = 0;
+	bool kicked;
+	unsigned int n = 0, count, i;
 
-	NCSI_FOR_EACH_PACKAGE(ndp, np) {
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			spin_lock_irqsave(&nc->lock, flags);
+	lockdep_assert_held(&ncsi_dev_mutex);
+
+	/*
+	 * Keep the RCU read-side section limited to list traversal. Kicking a
+	 * channel synchronously stops its monitor timer and must happen outside
+	 * the read-side section. The caller holds ncsi_dev_mutex, so the package
+	 * and channel objects remain alive while each batch is processed.
+	 */
+	do {
+		bool past_last = !last;
+
+		count = 0;
+		rcu_read_lock();
+		NCSI_FOR_EACH_PACKAGE(ndp, np) {
+			NCSI_FOR_EACH_CHANNEL(np, nc) {
+				if (!past_last) {
+					if (nc == last)
+						past_last = true;
+					continue;
+				}
+
+				batch[count++] = nc;
+				if (count == ARRAY_SIZE(batch)) {
+					last = nc;
+					goto batch_full;
+				}
+			}
+		}
+batch_full:
+		rcu_read_unlock();
+
+		for (i = 0; i < count; i++) {
+			nc = batch[i];
+			spin_lock_irqsave(&ndp->lock, flags);
+			spin_lock(&nc->lock);
 
 			/* Channels may be busy, mark dirty instead of
 			 * kicking if;
@@ -1639,25 +1688,32 @@ static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
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
-	}
+	} while (count == ARRAY_SIZE(batch));
 
 	return n;
 }
@@ -1669,37 +1725,49 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
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
@@ -1709,45 +1777,60 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 
 	found = ncsi_kick_channels(ndp) != 0;
 
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
 
 	found = ncsi_kick_channels(ndp) != 0;
 
-	return found ? ncsi_process_next_channel(ndp) : 0;
+	ret = found ? ncsi_process_next_channel(ndp) : 0;
+out_unlock:
+	mutex_unlock(&ncsi_dev_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ncsi_vlan_rx_kill_vid);
 
@@ -1762,14 +1845,21 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
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
@@ -1810,6 +1900,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 			ndp->mlx_multi_host = true;
 	}
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return nd;
 }
 EXPORT_SYMBOL_GPL(ncsi_register_dev);
@@ -1851,10 +1942,12 @@ void ncsi_stop_dev(struct ncsi_dev *nd)
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			ncsi_stop_channel_monitor(nc);
 
-			spin_lock_irqsave(&nc->lock, flags);
+			spin_lock_irqsave(&ndp->lock, flags);
+			spin_lock(&nc->lock);
 			chained = !list_empty(&nc->link);
 			old_state = nc->state;
-			spin_unlock_irqrestore(&nc->lock, flags);
+			spin_unlock(&nc->lock);
+			spin_unlock_irqrestore(&ndp->lock, flags);
 
 			WARN_ON_ONCE(chained ||
 				     old_state == NCSI_CHANNEL_INVISIBLE);
@@ -1952,22 +2045,74 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 	return 0;
 }
 
+void ncsi_unregister_dev_prepare(struct ncsi_dev *nd)
+{
+	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
+	struct ncsi_package *np;
+	struct ncsi_channel *nc;
+	int i;
+	unsigned long flags;
+
+	mutex_lock(&ncsi_dev_mutex);
+	if (!ndp->unregister_prepared) {
+		ndp->unregister_prepared = true;
+		spin_lock_irqsave(&ncsi_dev_lock, flags);
+		list_del_rcu(&ndp->node);
+		spin_unlock_irqrestore(&ncsi_dev_lock, flags);
+
+		dev_remove_pack(&ndp->ptype);
+
+		/* Wait for lookups that found this device before it was unlinked. */
+		synchronize_rcu();
+
+		/* Quiesce NCSI activity before the netdev is stopped. */
+		disable_work_sync(&ndp->work);
+		list_for_each_entry(np, &ndp->packages, node)
+			list_for_each_entry(nc, &np->channels, node)
+				ncsi_stop_channel_monitor(nc);
+		for (i = 0; i < ARRAY_SIZE(ndp->requests); i++)
+			timer_delete_sync(&ndp->requests[i].timer);
+	}
+	mutex_unlock(&ncsi_dev_mutex);
+}
+EXPORT_SYMBOL_GPL(ncsi_unregister_dev_prepare);
+
 void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
-	unsigned long flags;
+	struct ncsi_channel *nc;
+	struct vlan_vid *vlan, *vlan_tmp;
+	int i;
 
-	dev_remove_pack(&ndp->ptype);
+	ncsi_unregister_dev_prepare(nd);
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		struct ncsi_request *nr = &ndp->requests[i];
 
-	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
-		ncsi_remove_package(np);
+		if (!nr->used)
+			continue;
 
-	spin_lock_irqsave(&ncsi_dev_lock, flags);
-	list_del_rcu(&ndp->node);
-	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
+		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN && nr->cmd) {
+			struct ncsi_cmd_pkt *cmd = (struct ncsi_cmd_pkt *)
+				skb_network_header(nr->cmd);
+
+			rcu_read_lock();
+			ncsi_find_package_and_channel(ndp,
+						      cmd->cmd.common.channel,
+						      &np, &nc);
+			rcu_read_unlock();
+			ncsi_send_netlink_timeout(nr, np, nc);
+		}
+		ncsi_free_request(nr);
+	}
 
-	disable_work_sync(&ndp->work);
+	list_for_each_entry_safe(vlan, vlan_tmp, &ndp->vlan_vids, list) {
+		list_del_rcu(&vlan->list);
+		kfree_rcu(vlan, rcu);
+	}
+
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
 
 	kfree(ndp);
 }
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..9d821cc22062 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -47,7 +47,9 @@ static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
 		return NULL;
 	}
 
+	rcu_read_lock();
 	nd = ncsi_find_dev(dev);
+	rcu_read_unlock();
 	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
 
 	dev_put(dev);
@@ -100,11 +102,6 @@ static int ncsi_write_package_info(struct sk_buff *skb,
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
@@ -169,19 +166,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
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
 
@@ -190,6 +192,7 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package_id);
@@ -202,10 +205,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	rcu_read_unlock();
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -228,32 +233,39 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
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
@@ -264,11 +276,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
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
 
@@ -289,34 +304,43 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	mutex_lock(&ncsi_dev_mutex);
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
+	rcu_read_unlock();
 	if (!package) {
 		/* The user has set a package that does not exist */
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ERANGE;
 	}
 
 	channel = NULL;
 	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
 		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
+		rcu_read_lock();
 		NCSI_FOR_EACH_CHANNEL(package, nc)
 			if (nc->id == channel_id) {
 				channel = nc;
 				break;
 			}
+		rcu_read_unlock();
 		if (!channel) {
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			mutex_unlock(&ncsi_dev_mutex);
 			return -ERANGE;
 		}
 	}
@@ -350,6 +374,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return 0;
 }
 
@@ -365,10 +390,13 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	mutex_lock(&ncsi_dev_mutex);
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ENODEV;
+	}
 
 	/* Reset any whitelists and disable multi mode */
 	spin_lock_irqsave(&ndp->lock, flags);
@@ -376,6 +404,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	ndp->multi_package = false;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		spin_lock_irqsave(&np->lock, flags);
 		np->multi_channel = false;
@@ -383,12 +412,14 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		np->preferred_channel = NULL;
 		spin_unlock_irqrestore(&np->lock, flags);
 	}
+	rcu_read_unlock();
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
 	/* Update channel configuration */
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return 0;
 }
 
@@ -427,10 +458,12 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 		goto out;
 	}
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	mutex_lock(&ncsi_dev_mutex);
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp) {
 		ret = -ENODEV;
+		mutex_unlock(&ncsi_dev_mutex);
 		goto out;
 	}
 
@@ -479,6 +512,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      info->nlhdr,
 				      ret);
 	}
+	mutex_unlock(&ncsi_dev_mutex);
 out:
 	return ret;
 }
@@ -553,7 +587,7 @@ int ncsi_send_netlink_timeout(struct ncsi_request *nr,
 	else
 		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID,
 			    NCSI_PACKAGE_INDEX((((struct ncsi_pkt_hdr *)
-						 nr->cmd->data)->channel)));
+						 skb_network_header(nr->cmd))->channel)));
 
 	if (nc)
 		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, nc->id);
@@ -608,10 +642,13 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	mutex_lock(&ncsi_dev_mutex);
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ENODEV;
+	}
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
@@ -639,6 +676,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return rc;
 }
 
@@ -663,33 +701,43 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	mutex_lock(&ncsi_dev_mutex);
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id) {
 			package = np;
 			break;
 		}
-	if (!package)
+	rcu_read_unlock();
+	if (!package) {
+		mutex_unlock(&ncsi_dev_mutex);
 		return -ERANGE;
+	}
 
 	spin_lock_irqsave(&package->lock, flags);
 
 	channel = NULL;
 	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
 		channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
+		rcu_read_lock();
 		NCSI_FOR_EACH_CHANNEL(np, nc)
 			if (nc->id == channel_id) {
 				channel = nc;
 				break;
 			}
+		rcu_read_unlock();
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			mutex_unlock(&ncsi_dev_mutex);
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -721,6 +769,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return 0;
 }
 
-- 
2.55.0

