Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F638B143
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376103; cv=none; b=npFauYYErJRZ0ADiGHHxODdgxtE7CQDzAIbeBSDBganYfxAzieFbaoXfUwsZFOxeFGmTPrrYZYlPr0C/mK7fVt9U413/BpD5W2s/9u9ot/8FVLfGooNjdMhw00XnG9aq26xj99oNImbp1lC7YLoMoJ44LfdACHyuMz1RM7xVAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376103; c=relaxed/simple;
	bh=dGdxcf0bfNUwlrXDRB6pfb5vlQpqe4KSwpNTzbr75QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyEsXj9d3qk97LbSm8nFYFx2awJCdQgk+zEa4gbL0DgcUc5Ixw2xeQU2ynXBPkBSRIaoKmKfTS+4rzUKddebgoroVoODnF194kLsK6+noF1VKhblwsieLBjY/ercWD+x5xnT9NeSBaCwjXrSjHIgD4914ZgdhGJ0Ebb6smzD4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/4BtY10; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/4BtY10"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so204544166b.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376093; x=1789980893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLQiJ9yGRl0oJ6Ca33WgUYQ7olAFeJjl54Lxb+t+q2Q=;
        b=F/4BtY10DuxXX7SlJYL4La0mE16b6Xw2B09+kF1JvQSYeWCWdPCxT+Nnci6fy4QDwR
         CGrNSIdHiNx6kLrvtPVcYqy6eweyZTjWoBqorbiCZcUZfQsLcx9nRAjrCbonkHUrQyz6
         RZa/hZZCqqOatJhh+pYc7UBj9Dps7e4EbQFAzo2Uo7Arf7PQxnivUt7znIa+f2YC6gIy
         uR/3eQMapZqfThvu3LPam/d2dEt2IDGrbYi92r15NizpxRJZLm2XNUmuLhirIZ4OfO9E
         WHCt1oEbQqjmXrlasCo8Txzx288fcIFeAAn7Y5TBwpnj+bQKnHcsnuXoUc7nA+gjCMgj
         DxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376093; x=1789980893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLQiJ9yGRl0oJ6Ca33WgUYQ7olAFeJjl54Lxb+t+q2Q=;
        b=Sevef0ipIq3PXI2202VYZYxKOQjobfRj0MDIIPk3cuDWyNyaCkfxQZeCZsAg/aH4lW
         nPEF0M8ENrl4cOnh+R8spYzD/4giKYOKya4dA4eJXgkf4W+PIFDVfPeeAfrhwmayXzeZ
         IiywKIxIOe+Jh79okxvu6zuz7d3K2ShTxjKZUBLb/CMh8+CjVTgjBuoDPsxx2oFGylWO
         y5pSkpoKr5SSSiTJaRvFsJVB6o/be8fkIumG6HmdQAAqiFd67BJd6pGLVH61Pp0U52yl
         h3RqXhsEmoL9JY9/QSDwCMpXXKhcq6nUuvL+hd7TKmlzGT9RWWdOFxs3IAPg6C+q5u72
         xKjw==
X-Forwarded-Encrypted: i=1; AKwUvBzcGwJiSDpQzalrEfMNxyxaLccgWGCs/gwVciCD1/eMNtbty7XXZ00idmkFmKs7E4fNCsmKQaM=@vger.kernel.org
X-Gm-Message-State: AFuF++noy2D2v02Iug4Aq+Oq4bjOfuO1ehqtL0vNoHPo/B3BVEnCx9f4
	MTdnlPvvvf8+WRrBwb3RbUOwrr35VdY9qnDrbxrdge/fF4r2akXxZvGE
X-Gm-Gg: AYBFou2Gyn7nzBUnT+2DwZQvhowshcF5TtTwc9QRLOffFaUOs8IQ+RvutAbMoW/u8W5
	Xi0oa6iw2kP/+zV2wtjez8wTuelDLv8S+3qMRatZAYhdaOY9bcDwrviFUrRs5AzIiEG3McdQ5th
	q/2FhXDy5SjJcuwL02a1IfxXPGY+m7fT1BeLwjgeKcNxAXOiRrocr7bg4rV/8x29vkSbjDdOrd1
	PjiLih5P7E8HnWJwkTGv8Qv6tmsN5JkN9SP2NkEU442vb0DSA/Xsvifdfp6qrZBxgK+t3ztf5FG
	fq5q5Y662+49f4GbpK/J9SRzT2JRkBV9y6w2jywFB5bCQLQkxaZXzOUcxmgxy68Mt+MMS/+S/QO
	lSkiYGWGY7g4PGD9OuVsAhy+WjzWEGurAOWGHw09EQB0v96BskGDLuQpW6HnIbbJxyo687gNsXD
	nR7XWcC+araPLHJgyTDk8eoElOFF74HUQxf1SXJrT5QhQLohaFrdnkIvUHR/xU91Rq5Zr73OMA8
	kASwKIRD22krkysSAIHUv6d+q0+EIvCNaoPsrtgPX6UcdFHY36NY+iJN2MkcHWoa0KF
X-Received: by 2002:a17:907:961a:b0:c25:34c7:44d1 with SMTP id a640c23a62f3a-c29b8050791mr104499766b.0.1789376093041;
        Mon, 14 Sep 2026 01:54:53 -0700 (PDT)
Received: from BERSOARE-M-K4D5.cisco.com ([2603:5004:20a0:100c:4701:1ac4:1c21:4a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm101378466b.47.2026.09.14.01.54.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 01:54:52 -0700 (PDT)
From: Bernardo Soares <bsoares.it@gmail.com>
X-Google-Original-From: Bernardo Soares <bersoare@isovalent.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	Vlad Buslov <vladbu@nvidia.com>,
	Bernardo Soares <bersoare@isovalent.com>
Subject: [PATCH net v2 1/3] net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
Date: Mon, 14 Sep 2026 09:54:28 +0100
Message-ID: <20260914085430.18694-2-bersoare@isovalent.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914085430.18694-1-bersoare@isovalent.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
 <20260914085430.18694-1-bersoare@isovalent.com>
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

Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
Signed-off-by: Bernardo Soares <bersoare@isovalent.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
---
v2: unchanged, resending as part of the series alongside the two
    follow-up fixes raised in review (patches 2 and 3).
---

 .../mellanox/mlx5/core/en/rep/bridge.c        | 32 +++++++++++++++----
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  6 ++++
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 ++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index baac38bece14..56592e2e6b9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -104,6 +104,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
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
@@ -218,8 +240,7 @@ mlx5_esw_bridge_port_obj_add(struct net_device *dev,
 	u16 vport_num, esw_owner_vhca_id;
 	int err;
 
-	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
-						       &esw_owner_vhca_id))
+	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
 		return 0;
 
 	port_obj_info->handled = true;
@@ -251,8 +272,7 @@ mlx5_esw_bridge_port_obj_del(struct net_device *dev,
 	const struct switchdev_obj_port_mdb *mdb;
 	u16 vport_num, esw_owner_vhca_id;
 
-	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
-						       &esw_owner_vhca_id))
+	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
 		return 0;
 
 	port_obj_info->handled = true;
@@ -283,8 +303,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
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

