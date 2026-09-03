Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE54A1E0C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437337; cv=none; b=c1eMT4BeraWVchy2tk/chC6UN7JZBJvbo9vf/ai1KeZLS/mx2AIiHMTQ7CafPgENO0GJQbfPPN4gD482yzec5Euqx8TfGAzeVisw1OMNFT/E3il5tIc/Upij8eUWD/f2eKxnwXkJHyKwkkBgTneO5yjIOwHCcGPSCTafuTWYXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437337; c=relaxed/simple;
	bh=nJCpv5V6pPrb8obO/u9lhzs73G8vP9IU4NFG7Ij0IJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f9NFrte+vJVNU6161LuLMvYh9NkAQ8APN+IaD7DQ5j+TD9qymDI7t751PuWHQ+OQgoeEFw4+3PUtsselfTYkNGab6ho22gIvluEkEnGK7PHosHeCaSfoA6XRzJRJDaLIxg6DrLz61eOiApeqNaC/E5BPCQklKcVHIts2WQb1Dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3QsaXxd; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3QsaXxd"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e62e3459fso407552485a.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437334; x=1789042134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKs/tE0nUIte4lmo6sueBrsNwe9F7/WTjsyLzngB1+g=;
        b=Q3QsaXxdXYEBlv4FlkMtuZWKS/ChjD1MMLokjB7f78HEztopmSF7lo9beVo1BDSgUl
         sTgF6OIG+lcJg7hHqVeqcChPRQ+YsUrvRXknOHcVHi/My2Ft6pe6n/j3+KYFKp/BoqXU
         qaN6W36Z41wTqi/YPL0lQR4wcMgtP+JplJRAXxdApq4cQzSh+ITRYfnGbrNqzfHNWFP/
         uejW/56/RiELCAZFPgldhBbZ+apfE1SBSe7x2RH0p4/+6ufxY1UW49HMlRGApw9i7jo4
         s2Lts/Ul+vE2zFywx6PFSGQTA3WAm//UcMZlOJ4Sx3XhqDQSOXDjg9sLxoCBJED7ex+n
         T7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437334; x=1789042134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKs/tE0nUIte4lmo6sueBrsNwe9F7/WTjsyLzngB1+g=;
        b=nGNov4mhWCy8iXW0AMppb9sNFnCmX7/gdImG9Rxhqll2jhE+R+3JiAzuEMT9wgUEYt
         EGVubckKCHeydoGyxoq4+PviucI+Vn1tf+hJmGjyjGjS69xMpFlUO04Yj9APpklTPBg1
         AuUFwcRM2bSODNPZk01AZ0JRqVoa2fdigJztnAb3PqO8VOjwoaid7LoDfLCxYoONjA/d
         pVD8FYieUDHtl/SWODcOUoHXmz9VDg8hHAJ/bFnWrm/h3T4f/dceg0ukf5vq7Mej5JEM
         e/9031wkG66MFGNLFLw+K2EHHOd09p/HvK2g1JupYt5Nd5ar8qAItiL2VtEZe2QANKM2
         XnnA==
X-Forwarded-Encrypted: i=1; AKwUvBzKnWuIqPgkZKrtUSApBmBU89AtxjW7MuApcx1xyeNkPa/FkIIzjZTazNL3G0HVPp4YS6zUoZA=@vger.kernel.org
X-Gm-Message-State: AFuF++nmrV22p45S7coIKyAvF+k5zKHal92qusSSbz/3slF3fAnpS7PM
	RJo8UsyANaJPqgCYWnXrzYIUCvSAk7rE31e79LJZUJ6cTt8KkcpvoidpJsDlkmMvqe2x5QrBx3e
	TK54K782uYiD/5A==
X-Received: from qknvz22.prod.google.com ([2002:a05:620a:4956:b0:921:e7ee:c4c0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f0d:b0:939:6dea:3749 with SMTP id af79cd13be357-9396dea3889mr606047185a.45.1788437332363;
 Thu, 03 Sep 2026 05:08:52 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:38 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-8-edumazet@google.com>
Subject: [PATCH net-next 7/9] vxlan: convert configuration to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to allow lockless readers in future patches, convert 'vxlan->cfg'
to an RCU protected pointer.

Updating configuration via vxlan_changelink() or vxlan_dev_configure()
now uses rcu_assign_pointer() to publish it, freeing the previous config
with kfree_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       | 14 ++-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 57 +++++++----
 drivers/net/vxlan/vxlan_core.c                | 94 +++++++++++--------
 drivers/net/vxlan/vxlan_mdb.c                 | 10 +-
 drivers/net/vxlan/vxlan_multicast.c           | 12 ++-
 drivers/net/vxlan/vxlan_vnifilter.c           | 19 ++--
 include/net/vxlan.h                           |  3 +-
 7 files changed, 132 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 4db0efc376a8ef4d373b693240e041a708278b96..50cea39323f570e04067f2f98aff4d97e4a409fc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -59,8 +59,11 @@ static bool mlxsw_sp_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve,
 					   const struct mlxsw_sp_nve_params *params,
 					   struct netlink_ext_ack *extack)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	if (vxlan_addr_multicast(&cfg->remote_ip)) {
 		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Multicast destination IP is not supported");
@@ -148,8 +151,11 @@ static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
 				      const struct mlxsw_sp_nve_params *params,
 				      struct mlxsw_sp_nve_config *config)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	config->type = MLXSW_SP_NVE_TYPE_VXLAN;
 	config->ttl = cfg->ttl;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a22228bd95c90ae8a481ba2f07f2a38689266b78..de60b698bea982593f0f7550571e9a4f434dcceb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2513,15 +2513,17 @@ mlxsw_sp_bridge_vlan_aware_vxlan_join(struct mlxsw_sp_bridge_device *bridge_devi
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_device->dev);
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	struct mlxsw_sp_nve_params params = {
-		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg->vni,
-		.dev = vxlan_dev,
-		.ethertype = ethertype,
-	};
+	struct mlxsw_sp_nve_params params;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	params.type = MLXSW_SP_NVE_TYPE_VXLAN;
+	params.vni = cfg->vni;
+	params.dev = vxlan_dev;
+	params.ethertype = ethertype;
+
 	/* If the VLAN is 0, we need to find the VLAN that is configured as
 	 * PVID and egress untagged on the bridge port of the VxLAN device.
 	 * It is possible no such VLAN exists
@@ -2704,15 +2706,17 @@ mlxsw_sp_bridge_8021d_vxlan_join(struct mlxsw_sp_bridge_device *bridge_device,
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_device->dev);
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	struct mlxsw_sp_nve_params params = {
-		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg->vni,
-		.dev = vxlan_dev,
-		.ethertype = ETH_P_8021Q,
-	};
+	struct mlxsw_sp_nve_params params;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	params.type = MLXSW_SP_NVE_TYPE_VXLAN;
+	params.vni = cfg->vni;
+	params.dev = vxlan_dev;
+	params.ethertype = ETH_P_8021Q;
+
 	fid = mlxsw_sp_fid_8021d_get(mlxsw_sp, bridge_device->dev->ifindex);
 	if (IS_ERR(fid)) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to create 802.1D FID");
@@ -2933,10 +2937,13 @@ static void __mlxsw_sp_bridge_vxlan_leave(struct mlxsw_sp *mlxsw_sp,
 					  const struct net_device *vxlan_dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	/* If the VxLAN device is down, then the FID does not have a VNI */
-	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg->vni);
+	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, cfg->vni);
 	if (!fid)
 		return;
 
@@ -3029,11 +3036,13 @@ static void mlxsw_sp_fdb_vxlan_call_notifiers(struct net_device *dev,
 	struct switchdev_notifier_vxlan_fdb_info info;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	enum switchdev_notifier_type type;
+	const struct vxlan_config *cfg;
 
+	cfg = rtnl_dereference(vxlan->cfg);
 	type = adding ? SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE :
 			SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE;
 	mlxsw_sp_switchdev_addr_vxlan_convert(proto, addr, &info.remote_ip);
-	info.remote_port = vxlan->cfg->dst_port;
+	info.remote_port = cfg->dst_port;
 	info.remote_vni = vni;
 	info.remote_ifindex = 0;
 	ether_addr_copy(info.eth_addr, mac);
@@ -3236,8 +3245,10 @@ __mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
 
 	if (adding && netif_is_vxlan(dev)) {
 		struct vxlan_dev *vxlan = netdev_priv(dev);
+		const struct vxlan_config *cfg;
 
-		if (!(vxlan->cfg->flags & VXLAN_F_LEARN))
+		cfg = rtnl_dereference(vxlan->cfg);
+		if (!(cfg->flags & VXLAN_F_LEARN))
 			return -EINVAL;
 	}
 
@@ -3722,9 +3733,11 @@ mlxsw_sp_switchdev_vxlan_work_prepare(struct mlxsw_sp_switchdev_event_work *
 {
 	struct vxlan_dev *vxlan = netdev_priv(switchdev_work->dev);
 	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
-	struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg;
 	struct netlink_ext_ack *extack;
 
+	cfg = rcu_dereference_rtnl(vxlan->cfg);
+
 	extack = switchdev_notifier_info_to_extack(info);
 	vxlan_fdb_info = container_of(info,
 				      struct switchdev_notifier_vxlan_fdb_info,
@@ -3851,11 +3864,15 @@ mlxsw_sp_switchdev_vxlan_vlan_add(struct mlxsw_sp *mlxsw_sp,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg->vni;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
 	u16 old_vid;
+	__be32 vni;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	vni = cfg->vni;
+
 	/* We cannot have the same VLAN as PVID and egress untagged on multiple
 	 * VxLAN devices. Note that we get this notification before the VLAN is
 	 * actually added to the bridge's database, so it is not possible for
@@ -3935,12 +3952,16 @@ mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
 				  const struct net_device *vxlan_dev, u16 vid)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	__be32 vni = vxlan->cfg->vni;
+	const struct vxlan_config *cfg;
 	struct mlxsw_sp_fid *fid;
+	__be32 vni;
 
 	if (!netif_running(vxlan_dev))
 		return;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	vni = cfg->vni;
+
 	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vni);
 	if (!fid)
 		return;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index af320173a1e7f598dbe81a90beb0e68c7ed8c482..c49d55de020f49b68e322de2a4b0a5c0be0471ed 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -115,7 +115,7 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 		if (!node->vxlan)
 			continue;
 
-		cfg = node->vxlan->cfg;
+		cfg = rcu_dereference(node->vxlan->cfg);
 
 		vnode = NULL;
 		if (cfg->flags & VXLAN_F_VNIFILTER) {
@@ -160,7 +160,7 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			  u32 portid, u32 seq, int type, unsigned int flags,
 			  const struct vxlan_rdst *rdst)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	unsigned long now = jiffies;
 	struct nda_cacheinfo ci;
 	bool send_ip, send_eth;
@@ -422,7 +422,7 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	lockdep_assert_held_once(&vxlan->hash_lock);
 
 	rcu_read_lock();
-	f = vxlan_find_mac_rcu(vxlan, vxlan->cfg, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -463,7 +463,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, vxlan->cfg, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -869,7 +869,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		     u32 nhid, struct vxlan_fdb **fdb,
 		     struct netlink_ext_ack *extack)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
 	int rc;
@@ -1155,7 +1155,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			   __be32 *vni, u32 *ifindex, u32 *nhid,
 			   struct netlink_ext_ack *extack)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct net *net = dev_net(vxlan->dev);
 	int err;
 
@@ -1407,7 +1407,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 	__be32 vni;
 	int err;
 
-	cfg = vxlan->cfg;
+	cfg = rcu_dereference_rtnl(vxlan->cfg);
 
 	if (tb[NDA_VNI])
 		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
@@ -1521,7 +1521,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 
 static void vxlan_sock_release(struct vxlan_dev *vxlan)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
 #if IS_ENABLED(CONFIG_IPV6)
 	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
@@ -1704,7 +1704,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	cfg = vxlan->cfg;
+	cfg = rcu_dereference(vxlan->cfg);
 
 	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
 	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
@@ -2314,7 +2314,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	rcu_read_lock();
-	dst_cfg = dst_vxlan->cfg;
+	dst_cfg = rcu_dereference(dst_vxlan->cfg);
 	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
@@ -2781,7 +2781,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 nhid = 0;
 	u32 flags;
 
-	cfg = vxlan->cfg;
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 	flags = cfg->flags;
 	default_vni = cfg->vni;
 	saddr_family = cfg->saddr.sa.sa_family;
@@ -2800,14 +2801,19 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 				vxlan_xmit_one(skb, dev, cfg, vni, NULL, false);
 			else
 				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
+			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		}
 	}
 
 	if (flags & VXLAN_F_PROXY) {
 		eth = eth_hdr(skb);
-		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, cfg, vni);
+		if (ntohs(eth->h_proto) == ETH_P_ARP) {
+			netdev_tx_t res = arp_reduce(dev, skb, cfg, vni);
+
+			rcu_read_unlock();
+			return res;
+		}
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
 			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
@@ -2816,32 +2822,36 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
 			if (m->icmph.icmp6_code == 0 &&
-			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, cfg, vni);
+			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) {
+				netdev_tx_t res = neigh_reduce(dev, skb, cfg, vni);
+
+				rcu_read_unlock();
+				return res;
+			}
 		}
 #endif
 	}
 
-	if (nhid)
-		return vxlan_xmit_nhid(skb, dev, nhid, vni, saddr_family, cfg);
+	if (nhid) {
+		netdev_tx_t res = vxlan_xmit_nhid(skb, dev, nhid, vni, saddr_family, cfg);
+
+		rcu_read_unlock();
+		return res;
+	}
 
 	if (test_bit(VXLAN_DEV_F_MDB, &vxlan->flags)) {
 		struct vxlan_mdb_entry *mdb_entry;
 
-		rcu_read_lock();
 		mdb_entry = vxlan_mdb_entry_skb_get(vxlan, cfg, skb, vni);
 		if (mdb_entry) {
-			netdev_tx_t ret;
+			netdev_tx_t ret = vxlan_mdb_xmit(vxlan, cfg, mdb_entry, skb);
 
-			ret = vxlan_mdb_xmit(vxlan, cfg, mdb_entry, skb);
 			rcu_read_unlock();
 			return ret;
 		}
-		rcu_read_unlock();
 	}
 
 	eth = eth_hdr(skb);
-	rcu_read_lock();
 	f = vxlan_find_mac_tx(vxlan, cfg, eth->h_dest, vni);
 	did_rsc = false;
 
@@ -2907,7 +2917,7 @@ static void vxlan_cleanup(struct timer_list *t)
 		return;
 
 	rcu_read_lock();
-	cfg = vxlan->cfg;
+	cfg = rcu_dereference(vxlan->cfg);
 
 	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		unsigned long timeout;
@@ -2965,7 +2975,7 @@ static int vxlan_init(struct net_device *dev)
 	const struct vxlan_config *cfg;
 	int err;
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	err = rhashtable_init(&vxlan->fdb_hash_tbl, &vxlan_fdb_rht_params);
 	if (err)
@@ -3003,7 +3013,7 @@ static void vxlan_uninit(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct vxlan_config *cfg;
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	vxlan_mdb_fini(vxlan);
 
@@ -3032,7 +3042,7 @@ static int vxlan_open(struct net_device *dev)
 		return ret;
 	}
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 	if (cfg && cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
 
@@ -3055,7 +3065,7 @@ struct vxlan_fdb_flush_desc {
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 				       const struct vxlan_dev *vxlan)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 
 	return is_zero_ether_addr(f->key.eth_addr) &&
 	       f->key.vni == cfg->vni;
@@ -3279,7 +3289,7 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 	const struct vxlan_config *cfg;
 	struct net_device *lowerdev;
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	lowerdev = __dev_get_by_index(vxlan->net, dst->remote_ifindex);
 
@@ -3303,7 +3313,7 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	const struct vxlan_config *cfg;
 	__be16 sport, dport;
 
-	cfg = vxlan->cfg;
+	cfg = rcu_dereference(vxlan->cfg);
 
 	sport = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
 				  cfg->port_max, true);
@@ -3420,9 +3430,10 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 static void vxlan_free_dev(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_config *cfg = rcu_dereference_protected(vxlan->cfg, 1);
 
-	kfree(vxlan->cfg);
-	vxlan->cfg = NULL;
+	RCU_INIT_POINTER(vxlan->cfg, NULL);
+	kfree(cfg);
 }
 
 /* Initialize the device structure. */
@@ -3717,7 +3728,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	bool metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
 	struct vxlan_sock *vs = NULL;
 	struct vxlan_dev_node *node;
@@ -3767,7 +3778,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	bool metadata, ipv6, ipv4;
 	int ret = 0;
 
@@ -3803,7 +3814,7 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 		if (tmp == vxlan)
 			continue;
 
-		tmp_cfg = tmp->cfg;
+		tmp_cfg = rtnl_dereference(tmp->cfg);
 
 		if (tmp_cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_vnifilter_lookup(tmp, vni))
@@ -4034,9 +4045,10 @@ static void vxlan_config_apply(struct net_device *dev,
 	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
-	old_cfg = vxlan->cfg;
-	vxlan->cfg = new_cfg;
-	kfree(old_cfg);
+	old_cfg = rtnl_dereference(vxlan->cfg);
+	rcu_assign_pointer(vxlan->cfg, new_cfg);
+	if (old_cfg)
+		kfree_rcu(old_cfg, rcu);
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
@@ -4077,7 +4089,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	dev->ethtool_ops = &vxlan_ethtool_ops;
 
@@ -4177,7 +4189,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 
 	/* if changelink operation, start with old existing cfg */
 	if (changelink) {
-		const struct vxlan_config *cfg = vxlan->cfg;
+		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 
 		if (cfg)
 			memcpy(conf, cfg, sizeof(*conf));
@@ -4528,7 +4540,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
@@ -4689,7 +4701,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
 		goto nla_put_failure;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index e34f783a192d531a657f631d59ee428945855d4f..dac224dce9b6ca0c23f9139a7a993a6e061b5c79 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -165,7 +165,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -606,7 +606,9 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *vcfg = vxlan->cfg;
+	const struct vxlan_config *vcfg;
+
+	vcfg = rtnl_dereference(vxlan->cfg);
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -951,12 +953,12 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
 
-		     /* MDBA_MDB_ENTRY_INFO */
+	/* MDBA_MDB_ENTRY_INFO */
 	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
 		     /* MDBA_MDB_EATTR_TIMER */
 		     nla_total_size(sizeof(u32));
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index 6a95b6844cf442e9c9eb2311793c31f4ce824d70..e2cf10da274f1b608d8bb5020d2b87ebfedeff46 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -147,6 +147,8 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 #endif
 
 	list_for_each_entry(vxlan, &vn->vxlan_list, next) {
+		const struct vxlan_config *cfg;
+
 		if (!netif_running(vxlan->dev) || vxlan == dev)
 			continue;
 
@@ -158,7 +160,9 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 		    rtnl_dereference(vxlan->vn6_sock) != sock6)
 			continue;
 #endif
-		if (vxlan->cfg->flags & VXLAN_F_VNIFILTER) {
+		cfg = rtnl_dereference(vxlan->cfg);
+
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			if (!vxlan_group_used_by_vnifilter(vxlan, ip, ifindex))
 				continue;
 		} else {
@@ -233,6 +237,7 @@ static int vxlan_multicast_leave_vnigrp(struct vxlan_dev *vxlan)
 
 int vxlan_multicast_join(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	int ret = 0;
 
 	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
@@ -244,7 +249,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg->flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_join_vnigrp(vxlan);
 
 	return 0;
@@ -252,6 +257,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 
 int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	int ret = 0;
 
@@ -263,7 +269,7 @@ int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 			return ret;
 	}
 
-	if (vxlan->cfg->flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_leave_vnigrp(vxlan);
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 8f6c01930ace77776dd6f2d3197e9325fdfd8bbf..1069d6b1b2955c54d0ce0f89860390ebc0ff8f15 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -337,13 +337,15 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct tunnel_msg *new_tmsg, *tmsg;
+	const struct vxlan_config *cfg;
 	int idx = 0, s_idx = cb->args[1];
 	struct vxlan_vni_group *vg;
 	struct nlmsghdr *nlh;
 	bool dump_stats;
 	int err = 0;
 
-	if (!(vxlan->cfg->flags & VXLAN_F_VNIFILTER)) {
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!(cfg->flags & VXLAN_F_VNIFILTER)) {
 		cb->args[1] = 0;
 		return -EINVAL;
 	}
@@ -480,6 +482,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 					  union vxlan_addr *remote_ip,
 					  struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	int err = 0;
 
@@ -489,7 +492,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
-				       vxlan->cfg->dst_port,
+				       cfg->dst_port,
 				       vni,
 				       vni,
 				       dst->remote_ifindex,
@@ -503,7 +506,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   *old_remote_ip,
-				   vxlan->cfg->dst_port,
+				   cfg->dst_port,
 				   vni, vni,
 				   dst->remote_ifindex,
 				   true);
@@ -617,6 +620,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   struct vxlan_vni_node *vninode)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 
 	/* if per vni remote_ip not present, delete the
@@ -628,7 +632,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
-				   vxlan->cfg->dst_port,
+				   cfg->dst_port,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
@@ -728,6 +732,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 			 u32 vni, union vxlan_addr *group,
 			 struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_vni_node *vninode;
 	__be32 v = cpu_to_be32(vni);
 	bool changed = false;
@@ -736,7 +741,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	if (vxlan_vnifilter_lookup(vxlan, v))
 		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);
 
-	err = vxlan_vni_in_use(vxlan->net, vxlan, vxlan->cfg, v);
+	err = vxlan_vni_in_use(vxlan->net, vxlan, cfg, v);
 	if (err) {
 		NL_SET_ERR_MSG(extack, "VNI in use");
 		return err;
@@ -946,6 +951,7 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	const struct vxlan_config *cfg;
 	struct tunnel_msg *tmsg;
 	struct vxlan_dev *vxlan;
 	struct net_device *dev;
@@ -970,8 +976,9 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	vxlan = netdev_priv(dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
-	if (!(vxlan->cfg->flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
 	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 9b39f34b7eada647eb56512ede094555439f97e5..7eb4f8110a84872f1d0451f7ccef3a73ba5c2e7a 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -229,6 +229,7 @@ struct vxlan_config {
 	bool				no_share;
 	enum ifla_vxlan_df		df;
 	struct vxlanhdr			reserved_bits;
+	struct rcu_head			rcu;
 };
 
 enum {
@@ -303,7 +304,7 @@ struct vxlan_dev {
 	struct gro_cells  gro_cells;
 	unsigned long	  flags;
 
-	struct vxlan_config	*cfg;
+	struct vxlan_config __rcu	*cfg;
 
 	struct vxlan_vni_group  __rcu *vnigrp;
 
-- 
2.55.0.970.g62bdec98f9-goog

