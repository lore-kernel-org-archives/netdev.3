Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6D2D0602
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429539; cv=none; b=FeM6r0tVrmy8k5Zg390pnoeFJX0One/7mI37+OnnT0dR1+1xtxn/Aa1QQx//bIF2HGS+agwcVNcX0IFAEpO92kJNVtmle6wRPJXNg+Jl0n/GaQl6gwGWCoC3M0Sm7J6miGTtC+PD0zlgSZ1x0gMolTAJPeSNt47EI6vRg7Z8ZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429539; c=relaxed/simple;
	bh=MvMMR1XAmUu1FeBUahya/KoKbNfid+AIrb4T+z5fRKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STv6bvzfeEqEm0dhD8AfRmH48JcDpAYMNZBCcuAGu2U1cM2RdF2TFrGoK9dskRR6nkD3dORjc2d+Fc2deVGpCzajzaWhGy8pMIF3eWhBqb774dESsFERmfvrsUfYOK0b5dC7oSkljyTGUbWRxjUeYJH5qHTVmUoAqTzFfT4/FjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I06GFxwx; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I06GFxwx"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so289773a91.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429537; x=1791034337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxezZeoneSq0Ji3fXCTgnWutf111GaUHnPheqQePnQg=;
        b=I06GFxwxPBuiiVZkd6VmxCZ1YM1MaBKrO0dVlMhH3YG+qNdvOcoGkQu0k2x0PoO+LX
         R9OBR//PjR54Ylnmc2H26bqGuLL7qzoVQJM1DSNRZWStG8Vh+zYKZpZ+PQ/BDST4YGTW
         eUixUeBwM44riJJsB0NSxQc7DwZ8kFpVUv3hMBdcmEgQeZEmWPbW/Z6BdfZeh23Mo8fC
         vhXeSXyTrOIbnMagJ24HCY12nSIeag66A4HCycuwXgE/I+2UNjVmvh4/PhfF4X62Of0q
         L9cOMzfGUyvgP34diKdauIfLZGnPny0OVb3qYV3ntwReZ2xhnAXEUZq4GS88pvZMgw5S
         Pc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429537; x=1791034337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxezZeoneSq0Ji3fXCTgnWutf111GaUHnPheqQePnQg=;
        b=dx+AS+X3Yt3bmcXo6NR7AXjdIOHS+HxKBw9FIaPktg4hS6m0I5VxHuJyhutRR2TUkt
         VNXTkokcBv//gzVnM0jVI5Cbc61h1ZdbhULVy1lqQdVl+ouSL6zsElv+Cp+o1JHH8ECN
         7UEEnRLAq1ExoSI4MVJms5pPBRTqu/ZyQ/oNulk7/nu7x9MJRfBXtwYcaIc0rZAASbOE
         RNQX79noe0Xom3N5ri9RUP6tE0XpPNQbpm/Rqo8iTCj42aiV73LrlOobaBrzQMze61JB
         hqDy1ngeYHnPOH2afJfXPL2Nn58sViYN7cvWtPjaSUkEMhry1IzT4PSmxRnaa5fEsIb1
         AaVA==
X-Gm-Message-State: AFq9FYI3vt6K41zN/o1hrLyqvYC06LwzSSmKQuN52lr6MHFawxDdQHE6
	ve6a443MCZtph4bc6CMx8gxfXRRkeKJhbM9QDn1hAnfVohTDYdP3b0ygCoO0jOAi
X-Gm-Gg: AYBFou1dxx5XK3rngFojJssN1MHeJiFLGxvjeBILxCJZ+hMbK9if/O8hJXGmxkiVKfK
	R0l+qSHz4uDuXxE5y4VMiGbREPoJCKLJ2RXeOkEMbulK4g3LIMqNseNtHl8r4v8ZdqnnAR4lGXN
	V1+81J5l2l3YQ6OT2BZyddSplW1Paqwn3G4UrV6mySZ/Pp39YsXb227J451DGzrVq0RR041u/70
	ohZG8MoYBeTHdzq2BXPFxxQrVe7EXEWRtm57LM6LHwQjy4XFke16TEUi8GFfvTozJwQ0553C0og
	SkfZlMnTdzWPoxGzsnspL4VFT2xfgVeEzToOfEzvKPY/LIuhFYt70HeD8rKM7MImfAn9a5gVCdi
	F7ovDZBEn0X0Uhljta/sgFtq6AylLAzSnprDR7O2R8AsSZKv89khshZsDhaBrNMY0mCnD514Lw2
	vhYapjWHF6PgOfrpEwZslJripAOqdk3MF5QzBF+5DZQm791IyihG6aUE5ACialSSMR3H89zw+Gh
	DmBKhdqBHuQ
X-Received: by 2002:a17:90b:4ad2:b0:3a0:b312:1fb8 with SMTP id 98e67ed59e1d1-3a0b3122489mr4215649a91.6.1790429536813;
        Sat, 26 Sep 2026 06:32:16 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e0784510sm1493024a91.2.2026.09.26.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:32:16 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: [PATCH v7] net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu
Date: Sat, 26 Sep 2026 21:32:01 +0800
Message-ID: <20260926133201.689877-1-wongboonjhee52@gmail.com>
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
v6 -> v7:
- Protect VLAN callbacks from concurrent device teardown and defer VLAN
  entry freeing until RCU readers have completed.
- Synchronize channel-monitor timers even if the callback already cleared
  the enabled flag.
- Use borrowed socket network namespaces in Netlink handlers; remove
  unrelated VLAN and request cleanup from teardown.

 net/ncsi/internal.h     |  1 +
 net/ncsi/ncsi-manage.c  | 96 +++++++++++++++++++++++++++++++----------
 net/ncsi/ncsi-netlink.c | 91 ++++++++++++++++++++++++++++----------
 3 files changed, 142 insertions(+), 46 deletions(-)

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
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..c3d3a448a07c 100644
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
@@ -182,13 +184,10 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
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
 
@@ -1669,37 +1668,49 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
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
@@ -1709,45 +1720,60 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 
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
 
@@ -1762,14 +1788,21 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
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
@@ -1810,6 +1843,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 			ndp->mlx_multi_host = true;
 	}
 
+	mutex_unlock(&ncsi_dev_mutex);
 	return nd;
 }
 EXPORT_SYMBOL_GPL(ncsi_register_dev);
@@ -1956,19 +1990,35 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc;
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
 
+	/* Stop all request producers before draining request state. */
+	list_for_each_entry(np, &ndp->packages, node) {
+		list_for_each_entry(nc, &np->channels, node)
+			ncsi_stop_channel_monitor(nc);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		timer_delete_sync(&ndp->requests[i].timer);
+	}
+
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..202d4547d31d 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -169,19 +169,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
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
 
@@ -190,6 +195,7 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package_id);
@@ -202,10 +208,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	rcu_read_unlock();
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -228,11 +236,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
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
@@ -240,20 +251,23 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		if (np->id == package_id)
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
@@ -266,9 +280,12 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 
 	cb->args[0] = package_id + 1;
 
-	return skb->len;
+	rc = skb->len;
+	rcu_read_unlock();
+	return rc;
 err:
 	genlmsg_cancel(skb, hdr);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -289,10 +306,13 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
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
@@ -302,6 +322,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			package = np;
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
 		return -ERANGE;
 	}
 
@@ -317,6 +338,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 	}
@@ -350,6 +372,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -365,10 +388,13 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
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
@@ -389,6 +415,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -398,6 +425,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
+	bool rcu_locked = false;
 	u32 package_id;
 	u32 channel_id;
 	int len, ret;
@@ -427,10 +455,14 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
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
 
@@ -480,6 +512,8 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      ret);
 	}
 out:
+	if (rcu_locked)
+		rcu_read_unlock();
 	return ret;
 }
 
@@ -608,10 +642,13 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
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
@@ -639,6 +676,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -663,10 +701,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
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
@@ -675,8 +716,10 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return -ERANGE;
+	}
 
 	spin_lock_irqsave(&package->lock, flags);
 
@@ -690,6 +733,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -721,6 +765,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 

base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.55.0
