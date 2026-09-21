Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AB3E451B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984937; cv=none; b=RxGkg9WuAaYMm6ZYIVSSk0ay+AtaLlQeI1lOGfvdOSxGPoN/qt+7rhfY1uJj4esIVE4AlvtBgdI6KTdXxLCCNND8MjwVonOe59bfYNKKugkPEQ2trjAxUy+SEpe2WYHw4JVLFYh2uoKaot5zPZosBrCYEBd+1C1l70YgZGSkW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984937; c=relaxed/simple;
	bh=0PjGYqfUvb4RQHivrPC9iRhKfOGIDW6V+HNLA21BlYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HW8jjOnJmb789sPMDB2I7nxvtok5H72oM5vvtm09IGISOFdXvqyIZw2azp4g9ZK3hwWgT+oBVaM2VCNbl5rQXKqzcSFii1L9Pldo781c/nzObzyT85t5009nvWE8GF1OTGsj/ThQA8OeR7ezY0gRsgVQxu3IMvq1PWfM0/xafDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUT8jcNk; arc=none smtp.client-ip=209.85.221.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUT8jcNk"
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c7d5444845so4446631e0c.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984933; x=1790589733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF3RdoUyApm9Us0MP/dpYg8ACxU+sDFDKvswtoGuuMs=;
        b=iUT8jcNk0zFNjJ24lVLVwFK3zfI0RxLAqZNbC0Y1cBZiQUlg5B2FDEpZkW1HG0ExyB
         ZjgYeVkjsJVjw+1STMYgRRuMM0+X2yAM73Ge5hf9h9+5bGFCd2QXaBftdqt3+IABvqj0
         qJ6lQf9DQMD/J0W0dF11phB63FKmobDlhDgLliZ1BKogVvXHtLKDT236GxL13JM8VIDV
         YiZSVwRs+VzVxE5WCI5x27TmAtYAEYdIjDVVjOzn+FBnMBH2qZz65bOa2BQfBaFfNcnE
         FgwJHKQqURQ9X+LhCjAPWjDAI9/sl4NVrIPxCJYjB3gw1Mt3T+kW/klVvBSBUTRjToJl
         Cyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984933; x=1790589733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VF3RdoUyApm9Us0MP/dpYg8ACxU+sDFDKvswtoGuuMs=;
        b=uccSqLzH0wBabgHt0DIdBwaYZwAUO5TJNgk+KTNMJF8+3a2IToZ1Eds9A5Xw9L1+SE
         L7BFg876rq8AVN2ElFJI9Qzti9XAg5YlSeEuJf9NHqAJx90/8EPLz/JEz8JOxAoYc0GT
         kl25rBTwrJTgzB5PtsDq9wgFbz1tytuE5sTGRF8LiEsuneaPxffr34BswGN1CrVNJag+
         u68GRyoSmrwc0wHDHZCt6VMcO61bgUl9i76dxhv0BZKp3t1Vz5C6S3MGLuibJjXQEDZP
         Rk07tZyn1/1s6QVfKW9bfTZbOAFkONq1ojylPow0q0uCsPv/yHEcrzHQyJmzo/irnsCr
         RWow==
X-Forwarded-Encrypted: i=1; AKwUvBxKQcoQmDOC3ODTw3jCcD/rXZfVj7AdXqADY/pN/ujL8mFdjXcayEDCSes+fb9m9k0wRKd6hOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mK0Ci6llB0xOpjN1+gNcaUhrlyvhauxTsmsJ36/7qMw99xxsGE
	ou4Q6SHjN6TH2XVFreL8hArnliJ7EEdtKBqWPc7yAk+6pO9okUnN9bffd67gI10MkiQ6he6xpiq
	aQJLMNaa9teNz7Q==
X-Received: from qkee28-n2.prod.google.com ([2002:a05:620a:231c:20b0:93a:e68:f057])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:54d:b0:5c9:c60e:5cf6 with SMTP id 71dfb90a1353d-5c9c60e60e2mr2363175e0c.20.1789984910669;
 Mon, 21 Sep 2026 03:01:50 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:37 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-7-edumazet@google.com>
Subject: [PATCH v5 net-next 6/8] vxlan: convert configuration to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move 'struct vxlan_config' from an embedded structure inside
'struct vxlan_dev' to a dynamically allocated RCU-protected pointer
'vxlan->cfg'.

Updating configuration via vxlan_changelink() or vxlan_dev_configure()
allocates a new struct vxlan_config and publishes it with
rcu_assign_pointer(), freeing the previous config with kfree_rcu().

Readers are converted to use rcu_dereference() or rtnl_dereference().
In vxlan_xmit(), acquire rcu_read_lock() to protect config access.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  14 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 ++--
 drivers/net/vxlan/vxlan_core.c                | 274 ++++++++++++------
 drivers/net/vxlan/vxlan_mdb.c                 |  10 +-
 drivers/net/vxlan/vxlan_multicast.c           |  12 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  21 +-
 include/net/vxlan.h                           |   3 +-
 7 files changed, 263 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index b78aff31c98f2d8aedfdf36bbfc1cb61e1066edf..21e7b499f3879c050cc68ff024fcc62a809be840 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -59,8 +59,11 @@ static bool mlxsw_sp_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve,
 					   const struct mlxsw_sp_nve_params *params,
 					   struct netlink_ext_ack *extack)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	if (vxlan_addr_multicast(&cfg->remote_ip)) {
 		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Multicast destination IP is not supported");
@@ -153,8 +156,11 @@ static void mlxsw_sp_nve_vxlan_config(const struct mlxsw_sp_nve *nve,
 				      const struct mlxsw_sp_nve_params *params,
 				      struct mlxsw_sp_nve_config *config)
 {
-	struct vxlan_dev *vxlan = netdev_priv(params->dev);
-	struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg;
+	struct vxlan_dev *vxlan;
+
+	vxlan = netdev_priv(params->dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	config->type = MLXSW_SP_NVE_TYPE_VXLAN;
 	config->ttl = cfg->ttl;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index fe45e533a4b2efb532b85960009c586a53ade340..de60b698bea982593f0f7550571e9a4f434dcceb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2513,15 +2513,17 @@ mlxsw_sp_bridge_vlan_aware_vxlan_join(struct mlxsw_sp_bridge_device *bridge_devi
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_lower_get(bridge_device->dev);
 	struct vxlan_dev *vxlan = netdev_priv(vxlan_dev);
-	struct mlxsw_sp_nve_params params = {
-		.type = MLXSW_SP_NVE_TYPE_VXLAN,
-		.vni = vxlan->cfg.vni,
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
-		.vni = vxlan->cfg.vni,
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
-	fid = mlxsw_sp_fid_lookup_by_vni(mlxsw_sp, vxlan->cfg.vni);
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
-	info.remote_port = vxlan->cfg.dst_port;
+	info.remote_port = cfg->dst_port;
 	info.remote_vni = vni;
 	info.remote_ifindex = 0;
 	ether_addr_copy(info.eth_addr, mac);
@@ -3236,8 +3245,10 @@ __mlxsw_sp_fdb_notify_mac_uc_tunnel_process(struct mlxsw_sp *mlxsw_sp,
 
 	if (adding && netif_is_vxlan(dev)) {
 		struct vxlan_dev *vxlan = netdev_priv(dev);
+		const struct vxlan_config *cfg;
 
-		if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		cfg = rtnl_dereference(vxlan->cfg);
+		if (!(cfg->flags & VXLAN_F_LEARN))
 			return -EINVAL;
 	}
 
@@ -3722,9 +3733,11 @@ mlxsw_sp_switchdev_vxlan_work_prepare(struct mlxsw_sp_switchdev_event_work *
 {
 	struct vxlan_dev *vxlan = netdev_priv(switchdev_work->dev);
 	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
-	struct vxlan_config *cfg = &vxlan->cfg;
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
-	__be32 vni = vxlan->cfg.vni;
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
-	__be32 vni = vxlan->cfg.vni;
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
index f98f1d802724df40d4f68ba7282dc377752b1160..04b2925d7c38aafea3c4ab1a1b34ac1feeb93afe 100644
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
+		cfg = rcu_dereference(node->vxlan->cfg);
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
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
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
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -459,7 +463,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, rcu_dereference(vxlan->cfg), eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -865,12 +869,13 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		     u32 nhid, struct vxlan_fdb **fdb,
 		     struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
 	int rc;
 
-	if (vxlan->cfg.addrmax &&
-	    vxlan->addrcnt >= vxlan->cfg.addrmax)
+	if (cfg->addrmax &&
+	    vxlan->addrcnt >= cfg->addrmax)
 		return -ENOSPC;
 
 	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
@@ -1156,6 +1161,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			   __be32 *vni, u32 *ifindex, u32 *nhid,
 			   struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct net *net = dev_net(vxlan->dev);
 	int err;
 
@@ -1172,7 +1178,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			return err;
 		}
 	} else {
-		union vxlan_addr *remote = &vxlan->default_dst.remote_ip;
+		const union vxlan_addr *remote = &cfg->remote_ip;
 
 		if (remote->sa.sa_family == AF_INET) {
 			ip->sin.sin_addr.s_addr = htonl(INADDR_ANY);
@@ -1192,7 +1198,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*port = nla_get_be16(tb[NDA_PORT]);
 	} else {
-		*port = vxlan->cfg.dst_port;
+		*port = cfg->dst_port;
 	}
 
 	if (tb[NDA_VNI]) {
@@ -1202,7 +1208,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
 	} else {
-		*vni = vxlan->default_dst.remote_vni;
+		*vni = cfg->vni;
 	}
 
 	if (tb[NDA_SRC_VNI]) {
@@ -1212,7 +1218,7 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 		}
 		*src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
 	} else {
-		*src_vni = vxlan->default_dst.remote_vni;
+		*src_vni = cfg->vni;
 	}
 
 	if (tb[NDA_IFINDEX]) {
@@ -1407,18 +1413,21 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 			 struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 	__be32 vni;
 	int err;
 
+	cfg = rcu_dereference_rtnl(vxlan->cfg);
+
 	if (tb[NDA_VNI])
 		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
 	else
-		vni = vxlan->default_dst.remote_vni;
+		vni = cfg->vni;
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1521,6 +1530,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 
 static void vxlan_sock_release(struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
 #if IS_ENABLED(CONFIG_IPV6)
 	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
@@ -1530,7 +1540,7 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		vxlan_vs_del_vnigrp(vxlan);
 	else
 		vxlan_vs_del_dev(vxlan);
@@ -1703,7 +1713,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	cfg = &vxlan->cfg;
+	cfg = rcu_dereference(vxlan->cfg);
+
 	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
 	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
 		/* If the header uses bits besides those enabled by the
@@ -1859,7 +1870,8 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb,
+		      const struct vxlan_config *cfg, __be32 vni)
 {
 	struct neigh_table *tbl = arp_table(dev_net(dev));
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -1873,7 +1885,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 
 	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
-		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
+		vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
@@ -1914,7 +1926,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 		neigh_ha_snapshot(ha, n, n->dev);
 
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1940,11 +1952,11 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u
 
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
@@ -2052,7 +2064,8 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	return reply;
 }
 
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb,
+			const struct vxlan_config *cfg, __be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
@@ -2086,7 +2099,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 		}
 
 		neigh_ha_snapshot(ha, n, n->dev);
-		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2105,10 +2118,10 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni,
 
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
@@ -2295,7 +2308,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 			       const struct vxlan_config *src_cfg,
 			       __be32 vni, bool snoop)
 {
-	const struct vxlan_config *dst_cfg = &dst_vxlan->cfg;
+	const struct vxlan_config *dst_cfg;
 	union vxlan_addr loopback;
 	unsigned int len = skb->len;
 	struct net_device *dev = dst_vxlan->dev;
@@ -2316,6 +2329,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	rcu_read_lock();
+	dst_cfg = rcu_dereference(dst_vxlan->cfg);
 	if (unlikely(!(dev->flags & IFF_UP))) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
@@ -2781,7 +2795,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	u32 nhid = 0;
 	u32 flags;
 
-	cfg = &vxlan->cfg;
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 	flags = cfg->flags;
 	default_vni = cfg->vni;
 
@@ -2799,14 +2814,19 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
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
-			return arp_reduce(dev, skb, vni, flags);
+		if (ntohs(eth->h_proto) == ETH_P_ARP) {
+			netdev_tx_t res = arp_reduce(dev, skb, cfg, vni);
+
+			rcu_read_unlock();
+			return res;
+		}
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
 			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
@@ -2815,32 +2835,36 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
 			if (m->icmph.icmp6_code == 0 &&
-			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni, flags);
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
-		return vxlan_xmit_nhid(skb, dev, nhid, vni, cfg);
+	if (nhid) {
+		netdev_tx_t res = vxlan_xmit_nhid(skb, dev, nhid, vni, cfg);
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
 
@@ -2899,12 +2923,15 @@ static void vxlan_cleanup(struct timer_list *t)
 {
 	struct vxlan_dev *vxlan = timer_container_of(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
+	const struct vxlan_config *cfg;
 	struct vxlan_fdb *f;
 
 	if (!netif_running(vxlan->dev))
 		return;
 
 	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+
 	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
 		unsigned long timeout;
 
@@ -2914,7 +2941,7 @@ static void vxlan_cleanup(struct timer_list *t)
 		if (f->flags & NTF_EXT_LEARNED)
 			continue;
 
-		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
+		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;
 		if (time_before_eq(timeout, jiffies)) {
 			spin_lock(&vxlan->hash_lock);
 			if (!hlist_unhashed(&f->fdb_node)) {
@@ -2958,13 +2985,16 @@ static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
 static int vxlan_init(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	err = rhashtable_init(&vxlan->fdb_hash_tbl, &vxlan_fdb_rht_params);
 	if (err)
 		return err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+	if (cfg->flags & VXLAN_F_VNIFILTER) {
 		err = vxlan_vnigroup_init(vxlan);
 		if (err)
 			goto err_rhashtable_destroy;
@@ -2984,7 +3014,7 @@ static int vxlan_init(struct net_device *dev)
 err_gro_cells_destroy:
 	gro_cells_destroy(&vxlan->gro_cells);
 err_vnigroup_uninit:
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
 err_rhashtable_destroy:
 	rhashtable_destroy(&vxlan->fdb_hash_tbl);
@@ -2994,10 +3024,13 @@ static int vxlan_init(struct net_device *dev)
 static void vxlan_uninit(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
+
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	vxlan_mdb_fini(vxlan);
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
 
 	gro_cells_destroy(&vxlan->gro_cells);
@@ -3009,6 +3042,7 @@ static void vxlan_uninit(struct net_device *dev)
 static int vxlan_open(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg;
 	int ret;
 
 	ret = vxlan_sock_add(vxlan);
@@ -3021,7 +3055,8 @@ static int vxlan_open(struct net_device *dev)
 		return ret;
 	}
 
-	if (vxlan->cfg.age_interval)
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies + FDB_AGE_INTERVAL);
 
 	return ret;
@@ -3043,8 +3078,10 @@ struct vxlan_fdb_flush_desc {
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 				       const struct vxlan_dev *vxlan)
 {
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
+
 	return is_zero_ether_addr(f->key.eth_addr) &&
-	       f->key.vni == vxlan->cfg.vni;
+	       f->key.vni == cfg->vni;
 }
 
 static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
@@ -3262,14 +3299,18 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
+	const struct vxlan_config *cfg;
+	struct net_device *lowerdev;
+
+	cfg = rtnl_dereference(vxlan->cfg);
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
@@ -3282,11 +3323,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
+	const struct vxlan_config *cfg;
 	__be16 sport, dport;
 
-	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				  vxlan->cfg.port_max, true);
-	dport = info->key.tp_dst ? : vxlan->cfg.dst_port;
+	cfg = rcu_dereference(vxlan->cfg);
+
+	sport = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
+				  cfg->port_max, true);
+	dport = info->key.tp_dst ? : cfg->dst_port;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
@@ -3396,6 +3440,15 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 	}
 }
 
+static void vxlan_free_dev(struct net_device *dev)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_config *cfg = rcu_dereference_protected(vxlan->cfg, 1);
+
+	RCU_INIT_POINTER(vxlan->cfg, NULL);
+	kfree(cfg);
+}
+
 /* Initialize the device structure. */
 static void vxlan_setup(struct net_device *dev)
 {
@@ -3404,6 +3457,8 @@ static void vxlan_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 	ether_setup(dev);
 
+	dev->priv_destructor = vxlan_free_dev;
+
 	dev->needs_free_netdev = true;
 	SET_NETDEV_DEVTYPE(dev, &vxlan_type);
 
@@ -3686,21 +3741,22 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
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
@@ -3710,7 +3766,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 	}
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
-					 vxlan->cfg.dst_port, vxlan->cfg.flags,
+					 cfg->dst_port, cfg->flags,
 					 l3mdev_index);
 	if (IS_ERR(vs))
 		return PTR_ERR(vs);
@@ -3725,7 +3781,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		node = &vxlan->hlist4;
 	}
 
-	if (metadata && (vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (metadata && (cfg->flags & VXLAN_F_VNIFILTER))
 		vxlan_vs_add_vnigrp(vxlan, vs, ipv6);
 	else
 		vxlan_vs_add_dev(vs, vxlan, node);
@@ -3735,11 +3791,14 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 
 static int vxlan_sock_add(struct vxlan_dev *vxlan)
 {
-	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
-	bool ipv6 = vxlan->cfg.flags & VXLAN_F_IPV6 || metadata;
-	bool ipv4 = !ipv6 || metadata;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	bool metadata, ipv6, ipv4;
 	int ret = 0;
 
+	metadata = cfg->flags & VXLAN_F_COLLECT_METADATA;
+	ipv6 = (cfg->flags & VXLAN_F_IPV6) || metadata;
+	ipv4 = !ipv6 || metadata;
+
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	RCU_INIT_POINTER(vxlan->vn6_sock, NULL);
@@ -3763,22 +3822,27 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 	struct vxlan_dev *tmp;
 
 	list_for_each_entry(tmp, &vn->vxlan_list, next) {
+		const struct vxlan_config *tmp_cfg;
+
 		if (tmp == vxlan)
 			continue;
-		if (tmp->cfg.flags & VXLAN_F_VNIFILTER) {
+
+		tmp_cfg = rtnl_dereference(tmp->cfg);
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
@@ -3940,7 +4004,7 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 }
 
 static void vxlan_config_apply(struct net_device *dev,
-			       struct vxlan_config *conf,
+			       struct vxlan_config *new_cfg,
 			       struct net_device *lowerdev,
 			       struct net *src_net,
 			       bool changelink)
@@ -3948,8 +4012,9 @@ static void vxlan_config_apply(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
+	struct vxlan_config *old_cfg;
 	int max_mtu = ETH_MAX_MTU;
-	u32 flags = conf->flags;
+	u32 flags = new_cfg->flags;
 
 	if (!changelink) {
 		if (flags & VXLAN_F_GPE)
@@ -3957,18 +4022,18 @@ static void vxlan_config_apply(struct net_device *dev,
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
 
@@ -3981,7 +4046,7 @@ static void vxlan_config_apply(struct net_device *dev,
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
-		if (!changelink && !conf->mtu)
+		if (!changelink && !new_cfg->mtu)
 			dev->mtu = max_mtu;
 	}
 
@@ -3993,7 +4058,10 @@ static void vxlan_config_apply(struct net_device *dev,
 	needed_headroom += vxlan_headroom(flags);
 	dev->needed_headroom = needed_headroom;
 
-	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+	old_cfg = rtnl_dereference(vxlan->cfg);
+	rcu_assign_pointer(vxlan->cfg, new_cfg);
+	if (old_cfg)
+		kfree_rcu(old_cfg, rcu);
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
@@ -4002,13 +4070,18 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
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
@@ -4020,6 +4093,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
+	const struct vxlan_config *cfg;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -4028,11 +4102,15 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
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
@@ -4059,7 +4137,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 				       &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       cfg->dst_port,
 				       dst->remote_vni,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
@@ -4123,8 +4201,12 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	memset(conf, 0, sizeof(*conf));
 
 	/* if changelink operation, start with old existing cfg */
-	if (changelink)
-		memcpy(conf, &vxlan->cfg, sizeof(*conf));
+	if (changelink) {
+		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+
+		if (cfg)
+			memcpy(conf, cfg, sizeof(*conf));
+	}
 
 	if (data[IFLA_VXLAN_ID]) {
 		__be32 vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
@@ -4471,9 +4553,11 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
+	struct vxlan_config *new_cfg;
 	struct vxlan_rdst *dst;
 	u32 new_ifindex;
 	int err;
@@ -4491,13 +4575,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
 
 	/* vxlan_config_apply() only commits remote_ifindex if lowerdev is set */
 	new_ifindex = lowerdev ? conf.remote_ifindex : dst->remote_ifindex;
@@ -4515,7 +4605,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       &conf.remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
 					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
+					       cfg->dst_port,
 					       conf.vni, conf.vni,
 					       new_ifindex,
 					       NTF_SELF, 0, true, extack);
@@ -4523,13 +4613,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
@@ -4539,7 +4630,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* If vni filtering device, also update default fdb entries of
 		 * all vnis
 		 */
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		if (cfg->flags & VXLAN_F_VNIFILTER) {
 			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
 							 &conf.remote_ip,
 							 dst->remote_ifindex,
@@ -4553,6 +4644,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 							       NULL);
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
+				kfree(new_cfg);
 				return err;
 			}
 		}
@@ -4560,20 +4652,20 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	if (change_igmp &&
 	    (vxlan_addr_multicast(&dst->remote_ip) ||
-	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
+	     (cfg->flags & VXLAN_F_VNIFILTER)))
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
 	    (vxlan_addr_multicast(&dst->remote_ip) ||
-	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
+	     (new_cfg->flags & VXLAN_F_VNIFILTER)))
 		err = vxlan_multicast_join(vxlan);
 
 	return err;
@@ -4637,7 +4729,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = &vxlan->cfg;
+	cfg = rtnl_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
 		goto nla_put_failure;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index cf606256d0929c4dd356ec8aa343150c10edfb82..4ae6369ed4e35e307565f91d0706970f460af552 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -165,7 +165,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
+	const struct vxlan_config *cfg = rcu_dereference_rtnl(vxlan->cfg);
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -614,7 +614,9 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *vcfg = &vxlan->cfg;
+	const struct vxlan_config *vcfg;
+
+	vcfg = rtnl_dereference(vxlan->cfg);
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -959,12 +961,12 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
-	const struct vxlan_config *cfg = &vxlan->cfg;
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
index 3b75b48dc726df40cebb233095a8a046ee274c30..e2cf10da274f1b608d8bb5020d2b87ebfedeff46 100644
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
-		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
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
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
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
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
+	if (cfg->flags & VXLAN_F_VNIFILTER)
 		return vxlan_multicast_leave_vnigrp(vxlan);
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dc495d5eceb318be3c29e57d7a8bd431354ccec0..678565c4f8e277f31a485f8f7a2b79e1054ac530 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -178,7 +178,7 @@ void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vnode;
 
-	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return;
 
 	if (vninode) {
@@ -337,6 +337,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct tunnel_msg *new_tmsg, *tmsg;
+	const struct vxlan_config *cfg;
 	struct vxlan_vni_group *vg;
 	struct nlmsghdr *nlh;
 	int idx = 0, s_idx;
@@ -349,7 +350,8 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	}
 	s_idx = cb->args[1];
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!(cfg->flags & VXLAN_F_VNIFILTER)) {
 		cb->args[1] = 0;
 		cb->args[2] = 0;
 		return -EINVAL;
@@ -506,6 +508,7 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   u32 old_ifindex, u32 new_ifindex,
 				   struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	int err = 0;
 
 	if (old_remote_ip && remote_ip &&
@@ -519,7 +522,7 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
+				       cfg->dst_port,
 				       vni,
 				       vni,
 				       new_ifindex,
@@ -533,7 +536,7 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   *old_remote_ip,
-				   vxlan->cfg.dst_port,
+				   cfg->dst_port,
 				   vni, vni,
 				   old_ifindex,
 				   true);
@@ -683,6 +686,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   struct vxlan_vni_node *vninode)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_rdst *dst = &vxlan->default_dst;
 
 	/* if per vni remote_ip not present, delete the
@@ -694,7 +698,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
-				   vxlan->cfg.dst_port,
+				   cfg->dst_port,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
@@ -798,6 +802,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 			 u32 vni, union vxlan_addr *group,
 			 struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	struct vxlan_vni_node *vninode;
 	__be32 v = cpu_to_be32(vni);
 	bool changed = false;
@@ -806,7 +811,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	if (vxlan_vnifilter_lookup(vxlan, v))
 		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);
 
-	err = vxlan_vni_in_use(vxlan->net, vxlan, &vxlan->cfg, v);
+	err = vxlan_vni_in_use(vxlan->net, vxlan, cfg, v);
 	if (err) {
 		NL_SET_ERR_MSG(extack, "VNI in use");
 		return err;
@@ -1015,6 +1020,7 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	const struct vxlan_config *cfg;
 	struct tunnel_msg *tmsg;
 	struct vxlan_dev *vxlan;
 	struct net_device *dev;
@@ -1039,8 +1045,9 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	vxlan = netdev_priv(dev);
+	cfg = rtnl_dereference(vxlan->cfg);
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!(cfg->flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
 	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index d323f91af2364822e148310297c978fec7664010..7ced743ec8816d412bb14ec7ee7b422e97c38895 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -229,6 +229,7 @@ struct vxlan_config {
 	bool				no_share;
 	enum ifla_vxlan_df		df;
 	struct vxlanhdr			reserved_bits;
+	struct rcu_head			rcu;
 };
 
 enum {
@@ -302,7 +303,7 @@ struct vxlan_dev {
 	struct gro_cells  gro_cells;
 	unsigned long	  flags;
 
-	struct vxlan_config	cfg;
+	struct vxlan_config __rcu	*cfg;
 
 	struct vxlan_vni_group  __rcu *vnigrp;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

