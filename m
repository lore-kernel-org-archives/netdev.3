Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1C439340
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725596; cv=none; b=osqsf5IOdGDKpnot4FwoWffzVwai9oLCIwNKBQFUHEFfVRRcnMn6qNhZK3nKS2djzXJqxV5G1aEDCbN9Z8dZjoxN24+/EeN6H10jE8/z8qua4SOY/qiUxEIwCGD7V1Y71poTo1WRhGmeh+RfLL3qKiQbObuhi3kyPDXRFjmdu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725596; c=relaxed/simple;
	bh=QQM7Nr5Sh5F7elvNnwBMJJBFiB8aRONr/cYokr58l+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DusYGoLH/CzFEUYb990bsL93ooerUE4644cW9SCAAmA2XC2/YPFJFx1miTNPXxeXeyXRCm6C/6YbVMpP9u7VFzfxnTIrXEAuTwMKpue8xzqqkrpIrI1KmdrrWmABQ6Bxma5x6nJ4V9hlKfd3/I8Sj4qaOUDQHlvVQ0SsZu1daN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNrZkCwH; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNrZkCwH"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so78791566b.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725590; x=1790330390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Skcngj3xltd7I66fo+kUEQph4TyUSbQVnDmtiBBF2mA=;
        b=oNrZkCwH2iLWZUZ3YsqaHdrVuLgYCbiI83BYo5bYj1qVithxYNeFWRQOCuJNzkEo3C
         aqAW44/9PuoOQaYjdB2A6q+FgMCF12+rzIR4rLQG1y+ZnV3eyVrUeXhkL90Z7STMfiTA
         CQRqqBP6O8hJOxwBA2atcBsHB1bIlDpePM9cKR8pRSarx5WsY+wHALEouKFyBTlKfwLn
         z+ifZ6gOlWpK89HBARS35Bwgs/7z5qAE+YnCnP5jXfoearJ4Xg011hV6tYX8TfFIVCIY
         TqMrlemwHsKk5TYwZr5PYPBe8QMxVRw0K6ldo/NLinr4+isZRIP7a6LEzgU3D7SSsV/k
         dcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725590; x=1790330390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Skcngj3xltd7I66fo+kUEQph4TyUSbQVnDmtiBBF2mA=;
        b=fuDyof04ChLx3GFVN7mM73um0uO5STsIoDsSO09RswoXLvR+ZlikqJOQvOIB2sC39n
         N2GHzdJ8t9ofs7M9JJ9dwbAAr8FOxv1+QMdyWhfSDbNMwx/X7bUdcGhI6mADhH1vzLsf
         pMMY90KY58BPpp2fn9Y6kSbdFa9npV/0MfPJ06HTVhZE6aTvZRARav/h3f8qnUX/KCEZ
         UgpqBie1tsG9rFngSwFkz4cnCPHrqJXO0eqYrFYhD1wVFvXOUS5HJ3dEHcB3glIs9VAn
         XDrRsGFWgz4BOgvLgZxpy+JNrWjVdBfoHguTzcrc/yjVUFiJZvtWd+Ithh+Kg0bHEsj1
         Zsaw==
X-Forwarded-Encrypted: i=1; AKwUvBxGn6a2Sy5c5la/1p1g6l11xDcJY35XGZRha26kbrpubm+44tufVfbXxAhRofx2WOknXW9gs6E=@vger.kernel.org
X-Gm-Message-State: AFuF++kJXyxUGf6C48+88LFgVDsG/S9wynadMfYn4++5UfDmAcNheuCe
	Up1U4Gge5p04ZlWJwkcV3XCYDrdONa1/g2HfWXPThZNaHZa148X0nhAhKnNqAWP8g0w=
X-Gm-Gg: AYBFou2Z35CgQzL/cQ8Umgt4YzuGXFy/73IFvts8XAoWjIEyi6VL6ydUQF0vWbL/gPt
	OWNcE8CZROCN9sdK6G56SWr9sfqhJtFocFj6caEsyn5Q22tHlzH76Un1It3obPs0WHDhMoSPVAQ
	SBy6b1KItM0SHrm1ptuEkbsPuZFOcSBaDoIe1Uw1Z9OCNorfstae9ZjAvi96JOsGkcHgfzrqRFa
	Rxk9ivCwHIQrhhR2T50Ew9vBVYbzd2aOGMkN0W4n8SoVTaAJZ3eX26ByvAAfMYAa+XwAQU+4rnv
	FirIbQy120LeLbksjPaBkawcKeOjgQPIkoRGgCktYVS1v4C/tGEbMgIhi95jWvLFH9RUvWIS8S8
	0kFzxOvavaGjdy6gIbOEHaQlN8pesxnVcJp68e2FRDBl8GgxBFocKV4+INgSZ4kjsXTFD6/CoHK
	HpceQ08gda3jW7YYa7P8jHpvM+/hLWfHlG4V0j2PKSAaIvUdB+482Ys1UM6VSNHOu2RH2Q9ohi4
	RaeeM3DEnxWMpqMSoX9vbiwig9lENvYl3X64e0T5fRey57vK58Ip9lk
X-Received: by 2002:a17:907:1c0f:b0:c29:d62b:fcfa with SMTP id a640c23a62f3a-c2a156590b7mr208809466b.2.1789725589331;
        Fri, 18 Sep 2026 02:59:49 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100a:561b:120d:754d:a140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a99sm38313166b.59.2026.09.18.02.59.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 02:59:48 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bsoares.it@gmail.com>
Subject: [PATCH net v4 1/2] net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
Date: Fri, 18 Sep 2026 10:59:30 +0100
Message-ID: <20260918095931.29792-2-bsoares.it@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918095931.29792-1-bsoares.it@gmail.com>
References: <20260918095931.29792-1-bsoares.it@gmail.com>
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

The same gap exists in the generic recursive lower-device walk used by
attribute changes on a bridge with more than one representor enslaved
directly: mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() is entered
with the bridge master netdevice, falls through to its generic
netdev_for_each_lower_dev() loop, and returns as soon as the recursion
into any one lower device yields a non-NULL rep - the underlying base
case, mlx5_esw_bridge_rep_vport_num_vhca_id_get(), only checks
mlx5_esw_bridge_dev_same_hw(), not ownership by the calling instance's
br_offloads. mlx5_esw_bridge_lag_rep_get(), used for the LAG-master
case, already filters on mlx5_esw_bridge_dev_same_esw() per candidate
and so cannot select a sibling's rep; it is not the source of this bug.
On a merged-eswitch HCA with a bridge spanning representors of more
than one eswitch instance directly, the walk can return a sibling's rep
instead of continuing to the one the calling instance actually owns, so
the attribute change fails the same way as above. Fix by checking
mlx5_esw_bridge_port_exists() at the point each rep is picked, same as
the previous fix did for the notifier filter.

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

