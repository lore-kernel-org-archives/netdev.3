Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F74A1387
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437335; cv=none; b=WWLm8c35sZ+zLDNhJQjqIOuEXicSw07gMKiFBTM3pbEysFmpl45CmQnF/eS9IUKc2+mXXRNXdWlhk5tcp6sE/FXURo03/2qOd7aD23J0KnQCdcoIjsndNv4voKLXEHOi0GzArY+dDVvCxdlZellbreJ9TDblcZWqcf3OoLOS7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437335; c=relaxed/simple;
	bh=2gempg7LqK2WcJDua/Rg11ddUiqoufa9qq34B7ZRbxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AfuaH7cP7JwdZnNZ/x2/aBab3bnFNx1ycA8ULLr88gU1OtxIVCRsvPuperY0pjEHBoj7xxuVi7wZlcbz+9Plejv2lCUyc1uh86AYJ8B7AycbrRgJZ6qFcVg+cjTY9nkzDZZ21g9tAZVgmFlbP3pr/fi2gRiXlWjegGLV19tpA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZiyCYnj; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZiyCYnj"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ef04756caso43382691cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437331; x=1789042131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYqCf5Zf4TD6NF61rdwkZrwAkFFxnV3mK0J/L7yL5Ns=;
        b=bZiyCYnjQr7/W8Gk9uwXp+z6lKDkpH2dfg9JGTxOMshcy5/4/AoVaQKpal4E4emEzK
         8pqfUSEX0efng6GOGlOja/5BifPU1rq1jcGpZByiwr+MNqjTrjmelB1/swF/X6Mexyem
         tvyxE6gm5nKnZhrAwK21/DTqsg8d/YFVUABKRn2ryWlL7IjnOCCiVcnYKpspqcZu0rsE
         iXN0JdoIFDdzlhFgUdSpDDULmH8IvWHbkzLZoexeMnrmLk0HDNKi0qzEziVpO793rKrr
         gk+UCOy9CqnCVQB8t/b1OnZH3+6z2r/cv7i2Hz2ioCTUaaT6pZUsUZDV5wjpnwaYU5sk
         HnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437331; x=1789042131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYqCf5Zf4TD6NF61rdwkZrwAkFFxnV3mK0J/L7yL5Ns=;
        b=CNA1qTL/dHK+ZyYTvLRMW8ZnBs+mO6bTCUatFiBuYSX6o7H1HgNG1e9SlHVlYfWY68
         39Oz/ylXuOWqppr5alkVqsX3MEXgVnTep4p52TtdM5j0cb28reN9zWUCWcXyLdoGnjJu
         FIycpS3WC1btpjBY5CyysXrekwwRay3Qw1mU4fD1W+3zWP+1LPEU4MN7EFAEvQmg8IeP
         xIqK9GFOFWbKOLivtxxE9pn3auxXY0kFv1gxlA7q7o4xNlwHYDbJOem32X2gqhxDmVM9
         sso/PDlZ4rMmu1T7ZPYgUBaV6WJFy7+/4ys54bDjOwXAZAerfow8l3zvsr0Q95mlvgRC
         qq1w==
X-Forwarded-Encrypted: i=1; AKwUvByiv751eik8Xpi5i1nuw42SaO5sGcz5q+Rb3dZWgUwJBlYZmYwc8B4DIn/tdovdP1+adCD+3TQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ksQd3N8VzC7Ul/6LUBHeHxXDPB5/0j1MhBa8ewY1WmHLQaBsu6
	w8GUZibHajJhDfIP4B4+JYWjcSQbRBgn+fzaoZxJjLZ951EJRtUovEFhTvtbF7z3ya/3HI/OCAE
	n2pkBHWlr1HvlSQ==
X-Received: from qtrd21.prod.google.com ([2002:ac8:47d5:0:b0:52f:a270:602])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1448:b0:52f:a446:2469 with SMTP id d75a77b69052e-53036bc6aa8mr119738181cf.15.1788437330729;
 Thu, 03 Sep 2026 05:08:50 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:37 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-7-edumazet@google.com>
Subject: [PATCH net-next 6/9] vxlan: dynamically allocate struct vxlan_config
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move 'struct vxlan_config' from an embedded structure inside
'struct vxlan_dev' to a dynamically allocated pointer 'vxlan->cfg'.

Updating configuration via vxlan_changelink() or vxlan_dev_configure()
now allocates a new struct vxlan_config and frees the previous one.

This prepares the ground for converting vxlan->cfg to RCU protection
in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |   4 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  16 +-
 drivers/net/vxlan/vxlan_core.c                | 244 ++++++++++++------
 drivers/net/vxlan/vxlan_mdb.c                 |   6 +-
 drivers/net/vxlan/vxlan_multicast.c           |   6 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  14 +-
 include/net/vxlan.h                           |   2 +-
 7 files changed, 187 insertions(+), 105 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 52c2fe3644d4b9b27f1d589d9f7f597748339782..4db0efc376a8ef4d373b693240e041a708278b96 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -60,7 +60,7 @@ static bool mlxsw_sp_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve,
 					   struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	struct vxlan_config *cfg = vxlan->cfg;
 
 	if (vxlan_addr_multicast(&cfg->remote_ip)) {
 		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Multicast destination IP is not supported");
@@ -149,7 +149,7 @@ static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
 				      struct mlxsw_sp_nve_config *config)
 {
 	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	struct vxlan_config *cfg = vxlan->cfg;
 
 	config->type = MLXSW_SP_NVE_TYPE_VXLAN;
 	config->ttl = cfg->ttl;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index fe45e533a4b2efb532b85960009c586a53ade340..a22228bd95c90ae8a481ba2f07f2a38689266b78 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2515,7 +2515,7 @@ mlxsw_sp_bridge_vlan_aware_vxlan_join(struct mlxsw_sp_bridge_device *bridge_devi
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
 	struct mlxsw_sp_nve_params params = {
 		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg.vni,
+		.vni = vxlan->cfg->vni,
 		.dev = vxlan_dev,
 		.ethertype = ethertype,
 	};
@@ -2706,7 +2706,7 @@ mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bridge_device *bridge_device,
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
 	struct mlxsw_sp_nve_params params = {
 		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg.vni,
+		.vni = vxlan->cfg->vni,
 		.dev = vxlan_dev,
 		.ethertype = ETH_P_8021Q,
 	};
@@ -2936,7 +2936,7 @@ static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_fid *fid;
 
 	/* If the VxLAN device is down, then the FID does not have a VNI */
-	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg.vni);
+	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg->vni);
 	if (!fid)
 		return;
 
@@ -3033,7 +3033,7 @@ static void mlxsw_sp_fdb_vxlan_call_notifiers(struct net_device *dev,
 	type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE :
 			SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE;
 	mlxsw_sp_switchdev_addr_vxlan_convert(proto, addr, &info.remote_ip);
-	info.remote_port = vxlan->cfg.dst_port;
+	info.remote_port = vxlan->cfg->dst_port;
 	info.remote_vni = vni;
 	info.remote_ifindex = 0;
 	ether_addr_copy(info.eth_addr, mac);
@@ -3237,7 +3237,7 @@ __mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
 	if (adding && netif_is_vxlan(dev)) {
 		struct vxlan_dev *vxlan = netdev_priv(dev);
 
-		if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		if (!(vxlan->cfg->flags & VXLAN_F_LEARN))
 			return -EINVAL;
 	}
 
@@ -3722,7 +3722,7 @@ mlxsw_sp_switchdev_vxlan_work_prepare(struct mlxsw_sp_switchdev_event_work *
 {
 	struct vxlan_dev *vxlan = netdev_priv(switchdev_work->dev);
 	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
-	struct vxlan_config *cfg = &vxlan->cfg;
+	struct vxlan_config *cfg = vxlan->cfg;
 	struct netlink_ext_ack *extack;
 
 	extack = switchdev_notifier_info_to_extack(info);
@@ -3851,7 +3851,7 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg.vni;
+	__be32 vni = vxlan->cfg->vni;
 	struct mlxsw_sp_fid *fid;
 	u16 old_vid;
 	int err;
@@ -3935,7 +3935,7 @@ mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
 				  const struct net_device *vxlan_dev, u16 vid)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg.vni;
+	__be32 vni = vxlan->cfg->vni;
 	struct mlxsw_sp_fid *fid;
 
 	if (!netif_running(vxlan_dev))
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0fcc7282e69d08c4b94ce89ce99feeee576fabff..af320173a1e7f598dbe81a90beb0e68c7ed8c482 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -110,20 +110,23 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 		vni = 0;
 
 	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
+		const struct vxlan_config *cfg;
+
 		if (!node->vxlan)
 			continue;
+
+		cfg = node->vxlan->cfg;
+
 		vnode = NULL;
-		if (node->vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			vnode = vxlan_vnifilter_lookup(node->vxlan, vni);
 			if (!vnode)
 				continue;
-		} else if (node->vxlan->default_dst.remote_vni != vni) {
+		} else if (cfg->vni != vni) {
 			continue;
 		}
 
 		if (IS_ENABLED(CONFIG_IPV6)) {
-			const struct vxlan_config *cfg = &node->vxlan->cfg;
-
 			if ((cfg->flags & VXLAN_F_IPV6_LINKLOCAL) &&
 			    cfg->remote_ifindex != ifindex)
 				continue;
@@ -157,6 +160,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			  u32 portid, u32 seq, int type, unsigned int flags,
 			  const struct vxlan_rdst *rdst)
 {
+	const struct vxlan_config *cfg = vxlan->cfg;
 	unsigned long now = jiffies;
 	struct nda_cacheinfo ci;
 	bool send_ip, send_eth;
@@ -216,10 +220,10 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			goto nla_put_failure;
 
 		if (rdst->remote_port &&
-		    rdst->remote_port != vxlan->cfg.dst_port &&
+		    rdst->remote_port != cfg->dst_port &&
 		    nla_put_be16(skb, NDA_PORT, rdst->remote_port))
 			goto nla_put_failure;
-		if (rdst->remote_vni != vxlan->default_dst.remote_vni &&
+		if (rdst->remote_vni != cfg->vni &&
 		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
 			goto nla_put_failure;
 		if (rdst->remote_ifindex &&
@@ -227,7 +231,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			goto nla_put_failure;
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && fdb->key.vni &&
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) && fdb->key.vni &&
 	    nla_put_u32(skb, NDA_SRC_VNI,
 			be32_to_cpu(fdb->key.vni)))
 		goto nla_put_failure;
@@ -418,7 +422,7 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	lockdep_assert_held_once(&vxlan->hash_lock);
 
 	rcu_read_lock();
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, vxlan->cfg, mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -459,7 +463,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, vxlan->cfg, eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -865,12 +869,13 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		     u32 nhid, struct vxlan_fdb **fdb,
 		     struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = vxlan->cfg;
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
 	int rc;
 
-	if (vxlan->cfg.addrmax &&
-	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+	if (cfg->addrmax &&
+	    vxlan->addrcnt >= cfg->addrmax)
 		return -ENOSPC;
 
 	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
@@ -1150,6 +1155,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			   __be32 *vni, u32 *ifindex, u32 *nhid,
 			   struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = vxlan->cfg;
 	struct net *net = dev_net(vxlan->dev);
 	int err;
 
@@ -1166,7 +1172,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			return err;
 		}
 	} else {
-		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+		const union vxlan_addr *remote = &cfg->remote_ip;
 
 		if (remote->sa.sa_family == AF_INET) {
 			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -1186,7 +1192,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*port = nla_get_be16(tb[NDA_PORT]);
 	} else {
-		*port = vxlan->cfg.dst_port;
+		*port = cfg->dst_port;
 	}
 
 	if (tb[NDA_VNI]) {
@@ -1196,7 +1202,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
 	} else {
-		*vni = vxlan->default_dst.remote_vni;
+		*vni = cfg->vni;
 	}
 
 	if (tb[NDA_SRC_VNI]) {
@@ -1206,7 +1212,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
 	} else {
-		*src_vni = vxlan->default_dst.remote_vni;
+		*src_vni = cfg->vni;
 	}
 
 	if (tb[NDA_IFINDEX]) {
@@ -1396,18 +1402,23 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 			 struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 	__be32 vni;
 	int err;
 
+	cfg = vxlan->cfg;
+
 	if (tb[NDA_VNI])
 		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
+	else if (cfg)
+		vni = cfg->vni;
 	else
-		vni = vxlan->default_dst.remote_vni;
+		return -ENODEV;
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1510,6 +1521,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 
 static void vxlan_sock_release(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = vxlan->cfg;
 	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
 #if IS_ENABLED(CONFIG_IPV6)
 	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
@@ -1519,7 +1531,7 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vs_del_vnigrp(vxlan);
 	else
 		vxlan_vs_del_dev(vxlan);
@@ -1692,7 +1704,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	cfg = &vxlan->cfg;
+	cfg = vxlan->cfg;
+
 	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
 	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
 		/* If the header uses bits besides those enabled by the
@@ -1848,7 +1861,8 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb,
+		      const struct vxlan_config *cfg, __be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct arphdr *parp;
@@ -1861,7 +1875,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 
 	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+		vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
@@ -1902,7 +1916,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 		neigh_ha_snapshot(ha, n, n->dev);
 
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1928,11 +1942,11 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
 
-	} else if (flags & VXLAN_F_L3MISS) {
+	} else if (cfg->flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin.sin_addr.s_addr = tip,
 			.sin.sin_family = AF_INET,
@@ -2040,7 +2054,8 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	return reply;
 }
 
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb,
+			const struct vxlan_config *cfg, __be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
@@ -2074,7 +2089,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 		}
 
 		neigh_ha_snapshot(ha, n, n->dev);
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2093,10 +2108,10 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
-	} else if (flags & VXLAN_F_L3MISS) {
+	} else if (cfg->flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin6.sin6_addr = msg->target,
 			.sin6.sin6_family = AF_INET6,
@@ -2278,7 +2293,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 			       const struct vxlan_config *src_cfg,
 			       __be32 vni, bool snoop)
 {
-	const struct vxlan_config *dst_cfg = &dst_vxlan->cfg;
+	const struct vxlan_config *dst_cfg;
 	union vxlan_addr loopback;
 	unsigned int len = skb->len;
 	struct net_device *dev = dst_vxlan->dev;
@@ -2299,7 +2314,8 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	rcu_read_lock();
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	dst_cfg = dst_vxlan->cfg;
+	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
@@ -2765,7 +2781,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 nhid = 0;
 	u32 flags;
 
-	cfg = &vxlan->cfg;
+	cfg = vxlan->cfg;
 	flags = cfg->flags;
 	default_vni = cfg->vni;
 	saddr_family = cfg->saddr.sa.sa_family;
@@ -2791,7 +2807,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (flags & VXLAN_F_PROXY) {
 		eth = eth_hdr(skb);
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, vni, flags);
+			return arp_reduce(dev, skb, cfg, vni);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
 			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
@@ -2801,7 +2817,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 			if (m->icmph.icmp6_code == 0 &&
 			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni, flags);
+				return neigh_reduce(dev, skb, cfg, vni);
 		}
 #endif
 	}
@@ -2884,12 +2900,15 @@ static void vxlan_cleanup(struct timer_list *t)
 {
 	struct vxlan_dev *vxlan = timer_container_of(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 
 	if (!netif_running(vxlan->dev))
 		return;
 
 	rcu_read_lock();
+	cfg = vxlan->cfg;
+
 	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		unsigned long timeout;
 
@@ -2899,7 +2918,7 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
-		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
+		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node)) {
@@ -2943,13 +2962,16 @@ static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
 static int vxlan_init(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int err;
 
+	cfg = vxlan->cfg;
+
 	err = rhashtable_init(&vxlan->fdb_hash_tbl, &vxlan_fdb_rht_params);
 	if (err)
 		return err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+	if (cfg->flags & VXLAN_F_VNIFILTER) {
 		err = vxlan_vnigroup_init(vxlan);
 		if (err)
 			goto err_rhashtable_destroy;
@@ -2969,7 +2991,7 @@ static int vxlan_init(struct net_device *dev)
 err_gro_cells_destroy:
 	gro_cells_destroy(&vxlan->gro_cells);
 err_vnigroup_uninit:
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
 err_rhashtable_destroy:
 	rhashtable_destroy(&vxlan->fdb_hash_tbl);
@@ -2979,10 +3001,13 @@ static int vxlan_init(struct net_device *dev)
 static void vxlan_uninit(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
+
+	cfg = vxlan->cfg;
 
 	vxlan_mdb_fini(vxlan);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vnigroup_uninit(vxlan);
 
 	gro_cells_destroy(&vxlan->gro_cells);
@@ -2994,6 +3019,7 @@ static void vxlan_uninit(struct net_device *dev)
 static int vxlan_open(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int ret;
 
 	ret = vxlan_sock_add(vxlan);
@@ -3006,7 +3032,8 @@ static int vxlan_open(struct net_device *dev)
 		return ret;
 	}
 
-	if (vxlan->cfg.age_interval)
+	cfg = vxlan->cfg;
+	if (cfg && cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
 
 	return ret;
@@ -3028,8 +3055,10 @@ struct vxlan_fdb_flush_desc {
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 				       const struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = vxlan->cfg;
+
 	return is_zero_ether_addr(f->key.eth_addr) &&
-	       f->key.vni == vxlan->cfg.vni;
+	       f->key.vni == cfg->vni;
 }
 
 static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
@@ -3247,14 +3276,18 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
+	const struct vxlan_config *cfg;
+	struct net_device *lowerdev;
+
+	cfg = vxlan->cfg;
+
+	lowerdev = __dev_get_by_index(vxlan->net, dst->remote_ifindex);
 
 	/* This check is different than dev->max_mtu, because it looks at
 	 * the lowerdev->mtu, rather than the static dev->max_mtu
 	 */
 	if (lowerdev) {
-		int max_mtu = lowerdev->mtu - vxlan_headroom(vxlan->cfg.flags);
+		int max_mtu = lowerdev->mtu - vxlan_headroom(cfg->flags);
 		if (new_mtu > max_mtu)
 			return -EINVAL;
 	}
@@ -3267,11 +3300,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
+	const struct vxlan_config *cfg;
 	__be16 sport, dport;
 
-	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				  vxlan->cfg.port_max, true);
-	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
+	cfg = vxlan->cfg;
+
+	sport = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
+				  cfg->port_max, true);
+	dport = info->key.tp_dst ? : cfg->dst_port;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
@@ -3381,6 +3417,14 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 	}
 }
 
+static void vxlan_free_dev(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+
+	kfree(vxlan->cfg);
+	vxlan->cfg = NULL;
+}
+
 /* Initialize the device structure. */
 static void vxlan_setup(struct net_device *dev)
 {
@@ -3389,6 +3433,8 @@ static void vxlan_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 	ether_setup(dev);
 
+	dev->priv_destructor = vxlan_free_dev;
+
 	dev->needs_free_netdev = true;
 	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
 
@@ -3671,21 +3717,22 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
+	const struct vxlan_config *cfg = vxlan->cfg;
+	bool metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
 	struct vxlan_sock *vs = NULL;
 	struct vxlan_dev_node *node;
 	int l3mdev_index = 0;
 
 	ASSERT_RTNL();
 
-	if (vxlan->cfg.remote_ifindex)
+	if (cfg->remote_ifindex)
 		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
-			vxlan->net, vxlan->cfg.remote_ifindex);
+			vxlan->net, cfg->remote_ifindex);
 
-	if (!vxlan->cfg.no_share) {
+	if (!cfg->no_share) {
 		rcu_read_lock();
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
-				     vxlan->cfg.dst_port, vxlan->cfg.flags,
+				     cfg->dst_port, cfg->flags,
 				     l3mdev_index);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			rcu_read_unlock();
@@ -3695,7 +3742,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 	}
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
-					 vxlan->cfg.dst_port, vxlan->cfg.flags,
+					 cfg->dst_port, cfg->flags,
 					 l3mdev_index);
 	if (IS_ERR(vs))
 		return PTR_ERR(vs);
@@ -3710,7 +3757,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		node = &vxlan->hlist4;
 	}
 
-	if (metadata && (vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (metadata && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vs_add_vnigrp(vxlan, vs, ipv6);
 	else
 		vxlan_vs_add_dev(vs, vxlan, node);
@@ -3720,11 +3767,14 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
-	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
-	bool ipv4 = !ipv6 || metadata;
+	const struct vxlan_config *cfg = vxlan->cfg;
+	bool metadata, ipv6, ipv4;
 	int ret = 0;
 
+	metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
+	ipv6 = (cfg->flags & VXLAN_F_IPV6) || metadata;
+	ipv4 = !ipv6 || metadata;
+
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
@@ -3748,22 +3798,27 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 	struct vxlan_dev *tmp;
 
 	list_for_each_entry(tmp, &vn->vxlan_list, next) {
+		const struct vxlan_config *tmp_cfg;
+
 		if (tmp == vxlan)
 			continue;
-		if (tmp->cfg.flags & VXLAN_F_VNIFILTER) {
+
+		tmp_cfg = tmp->cfg;
+
+		if (tmp_cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_vnifilter_lookup(tmp, vni))
 				continue;
-		} else if (tmp->cfg.vni != vni) {
+		} else if (tmp_cfg->vni != vni) {
 			continue;
 		}
-		if (tmp->cfg.dst_port != conf->dst_port)
+		if (tmp_cfg->dst_port != conf->dst_port)
 			continue;
-		if ((tmp->cfg.flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
+		if ((tmp_cfg->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)) !=
 		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
 			continue;
 
 		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
-		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
+		    tmp_cfg->remote_ifindex != conf->remote_ifindex)
 			continue;
 
 		return -EEXIST;
@@ -3925,7 +3980,7 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 }
 
 static void vxlan_config_apply(struct net_device *dev,
-			       struct vxlan_config *conf,
+			       struct vxlan_config *new_cfg,
 			       struct net_device *lowerdev,
 			       struct net *src_net,
 			       bool changelink)
@@ -3933,8 +3988,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
+	struct vxlan_config *old_cfg;
 	int max_mtu = ETH_MAX_MTU;
-	u32 flags = conf->flags;
+	u32 flags = new_cfg->flags;
 
 	if (!changelink) {
 		if (flags & VXLAN_F_GPE)
@@ -3942,18 +3998,18 @@ static void vxlan_config_apply(struct net_device *dev,
 		else
 			vxlan_ether_setup(dev);
 
-		if (conf->mtu)
-			dev->mtu = conf->mtu;
+		if (new_cfg->mtu)
+			dev->mtu = new_cfg->mtu;
 
 		vxlan->net = src_net;
 	}
 
-	dst->remote_vni = conf->vni;
+	dst->remote_vni = new_cfg->vni;
 
-	memcpy(&dst->remote_ip, &conf->remote_ip, sizeof(conf->remote_ip));
+	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
 
 	if (lowerdev) {
-		dst->remote_ifindex = conf->remote_ifindex;
+		dst->remote_ifindex = new_cfg->remote_ifindex;
 
 		netif_inherit_tso_max(dev, lowerdev);
 
@@ -3966,7 +4022,7 @@ static void vxlan_config_apply(struct net_device *dev,
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
-		if (!changelink && !conf->mtu)
+		if (!changelink && !new_cfg->mtu)
 			dev->mtu = max_mtu;
 	}
 
@@ -3978,7 +4034,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
-	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+	old_cfg = vxlan->cfg;
+	vxlan->cfg = new_cfg;
+	kfree(old_cfg);
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
@@ -3987,13 +4045,18 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *lowerdev;
+	struct vxlan_config *new_cfg;
 	int ret;
 
 	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
 	if (ret)
 		return ret;
 
-	vxlan_config_apply(dev, conf, lowerdev, src_net, false);
+	new_cfg = kmemdup(conf, sizeof(*conf), GFP_KERNEL);
+	if (!new_cfg)
+		return -ENOMEM;
+
+	vxlan_config_apply(dev, new_cfg, lowerdev, src_net, false);
 
 	return 0;
 }
@@ -4005,6 +4068,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
+	const struct vxlan_config *cfg;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -4013,11 +4077,15 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
+	cfg = vxlan->cfg;
+
 	dev->ethtool_ops = &vxlan_ethtool_ops;
 
 	err = register_netdevice(dev);
-	if (err)
+	if (err) {
+		vxlan_free_dev(dev);
 		return err;
+	}
 
 	if (dst->remote_ifindex) {
 		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
@@ -4044,7 +4112,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 				       &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       cfg->dst_port,
 				       dst->remote_vni,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
@@ -4108,8 +4176,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	memset(conf, 0, sizeof(*conf));
 
 	/* if changelink operation, start with old existing cfg */
-	if (changelink)
-		memcpy(conf, &vxlan->cfg, sizeof(*conf));
+	if (changelink) {
+		const struct vxlan_config *cfg = vxlan->cfg;
+
+		if (cfg)
+			memcpy(conf, cfg, sizeof(*conf));
+	}
 
 	if (data[IFLA_VXLAN_ID]) {
 		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
@@ -4456,9 +4528,11 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg = vxlan->cfg;
 	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
+	struct vxlan_config *new_cfg;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -4475,13 +4549,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	new_cfg = kmemdup(&conf, sizeof(conf), GFP_KERNEL);
+	if (!new_cfg)
+		return -ENOMEM;
+
 	if (dst->remote_dev == lowerdev)
 		lowerdev = NULL;
 
 	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
 					     extack);
-	if (err)
+	if (err) {
+		kfree(new_cfg);
 		return err;
+	}
 
 	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
 	change_igmp = vxlan->dev->flags & IFF_UP &&
@@ -4496,7 +4576,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       &conf.remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
 					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
+					       cfg->dst_port,
 					       conf.vni, conf.vni,
 					       conf.remote_ifindex,
 					       NTF_SELF, 0, true, extack);
@@ -4504,13 +4584,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 				spin_unlock_bh(&vxlan->hash_lock);
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
+				kfree(new_cfg);
 				return err;
 			}
 		}
 		if (!vxlan_addr_any(&dst->remote_ip))
 			__vxlan_fdb_delete(vxlan, all_zeros_mac,
 					   dst->remote_ip,
-					   vxlan->cfg.dst_port,
+					   cfg->dst_port,
 					   dst->remote_vni,
 					   dst->remote_vni,
 					   dst->remote_ifindex,
@@ -4520,12 +4601,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* If vni filtering device, also update fdb entries of
 		 * all vnis that were using default remote ip
 		 */
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
 							 &conf.remote_ip, extack);
 			if (err) {
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
+				kfree(new_cfg);
 				return err;
 			}
 		}
@@ -4534,13 +4616,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
 		err = vxlan_multicast_leave(vxlan);
 
-	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
+	if (netif_running(dev) && conf.age_interval != cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
 	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
 	if (lowerdev && lowerdev != dst->remote_dev)
 		dst->remote_dev = lowerdev;
-	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
+	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);
 
 	if (!err && change_igmp &&
 	    vxlan_addr_multicast(&dst->remote_ip))
@@ -4607,7 +4689,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = &vxlan->cfg;
+	cfg = vxlan->cfg;
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
 		goto nla_put_failure;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index fe079d6abc5fcfb8bdac4d27b95dabd30aa10526..e34f783a192d531a657f631d59ee428945855d4f 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -165,7 +165,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg = vxlan->cfg;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -606,7 +606,7 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *vcfg = &vxlan->cfg;
+	const struct vxlan_config *vcfg = vxlan->cfg;
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -951,7 +951,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg = vxlan->cfg;
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index 3b75b48dc726df40cebb233095a8a046ee274c30..6a95b6844cf442e9c9eb2311793c31f4ce824d70 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -158,7 +158,7 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 		    rtnl_dereference(vxlan->vn6_sock) != sock6)
 			continue;
 #endif
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (vxlan->cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_group_used_by_vnifilter(vxlan, ip, ifindex))
 				continue;
 		} else {
@@ -244,7 +244,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (vxlan->cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_join_vnigrp(vxlan);
 
 	return 0;
@@ -263,7 +263,7 @@ int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (vxlan->cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_leave_vnigrp(vxlan);
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index c46d5716493695b0651570a2686c6b0a150f61e6..8f6c01930ace77776dd6f2d3197e9325fdfd8bbf 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -178,7 +178,7 @@ void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vnode;
 
-	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return;
 
 	if (vninode) {
@@ -343,7 +343,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	bool dump_stats;
 	int err = 0;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
+	if (!(vxlan->cfg->flags & VXLAN_F_VNIFILTER)) {
 		cb->args[1] = 0;
 		return -EINVAL;
 	}
@@ -489,7 +489,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       vxlan->cfg->dst_port,
 				       vni,
 				       vni,
 				       dst->remote_ifindex,
@@ -503,7 +503,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   *old_remote_ip,
-				   vxlan->cfg.dst_port,
+				   vxlan->cfg->dst_port,
 				   vni, vni,
 				   dst->remote_ifindex,
 				   true);
@@ -628,7 +628,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
-				   vxlan->cfg.dst_port,
+				   vxlan->cfg->dst_port,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
@@ -736,7 +736,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	if (vxlan_vnifilter_lookup(vxlan, v))
 		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);
 
-	err = vxlan_vni_in_use(vxlan->net, vxlan, &vxlan->cfg, v);
+	err = vxlan_vni_in_use(vxlan->net, vxlan, vxlan->cfg, v);
 	if (err) {
 		NL_SET_ERR_MSG(extack, "VNI in use");
 		return err;
@@ -971,7 +971,7 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	vxlan = netdev_priv(dev);
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!(vxlan->cfg->flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
 	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index f4f519a365f524e1301d769f75690d836b9e4432..9b39f34b7eada647eb56512ede094555439f97e5 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -303,7 +303,7 @@ struct vxlan_dev {
 	struct gro_cells  gro_cells;
 	unsigned long	  flags;
 
-	struct vxlan_config	cfg;
+	struct vxlan_config	*cfg;
 
 	struct vxlan_vni_group  __rcu *vnigrp;
 
-- 
2.55.0.970.g62bdec98f9-goog

