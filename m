Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25A4A2045
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437339; cv=none; b=uFL0887h1bAGg6u8REQ9zqHhTCRFavS4mCetQ4YHgSPkX2IK3VRFrE3Msqw/Mwy/f33h6d1CMlNqq9zjF/9hFXyD2oc2TZ14DvyuQjbkXRf3RE08lgeSSG1IedWw1P1s77n5O7C0is/9XVwxH8BI8iC12wwGffYbQOr2H+11+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437339; c=relaxed/simple;
	bh=49/jvIADuEmUbRfBDlX+WrFEzqcxrCMyjxTzbDI72F4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nCk5oC+xgK+DPNjwxuPrtD5dJvFMPeMB7Y2dYe/c8j/gCCxY/Rk10onuXAHnJoghlH09sEOuyY7AHyjLMdNHr7SXjsJZK1EYgqQaZsCkqmiVMrJAkBKplWpm+9lFNXmpfjmQCq/cf/aG2DRDrP+F8nCZSUyGLirNB4aK0bMmBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGP5azzE; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGP5azzE"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90e8013741eso22815086d6.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437335; x=1789042135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhcWpY9kV4gM/QiL27s8TI97O2esPydZTJtcdJ3yhP4=;
        b=kGP5azzEWwnr4Kq4Ttbmi6GUSnitEexe3OwQvehS1tPzI9AMovGe0/tXdrdHza8Jfp
         aXEjMssoq0irmvvwWie3QXfpe5uirwb0luYGPXnrOgveOvHx0mV+bQLnd1M8GAYFgP8I
         GgGZCBSLkDMK0kKs63cKriTw3zLnUuiXCgsjZ28uzbuCXS4onujFonuB0/EkJwZCcfL7
         s+Uk9eikNRKmt+uFYvq0TZNAYov/nBGpg/ENHbrjAV5cYg7XBKtCqTLMB7UL7rPNfvKP
         g96Fty+dcRM6UPLDElG609Nug9uIelfNK+uqfOINQXu9fAYAlRYsTwWRFiekSIKnk1Yo
         lA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437335; x=1789042135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhcWpY9kV4gM/QiL27s8TI97O2esPydZTJtcdJ3yhP4=;
        b=agnrHgQ94DFNRLCV8zuqgDvkd8CWjXQqms1LAE852JtfzixVYBLzsIlazk5m9NV0O2
         LAKGTpd94GJvPuLqArTYePcBUBiaCgC3ZemJ4JQ5Yl90dUhistB9c5MzfwmW2pr/pIt1
         ngdGJwoIsUfNZdu1G1Xp2TxQsaE2Bh2Qo8wpBHB3BSwwVrxWAaDLs1dDbq1SehzW+noN
         gmJf7k9emVjg4Vu91LLaDbo1rnvcQBry3rwFzwdOOQSbL5WsQq8F5O65comXobStk6s/
         3FIrseZEsJj0t52b7t3qEG343rCRQ8JFIRDu0qa3iP3yQv9soMpymBeop23fkCuPbbmf
         D/nw==
X-Forwarded-Encrypted: i=1; AKwUvByvKA9uU01QmICF3lGhVFSfDTQNMJbeb4mDbUvOzBuT2sJGrFRkNXmfQc4FXP1EnyTpXuuogRY=@vger.kernel.org
X-Gm-Message-State: AFuF++n9DhxIaAsoGpOQltkxFfLGoNx4b8MR/modokq2OPMQmMNsOVra
	enHvofWc/3lSXKRi87EIOu1J5eRf7NPYW+F+waoHGBg/qmAx5qFwe98aaAtAQNOeHHZ+zhjIc81
	ECwhrd9fi7X0KCQ==
X-Received: from qvae18.prod.google.com ([2002:a05:6214:6212:b0:90c:e0b7:48d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ee4:0:b0:8ec:4ead:cda6 with SMTP id 6a1803df08f44-90ebafd39b1mr135640506d6.30.1788437334138;
 Thu, 03 Sep 2026 05:08:54 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:39 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-9-edumazet@google.com>
Subject: [PATCH net-next 8/9] vxlan: remove default_dst and use vxlan_config
 and lowerdev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is an RCU-protected pointer, storing default
destination attributes (remote_ip, remote_vni, remote_ifindex) in
vxlan->default_dst is redundant and creates potential data races for
lockless readers.

Furthermore, several fields of struct vxlan_rdst (remote_port,
offloaded, list, rcu, dst_cache) in default_dst were completely unused.

Replace vxlan->default_dst with a 'struct net_device *lowerdev' pointer
in struct vxlan_dev to track adjacent upper/lower netdev topology under
RTNL, and switch all remaining users over to reading configuration
attributes from vxlan->cfg.

Also update mlx5e_tc_tun_get_remote_ifindex() to read remote_ifindex
from vxlan->cfg under rcu_read_lock().

While updating lowerdev handling in vxlan_changelink(), avoid clobbering
lowerdev to NULL when unchanged, and properly unlink and clear
vxlan->lowerdev if the lower device is removed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  11 +-
 drivers/net/vxlan/vxlan_core.c                | 152 +++++++++---------
 drivers/net/vxlan/vxlan_mdb.c                 |  14 +-
 drivers/net/vxlan/vxlan_multicast.c           |  68 ++++----
 drivers/net/vxlan/vxlan_private.h             |  10 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  40 ++---
 include/net/vxlan.h                           |   2 +-
 7 files changed, 160 insertions(+), 137 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index 7a18a469961db809890d69f7d6d8bc656e560946..467fbe43b89e9bc3d28047a3a17a84495c3875af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -241,9 +241,16 @@ static bool mlx5e_tc_tun_encap_info_equal_vxlan(struct mlx5e_encap_key *a,
 static int mlx5e_tc_tun_get_remote_ifindex(struct net_device *mirred_dev)
 {
 	const struct vxlan_dev *vxlan = netdev_priv(mirred_dev);
-	const struct vxlan_rdst *dst = &vxlan->default_dst;
+	const struct vxlan_config *cfg;
+	int ifindex = 0;
 
-	return dst->remote_ifindex;
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	if (cfg)
+		ifindex = cfg->remote_ifindex;
+	rcu_read_unlock();
+
+	return ifindex;
 }
 
 struct mlx5e_tc_tunnel vxlan_tunnel = {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c49d55de020f49b68e322de2a4b0a5c0be0471ed..453cac5dde67ffe969edf9d3bdafe834c05632ad 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -804,6 +804,7 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 			       u32 nhid, struct netlink_ext_ack *extack)
 {
 	struct nexthop *old_nh = rtnl_dereference(fdb->nh);
+	const struct vxlan_config *cfg;
 	struct nexthop *nh;
 	int err = -EINVAL;
 
@@ -832,7 +833,8 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 	}
 
 	/* check nexthop group family */
-	switch (vxlan->default_dst.remote_ip.sa.sa_family) {
+	cfg = rtnl_dereference(vxlan->cfg);
+	switch (cfg->remote_ip.sa.sa_family) {
 	case AF_INET:
 		if (!nexthop_has_v4(nh)) {
 			err = -EAFNOSUPPORT;
@@ -1243,6 +1245,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			 const unsigned char *addr, u16 vid, u16 flags,
 			 bool *notified, struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	/* struct net *net = dev_net(vxlan->dev); */
 	union vxlan_addr ip;
@@ -1265,7 +1268,8 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (cfg->remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
@@ -2303,7 +2307,14 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	skb->dev = dev;
 	__skb_pull(skb, skb_network_offset(skb));
 
-	if (dst_vxlan->default_dst.remote_ip.sa.sa_family == AF_INET) {
+	rcu_read_lock();
+	dst_cfg = rcu_dereference(dst_vxlan->cfg);
+	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
+		goto drop;
+	}
+
+	if (dst_cfg->remote_ip.sa.sa_family == AF_INET) {
 		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		loopback.sa.sa_family =  AF_INET;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2313,13 +2324,6 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 #endif
 	}
 
-	rcu_read_lock();
-	dst_cfg = rcu_dereference(dst_vxlan->cfg);
-	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
-		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
-		goto drop;
-	}
-
 	if ((dst_cfg->flags & VXLAN_F_LEARN) && snoop)
 		vxlan_snoop(dev, dst_cfg, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
@@ -2333,8 +2337,9 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	} else {
 drop:
 		dev_dstats_rx_dropped(dev);
-		vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
-				      VXLAN_VNI_STATS_RX_DROPS, 0);
+		if (dst_cfg)
+			vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
+					      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
 	rcu_read_unlock();
 }
@@ -2960,10 +2965,14 @@ static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
 static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
 			     struct vxlan_dev_node *node)
 {
-	__be32 vni = vxlan->default_dst.remote_vni;
+	const struct vxlan_config *cfg;
+	__be32 vni;
 
 	ASSERT_RTNL();
 
+	cfg = rtnl_dereference(vxlan->cfg);
+	vni = cfg->vni;
+
 	node->vxlan = vxlan;
 	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
 }
@@ -3285,13 +3294,12 @@ static void vxlan_set_multicast_list(struct net_device *dev)
 static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 	const struct vxlan_config *cfg;
 	struct net_device *lowerdev;
 
 	cfg = rtnl_dereference(vxlan->cfg);
 
-	lowerdev = __dev_get_by_index(vxlan->net, dst->remote_ifindex);
+	lowerdev = __dev_get_by_index(vxlan->net, cfg->remote_ifindex);
 
 	/* This check is different than dev->max_mtu, because it looks at
 	 * the lowerdev->mtu, rather than the static dev->max_mtu
@@ -3620,9 +3628,11 @@ static int vxlan_get_link_ksettings(struct net_device *dev,
 				    struct ethtool_link_ksettings *cmd)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct net_device *lowerdev = __dev_get_by_index(vxlan->net,
-							 dst->remote_ifindex);
+	const struct vxlan_config *cfg;
+	struct net_device *lowerdev;
+
+	cfg = rtnl_dereference(vxlan->cfg);
+	lowerdev = __dev_get_by_index(vxlan->net, cfg->remote_ifindex);
 
 	if (!lowerdev) {
 		cmd->base.duplex = DUPLEX_UNKNOWN;
@@ -3997,7 +4007,6 @@ static void vxlan_config_apply(struct net_device *dev,
 			       bool changelink)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
 	struct vxlan_config *old_cfg;
 	int max_mtu = ETH_MAX_MTU;
@@ -4015,13 +4024,7 @@ static void vxlan_config_apply(struct net_device *dev,
 		vxlan->net = src_net;
 	}
 
-	dst->remote_vni = new_cfg->vni;
-
-	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
-
 	if (lowerdev) {
-		dst->remote_ifindex = new_cfg->remote_ifindex;
-
 		netif_inherit_tso_max(dev, lowerdev);
 
 		needed_headroom = lowerdev->hard_header_len;
@@ -4081,10 +4084,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
 	const struct vxlan_config *cfg;
-	struct vxlan_rdst *dst;
 	int err;
 
-	dst = &vxlan->default_dst;
 	err = vxlan_dev_configure(net, dev, conf, extack);
 	if (err)
 		return err;
@@ -4099,8 +4100,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 		return err;
 	}
 
-	if (dst->remote_ifindex) {
-		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
+	if (cfg->remote_ifindex) {
+		remote_dev = __dev_get_by_index(net, cfg->remote_ifindex);
 		if (!remote_dev) {
 			err = -ENODEV;
 			goto unregister;
@@ -4110,7 +4111,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 		if (err)
 			goto unregister;
 
-		dst->remote_dev = remote_dev;
+		vxlan->lowerdev = remote_dev;
 	}
 
 	err = rtnl_configure_link(dev, NULL, 0, NULL);
@@ -4118,16 +4119,18 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 		goto unlink;
 
 	/* create an fdb entry for a valid default destination */
-	if (!vxlan_addr_any(&dst->remote_ip)) {
+	if (!vxlan_addr_any(&cfg->remote_ip)) {
+		union vxlan_addr rip = cfg->remote_ip;
+
 		spin_lock_bh(&vxlan->hash_lock);
 		err = vxlan_fdb_update(vxlan, all_zeros_mac,
-				       &dst->remote_ip,
+				       &rip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
 				       cfg->dst_port,
-				       dst->remote_vni,
-				       dst->remote_vni,
-				       dst->remote_ifindex,
+				       cfg->vni,
+				       cfg->vni,
+				       cfg->remote_ifindex,
 				       NTF_SELF, 0, true, extack);
 		spin_unlock_bh(&vxlan->hash_lock);
 		if (err)
@@ -4545,13 +4548,11 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
 	struct vxlan_config *new_cfg;
-	struct vxlan_rdst *dst;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
 		return -EPERM;
 
-	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
 		return err;
@@ -4565,20 +4566,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!new_cfg)
 		return -ENOMEM;
 
-	if (dst->remote_dev == lowerdev)
-		lowerdev = NULL;
-
-	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
-					     extack);
-	if (err) {
-		kfree(new_cfg);
-		return err;
+	if (vxlan->lowerdev != lowerdev) {
+		err = netdev_adjacent_change_prepare(vxlan->lowerdev, lowerdev,
+						     dev, extack);
+		if (err) {
+			kfree(new_cfg);
+			return err;
+		}
 	}
 
-	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
+	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
 	change_igmp = vxlan->dev->flags & IFF_UP &&
 		      (rem_ip_changed ||
-		       dst->remote_ifindex != conf.remote_ifindex);
+		       cfg->remote_ifindex != conf.remote_ifindex);
 
 	/* handle default dst entry */
 	if (rem_ip_changed) {
@@ -4594,19 +4594,20 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       NTF_SELF, 0, true, extack);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
+				if (vxlan->lowerdev != lowerdev)
+					netdev_adjacent_change_abort(vxlan->lowerdev,
+								     lowerdev, dev);
 				kfree(new_cfg);
 				return err;
 			}
 		}
-		if (!vxlan_addr_any(&dst->remote_ip))
+		if (!vxlan_addr_any(&cfg->remote_ip))
 			__vxlan_fdb_delete(vxlan, all_zeros_mac,
-					   dst->remote_ip,
+					   cfg->remote_ip,
 					   cfg->dst_port,
-					   dst->remote_vni,
-					   dst->remote_vni,
-					   dst->remote_ifindex,
+					   cfg->vni,
+					   cfg->vni,
+					   cfg->remote_ifindex,
 					   true);
 		spin_unlock_bh(&vxlan->hash_lock);
 
@@ -4614,30 +4615,36 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		 * all vnis that were using default remote ip
 		 */
 		if (cfg->flags & VXLAN_F_VNIFILTER) {
-			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
+			err = vxlan_vnilist_update_group(vxlan, &cfg->remote_ip,
 							 &conf.remote_ip, extack);
 			if (err) {
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
+				if (vxlan->lowerdev != lowerdev)
+					netdev_adjacent_change_abort(vxlan->lowerdev,
+								     lowerdev, dev);
 				kfree(new_cfg);
 				return err;
 			}
 		}
 	}
 
-	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
+	if (change_igmp && vxlan_addr_multicast(&cfg->remote_ip))
 		err = vxlan_multicast_leave(vxlan);
 
 	if (netif_running(dev) && conf.age_interval != cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
-	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-	if (lowerdev && lowerdev != dst->remote_dev)
-		dst->remote_dev = lowerdev;
+	if (vxlan->lowerdev != lowerdev) {
+		if (lowerdev)
+			netdev_adjacent_change_commit(vxlan->lowerdev, lowerdev,
+						      dev);
+		else
+			netdev_upper_dev_unlink(vxlan->lowerdev, dev);
+		vxlan->lowerdev = lowerdev;
+	}
 	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);
 
 	if (!err && change_igmp &&
-	    vxlan_addr_multicast(&dst->remote_ip))
+	    vxlan_addr_multicast(&new_cfg->remote_ip))
 		err = vxlan_multicast_join(vxlan);
 
 	return err;
@@ -4652,8 +4659,8 @@ static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
-	if (vxlan->default_dst.remote_dev)
-		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
+	if (vxlan->lowerdev)
+		netdev_upper_dev_unlink(vxlan->lowerdev, dev);
 }
 
 static size_t vxlan_get_size(const struct net_device *dev)
@@ -4697,30 +4704,29 @@ static size_t vxlan_get_size(const struct net_device *dev)
 static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	const struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_rdst *dst = &vxlan->default_dst;
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
 	cfg = rtnl_dereference(vxlan->cfg);
 
-	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
+	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
 
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		if (dst->remote_ip.sa.sa_family == AF_INET) {
+	if (!vxlan_addr_any(&cfg->remote_ip)) {
+		if (cfg->remote_ip.sa.sa_family == AF_INET) {
 			if (nla_put_in_addr(skb, IFLA_VXLAN_GROUP,
-					    dst->remote_ip.sin.sin_addr.s_addr))
+					    cfg->remote_ip.sin.sin_addr.s_addr))
 				goto nla_put_failure;
 #if IS_ENABLED(CONFIG_IPV6)
 		} else {
 			if (nla_put_in6_addr(skb, IFLA_VXLAN_GROUP6,
-					     &dst->remote_ip.sin6.sin6_addr))
+					     &cfg->remote_ip.sin6.sin6_addr))
 				goto nla_put_failure;
 #endif
 		}
 	}
 
-	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
+	if (cfg->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, cfg->remote_ifindex))
 		goto nla_put_failure;
 
 	if (!vxlan_addr_any(&cfg->saddr)) {
@@ -4835,7 +4841,7 @@ static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 	LIST_HEAD(list_kill);
 
 	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		struct vxlan_rdst *dst = &vxlan->default_dst;
+		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 
 		/* In case we created vxlan device with carrier
 		 * and we loose the carrier due to module unload
@@ -4843,7 +4849,7 @@ static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 		 * cases, it's not necessary and remote_ifindex
 		 * is 0 here, so no matches.
 		 */
-		if (dst->remote_ifindex == dev->ifindex)
+		if (cfg->remote_ifindex == dev->ifindex)
 			vxlan_dellink(vxlan->dev, &list_kill);
 	}
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index dac224dce9b6ca0c23f9139a7a993a6e061b5c79..89e522a178ca189a58ec2fd1564ed1220b5b85a3 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -195,7 +195,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 			be16_to_cpu(rd->remote_port)))
 		goto nest_err;
 
-	if (rd->remote_vni != vxlan->default_dst.remote_vni &&
+	if (rd->remote_vni != cfg->vni &&
 	    nla_put_u32(skb, MDBA_MDB_EATTR_VNI, be32_to_cpu(rd->remote_vni)))
 		goto nest_err;
 
@@ -612,12 +612,12 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
-	cfg->group.vni = vxlan->default_dst.remote_vni;
+	cfg->group.vni = vcfg->vni;
 	INIT_LIST_HEAD(&cfg->src_list);
 	cfg->nlflags = nlmsg_flags;
 	cfg->filter_mode = MCAST_EXCLUDE;
 	cfg->rt_protocol = RTPROT_STATIC;
-	cfg->remote_vni = vxlan->default_dst.remote_vni;
+	cfg->remote_vni = vcfg->vni;
 	cfg->remote_port = vcfg->dst_port;
 
 	if (entry->ifindex != dev->ifindex) {
@@ -978,7 +978,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	if (rd->remote_port && rd->remote_port != cfg->dst_port)
 		nlmsg_size += nla_total_size(sizeof(u16));
 	/* MDBA_MDB_EATTR_VNI */
-	if (rd->remote_vni != vxlan->default_dst.remote_vni)
+	if (rd->remote_vni != cfg->vni)
 		nlmsg_size += nla_total_size(sizeof(u32));
 	/* MDBA_MDB_EATTR_IFINDEX */
 	if (rd->remote_ifindex)
@@ -1480,11 +1480,13 @@ static int vxlan_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_GET_ENTRY]);
 	struct nlattr *mdbe_attrs[MDBE_ATTR_MAX + 1];
+	const struct vxlan_config *cfg;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
 	memset(group, 0, sizeof(*group));
-	group->vni = vxlan->default_dst.remote_vni;
+	group->vni = cfg->vni;
 
 	if (!tb[MDBA_GET_ENTRY_ATTRS]) {
 		vxlan_mdb_group_set(group, entry, NULL);
@@ -1633,7 +1635,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	 * entries are stored with the VNI of the VXLAN device.
 	 */
 	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
-		src_vni = vxlan->default_dst.remote_vni;
+		src_vni = cfg->vni;
 
 	memset(&group, 0, sizeof(group));
 	group.vni = src_vni;
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index e2cf10da274f1b608d8bb5020d2b87ebfedeff46..ae0320921c8ca5da8c9fabda5852467f2872ce00 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -14,11 +14,12 @@
 /* Update multicast group membership when first VNI on
  * multicast address is brought up
  */
-int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
+int vxlan_igmp_join(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
 		    int rifindex)
 {
-	union vxlan_addr *ip = (rip ? : &vxlan->default_dst.remote_ip);
-	int ifindex = (rifindex ? : vxlan->default_dst.remote_ifindex);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	const union vxlan_addr *ip = (rip ? : &cfg->remote_ip);
+	int ifindex = (rifindex ? : cfg->remote_ifindex);
 	int ret = -EINVAL;
 	struct sock *sk;
 
@@ -47,11 +48,12 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	return ret;
 }
 
-int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
+int vxlan_igmp_leave(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
 		     int rifindex)
 {
-	union vxlan_addr *ip = (rip ? : &vxlan->default_dst.remote_ip);
-	int ifindex = (rifindex ? : vxlan->default_dst.remote_ifindex);
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	const union vxlan_addr *ip = (rip ? : &cfg->remote_ip);
+	int ifindex = (rifindex ? : cfg->remote_ifindex);
 	int ret = -EINVAL;
 	struct sock *sk;
 
@@ -80,8 +82,8 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	return ret;
 }
 
-static bool vxlan_group_used_match(union vxlan_addr *ip, int ifindex,
-				   union vxlan_addr *rip, int rifindex)
+static bool vxlan_group_used_match(const union vxlan_addr *ip, int ifindex,
+				   const union vxlan_addr *rip, int rifindex)
 {
 	if (!vxlan_addr_multicast(rip))
 		return false;
@@ -96,14 +98,16 @@ static bool vxlan_group_used_match(union vxlan_addr *ip, int ifindex,
 }
 
 static bool vxlan_group_used_by_vnifilter(struct vxlan_dev *vxlan,
-					  union vxlan_addr *ip, int ifindex)
+					  const struct vxlan_config *cfg,
+					  const union vxlan_addr *ip,
+					  int ifindex)
 {
 	struct vxlan_vni_group *vg = rtnl_dereference(vxlan->vnigrp);
 	struct vxlan_vni_node *v, *tmp;
 
 	if (vxlan_group_used_match(ip, ifindex,
-				   &vxlan->default_dst.remote_ip,
-				   vxlan->default_dst.remote_ifindex))
+				   &cfg->remote_ip,
+				   cfg->remote_ifindex))
 		return true;
 
 	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
@@ -112,7 +116,7 @@ static bool vxlan_group_used_by_vnifilter(struct vxlan_dev *vxlan,
 
 		if (vxlan_group_used_match(ip, ifindex,
 					   &v->remote_ip,
-					   vxlan->default_dst.remote_ifindex))
+					   cfg->remote_ifindex))
 			return true;
 	}
 
@@ -121,16 +125,17 @@ static bool vxlan_group_used_by_vnifilter(struct vxlan_dev *vxlan,
 
 /* See if multicast group is already in use by other ID */
 bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
-		      __be32 vni, union vxlan_addr *rip, int rifindex)
+		      __be32 vni, const union vxlan_addr *rip, int rifindex)
 {
-	union vxlan_addr *ip = (rip ? : &dev->default_dst.remote_ip);
-	int ifindex = (rifindex ? : dev->default_dst.remote_ifindex);
+	const struct vxlan_config *dev_cfg = rtnl_dereference(dev->cfg);
+	const union vxlan_addr *ip = (rip ? : &dev_cfg->remote_ip);
+	int ifindex = (rifindex ? : dev_cfg->remote_ifindex);
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *sock4;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct vxlan_sock *sock6;
 #endif
-	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
+	unsigned short family = dev_cfg->remote_ip.sa.sa_family;
 
 	sock4 = rtnl_dereference(dev->vn4_sock);
 
@@ -153,22 +158,22 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 			continue;
 
 		if (family == AF_INET &&
-		    rtnl_dereference(vxlan->vn4_sock) != sock4)
+			rtnl_dereference(vxlan->vn4_sock) != sock4)
 			continue;
 #if IS_ENABLED(CONFIG_IPV6)
 		if (family == AF_INET6 &&
-		    rtnl_dereference(vxlan->vn6_sock) != sock6)
+			rtnl_dereference(vxlan->vn6_sock) != sock6)
 			continue;
 #endif
 		cfg = rtnl_dereference(vxlan->cfg);
 
 		if (cfg->flags & VXLAN_F_VNIFILTER) {
-			if (!vxlan_group_used_by_vnifilter(vxlan, ip, ifindex))
+			if (!vxlan_group_used_by_vnifilter(vxlan, cfg, ip, ifindex))
 				continue;
 		} else {
 			if (!vxlan_group_used_match(ip, ifindex,
-						    &vxlan->default_dst.remote_ip,
-						    vxlan->default_dst.remote_ifindex))
+						    &cfg->remote_ip,
+						    cfg->remote_ifindex))
 				continue;
 		}
 
@@ -178,7 +183,8 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
 	return false;
 }
 
-static int vxlan_multicast_join_vnigrp(struct vxlan_dev *vxlan)
+static int vxlan_multicast_join_vnigrp(struct vxlan_dev *vxlan,
+				       const struct vxlan_config *cfg)
 {
 	struct vxlan_vni_group *vg = rtnl_dereference(vxlan->vnigrp);
 	struct vxlan_vni_node *v, *tmp, *vgood = NULL;
@@ -189,7 +195,7 @@ static int vxlan_multicast_join_vnigrp(struct vxlan_dev *vxlan)
 			continue;
 		/* skip if address is same as default address */
 		if (vxlan_addr_equal(&v->remote_ip,
-				     &vxlan->default_dst.remote_ip))
+				     &cfg->remote_ip))
 			continue;
 		ret = vxlan_igmp_join(vxlan, &v->remote_ip, 0);
 		if (ret == -EADDRINUSE)
@@ -204,7 +210,7 @@ static int vxlan_multicast_join_vnigrp(struct vxlan_dev *vxlan)
 			if (!vxlan_addr_multicast(&v->remote_ip))
 				continue;
 			if (vxlan_addr_equal(&v->remote_ip,
-					     &vxlan->default_dst.remote_ip))
+					     &cfg->remote_ip))
 				continue;
 			vxlan_igmp_leave(vxlan, &v->remote_ip, 0);
 			if (v == vgood)
@@ -240,9 +246,9 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 	int ret = 0;
 
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip)) {
-		ret = vxlan_igmp_join(vxlan, &vxlan->default_dst.remote_ip,
-				      vxlan->default_dst.remote_ifindex);
+	if (vxlan_addr_multicast(&cfg->remote_ip)) {
+		ret = vxlan_igmp_join(vxlan, &cfg->remote_ip,
+				      cfg->remote_ifindex);
 		if (ret == -EADDRINUSE)
 			ret = 0;
 		if (ret)
@@ -250,7 +256,7 @@ int vxlan_multicast_join(struct vxlan_dev *vxlan)
 	}
 
 	if (cfg->flags & VXLAN_F_VNIFILTER)
-		return vxlan_multicast_join_vnigrp(vxlan);
+		return vxlan_multicast_join_vnigrp(vxlan, cfg);
 
 	return 0;
 }
@@ -261,10 +267,10 @@ int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	int ret = 0;
 
-	if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
+	if (vxlan_addr_multicast(&cfg->remote_ip) &&
 	    !vxlan_group_used(vn, vxlan, 0, NULL, 0)) {
-		ret = vxlan_igmp_leave(vxlan, &vxlan->default_dst.remote_ip,
-				       vxlan->default_dst.remote_ifindex);
+		ret = vxlan_igmp_leave(vxlan, &cfg->remote_ip,
+				       cfg->remote_ifindex);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index ab7216c4e41011b99f8bf72de50fc2230b43c405..4f70afc502c906ca7361e33fee202d1a63da9506 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -216,8 +216,8 @@ void vxlan_vs_add_vnigrp(struct vxlan_dev *vxlan,
 			 bool ipv6);
 void vxlan_vs_del_vnigrp(struct vxlan_dev *vxlan);
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
-			       union vxlan_addr *old_remote_ip,
-			       union vxlan_addr *new_remote_ip,
+			       const union vxlan_addr *old_remote_ip,
+			       const union vxlan_addr *new_remote_ip,
 			       struct netlink_ext_ack *extack);
 
 
@@ -225,10 +225,10 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 int vxlan_multicast_join(struct vxlan_dev *vxlan);
 int vxlan_multicast_leave(struct vxlan_dev *vxlan);
 bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
-		      __be32 vni, union vxlan_addr *rip, int rifindex);
-int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
+		      __be32 vni, const union vxlan_addr *rip, int rifindex);
+int vxlan_igmp_join(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
 		    int rifindex);
-int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
+int vxlan_igmp_leave(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
 		     int rifindex);
 
 /* vxlan_mdb.c */
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 1069d6b1b2955c54d0ce0f89860390ebc0ff8f15..35ec32938004d7fbc33f93345006151f56f4d629 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -478,24 +478,25 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
 };
 
 static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
-					  union vxlan_addr *old_remote_ip,
-					  union vxlan_addr *remote_ip,
+					  const union vxlan_addr *old_remote_ip,
+					  const union vxlan_addr *remote_ip,
 					  struct netlink_ext_ack *extack)
 {
 	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 	int err = 0;
 
 	spin_lock_bh(&vxlan->hash_lock);
 	if (remote_ip && !vxlan_addr_any(remote_ip)) {
+		union vxlan_addr rip = *remote_ip;
+
 		err = vxlan_fdb_update(vxlan, all_zeros_mac,
-				       remote_ip,
+				       &rip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
 				       cfg->dst_port,
 				       vni,
 				       vni,
-				       dst->remote_ifindex,
+				       cfg->remote_ifindex,
 				       NTF_SELF, 0, true, extack);
 		if (err) {
 			spin_unlock_bh(&vxlan->hash_lock);
@@ -508,7 +509,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   *old_remote_ip,
 				   cfg->dst_port,
 				   vni, vni,
-				   dst->remote_ifindex,
+				   cfg->remote_ifindex,
 				   true);
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
@@ -523,8 +524,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	union vxlan_addr *newrip = NULL, *oldrip = NULL;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	const union vxlan_addr *newrip = NULL, *oldrip = NULL;
 	union vxlan_addr old_remote_ip;
 	int ret = 0;
 
@@ -536,8 +537,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 	if (group && !vxlan_addr_any(group)) {
 		newrip = group;
 	} else {
-		if (!vxlan_addr_any(&dst->remote_ip))
-			newrip = &dst->remote_ip;
+		if (!vxlan_addr_any(&cfg->remote_ip))
+			newrip = &cfg->remote_ip;
 	}
 
 	/* if old rip exists, and no newrip,
@@ -565,7 +566,7 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 		if (vxlan_addr_multicast(&old_remote_ip) &&
 		    !vxlan_group_used(vn, vxlan, vninode->vni,
 				      &old_remote_ip,
-				      vxlan->default_dst.remote_ifindex)) {
+				      cfg->remote_ifindex)) {
 			ret = vxlan_igmp_leave(vxlan, &old_remote_ip,
 					       0);
 			if (ret)
@@ -589,8 +590,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 }
 
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
-			       union vxlan_addr *old_remote_ip,
-			       union vxlan_addr *new_remote_ip,
+			       const union vxlan_addr *old_remote_ip,
+			       const union vxlan_addr *new_remote_ip,
 			       struct netlink_ext_ack *extack)
 {
 	struct list_head *headp, *hpos;
@@ -621,20 +622,19 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 
 	/* if per vni remote_ip not present, delete the
 	 * default dst remote_ip previously added for this vni
 	 */
 	if (!vxlan_addr_any(&vninode->remote_ip) ||
-	    !vxlan_addr_any(&dst->remote_ip)) {
+	    !vxlan_addr_any(&cfg->remote_ip)) {
 		spin_lock_bh(&vxlan->hash_lock);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
-				   dst->remote_ip : vninode->remote_ip),
+				   cfg->remote_ip : vninode->remote_ip),
 				   cfg->dst_port,
 				   vninode->vni, vninode->vni,
-				   dst->remote_ifindex,
+				   cfg->remote_ifindex,
 				   true);
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
@@ -643,7 +643,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		if (vxlan_addr_multicast(&vninode->remote_ip) &&
 		    !vxlan_group_used(vn, vxlan, vninode->vni,
 				      &vninode->remote_ip,
-				      dst->remote_ifindex)) {
+				      cfg->remote_ifindex)) {
 			vxlan_igmp_leave(vxlan, &vninode->remote_ip, 0);
 		}
 	}
@@ -854,6 +854,7 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 				    int cmd, struct netlink_ext_ack *extack)
 {
 	struct nlattr *vattrs[VXLAN_VNIFILTER_ENTRY_MAX + 1];
+	const struct vxlan_config *cfg;
 	u32 vni_start = 0, vni_end = 0;
 	union vxlan_addr group;
 	int err;
@@ -891,7 +892,8 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 		memset(&group, 0, sizeof(group));
 	}
 
-	if (vxlan_addr_multicast(&group) && !vxlan->default_dst.remote_ifindex) {
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (vxlan_addr_multicast(&group) && !cfg->remote_ifindex) {
 		NL_SET_ERR_MSG(extack,
 			       "Local interface required for multicast remote group");
 
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7eb4f8110a84872f1d0451f7ccef3a73ba5c2e7a..8482954bff7692129ed684240c1b94feac7c3c00 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -296,7 +296,7 @@ struct vxlan_dev {
 #endif
 	struct net_device *dev;
 	struct net	  *net;		/* netns for packet i/o */
-	struct vxlan_rdst default_dst;	/* default destination */
+	struct net_device *lowerdev;
 
 	struct timer_list age_timer;
 	spinlock_t	  hash_lock;
-- 
2.55.0.970.g62bdec98f9-goog

