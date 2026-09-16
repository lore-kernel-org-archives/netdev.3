Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BD4BEE2C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555663; cv=none; b=hpBuLRTyKyl/cLXr8qkehDa3AU5HLjE/FLq8yEmLI7ENxf3r37tFvkYYW3ebFmB9P/AOU5kVofu4pWM9Shxac0nr731vIkDpQXziG4GLa98EIEDit3WAmPaBD3X1A8WvzHgvjEQHmgjLVn7KBaTdJfruqMwUDXOCtmHRvFqC2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555663; c=relaxed/simple;
	bh=d4b0xpDrxku9YsACAd+D8Y0zySP4jwRk9XGuLcNhcgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn8YXQ0DLL0t6lrHNLLhp/oQQ4F94iIFDounuQq6Yl9n+sA/ina7Hkl3fkT4DB/Ip2K5XgfTbtfKUOxA87i7XtUG9eWtWGX7d8fJ0E4jV3fwA2YuND2GyKiO1fb9o/mFxdemQhjstw2Jl5jUWieGi6gs/b+RWpwn/FkcgkHKYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPraPSjb; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPraPSjb"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f9f7db0so117178666b.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789555648; x=1790160448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UsHRuNcnEHJn/WZVmEnQSfXguHgGsjpGYN+zq0iq0aQ=;
        b=rPraPSjbvr5mA/QCVhCqc1LsZsF9pOn4hejfx6ulPM/okpDffk+z+W6e+OaRZYRpnk
         m3EBE86GnMSIjkCi1cwHcFJJUBO4Quar0Ovg/LKMXcBtLTiQXs+9jQHCjj/hxayr0bz5
         cQuW0psJdDvKL4tLAOPhilrDAdzF7KEftUtJK8hdVCyDuzVo8DVCINWrvPPQVTHBT9ZS
         12CntpGB4+0k+1StxsSwuOUItTk+794Vluv2giFIAJ45YmHiiJAo5H7nthgv4q7S7jIM
         0ZqwRulG2FaWmPRY9zqnZpLa+3XN/xcWFwsie8RnFz6RRX8h4LsYuQA7QZ53XYt2r7nw
         SIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789555648; x=1790160448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UsHRuNcnEHJn/WZVmEnQSfXguHgGsjpGYN+zq0iq0aQ=;
        b=HyV6CPXwhV3I5zyE2PIs4YvJR28o97HcWuYObA0lkwh/mK+4oOXCEyXFF9aEstCsYr
         cHh3aCQUu2L3vkxXn7gnvdplE/VvdhWe/IERY91Kpn54R3FPUDwMVJFLnUi52nvIGBoe
         YFfd6NwQtitt2DUhkzcfLFQT4rzWF4RcsCAzipPJVV3zl04ESuhWG5u+CTphh/3WyaKk
         NB3+FYdYrINBK9+mh0pbV43AlKLA105CdFr+3jweFTGDOZSr0RsR6xwePNLaQKm8srQA
         OO1wOp1k6D0bqT/e7FYKrJtcBx4ty+mQywc6sXzUYb9upP22A97aXySdMQnoKE8JHdPO
         ORhw==
X-Forwarded-Encrypted: i=1; AKwUvBxueuiA18o3u+l4iBFwiO5VzGc/CdnV+Qz20+mZRvWVPXxhTjex7JoTZMM/aWwPnAOOlCaoT+k=@vger.kernel.org
X-Gm-Message-State: AFuF++lpwoCuumq5Dj4debZtSjh5ODZUrGOGitEsa+0DBUE6DuMerh38
	QRvNNyCPF+woIX5eoK0vCXwc1Z3nwSulPWZMwt3S4YmIrUVZZA/AjApUfCEa/+I1MLk=
X-Gm-Gg: AYBFou2szgcXrc52AjXBP96o/lMdQB98a+IRzGqFwtS6EjaN1/INsY176x/fNsCjk1B
	zeiARKoHGl3XfLSrenpc020T9mZkq5ktsHMkbia4C88p8GswxLUwczA0RIuojjOCqrv3bSWxmCV
	hKXUOvsiqN3U2yIWjiszcgSZSZGqLZS9G3lu8Bcpo88vQcfQtJFYOfDTJhZL6prPEPUELrPvMgz
	W/zzqrH4t2cdAaLocsavY8ETOsFVEKd8TL9WVUztiqUFhGNwB75xNmUlI9KHwddP0pxEEK0Dxus
	V6UfK1IfyQyktYxdneObSOKlC46HJONrj0Gk8mIhxQ7RTX1PTwazIn0m6vG5Pf2nllzLAR2JSPP
	PtoAwNHNfbf1nI/c5p7zsSTnTCmQqh3ahagLKRSannrSXuRAj+Mhdj0L4lxAISeBXsHqXFqr6jf
	RjqJx2mazvNItPGQcKl4e7ItaLpyGTxd+VxwVJ0GFpXBk+97rMnn5bUi5Ht0zeMYrENKjykgoQs
	Si/wtfr1//7lEl+TU2+w6d4LgkI2wBdWOc6+9ONt8qv5YNQME+m3Tc/
X-Received: by 2002:a17:907:9721:b0:c24:b11c:6c05 with SMTP id a640c23a62f3a-c29e52b6b04mr146667666b.14.1789555647617;
        Wed, 16 Sep 2026 03:47:27 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:994b:30b9:46d9:46de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0851ebsm108520266b.4.2026.09.16.03.47.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 03:47:26 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v3 1/2] net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
Date: Wed, 16 Sep 2026 11:46:53 +0100
Message-ID: <20260916104654.31901-2-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916104654.31901-1-bsoares.it@gmail.com>
References: <20260916104654.31901-1-bsoares.it@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 registers the bridge offload switchdev notifiers once per eswitch
instance, but the notifier chains are global, so every instance sees
every event and must filter out the ones that aren't its own. The
existing filter, mlx5_esw_bridge_dev_same_hw(), only checks that the
event netdevice sits on the same HCA - intentional for merged eswitch,
where one bridge can span representors of several eswitches on one
HCA - but same-HCA doesn't mean the instance actually has that port:
peer ports are only created reactively from NETDEV_CHANGEUPPER, so an
instance brought up after a sibling PF's port was already enslaved has
none. The port object and attribute handlers claim the event anyway
once same-HW passes, then fail the port lookup and return -EINVAL,
which gets reported to user space even though the owning instance
already handled it (e.g. "bridge vlan add ... RTNETLINK answers:
Invalid argument"). Fix by filtering on the tracked port instead.

The same gap exists in the LAG bond lookup used by attribute changes
on a bonded uplink: mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get()
walks the bond's lower devices and returns the first rep that's
structurally eligible (same HCA, is a rep), without checking it's
tracked by the calling instance's br_offloads. Lower devices are
appended in enslavement order (__netdev_adjacent_dev_insert() uses
list_add_tail_rcu()), so on a merged-eswitch HCA where a bond spans
reps of more than one eswitch instance, whichever rep was enslaved
first wins the walk regardless of which instance's br_offloads is
doing the lookup. If a sibling's rep was enslaved first, this returns
that rep instead of continuing to the one this instance actually owns
- reached via mlx5_esw_bridge_port_obj_attr_set(), so a bridge
attribute change on a bonded uplink can silently no-op on the right
instance depending on enslavement order. Fix the same way, by checking
mlx5_esw_bridge_port_exists() at the point each rep is picked.

Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  6 +++
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index baac38bece14..4b7b0a0fc2b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -85,9 +85,16 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
 	struct net_device *lower_dev;
 	struct list_head *iter;
 
-	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev))
-		return mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
-								 esw_owner_vhca_id);
+	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev)) {
+		struct net_device *rep;
+
+		rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
+								esw_owner_vhca_id);
+		if (rep && !mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id,
+							esw->br_offloads))
+			return NULL;
+		return rep;
+	}
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
 		struct net_device *rep;
@@ -104,6 +111,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
 	return NULL;
 }
 
+static bool mlx5_esw_bridge_rep_port_lookup(struct net_device *dev,
+					    struct mlx5_esw_bridge_offloads *br_offloads,
+					    u16 *vport_num, u16 *esw_owner_vhca_id)
+{
+	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
+						       esw_owner_vhca_id))
+		return false;
+
+	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
+}
+
+static bool mlx5_esw_bridge_lower_rep_port_lookup(struct net_device *dev,
+						  struct mlx5_esw_bridge_offloads *br_offloads,
+						  u16 *vport_num, u16 *esw_owner_vhca_id)
+{
+	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
+							     esw_owner_vhca_id))
+		return false;
+
+	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
+}
+
 static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *rep,
 				     struct mlx5_eswitch *esw)
 {
@@ -218,8 +247,7 @@ mlx5_esw_bridge_port_obj_add(struct net_device *dev,
 	u16 vport_num, esw_owner_vhca_id;
 	int err;
 
-	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
-						       &esw_owner_vhca_id))
+	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
 		return 0;
 
 	port_obj_info->handled = true;
@@ -251,8 +279,7 @@ mlx5_esw_bridge_port_obj_del(struct net_device *dev,
 	const struct switchdev_obj_port_mdb *mdb;
 	u16 vport_num, esw_owner_vhca_id;
 
-	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
-						       &esw_owner_vhca_id))
+	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
 		return 0;
 
 	port_obj_info->handled = true;
@@ -283,8 +310,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
 	u16 vport_num, esw_owner_vhca_id;
 	int err = 0;
 
-	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
-							     &esw_owner_vhca_id))
+	if (!mlx5_esw_bridge_lower_rep_port_lookup(dev, br_offloads, &vport_num,
+						   &esw_owner_vhca_id))
 		return 0;
 
 	port_attr_info->handled = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 87b5fd349594..ac90ccda1272 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1686,6 +1686,12 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
 					    extack);
 }
 
+bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
+				 struct mlx5_esw_bridge_offloads *br_offloads)
+{
+	return mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
+}
+
 int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
 				  struct mlx5_esw_bridge_offloads *br_offloads,
 				  struct netlink_ext_ack *extack)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index d6f539161993..a4e59cc21089 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -80,6 +80,8 @@ int mlx5_esw_bridge_vlan_proto_set(u16 vport_num, u16 esw_owner_vhca_id, u16 pro
 				   struct mlx5_esw_bridge_offloads *br_offloads);
 int mlx5_esw_bridge_mcast_set(u16 vport_num, u16 esw_owner_vhca_id, bool enable,
 			      struct mlx5_esw_bridge_offloads *br_offloads);
+bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
+				 struct mlx5_esw_bridge_offloads *br_offloads);
 int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
 				  struct mlx5_esw_bridge_offloads *br_offloads,
 				  struct netlink_ext_ack *extack);
-- 
2.43.0

