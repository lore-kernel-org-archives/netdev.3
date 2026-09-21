Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715F45D909
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984941; cv=none; b=b5FTNFKPFfgnrJWOI00F+jOkoKBguS3LZOqj8mZm6RKN7mvAaj9DDbA5lnpXa3fQWYaxakB9dmzw58F3wdRj6Q5ZaIlk4m/RnSdSvPxOzs2tGpBhOIUHlnrJFEA/9jiba4/t6CQg+xtnUHV2nNXubfsAvevjxgppbrOa49z7CqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984941; c=relaxed/simple;
	bh=xEIWYbE2TFIBltjAbValqp4Yu4NVtNiwJrIC4RqsNKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FPpBjwZpZ/BBIPRaJoUe8P3e1QM8VjNviyrek0YkhSLyKTqHOXApnfipTQLIrs2QaKdrc8IK1ttu2qUdir6gu9sxRI2E/jMkRlkXDW7pKq7aNFswCfw9Y+KdSwbYRT1K5rf2O2BK+u4Wy0/BLXb60Gy70BOUwbQFlZdEsFjz4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WU8+5mOg; arc=none smtp.client-ip=209.85.221.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WU8+5mOg"
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7d5444845so4446700e0c.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984937; x=1790589737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MezLHCSX1nWuTSJe29PS12BeebRGvMBCk/Y+Zxk7clg=;
        b=WU8+5mOgd9VVpoBq4yp7UUjRHH+0qmn0l+PIr4Ku1G5H/jvWptgxuDJ/x5A7Humdjz
         oE/S4ZY+UT9868U6b1Mz/cpf4nfyPskNpCoYlRVkvRvtcP5LKh6xAfeKnvFdDjyNwPeL
         1zoxv+mLlluWDWwUimpoVJfAGOFl25OghN4h7xm2PXQ7w7TrVVm05ESXgjwmzQpdLPLg
         c00EljJ6AWTF3WWd/rvTdwQuKr/L2cVdr8uwDXttZmlSm4S9ihPPhS+bn6/bsfUkFZWH
         Y6Q3RZLca96WgmLuVa5u46QyKOIkno6S14thRZ0GlHH4mrNYK9EgFORSuQtP9UOMpHaw
         raMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984937; x=1790589737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MezLHCSX1nWuTSJe29PS12BeebRGvMBCk/Y+Zxk7clg=;
        b=zhZ5Uv/0rs43vhltFxxu3CxNPIALWRdq16VwzZ5+Az8Y+FeVpQ8rTaMwAFgRpbm5aG
         DKjVGs925mDslnRG/4S6wR0LMF7S5I/dNjT0VTWQWGQ6UgLYw0znZ483hSn2e9rxabof
         m32Rl++tJ77bHE28vYHTX/7mGhJ8yZMGLuJXXyux+2HxJKepHOzC/IclMWObyWoeuzwI
         5X3CyL6rotSaD2oI3hn4EfDyWMuLSUdxO8+HGiqtQMcjSpJQDh5qoIreYW8luOBRqjNp
         wc4f4VpiBiBY89XqO9AWjERDX8F5qMAb7GsIXQK1GL5LUmPuGHbGcUu7GERKjD95YuqF
         B5qw==
X-Forwarded-Encrypted: i=1; AKwUvBy9ZcsWiPPT32sEf0F8pAmn1tkAxYEf9cFJErv0Z9uy2lyJ3SD4jdwpLBqHT4wYhiECsqKZ9jw=@vger.kernel.org
X-Gm-Message-State: AFuF++k8N5E4msP7cIC4YAKbXm9CvpgO3iduQYUlMVdXVFzKXBfjNkBT
	8Iw0dKvAZuohXbH3h6CEvM1YXqEg2ev152nwgqHg7LJuQtUnOe1cDsavrPxiDrNOk47Pj15q3FO
	bnTYxVpDTw7oKyg==
X-Received: from qkjw14.prod.google.com ([2002:a05:620a:148e:b0:93a:761:e75c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:1d08:b0:5c9:a60b:e5ac with SMTP id 71dfb90a1353d-5c9b59a397amr4840973e0c.14.1789984913118;
 Mon, 21 Sep 2026 03:01:53 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:38 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-8-edumazet@google.com>
Subject: [PATCH v5 net-next 7/8] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is an RCU-protected pointer, storing default
destination attributes (remote_ip, remote_vni, remote_ifindex) in
vxlan->default_dst is redundant and creates potential data races for
lockless readers.

Furthermore, several fields of struct vxlan_rdst (remote_port,
offloaded, list, rcu, dst_cache) in default_dst were completely unused.
The remaining one, remote_dev, only tracked the lower device, a role
now taken by vxlan->lowerdev, so drop it from struct vxlan_rdst.

Replace vxlan->default_dst with a 'struct net_device *lowerdev' pointer
in struct vxlan_dev to track adjacent upper/lower netdev topology under
RTNL, and switch all remaining users over to reading configuration
attributes from vxlan->cfg.

Also update mlx5e_tc_tun_get_remote_ifindex() to read remote_ifindex
from vxlan->cfg under rcu_read_lock().

In vxlan_changelink(), pass lowerdev to vxlan_config_apply() to preserve
needed_headroom and needed_tailroom. The mtu is still only reconsidered
when the lower device changes, so that an unrelated changelink can not
shrink it.

cfg->remote_ifindex is now committed unconditionally, where
default_dst.remote_ifindex was left untouched when IFLA_VXLAN_LINK was
cleared, so a changelink dropping the lower device no longer leaves a
stale ifindex behind. For the same reason vxlan_changelink() no longer
needs to compute the ifindex that will actually be committed.

Setting IFLA_VXLAN_LINK to 0 now also tears down the upper/lower
adjacency, which netdev_adjacent_change_commit() used to skip for a NULL
new device, resets needed_tailroom, and is rejected if per-VNI multicast
groups are configured.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  11 +-
 drivers/net/vxlan/vxlan_core.c                | 201 ++++++++++--------
 drivers/net/vxlan/vxlan_mdb.c                 |  14 +-
 drivers/net/vxlan/vxlan_multicast.c           |  64 +++---
 drivers/net/vxlan/vxlan_private.h             |  15 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  57 +++--
 include/net/vxlan.h                           |   3 +-
 7 files changed, 207 insertions(+), 158 deletions(-)

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
index 04b2925d7c38aafea3c4ab1a1b34ac1feeb93afe..b505fefcef70ae9e1704eb5ad5f50a3d5d7488cf 100644
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
@@ -1249,6 +1251,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			 const unsigned char *addr, u16 vid, u16 flags,
 			 bool *notified, struct netlink_ext_ack *extack)
 {
+	const struct vxlan_config *cfg;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	/* struct net *net = dev_net(vxlan->dev); */
 	union vxlan_addr ip;
@@ -1276,7 +1279,8 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
-	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (cfg->remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
@@ -2318,7 +2322,14 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	skb->dev = dev;
 	__skb_pull(skb, skb_network_offset(skb));
 
-	if (dst_vxlan->default_dst.remote_ip.sa.sa_family == AF_INET) {
+	rcu_read_lock();
+	dst_cfg = rcu_dereference(dst_vxlan->cfg);
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
+		goto drop;
+	}
+
+	if (dst_cfg->remote_ip.sa.sa_family == AF_INET) {
 		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		loopback.sa.sa_family =  AF_INET;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2328,13 +2339,6 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 #endif
 	}
 
-	rcu_read_lock();
-	dst_cfg = rcu_dereference(dst_vxlan->cfg);
-	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
-		goto drop;
-	}
-
 	if ((dst_cfg->flags & VXLAN_F_LEARN) && snoop)
 		vxlan_snoop(dev, dst_cfg, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
@@ -2973,10 +2977,14 @@ static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
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
@@ -3298,13 +3306,12 @@ static void vxlan_set_multicast_list(struct net_device *dev)
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
@@ -3633,9 +3640,11 @@ static int vxlan_get_link_ksettings(struct net_device *dev,
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
@@ -3973,6 +3982,13 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 			return -EINVAL;
 		}
 
+		if ((conf->flags & VXLAN_F_VNIFILTER) && old &&
+		    vxlan_vnifilter_has_multicast(old)) {
+			NL_SET_ERR_MSG(extack,
+				       "Local interface required for multicast remote group");
+			return -EINVAL;
+		}
+
 #if IS_ENABLED(CONFIG_IPV6)
 		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
 			NL_SET_ERR_MSG(extack,
@@ -4007,10 +4023,9 @@ static void vxlan_config_apply(struct net_device *dev,
 			       struct vxlan_config *new_cfg,
 			       struct net_device *lowerdev,
 			       struct net *src_net,
-			       bool changelink)
+			       bool changelink, bool lowerdev_changed)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 	unsigned short needed_headroom = ETH_HLEN;
 	struct vxlan_config *old_cfg;
 	int max_mtu = ETH_MAX_MTU;
@@ -4023,18 +4038,13 @@ static void vxlan_config_apply(struct net_device *dev,
 			vxlan_ether_setup(dev);
 
 		if (new_cfg->mtu)
-			dev->mtu = new_cfg->mtu;
+			WRITE_ONCE(dev->mtu, new_cfg->mtu);
 
 		vxlan->net = src_net;
 	}
 
-	dst->remote_vni = new_cfg->vni;
-
-	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
-
+	dev->needed_tailroom = 0;
 	if (lowerdev) {
-		dst->remote_ifindex = new_cfg->remote_ifindex;
-
 		netif_inherit_tso_max(dev, lowerdev);
 
 		needed_headroom = lowerdev->hard_header_len;
@@ -4042,16 +4052,17 @@ static void vxlan_config_apply(struct net_device *dev,
 
 		dev->needed_tailroom = lowerdev->needed_tailroom;
 
-		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
+		max_mtu = READ_ONCE(lowerdev->mtu) - vxlan_headroom(flags);
 		if (max_mtu < ETH_MIN_MTU)
 			max_mtu = ETH_MIN_MTU;
 
 		if (!changelink && !new_cfg->mtu)
-			dev->mtu = max_mtu;
+			WRITE_ONCE(dev->mtu, max_mtu);
 	}
 
-	if (dev->mtu > max_mtu)
-		dev->mtu = max_mtu;
+	/* A changelink leaving the lower device alone must not shrink the mtu */
+	if (lowerdev_changed && READ_ONCE(dev->mtu) > max_mtu)
+		WRITE_ONCE(dev->mtu, max_mtu);
 
 	if (flags & VXLAN_F_COLLECT_METADATA)
 		flags |= VXLAN_F_IPV6;
@@ -4081,7 +4092,7 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 	if (!new_cfg)
 		return -ENOMEM;
 
-	vxlan_config_apply(dev, new_cfg, lowerdev, src_net, false);
+	vxlan_config_apply(dev, new_cfg, lowerdev, src_net, false, true);
 
 	return 0;
 }
@@ -4094,10 +4105,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
 	const struct vxlan_config *cfg;
-	struct vxlan_rdst *dst;
 	int err;
 
-	dst = &vxlan->default_dst;
 	err = vxlan_dev_configure(net, dev, conf, extack);
 	if (err)
 		return err;
@@ -4112,8 +4121,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 		return err;
 	}
 
-	if (dst->remote_ifindex) {
-		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
+	if (cfg->remote_ifindex) {
+		remote_dev = __dev_get_by_index(net, cfg->remote_ifindex);
 		if (!remote_dev) {
 			err = -ENODEV;
 			goto unregister;
@@ -4123,7 +4132,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 		if (err)
 			goto unregister;
 
-		dst->remote_dev = remote_dev;
+		vxlan->lowerdev = remote_dev;
 	}
 
 	err = rtnl_configure_link(dev, NULL, 0, NULL);
@@ -4131,16 +4140,18 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
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
@@ -4552,20 +4563,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct nlattr *data[],
 			    struct netlink_ext_ack *extack)
 {
+	bool lowerdev_changed, rem_ip_changed, change_igmp;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
-	bool rem_ip_changed, change_igmp;
+	const struct vxlan_config *cfg;
+	struct vxlan_config *new_cfg;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
-	struct vxlan_config *new_cfg;
-	struct vxlan_rdst *dst;
-	u32 new_ifindex;
 	int err;
 
+	cfg = rtnl_dereference(vxlan->cfg);
+
 	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
 		return -EPERM;
 
-	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
 		return err;
@@ -4579,26 +4589,23 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
+	lowerdev_changed = vxlan->lowerdev != lowerdev;
+	if (lowerdev_changed) {
+		err = netdev_adjacent_change_prepare(vxlan->lowerdev, lowerdev,
+						     dev, extack);
+		if (err) {
+			kfree(new_cfg);
+			return err;
+		}
 	}
 
-	/* vxlan_config_apply() only commits remote_ifindex if lowerdev is set */
-	new_ifindex = lowerdev ? conf.remote_ifindex : dst->remote_ifindex;
-
-	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
+	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
 	change_igmp = vxlan->dev->flags & IFF_UP &&
 		      (rem_ip_changed ||
-		       dst->remote_ifindex != new_ifindex);
+		       cfg->remote_ifindex != conf.remote_ifindex);
 
 	/* handle default dst entry */
-	if (rem_ip_changed || dst->remote_ifindex != new_ifindex) {
+	if (rem_ip_changed || cfg->remote_ifindex != conf.remote_ifindex) {
 		spin_lock_bh(&vxlan->hash_lock);
 		if (!vxlan_addr_any(&conf.remote_ip)) {
 			err = vxlan_fdb_update(vxlan, all_zeros_mac,
@@ -4607,23 +4614,24 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       NLM_F_APPEND | NLM_F_CREATE,
 					       cfg->dst_port,
 					       conf.vni, conf.vni,
-					       new_ifindex,
+					       conf.remote_ifindex,
 					       NTF_SELF, 0, true, extack);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
+				if (lowerdev_changed)
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
 
@@ -4631,19 +4639,21 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		 * all vnis
 		 */
 		if (cfg->flags & VXLAN_F_VNIFILTER) {
-			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
+			err = vxlan_vnilist_update_group(vxlan, &cfg->remote_ip,
 							 &conf.remote_ip,
-							 dst->remote_ifindex,
-							 new_ifindex, extack);
+							 cfg->remote_ifindex,
+							 conf.remote_ifindex,
+							 extack);
 			if (err) {
 				vxlan_update_default_fdb_entry(vxlan, conf.vni,
 							       &conf.remote_ip,
-							       &dst->remote_ip,
-							       new_ifindex,
-							       dst->remote_ifindex,
+							       &cfg->remote_ip,
+							       conf.remote_ifindex,
+							       cfg->remote_ifindex,
 							       NULL);
-				netdev_adjacent_change_abort(dst->remote_dev,
-							     lowerdev, dev);
+				if (lowerdev_changed)
+					netdev_adjacent_change_abort(vxlan->lowerdev,
+								     lowerdev, dev);
 				kfree(new_cfg);
 				return err;
 			}
@@ -4651,20 +4661,26 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (change_igmp &&
-	    (vxlan_addr_multicast(&dst->remote_ip) ||
+	    (vxlan_addr_multicast(&cfg->remote_ip) ||
 	     (cfg->flags & VXLAN_F_VNIFILTER)))
 		err = vxlan_multicast_leave(vxlan);
 
 	if (netif_running(dev) && conf.age_interval != cfg->age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
-	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-	if (lowerdev && lowerdev != dst->remote_dev)
-		dst->remote_dev = lowerdev;
-	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);
+	if (lowerdev_changed) {
+		if (lowerdev)
+			netdev_adjacent_change_commit(vxlan->lowerdev, lowerdev,
+						      dev);
+		else
+			netdev_upper_dev_unlink(vxlan->lowerdev, dev);
+		vxlan->lowerdev = lowerdev;
+	}
+	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true,
+			   lowerdev_changed);
 
 	if (!err && change_igmp &&
-	    (vxlan_addr_multicast(&dst->remote_ip) ||
+	    (vxlan_addr_multicast(&new_cfg->remote_ip) ||
 	     (new_cfg->flags & VXLAN_F_VNIFILTER)))
 		err = vxlan_multicast_join(vxlan);
 
@@ -4680,8 +4696,8 @@ static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
-	if (vxlan->default_dst.remote_dev)
-		netdev_upper_dev_unlink(vxlan->default_dst.remote_dev, dev);
+	if (vxlan->lowerdev)
+		netdev_upper_dev_unlink(vxlan->lowerdev, dev);
 }
 
 static size_t vxlan_get_size(const struct net_device *dev)
@@ -4725,30 +4741,29 @@ static size_t vxlan_get_size(const struct net_device *dev)
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
@@ -4863,7 +4878,7 @@ static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 	LIST_HEAD(list_kill);
 
 	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		struct vxlan_rdst *dst = &vxlan->default_dst;
+		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
 
 		/* In case we created vxlan device with carrier
 		 * and we loose the carrier due to module unload
@@ -4871,7 +4886,7 @@ static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 		 * cases, it's not necessary and remote_ifindex
 		 * is 0 here, so no matches.
 		 */
-		if (dst->remote_ifindex == dev->ifindex)
+		if (cfg->remote_ifindex == dev->ifindex)
 			vxlan_dellink(vxlan->dev, &list_kill);
 	}
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 4ae6369ed4e35e307565f91d0706970f460af552..c1a0551990555ce3e1dca81a9b5df7196a2a5fdf 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -195,7 +195,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 			be16_to_cpu(rd->remote_port)))
 		goto nest_err;
 
-	if (rd->remote_vni != vxlan->default_dst.remote_vni &&
+	if (rd->remote_vni != cfg->vni &&
 	    nla_put_u32(skb, MDBA_MDB_EATTR_VNI, be32_to_cpu(rd->remote_vni)))
 		goto nest_err;
 
@@ -620,12 +620,12 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 
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
@@ -986,7 +986,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	if (rd->remote_port && rd->remote_port != cfg->dst_port)
 		nlmsg_size += nla_total_size(sizeof(u16));
 	/* MDBA_MDB_EATTR_VNI */
-	if (rd->remote_vni != vxlan->default_dst.remote_vni)
+	if (rd->remote_vni != cfg->vni)
 		nlmsg_size += nla_total_size(sizeof(u32));
 	/* MDBA_MDB_EATTR_IFINDEX */
 	if (rd->remote_ifindex)
@@ -1488,11 +1488,13 @@ static int vxlan_mdb_get_parse(struct net_device *dev, struct nlattr *tb[],
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
@@ -1641,7 +1643,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	 * entries are stored with the VNI of the VXLAN device.
 	 */
 	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
-		src_vni = vxlan->default_dst.remote_vni;
+		src_vni = cfg->vni;
 
 	memset(&group, 0, sizeof(group));
 	group.vni = src_vni;
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index e2cf10da274f1b608d8bb5020d2b87ebfedeff46..6fcc4a36734361c28563d487d4ec108ca22d9e4f 100644
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
 
@@ -163,12 +168,12 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
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
index a2034ad418f7f77f64d8d81cb2312fcc608c7a0f..f0ee85f83732a2924236995015ae0d3a4f4cb872 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -224,14 +224,15 @@ void vxlan_vs_add_vnigrp(struct vxlan_dev *vxlan,
 			 struct vxlan_sock *vs,
 			 bool ipv6);
 void vxlan_vs_del_vnigrp(struct vxlan_dev *vxlan);
+bool vxlan_vnifilter_has_multicast(const struct vxlan_dev *vxlan);
 int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
-				   union vxlan_addr *old_remote_ip,
-				   union vxlan_addr *remote_ip,
+				   const union vxlan_addr *old_remote_ip,
+				   const union vxlan_addr *remote_ip,
 				   u32 old_ifindex, u32 new_ifindex,
 				   struct netlink_ext_ack *extack);
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
-			       union vxlan_addr *old_remote_ip,
-			       union vxlan_addr *new_remote_ip,
+			       const union vxlan_addr *old_remote_ip,
+			       const union vxlan_addr *new_remote_ip,
 			       u32 old_ifindex, u32 new_ifindex,
 			       struct netlink_ext_ack *extack);
 
@@ -240,10 +241,10 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
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
index 678565c4f8e277f31a485f8f7a2b79e1054ac530..48135ff9b95a1b2710b61f2e5e406816d4661367 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -502,9 +502,25 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
 	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
 };
 
+bool vxlan_vnifilter_has_multicast(const struct vxlan_dev *vxlan)
+{
+	struct vxlan_vni_group *vg = rtnl_dereference(vxlan->vnigrp);
+	struct vxlan_vni_node *v;
+
+	if (!vg)
+		return false;
+
+	list_for_each_entry(v, &vg->vni_list, vlist) {
+		if (vxlan_addr_multicast(&v->remote_ip))
+			return true;
+	}
+
+	return false;
+}
+
 int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
-				   union vxlan_addr *old_remote_ip,
-				   union vxlan_addr *remote_ip,
+				   const union vxlan_addr *old_remote_ip,
+				   const union vxlan_addr *remote_ip,
 				   u32 old_ifindex, u32 new_ifindex,
 				   struct netlink_ext_ack *extack)
 {
@@ -518,8 +534,10 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 
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
@@ -553,8 +571,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 				  struct netlink_ext_ack *extack)
 {
 	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
-	struct vxlan_rdst *dst = &vxlan->default_dst;
-	union vxlan_addr *newrip = NULL, *oldrip = NULL;
+	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
+	const union vxlan_addr *newrip = NULL, *oldrip = NULL;
 	union vxlan_addr old_remote_ip;
 	int ret = 0;
 
@@ -566,8 +584,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 	if (group && !vxlan_addr_any(group)) {
 		newrip = group;
 	} else {
-		if (!vxlan_addr_any(&dst->remote_ip))
-			newrip = &dst->remote_ip;
+		if (!vxlan_addr_any(&cfg->remote_ip))
+			newrip = &cfg->remote_ip;
 	}
 
 	/* if old rip exists, and no newrip,
@@ -584,8 +602,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 
 	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
 					     oldrip, newrip,
-					     dst->remote_ifindex,
-					     dst->remote_ifindex,
+					     cfg->remote_ifindex,
+					     cfg->remote_ifindex,
 					     extack);
 	if (ret)
 		goto out;
@@ -600,7 +618,7 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 		if (vxlan_addr_multicast(&old_remote_ip) &&
 		    !vxlan_group_used(vn, vxlan, vninode->vni,
 				      &old_remote_ip,
-				      vxlan->default_dst.remote_ifindex)) {
+				      cfg->remote_ifindex)) {
 			ret = vxlan_igmp_leave(vxlan, &old_remote_ip,
 					       0);
 			if (ret)
@@ -624,12 +642,12 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 }
 
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
-			       union vxlan_addr *old_remote_ip,
-			       union vxlan_addr *new_remote_ip,
+			       const union vxlan_addr *old_remote_ip,
+			       const union vxlan_addr *new_remote_ip,
 			       u32 old_ifindex, u32 new_ifindex,
 			       struct netlink_ext_ack *extack)
 {
-	union vxlan_addr *oldrip, *newrip;
+	const union vxlan_addr *oldrip, *newrip;
 	struct list_head *headp, *hpos;
 	struct vxlan_vni_group *vg;
 	struct vxlan_vni_node *vent;
@@ -687,20 +705,19 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
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
@@ -709,7 +726,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		if (vxlan_addr_multicast(&vninode->remote_ip) &&
 		    !vxlan_group_used(vn, vxlan, vninode->vni,
 				      &vninode->remote_ip,
-				      dst->remote_ifindex)) {
+				      cfg->remote_ifindex)) {
 			vxlan_igmp_leave(vxlan, &vninode->remote_ip, 0);
 		}
 	}
@@ -924,6 +941,7 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 				    int cmd, struct netlink_ext_ack *extack)
 {
 	struct nlattr *vattrs[VXLAN_VNIFILTER_ENTRY_MAX + 1];
+	const struct vxlan_config *cfg;
 	u32 vni_start = 0, vni_end = 0;
 	union vxlan_addr group;
 	int err;
@@ -961,7 +979,8 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 		memset(&group, 0, sizeof(group));
 	}
 
-	if (vxlan_addr_multicast(&group) && !vxlan->default_dst.remote_ifindex) {
+	cfg = rtnl_dereference(vxlan->cfg);
+	if (vxlan_addr_multicast(&group) && !cfg->remote_ifindex) {
 		NL_SET_ERR_MSG(extack,
 			       "Local interface required for multicast remote group");
 
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7ced743ec8816d412bb14ec7ee7b422e97c38895..c3c9f2ccc3d1bfdf661312482856e0714e9ea3a6 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -204,7 +204,6 @@ struct vxlan_rdst {
 	u8			 offloaded:1;
 	__be32			 remote_vni;
 	u32			 remote_ifindex;
-	struct net_device	 *remote_dev;
 	struct list_head	 list;
 	struct rcu_head		 rcu;
 	struct dst_cache	 dst_cache;
@@ -295,7 +294,7 @@ struct vxlan_dev {
 #endif
 	struct net_device *dev;
 	struct net	  *net;		/* netns for packet i/o */
-	struct vxlan_rdst default_dst;	/* default destination */
+	struct net_device *lowerdev;
 
 	struct timer_list age_timer;
 	spinlock_t	  hash_lock;
-- 
2.55.0.1082.g2b9226bbc0-goog

