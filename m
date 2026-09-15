Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464924B2046
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494918; cv=none; b=g03iwxiLKDjs9UhsjwtRdleJknqFLcc4W6naJnpnNfRI0XzqOi+/iZHPRfgO6yzXvR0EFoMx2NVBUfsrlgkIrTlRiOEuPB0jj9aUzY1EvwEyrpCkS4B48PgHSSP+rGCjVFYLUS+9vzf0+wmTZ+uTu1Izg7RPDltBSbHhNwK37Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494918; c=relaxed/simple;
	bh=L2k7VpyHdybe6qrV2e44zsJgQZQCGlaQjLEb2p+bZEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvNk4PYpf9Z1xIh1UakZSAyEi8Gp76rHPPPXpS7VQP0yVWiIYtwWpUypOqf337x+PVXJf34vPOL5Q4oDVweUVUykL+chNCT3xFmdPTNdfKcYkWC9+sWrWvS7U6cwiEi8WLFtoHquOPmx+IGUtB0Wqn/dfQeLnQYcdIPgCWwgElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdfgEQFU; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdfgEQFU"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90ce8ad8002so108136996d6.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494909; x=1790099709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/ac81Fl7mkdJIoGKi9B5tmhVGYg0ErR/TGQTUqg2tc=;
        b=LdfgEQFUZ3ATNzzK2A7kTSxyJthH+eqMWVer2nB0TTxApnZpt6O3s4Nb82MgM7O9yt
         UnXmKrNLRuecCpjc/3UogS/LLwXKOsNLy9Wjcuiz9RAvP3T1N5gX1yV3r5JbJwpCSFv5
         sjuWpPXEoYSYzeQBcx2BGHW+7uI2pn3rqCd86zyUgK92Ag0di3Lt5kHZypa4yzSnEn0h
         sF0oPlcOcPM0/ov1JhHs6g19/0wQudUnX0pnVzvREVkOe2XV6p79opeQBibCGsKygrfn
         oViYm1VhDeGRcMBcV0hV8RcVq9DbhQISqk7habWtaPfdbx1JJNVfsWEOPrD/c6sif5YR
         /GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494909; x=1790099709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/ac81Fl7mkdJIoGKi9B5tmhVGYg0ErR/TGQTUqg2tc=;
        b=FMkcrvU2UKBQNug8D26nw7nGCLkMtPSKa/9eXEw5iREfNm/j/0rNonAarYInhPx0bX
         D5V2X4W3Ysgdef7rSIbIdZqZZfO/7VDqi5upxnoRzS3aPRTMHnv6cS8YXzWDv54RUp+W
         IEzJ6PV9v1qCE9fLQQcu5P/k+mERhIeno7KoHkM9FRAxIWKsx4lK/j951I9V0p5QXU83
         ZeivqmOnS3n03qd+VD89Oz9qn6BBDvJVgR2yDkoTviYPYevXaJECuRa1WnBNJ0tePqEN
         FKjUL1yUcF/H25wxi+KESNyWLkGty7VFgE17HCtLwcxqU2sXvMHvpQECYCZDcaCd4nvX
         lcEQ==
X-Forwarded-Encrypted: i=1; AKwUvByW/vOWz/mYHQBYEVP1IPfRV8tUaqEma9BkIXPGLhGUjDYWJS7e2+rTJ1FePdhW5UghTus02PA=@vger.kernel.org
X-Gm-Message-State: AFuF++lC11tJiJTwZMDhswak3QRayn1c+SOoFpVz5ll0nNKsCfffgotc
	KDvWRwz8C6cR61f8iSMihvOXL7gRGjiwU3x54m8aGcs4o5MSwT5A0SjT8Ks3en3Wve9fyOqqiWi
	PhapjJi4nv5uRuA==
X-Received: from qvbkc9.prod.google.com ([2002:a05:6214:4109:b0:910:6ec8:eff7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:46a1:b0:90e:9aa2:5169 with SMTP id 6a1803df08f44-9122e4cc40cmr134965816d6.7.1789494908589;
 Tue, 15 Sep 2026 10:55:08 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:57 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-5-edumazet@google.com>
Subject: [PATCH v4 net-next 4/8] vxlan: pass vxlan_config pointer to helper functions
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for converting vxlan->cfg to an RCU-protected pointer,
refactor internal helper functions in the RX, TX, MDB, and VNIFILTER
paths to accept a pointer to struct vxlan_config (or pass flags/
saddr_family where appropriate) rather than directly accessing
vxlan->cfg.

No functional changes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 343 +++++++++++++++-------------
 drivers/net/vxlan/vxlan_mdb.c       |  21 +-
 drivers/net/vxlan/vxlan_private.h   |   8 +-
 drivers/net/vxlan/vxlan_vnifilter.c |   5 +-
 4 files changed, 206 insertions(+), 171 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a693e189cf9a87d2c8215252c1e45d7794f3cade..a0c2a480701188506ca2f7f00d1890edf8662ced 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -377,14 +377,15 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
 
 /* Look up Ethernet address in forwarding table */
 static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
+					    const struct vxlan_config *cfg,
 					    const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb_key key;
 
 	memset(&key, 0, sizeof(key));
 	memcpy(key.eth_addr, mac, sizeof(key.eth_addr));
-	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
-		key.vni = vxlan->default_dst.remote_vni;
+	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
+		key.vni = cfg->vni;
 	else
 		key.vni = vni;
 
@@ -393,11 +394,12 @@ static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
 }
 
 static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
+					   const struct vxlan_config *cfg,
 					   const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb *f;
 
-	f = vxlan_find_mac_rcu(vxlan, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, mac, vni);
 	if (f) {
 		unsigned long now = jiffies;
 
@@ -416,7 +418,7 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	lockdep_assert_held_once(&vxlan->hash_lock);
 
 	rcu_read_lock();
-	f = vxlan_find_mac_rcu(vxlan, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -457,7 +459,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -1416,7 +1418,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1434,6 +1436,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  */
 static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					const struct vxlan_config *cfg,
 					union vxlan_addr *src_ip,
 					const u8 *src_mac, u32 src_ifindex,
 					__be32 vni)
@@ -1452,7 +1455,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		ifindex = src_ifindex;
 #endif
 
-	f = vxlan_find_mac_rcu(vxlan, src_mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 		unsigned long now = jiffies;
@@ -1488,9 +1491,9 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 			vxlan_fdb_update(vxlan, src_mac, src_ip,
 					 NUD_REACHABLE,
 					 NLM_F_EXCL|NLM_F_CREATE,
-					 vxlan->cfg.dst_port,
+					 cfg->dst_port,
 					 vni,
-					 vxlan->default_dst.remote_vni,
+					 cfg->vni,
 					 ifindex, NTF_SELF, 0, true, NULL);
 		spin_unlock(&vxlan->hash_lock);
 	}
@@ -1598,6 +1601,7 @@ static void vxlan_parse_gbp_hdr(struct sk_buff *skb, u32 vxflags,
 }
 
 static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  const struct vxlan_config *cfg,
 					  struct vxlan_sock *vs,
 					  struct sk_buff *skb, __be32 vni)
 {
@@ -1623,10 +1627,10 @@ static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+	if (!(cfg->flags & VXLAN_F_LEARN))
 		return SKB_NOT_DROPPED_YET;
 
-	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+	return vxlan_snoop(skb->dev, cfg, &saddr, eth_hdr(skb)->h_source,
 			   ifindex, vni);
 }
 
@@ -1657,18 +1661,21 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
-	const struct vxlanhdr *vh;
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
+	const struct vxlan_config *cfg;
 	enum skb_drop_reason reason;
+	const struct vxlanhdr *vh;
+	struct vxlan_metadata *md;
+	struct vxlan_metadata _md;
+	struct vxlan_dev *vxlan;
 	bool raw_proto = false;
-	void *oiph;
+	struct vxlan_sock *vs;
 	__be32 vni = 0;
+	void *oiph;
 	int nh;
 
+	md = &_md;
+
 	/* Need UDP and VXLAN header to be present */
 	reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
 	if (reason)
@@ -1696,8 +1703,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vh->vx_flags & vxlan->cfg.reserved_bits.vx_flags ||
-	    vh->vx_vni & vxlan->cfg.reserved_bits.vx_vni) {
+	cfg = &vxlan->cfg;
+	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
+	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
 		/* If the header uses bits besides those enabled by the
 		 * netdevice configuration, treat this as a malformed packet.
 		 * This behavior diverges from VXLAN RFC (RFC7348) which
@@ -1709,12 +1717,12 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GPE) {
+	if (cfg->flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
 		raw_proto = true;
@@ -1726,8 +1734,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
-		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
+	if (cfg->flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(skb, cfg->flags);
 		if (unlikely(reason))
 			goto drop;
 	}
@@ -1752,14 +1760,14 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
+	if (cfg->flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(skb, cfg->flags, md);
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
 
 	if (!raw_proto) {
-		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		reason = vxlan_set_mac(vxlan, cfg, vs, skb, vni);
 		if (reason)
 			goto drop;
 	} else {
@@ -1780,7 +1788,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1792,7 +1800,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1802,14 +1810,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
 		rcu_read_unlock();
 		dev_dstats_rx_dropped(vxlan->dev);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
 	dev_dstats_rx_add(vxlan->dev, skb->len);
-	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
+	vxlan_vnifilter_count(vxlan, cfg, vni, vninode, VXLAN_VNI_STATS_RX,
+			      skb->len);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
 	rcu_read_unlock();
@@ -1850,7 +1859,7 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct neigh_table *tbl = arp_table(dev_net(dev));
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -1864,7 +1873,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (!pskb_network_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
-		vxlan_vnifilter_count(vxlan, vni, NULL,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
@@ -1905,7 +1914,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		neigh_ha_snapshot(ha, n, n->dev);
 
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1931,11 +1940,11 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
 
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+	} else if (flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin.sin_addr.s_addr = tip,
 			.sin.sin_family = AF_INET,
@@ -2043,7 +2052,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	return reply;
 }
 
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
@@ -2077,7 +2086,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		}
 
 		neigh_ha_snapshot(ha, n, n->dev);
-		f = vxlan_find_mac_tx(vxlan, ha, vni);
+		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2096,10 +2105,10 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+	} else if (flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin6.sin6_addr = msg->target,
 			.sin6.sin6_family = AF_INET6,
@@ -2115,9 +2124,9 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 }
 #endif
 
-static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
+static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb,
+			       const struct vxlan_config *cfg)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct neigh_table *tbl;
 	struct neighbour *n;
 
@@ -2136,7 +2145,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		tbl = arp_table(dev_net(dev));
 		pip = ip_hdr(skb);
 		n = neigh_lookup(tbl, &pip->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin.sin_addr.s_addr = pip->daddr,
 				.sin.sin_family = AF_INET,
@@ -2164,7 +2173,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		tbl = nd_table(dev_net(dev));
 		pip6 = ipv6_hdr(skb);
 		n = neigh_lookup(tbl, &pip6->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin6.sin6_addr = pip6->daddr,
 				.sin6.sin6_family = AF_INET6,
@@ -2282,20 +2291,21 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 
 /* Bypass encapsulation if the destination is local */
 static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
-			       struct vxlan_dev *dst_vxlan, __be32 vni,
-			       bool snoop)
+			       struct vxlan_dev *dst_vxlan,
+			       const struct vxlan_config *src_cfg,
+			       __be32 vni, bool snoop)
 {
+	const struct vxlan_config *dst_cfg = &dst_vxlan->cfg;
 	union vxlan_addr loopback;
-	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
 	unsigned int len = skb->len;
-	struct net_device *dev;
+	struct net_device *dev = dst_vxlan->dev;
 
 	skb->pkt_type = PACKET_HOST;
 	skb->encapsulation = 0;
-	skb->dev = dst_vxlan->dev;
+	skb->dev = dev;
 	__skb_pull(skb, skb_network_offset(skb));
 
-	if (remote_ip->sa.sa_family == AF_INET) {
+	if (dst_vxlan->default_dst.remote_ip.sa.sa_family == AF_INET) {
 		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		loopback.sa.sa_family =  AF_INET;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2306,26 +2316,25 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	rcu_read_lock();
-	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
-		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
+	if ((dst_cfg->flags & VXLAN_F_LEARN) && snoop)
+		vxlan_snoop(dev, dst_cfg, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
 	dev_dstats_tx_add(src_vxlan->dev, len);
-	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
+	vxlan_vnifilter_count(src_vxlan, src_cfg, vni, NULL, VXLAN_VNI_STATS_TX, len);
 
 	if (__netif_rx(skb) == NET_RX_SUCCESS) {
 		dev_dstats_rx_add(dst_vxlan->dev, len);
-		vxlan_vnifilter_count(dst_vxlan, vni, NULL, VXLAN_VNI_STATS_RX,
+		vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL, VXLAN_VNI_STATS_RX,
 				      len);
 	} else {
 drop:
 		dev_dstats_rx_dropped(dev);
-		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
+		vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
 	rcu_read_unlock();
@@ -2333,6 +2342,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 
 static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 struct vxlan_dev *vxlan,
+				 const struct vxlan_config *cfg,
 				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
 				 struct dst_entry *dst,
@@ -2348,22 +2358,22 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	/* Bypass encapsulation if the destination is local */
 	if (rt_flags & RTCF_LOCAL &&
 	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST)) &&
-	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
+	    cfg->flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   cfg->flags);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND);
 
 			return -ENOENT;
 		}
-		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
+		vxlan_encap_bypass(skb, vxlan, dst_vxlan, cfg, vni, true);
 		return 1;
 	}
 
@@ -2371,30 +2381,35 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 }
 
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    const struct vxlan_config *cfg,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
 {
+	unsigned int pkt_len = skb->len;
+	struct vxlan_metadata _md = {};
+	__be16 src_port = 0, dst_port;
+	struct dst_entry *ndst = NULL;
+	enum skb_drop_reason reason;
 	struct dst_cache *dst_cache;
+	const struct iphdr *old_iph;
 	struct ip_tunnel_info *info;
 	struct ip_tunnel_key *pkey;
+	struct vxlan_metadata *md;
 	struct ip_tunnel_key key;
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct iphdr *old_iph;
-	struct vxlan_metadata _md = {};
-	struct vxlan_metadata *md = &_md;
-	unsigned int pkt_len = skb->len;
-	__be16 src_port = 0, dst_port;
-	struct dst_entry *ndst = NULL;
+	struct vxlan_dev *vxlan;
+	u32 flags = cfg->flags;
+	bool udp_sum = false;
+	bool no_eth_encap;
 	int addr_family;
+	bool use_cache;
+	__be32 vni = 0;
 	__u8 tos, ttl;
 	int ifindex;
 	int err = 0;
-	u32 flags = vxlan->cfg.flags;
-	bool use_cache;
-	bool udp_sum = false;
-	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
-	enum skb_drop_reason reason;
-	bool no_eth_encap;
-	__be32 vni = 0;
+	bool xnet;
+
+	vxlan = netdev_priv(dev);
+	xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+	md = &_md;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
 	reason = skb_vlan_inet_prepare(skb, no_eth_encap);
@@ -2414,23 +2429,23 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (vxlan_addr_any(&rdst->remote_ip)) {
 			if (did_rsc) {
 				/* short-circuited back to local bridge */
-				vxlan_encap_bypass(skb, vxlan, vxlan,
+				vxlan_encap_bypass(skb, vxlan, vxlan, cfg,
 						   default_vni, true);
 				return;
 			}
 			goto drop;
 		}
 
-		addr_family = vxlan->cfg.saddr.sa.sa_family;
-		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
+		addr_family = cfg->saddr.sa.sa_family;
+		dst_port = rdst->remote_port ? rdst->remote_port : cfg->dst_port;
 		vni = (rdst->remote_vni) ? : default_vni;
 		ifindex = rdst->remote_ifindex;
 
 		if (addr_family == AF_INET) {
-			key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
+			key.u.ipv4.src = cfg->saddr.sin.sin_addr.s_addr;
 			key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
 		} else {
-			key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
+			key.u.ipv6.src = cfg->saddr.sin6.sin6_addr;
 			key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
 		}
 
@@ -2439,11 +2454,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (flags & VXLAN_F_TTL_INHERIT) {
 			ttl = ip_tunnel_get_ttl(old_iph, skb);
 		} else {
-			ttl = vxlan->cfg.ttl;
+			ttl = cfg->ttl;
 			if (!ttl && vxlan_addr_multicast(&rdst->remote_ip))
 				ttl = 1;
 		}
-		tos = vxlan->cfg.tos;
+		tos = cfg->tos;
 		if (tos == 1)
 			tos = ip_tunnel_get_dsfield(old_iph, skb);
 		if (tos && !info)
@@ -2454,9 +2469,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
-		switch (vxlan->cfg.label_policy) {
+		switch (cfg->label_policy) {
 		case VXLAN_LABEL_FIXED:
-			key.label = vxlan->cfg.label;
+			key.label = cfg->label;
 			break;
 		case VXLAN_LABEL_INHERIT:
 			key.label = ip_tunnel_get_flowlabel(old_iph, skb);
@@ -2474,7 +2489,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 		pkey = &info->key;
 		addr_family = ip_tunnel_info_af(info);
-		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
+		dst_port = info->key.tp_dst ? : cfg->dst_port;
 		vni = tunnel_id_to_key32(info->key.tun_id);
 		ifindex = 0;
 		dst_cache = &info->dst_cache;
@@ -2487,8 +2502,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		tos = info->key.tos;
 		udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	}
-	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				     vxlan->cfg.port_max, true);
+	src_port = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
+				     cfg->port_max, true);
 
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
@@ -2521,15 +2536,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		if (!info) {
 			/* Bypass encapsulation if the destination is local */
-			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
+			err = encap_bypass_if_local(skb, dev, vxlan, cfg, AF_INET,
 						    dst_port, ifindex, vni,
 						    &rt->dst, rt->rt_flags);
 			if (err)
 				goto out_unlock;
 
-			if (vxlan->cfg.df == VXLAN_DF_SET) {
+			if (cfg->df == VXLAN_DF_SET) {
 				df = htons(IP_DF);
-			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
+			} else if (cfg->df == VXLAN_DF_INHERIT) {
 				struct ethhdr *eth = eth_hdr(skb);
 
 				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
@@ -2558,7 +2573,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
 				unclone->key.u.ipv4.dst = saddr;
 			}
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			vxlan_encap_bypass(skb, vxlan, vxlan, cfg, vni, false);
 			dst_release(ndst);
 			goto out_unlock;
 		}
@@ -2608,7 +2623,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!info) {
 			u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
 
-			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
+			err = encap_bypass_if_local(skb, dev, vxlan, cfg, AF_INET6,
 						    dst_port, ifindex, vni,
 						    ndst, rt6i_flags);
 			if (err)
@@ -2632,7 +2647,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv6.dst = saddr;
 			}
 
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			vxlan_encap_bypass(skb, vxlan, vxlan, cfg, vni, false);
 			dst_release(ndst);
 			goto out_unlock;
 		}
@@ -2653,14 +2668,14 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     ip6cb_flags);
 #endif
 	}
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
 out_unlock:
 	rcu_read_unlock();
 	return;
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	kfree_skb_reason(skb, reason);
 	return;
 
@@ -2672,11 +2687,12 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
 }
 
 static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
+			  const struct vxlan_config *cfg,
 			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
 {
 	struct vxlan_rdst nh_rdst;
@@ -2693,7 +2709,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
 
 	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
+		vxlan_xmit_one(skb, dev, cfg, vni, &nh_rdst, did_rsc);
 	else
 		goto drop;
 
@@ -2701,15 +2717,15 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+	vxlan_vnifilter_count(netdev_priv(dev), cfg, vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 }
 
 static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
-				   u32 nhid, __be32 vni)
+				   u32 nhid, __be32 vni,
+				   const struct vxlan_config *cfg)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst nh_rdst;
 	struct nexthop *nh;
 	bool do_xmit;
@@ -2727,11 +2743,11 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
 	rcu_read_unlock();
 
-	if (vxlan->cfg.saddr.sa.sa_family != nh_rdst.remote_ip.sa.sa_family)
+	if (cfg->saddr.sa.sa_family != nh_rdst.remote_ip.sa.sa_family)
 		goto drop;
 
 	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, false);
+		vxlan_xmit_one(skb, dev, cfg, vni, &nh_rdst, false);
 	else
 		goto drop;
 
@@ -2739,7 +2755,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+	vxlan_vnifilter_count(netdev_priv(dev), cfg, vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
@@ -2756,34 +2772,41 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *rdst, *fdst = NULL;
 	const struct ip_tunnel_info *info;
+	const struct vxlan_config *cfg;
+	__be32 default_vni;
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
 	__be32 vni = 0;
-	u32 nhid = 0;
 	bool did_rsc;
+	u32 nhid = 0;
+	u32 flags;
+
+	cfg = &vxlan->cfg;
+	flags = cfg->flags;
+	default_vni = cfg->vni;
 
 	info = skb_tunnel_info(skb);
 
 	skb_reset_mac_header(skb);
 
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+	if (flags & VXLAN_F_COLLECT_METADATA) {
 		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
 		    info->mode & IP_TUNNEL_INFO_TX) {
 			vni = tunnel_id_to_key32(info->key.tun_id);
 			nhid = info->key.nhid;
 		} else {
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
-				vxlan_xmit_one(skb, dev, vni, NULL, false);
+				vxlan_xmit_one(skb, dev, cfg, vni, NULL, false);
 			else
 				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
+	if (flags & VXLAN_F_PROXY) {
 		eth = eth_hdr(skb);
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, vni);
+			return arp_reduce(dev, skb, vni, flags);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
 			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr) +
@@ -2793,23 +2816,23 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 			if (m->icmph.icmp6_code == 0 &&
 			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni);
+				return neigh_reduce(dev, skb, vni, flags);
 		}
 #endif
 	}
 
 	if (nhid)
-		return vxlan_xmit_nhid(skb, dev, nhid, vni);
+		return vxlan_xmit_nhid(skb, dev, nhid, vni, cfg);
 
-	if (vxlan->cfg.flags & VXLAN_F_MDB) {
+	if (flags & VXLAN_F_MDB) {
 		struct vxlan_mdb_entry *mdb_entry;
 
 		rcu_read_lock();
-		mdb_entry = vxlan_mdb_entry_skb_get(vxlan, skb, vni);
+		mdb_entry = vxlan_mdb_entry_skb_get(vxlan, cfg, skb, vni);
 		if (mdb_entry) {
 			netdev_tx_t ret;
 
-			ret = vxlan_mdb_xmit(vxlan, mdb_entry, skb);
+			ret = vxlan_mdb_xmit(vxlan, cfg, mdb_entry, skb);
 			rcu_read_unlock();
 			return ret;
 		}
@@ -2818,27 +2841,27 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	eth = eth_hdr(skb);
 	rcu_read_lock();
-	f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
+	f = vxlan_find_mac_tx(vxlan, cfg, eth->h_dest, vni);
 	did_rsc = false;
 
-	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
+	if (f && (f->flags & NTF_ROUTER) && (flags & VXLAN_F_RSC) &&
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
-		did_rsc = route_shortcircuit(dev, skb);
+		did_rsc = route_shortcircuit(dev, skb, cfg);
 		eth = eth_hdr(skb);
 		if (did_rsc)
-			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
+			f = vxlan_find_mac_tx(vxlan, cfg, eth->h_dest, vni);
 	}
 
 	if (f == NULL) {
-		f = vxlan_find_mac_tx(vxlan, all_zeros_mac, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, all_zeros_mac, vni);
 		if (f == NULL) {
-			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
+			if ((flags & VXLAN_F_L2MISS) &&
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
 			dev_dstats_tx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 			goto out;
@@ -2846,8 +2869,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (rcu_access_pointer(f->nh)) {
-		vxlan_xmit_nh(skb, dev, f,
-			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
+		vxlan_xmit_nh(skb, dev, cfg, f,
+			      (vni ? : default_vni), did_rsc);
 	} else {
 		list_for_each_entry_rcu(rdst, &f->remotes, list) {
 			struct sk_buff *skb1;
@@ -2858,10 +2881,10 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			}
 			skb1 = skb_clone(skb, GFP_ATOMIC);
 			if (skb1)
-				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
+				vxlan_xmit_one(skb1, dev, cfg, vni, rdst, did_rsc);
 		}
 		if (fdst)
-			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
+			vxlan_xmit_one(skb, dev, cfg, vni, fdst, did_rsc);
 		else
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
@@ -3734,7 +3757,7 @@ static int vxlan_sock_add(struct vxlan_dev *vxlan)
 }
 
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
-		     struct vxlan_config *conf, __be32 vni)
+		     const struct vxlan_config *conf, __be32 vni)
 {
 	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
 	struct vxlan_dev *tmp;
@@ -4602,10 +4625,10 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	const struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct vxlan_rdst *dst = &vxlan->default_dst;
-	struct ifla_vxlan_port_range ports = {
-		.low =  htons(vxlan->cfg.port_min),
-		.high = htons(vxlan->cfg.port_max),
-	};
+	struct ifla_vxlan_port_range ports;
+	const struct vxlan_config *cfg;
+
+	cfg = &vxlan->cfg;
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(dst->remote_vni)))
 		goto nla_put_failure;
@@ -4627,79 +4650,81 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (dst->remote_ifindex && nla_put_u32(skb, IFLA_VXLAN_LINK, dst->remote_ifindex))
 		goto nla_put_failure;
 
-	if (!vxlan_addr_any(&vxlan->cfg.saddr)) {
-		if (vxlan->cfg.saddr.sa.sa_family == AF_INET) {
+	if (!vxlan_addr_any(&cfg->saddr)) {
+		if (cfg->saddr.sa.sa_family == AF_INET) {
 			if (nla_put_in_addr(skb, IFLA_VXLAN_LOCAL,
-					    vxlan->cfg.saddr.sin.sin_addr.s_addr))
+					    cfg->saddr.sin.sin_addr.s_addr))
 				goto nla_put_failure;
 #if IS_ENABLED(CONFIG_IPV6)
 		} else {
 			if (nla_put_in6_addr(skb, IFLA_VXLAN_LOCAL6,
-					     &vxlan->cfg.saddr.sin6.sin6_addr))
+					     &cfg->saddr.sin6.sin6_addr))
 				goto nla_put_failure;
 #endif
 		}
 	}
 
-	if (nla_put_u8(skb, IFLA_VXLAN_TTL, vxlan->cfg.ttl) ||
+	if (nla_put_u8(skb, IFLA_VXLAN_TTL, cfg->ttl) ||
 	    nla_put_u8(skb, IFLA_VXLAN_TTL_INHERIT,
-		       !!(vxlan->cfg.flags & VXLAN_F_TTL_INHERIT)) ||
-	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
-	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
-	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
+		       !!(cfg->flags & VXLAN_F_TTL_INHERIT)) ||
+	    nla_put_u8(skb, IFLA_VXLAN_TOS, cfg->tos) ||
+	    nla_put_u8(skb, IFLA_VXLAN_DF, cfg->df) ||
+	    nla_put_be32(skb, IFLA_VXLAN_LABEL, cfg->label) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LABEL_POLICY, cfg->label_policy) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
-		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
+		       !!(cfg->flags & VXLAN_F_LEARN)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
-		       !!(vxlan->cfg.flags & VXLAN_F_PROXY)) ||
+		       !!(cfg->flags & VXLAN_F_PROXY)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_RSC,
-		       !!(vxlan->cfg.flags & VXLAN_F_RSC)) ||
+		       !!(cfg->flags & VXLAN_F_RSC)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L2MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L2MISS)) ||
+		       !!(cfg->flags & VXLAN_F_L2MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_L3MISS,
-		       !!(vxlan->cfg.flags & VXLAN_F_L3MISS)) ||
+		       !!(cfg->flags & VXLAN_F_L3MISS)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_COLLECT_METADATA,
-		       !!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)) ||
-	    nla_put_u32(skb, IFLA_VXLAN_AGEING, vxlan->cfg.age_interval) ||
-	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, vxlan->cfg.addrmax) ||
-	    nla_put_be16(skb, IFLA_VXLAN_PORT, vxlan->cfg.dst_port) ||
+		       !!(cfg->flags & VXLAN_F_COLLECT_METADATA)) ||
+	    nla_put_u32(skb, IFLA_VXLAN_AGEING, cfg->age_interval) ||
+	    nla_put_u32(skb, IFLA_VXLAN_LIMIT, cfg->addrmax) ||
+	    nla_put_be16(skb, IFLA_VXLAN_PORT, cfg->dst_port) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_CSUM,
-		       !(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
+		       !(cfg->flags & VXLAN_F_UDP_ZERO_CSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
+		       !!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM6_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_UDP_ZERO_CSUM6_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
+		       !!(cfg->flags & VXLAN_F_UDP_ZERO_CSUM6_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_TX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_TX)) ||
+		       !!(cfg->flags & VXLAN_F_REMCSUM_TX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
-		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
+		       !!(cfg->flags & VXLAN_F_REMCSUM_RX)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
-		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
+		       !!(cfg->flags & VXLAN_F_LOCALBYPASS)))
 		goto nla_put_failure;
 
+	ports.low = htons(cfg->port_min);
+	ports.high = htons(cfg->port_max);
 	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP &&
+	if (cfg->flags & VXLAN_F_GBP &&
 	    nla_put_flag(skb, IFLA_VXLAN_GBP))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_GPE &&
+	if (cfg->flags & VXLAN_F_GPE &&
 	    nla_put_flag(skb, IFLA_VXLAN_GPE))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_NOPARTIAL &&
+	if (cfg->flags & VXLAN_F_REMCSUM_NOPARTIAL &&
 	    nla_put_flag(skb, IFLA_VXLAN_REMCSUM_NOPARTIAL))
 		goto nla_put_failure;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER &&
+	if (cfg->flags & VXLAN_F_VNIFILTER &&
 	    nla_put_u8(skb, IFLA_VXLAN_VNIFILTER,
-		       !!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
+		       !!(cfg->flags & VXLAN_F_VNIFILTER)))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_VXLAN_RESERVED_BITS,
-		    sizeof(vxlan->cfg.reserved_bits),
-		    &vxlan->cfg.reserved_bits))
+		    sizeof(cfg->reserved_bits),
+		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 841f42ffecb9aa351b10cfadf3d423f7e0f9f290..56ca9283283307d8b1231c3b26724474e6c838d6 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -165,6 +165,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
+	const struct vxlan_config *cfg = &vxlan->cfg;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -189,7 +190,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 	    vxlan_nla_put_addr(skb, MDBA_MDB_EATTR_DST, &rd->remote_ip))
 		goto nest_err;
 
-	if (rd->remote_port && rd->remote_port != vxlan->cfg.dst_port &&
+	if (rd->remote_port && rd->remote_port != cfg->dst_port &&
 	    nla_put_u16(skb, MDBA_MDB_EATTR_DST_PORT,
 			be16_to_cpu(rd->remote_port)))
 		goto nest_err;
@@ -202,7 +203,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 	    nla_put_u32(skb, MDBA_MDB_EATTR_IFINDEX, rd->remote_ifindex))
 		goto nest_err;
 
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) &&
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) &&
 	    mdb_entry->key.vni && nla_put_u32(skb, MDBA_MDB_EATTR_SRC_VNI,
 					      be32_to_cpu(mdb_entry->key.vni)))
 		goto nest_err;
@@ -613,6 +614,7 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *vcfg = &vxlan->cfg;
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -622,7 +624,7 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 	cfg->filter_mode = MCAST_EXCLUDE;
 	cfg->rt_protocol = RTPROT_STATIC;
 	cfg->remote_vni = vxlan->default_dst.remote_vni;
-	cfg->remote_port = vxlan->cfg.dst_port;
+	cfg->remote_port = vcfg->dst_port;
 
 	if (entry->ifindex != dev->ifindex) {
 		NL_SET_ERR_MSG_MOD(extack, "Port net device must be the VXLAN net device");
@@ -957,6 +959,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
+	const struct vxlan_config *cfg = &vxlan->cfg;
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
@@ -978,7 +981,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	/* MDBA_MDB_EATTR_DST */
 	nlmsg_size += nla_total_size(vxlan_addr_size(&rd->remote_ip));
 	/* MDBA_MDB_EATTR_DST_PORT */
-	if (rd->remote_port && rd->remote_port != vxlan->cfg.dst_port)
+	if (rd->remote_port && rd->remote_port != cfg->dst_port)
 		nlmsg_size += nla_total_size(sizeof(u16));
 	/* MDBA_MDB_EATTR_VNI */
 	if (rd->remote_vni != vxlan->default_dst.remote_vni)
@@ -987,7 +990,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	if (rd->remote_ifindex)
 		nlmsg_size += nla_total_size(sizeof(u32));
 	/* MDBA_MDB_EATTR_SRC_VNI */
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && group->vni)
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) && group->vni)
 		nlmsg_size += nla_total_size(sizeof(u32));
 
 	return nlmsg_size;
@@ -1621,6 +1624,7 @@ int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
 }
 
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
+						const struct vxlan_config *cfg,
 						struct sk_buff *skb,
 						__be32 src_vni)
 {
@@ -1634,7 +1638,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
 	 * entries are stored with the VNI of the VXLAN device.
 	 */
-	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
+	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
 		src_vni = vxlan->default_dst.remote_vni;
 
 	memset(&group, 0, sizeof(group));
@@ -1700,6 +1704,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 }
 
 netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg,
 			   const struct vxlan_mdb_entry *mdb_entry,
 			   struct sk_buff *skb)
 {
@@ -1721,12 +1726,12 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 
 		skb1 = skb_clone(skb, GFP_ATOMIC);
 		if (skb1)
-			vxlan_xmit_one(skb1, vxlan->dev, src_vni,
+			vxlan_xmit_one(skb1, vxlan->dev, cfg, src_vni,
 				       rcu_dereference(remote->rd), false);
 	}
 
 	if (fremote)
-		vxlan_xmit_one(skb, vxlan->dev, src_vni,
+		vxlan_xmit_one(skb, vxlan->dev, cfg, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
 		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 5796cf0487ba0550705099e64c1b7fcdce23dab9..b81b25af7aea737caad4493b7fdcd8dcb5a36f33 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -204,9 +204,10 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
 		     bool swdev_notify, struct netlink_ext_ack *extack);
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    const struct vxlan_config *cfg,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
-		     struct vxlan_config *conf, __be32 vni);
+		     const struct vxlan_config *conf, __be32 vni);
 
 /* vxlan_vnifilter.c */
 int vxlan_vnigroup_init(struct vxlan_dev *vxlan);
@@ -214,7 +215,8 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan);
 
 int vxlan_vnifilter_init(void);
 void vxlan_vnifilter_uninit(void);
-void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
+void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg, __be32 vni,
 			   struct vxlan_vni_node *vninode,
 			   int type, unsigned int len);
 
@@ -251,9 +253,11 @@ int vxlan_mdb_del_bulk(struct net_device *dev, struct nlattr *tb[],
 int vxlan_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid,
 		  u32 seq, struct netlink_ext_ack *extack);
 struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
+						const struct vxlan_config *cfg,
 						struct sk_buff *skb,
 						__be32 src_vni);
 netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg,
 			   const struct vxlan_mdb_entry *mdb_entry,
 			   struct sk_buff *skb);
 int vxlan_mdb_init(struct vxlan_dev *vxlan);
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index ce986a00a05c9b14d3e901a90508192c4ca30258..544c0023ab731840d7f6acccefdef34cca54a37f 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -171,13 +171,14 @@ static void vxlan_vnifilter_stats_add(struct vxlan_vni_node *vninode,
 	u64_stats_update_end(&pstats->syncp);
 }
 
-void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
+void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg, __be32 vni,
 			   struct vxlan_vni_node *vninode,
 			   int type, unsigned int len)
 {
 	struct vxlan_vni_node *vnode;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
 		return;
 
 	if (vninode) {
-- 
2.55.0.1032.g73a4cd73de-goog

