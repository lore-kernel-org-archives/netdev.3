Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE330DD00
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309241; cv=none; b=aRd8fdMdF/jXis0IUGC5HXA0frL5TTESWCBeiS+0Xugg6pWVHkWcYnYAhPPKzmN8TWwiR5W8i4w+3EbwA/NnO8QlTm6/V4mRrC+sWy858U+gveQ31xZ4MuGaxcEmBuY1blsXPx88PX0IpO6/Scd7FwX0o4s0AybmpgU/hsXtPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309241; c=relaxed/simple;
	bh=X+WSm6oiuL3t2XnDF8NlZWd1xnZNWut+nuQRWgh1cRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZ3PJXqv0qHUoTtMICNvqpIOyYY4dyRoGd/+DE7+c4TcFEEivUhQmCTSZsXrPWEs8BSAFq9DBsw1wxV3N8/b1P0pN5z3SvxoVJ8sFAVw5U8SLBnQ7NCArOpkRCtsOC5/4f28quM0sDOEX+0N6Hfa/gdLNKEFQot3HnWP97UAExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYhM3ynd; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYhM3ynd"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so73486185a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309239; x=1788914039; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qotbDE97SQLmxh6zBMf8K1Y6Hn7bZY1RGV28asIKbZE=;
        b=TYhM3yndPPeGQRmTt720moppjtk34icPgzLZyaIimF4H4YDjtxv3Cehga8SW9fP1yX
         snCNB8TP5mt6okm4X9RMIY9+25Yzt2DDPwpKQmbiqtTdfPTCwwhsovsTmzJdkQpemtxN
         LEFdTW8EyRcSOiJPABLBaHsW6JBXqR8dwwf5mZFwe+RPQDggCafJHYqXMepLIBxpz0fv
         JXkHmgCGFQ8gE9JWYJj6v3BggTrRhBz8cq7PntlpHpIaarnCx+m/IOWdYJ8FzRzTV3iz
         Qj1ESy60Jt0h9YF/CbGuWDeL5QV5+Rm/5D62onjjA+3yOoVbNmKR4/mTHBTgLKNqm0bg
         uEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309239; x=1788914039;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qotbDE97SQLmxh6zBMf8K1Y6Hn7bZY1RGV28asIKbZE=;
        b=KfFphrJZLMyGvVK9B8FYKu68bpaLTDASK38SKXZEzVO2zKXUuS06Y/9xEAOIbIfpg6
         L6nb8jNC9puWfQgDHGVbDk90uGHMtilW2zPU656wBFRWWZKeJ19HdqO2ZbxlTT9mzjs8
         XG61c4TYj8oAa5GZxTumj9XACqpS935wTCteIlK/oG6QuaaZTaM0lTJ11QCEWwEAsqLC
         N7AFEkTpn4IB2ZA/As44baOA+et6lqN0Z20kw2kBbpiR0YMvXKjEUZUEaUpGOrQu8Pgb
         GGroBcTHKXNUDoSqcyP8k0Ys5GSU5jB4c6hTTa/skRqAqmcBYbpzI58XBnsW2F2XeGuo
         y0jg==
X-Forwarded-Encrypted: i=1; AHgh+RpBmVcOMFSRhLIDShwLUYQycYps5Aia+Ls0iMZ/4tduJxm4Z/VOvsf0UuGJJT8LoD3+2y1DHWA=@vger.kernel.org
X-Gm-Message-State: AFuF++mlYf502fhrNuQ60fDO4+vNxmXpwZisEwH2r/8MryiWXXFepeLz
	CVQsIar+jJNRmpJ5k/xFtc6kTqGbsRI7ycZTzZV2fVp2GZGMEWosKg0FbDqpzM/n6VFzHbWnFPO
	dxv7Obez6h1CN5g==
X-Received: from qkpn11.prod.google.com ([2002:a05:620a:294b:b0:936:bc65:7ec9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4002:b0:937:2d64:57ae with SMTP id af79cd13be357-93960893c96mr160554985a.0.1788309238214;
 Tue, 01 Sep 2026 17:33:58 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:42 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-9-edumazet@google.com>
Subject: [PATCH net-next 08/10] vxlan: do not assume mac header is set in tx paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() in tx paths,
and remove now redundant skb_reset_mac_header() call in vxlan_xmit().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 24 +++++++++++-------------
 drivers/net/vxlan/vxlan_mdb.c  |  4 ++--
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e5bafe9e4c57ef8819645c3da7121..a1c3bc530b97cb8617ac324b60e32b77ea23e5ee 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1967,7 +1967,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 
 	ns = (struct nd_msg *)(ipv6_hdr(request) + 1);
 
-	daddr = eth_hdr(request)->h_source;
+	daddr = skb_eth_hdr(request)->h_source;
 	ns_olen = request->len - skb_network_offset(request) -
 		sizeof(struct ipv6hdr) - sizeof(*ns);
 	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
@@ -2108,11 +2108,11 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct neighbour *n;
 
-	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+	if (is_multicast_ether_addr(skb_eth_hdr(skb)->h_dest))
 		return false;
 
 	n = NULL;
-	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	switch (ntohs(skb_eth_hdr(skb)->h_proto)) {
 	case ETH_P_IP:
 	{
 		struct iphdr *pip;
@@ -2169,15 +2169,15 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 		bool diff;
 
 		neigh_ha_snapshot(haddr, n, dev);
-		diff = !ether_addr_equal_unaligned(eth_hdr(skb)->h_dest, haddr);
+		diff = !ether_addr_equal_unaligned(skb_eth_hdr(skb)->h_dest, haddr);
 		if (diff) {
 			if (skb_cow_head(skb, 0)) {
 				neigh_release(n);
 				return false;
 			}
-			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
+			memcpy(skb_eth_hdr(skb)->h_source, skb_eth_hdr(skb)->h_dest,
 				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, haddr, dev->addr_len);
+			memcpy(skb_eth_hdr(skb)->h_dest, haddr, dev->addr_len);
 		}
 		neigh_release(n);
 		return diff;
@@ -2296,7 +2296,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
-		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
+		vxlan_snoop(dev, &loopback, skb_eth_hdr(skb)->h_source, 0, vni);
 
 	dev_dstats_tx_add(src_vxlan->dev, len);
 	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
@@ -2513,7 +2513,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			if (vxlan->cfg.df == VXLAN_DF_SET) {
 				df = htons(IP_DF);
 			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
-				struct ethhdr *eth = eth_hdr(skb);
+				struct ethhdr *eth = skb_eth_hdr(skb);
 
 				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
 				    (ntohs(eth->h_proto) == ETH_P_IP &&
@@ -2747,8 +2747,6 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	info = skb_tunnel_info(skb);
 
-	skb_reset_mac_header(skb);
-
 	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
 		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
 		    info->mode & IP_TUNNEL_INFO_TX) {
@@ -2764,7 +2762,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
-		eth = eth_hdr(skb);
+		eth = skb_eth_hdr(skb);
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
 			return arp_reduce(dev, skb, vni);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2799,7 +2797,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		rcu_read_unlock();
 	}
 
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	rcu_read_lock();
 	f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	did_rsc = false;
@@ -2808,7 +2806,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
 		did_rsc = route_shortcircuit(dev, skb);
-		eth = eth_hdr(skb);
+		eth = skb_eth_hdr(skb);
 		if (did_rsc)
 			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	}
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index d71e1925ecfdbd6fa7b78b38cb4168b51c85a553..2ec005c003e3c0ada7eacf1f5af9a3bf5ab433da 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1619,8 +1619,8 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	struct vxlan_mdb_entry *mdb_entry;
 	struct vxlan_mdb_entry_key group;
 
-	if (!is_multicast_ether_addr(eth_hdr(skb)->h_dest) ||
-	    is_broadcast_ether_addr(eth_hdr(skb)->h_dest))
+	if (!is_multicast_ether_addr(skb_eth_hdr(skb)->h_dest) ||
+	    is_broadcast_ether_addr(skb_eth_hdr(skb)->h_dest))
 		return NULL;
 
 	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
-- 
2.55.0.966.g6673acef38-goog

