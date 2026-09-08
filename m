Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB1568554
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884400; cv=none; b=Bb325er3FMQxzLLKcvph7TcLGqRpBRlQVuRUn9G75kqHrVQH6XYMa+rHa+g+MMJ/DIuXtxemmDk1Bdvw9X4nMVeXIiEHwynS1DIDpEzDbIjnssIpOOnclj5iWqCTUmqYKU/rvMJsfhyFqVrCHjqOdy1amu7Gd6oc+cYvrD7hLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884400; c=relaxed/simple;
	bh=mqkNwAA0w02ekmTSEcOpS6fsCLNuaz8vsE8iZJ37atI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RktzqWu0KwZfe3o2VjqFwqxUjUxWa1qdRqYkg48YnVYPf+OOwGc63xH41KU51Cn383W8S5oNBp8VrVH4BZA/hazIg860FN41YXJIaIlG1+aAHrxXrGH+BWEMjv/VV8+klcWTTc5lGDsOcXrWrAsJLCnBcB/azUvH5s2ECh0wtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TWTt5G4q; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TWTt5G4q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=G1LtzQeyyTLTqEOvfXDuoCxdl+zc3ta3A4kdbvTkWlY=; b=TWTt5G4qy7qTTVHfVaSwdplcWI
	9NKtfLv1zHbbVhRrJgSueH2yKc4GGTF9gGmoiV39pyRJVSQGLZX/Ofpe2EkGbqdJRmUkuYITIUFhh
	HdcJqH+AwI5fL5G9FqVLFdkPv6/yAO43MStBbND/HC1xgTXofgUFSc7pPejT5QV3ba4Y1bsjWBY2V
	D4A/ZtjL3+x9b5K/erxL6vpb+D9XXnA6oom3iCrWvMU1Gc/GeDIV6r2VtmOy8DsiMdjB0lzYHYwy9
	uLWwI2am0n84PjI0RGHDeKxJLg83pmkUOdsBfhNFeOPWu+wQGtStZWUCJbFEYq0ZF0hw0BBJJJuu4
	QiXb6Q5Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x3yXz-0005pH-1F;
	Tue, 08 Sep 2026 18:19:47 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	Bernardo Soares <bersoare@isovalent.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [PATCH net] net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
Date: Tue,  8 Sep 2026 18:19:46 +0200
Message-ID: <f26aa63abf085a087f7ed1df9080f9f0982bb311.1788884253.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28117/Tue Sep  8 08:26:31 2026)

From: Bernardo Soares <bersoare@isovalent.com>

mlx5 registers the bridge offload switchdev notifiers once per eswitch
instance, i.e. once per PF, but the switchdev notifier chains are global.
Every registered instance is called for every switchdev event and has to
filter out the events that are not its own.

Since commit c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch
connectivity") that filter is mlx5_esw_bridge_dev_same_hw(), which only
tells that the event netdevice and the eswitch of the instance sit on the
same HCA. This is intentional: with merged eswitch a bridge can span the
representors of several eswitches of one HCA, and each instance keeps the
ports of its sibling eswitches as peer ports in order to offload FDB
entries pointing at them.

However, the instance may not have the port at all. Peer ports are only
created from NETDEV_CHANGEUPPER events observed while the instance is
already registered, and only when merged_eswitch is supported. So when
more than one PF of the same HCA runs bridge offload and the PF that is
put in switchdev mode last has the uplink of an earlier configured PF
already enslaved to a bridge, that instance has no port for it.

The switchdev port object and attribute handlers do not check for this.
They claim the event via port_obj_info->handled and pass the
vport_num/esw_owner_vhca_id pair down, where the port lookup fails and
-EINVAL is returned. call_switchdev_blocking_notifiers() stops the chain
on the error and it is reported to user space, even though the instance
owning the port has already offloaded the request:

  # bridge vlan add dev ens1f2np2 vid 999 master
  RTNETLINK answers: Invalid argument

The same applies to bridge vlan del, mdb add/del and to the bridge
attributes (ageing time, vlan filtering, vlan protocol, mcast). Thus
fix by filter on the port instead. We tested that this fixes the issue
on ConnectX-7.

Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
Signed-off-by: Bernardo Soares <bersoare@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
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

