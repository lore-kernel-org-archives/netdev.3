Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49705374A0E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565140; cv=none; b=eAz9pgosYRAhvOykrzPFZc25VlcKE4XCJA27AFC8UzdHp0MQNdlZ/3rxt9pymhd3/9VbBkFC0TDHheJluRBGo0IEGhcUweHG6EjQmmchH8odxVHDM/6EZZMChOLOCoow23OSP3cpHTHoCv0CFymZFA0lKiPRPmq7Mf0Obgp55UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565140; c=relaxed/simple;
	bh=ezb2gDsB2CJ5tf6AoGuYgVl6swy+BZnjJNoMy4Uzr9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mo45+nInPg9yvqJmbgYitoBXptTBKCRfGnZYBSYVDHwiTU+ocIKYiX24TxNJMTpMFOi0rB4kwP87XKTQ8AfCHeZP0+GHqmIet/eRgu6m3yeNbmsxA8EVVhjy7Yas3FdnF4e3ZBLPx7hGJde6OjmXmev5WJ88e42euGXjDcMYTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCp55WEn; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCp55WEn"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5328ac111d5so1102201cf.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789565135; x=1790169935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2uIUVwkh2FtafyfuPWXyW9u/h1GUS6X5zcf6mpXfRU8=;
        b=eCp55WEn/ySwMNYiUfRTk+lXLj1X397HQrX1wgs2zWo68yrLwpViIEMcCCSKMxxXrI
         F4zoEp72ztKZd6bCvf1n78J7oUDSQT3swoL69AvbrV4fYjL1IJNgyMbCAJAQ0QJlgwKk
         PK6CCrLJViRWHTRyEAOmizWmUW8KuG9BDLOzKKVVmVmf7PSwZBHZ8h+3h2CI6HG5cc13
         3h726wN0+6ciXz8O7dyDrGjfhAhlJ8viCCGpfW+5EpUEDOCzHN69DGN+Pm5WT+3ID6rn
         polNSTMkOcdFb7gdCgSGgXSmIsj52rjUkmLRd+fZRqR9TjcDh4MYVUmGjsPZ8czyRyuz
         /MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565135; x=1790169935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2uIUVwkh2FtafyfuPWXyW9u/h1GUS6X5zcf6mpXfRU8=;
        b=fVg5WoeReEuT7CIQKo/EtI8E0GMUyAzFERjP87/zy4o0TZbDxxcy8u9mgAvcBMnt+a
         Wn4XkGAazGYaKan/CXOucuMo8FtSjhu1lS2eCUQmcjIrsnHGW0CgNGMFBXi6rGvcJUdf
         CFRFp85ErsKKdCpv3yAbnilg96Sab6TZQxG5KkcUWZ1+ue3UHKm9K4gHrN/acvG7Sit3
         CtIzilXQ0P6xfDNitqYwwG5R7Bw9Gz0Fi0AX/Hm1CLT4l7cestP8TlLKZZwR73goSbno
         OIsDMidp9+8yOoqxAxFvb2mKYKEEync0CjlnJSrbARdWyssSGJLsHJ49eABq2cTP6zFE
         Zu+w==
X-Forwarded-Encrypted: i=1; AKwUvBwhXKX5zIFhIRpG8LG0daxuCRA3shnupNutmm4YFn5NLiTywTCKXnggcQ8BPn6fIebc1oKL1UI=@vger.kernel.org
X-Gm-Message-State: AFuF++kV2BEpepueS4AW96HoEpUOUjgUE1Au1CXAqhyEd3puckos1wrt
	FBuDjyULBjPqqXEuZ5FEDuMp2V+ilL6zY6TFcgng0m7zqN3UMhIiHoWGIZ1VIshb+tNl4oItNbS
	dug7vYPDGGmoO1A==
X-Received: from qtam22-n2.prod.google.com ([2002:a05:622a:e116:20b0:531:6a8:4fbf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f15:0:b0:531:181:d6b6 with SMTP id d75a77b69052e-5327f54ac0fmr41194901cf.37.1789565135391;
 Wed, 16 Sep 2026 06:25:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:25:31 +0000
In-Reply-To: <20260916132532.1785657-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132532.1785657-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132532.1785657-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] vlan: annotate data-races in vlan_dev_priv fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vlan->flags, vlan->ingress_priority_map[] and vlan->nr_*_mappings
are written under RTNL, but read from lockless contexts:

- the RX path reads vlan->flags (VLAN_FLAG_REORDER_HDR) and
  the ingress priority map,
- the TX path reads vlan->flags,
- /proc/net/vlan/<dev> reads vlan->flags and the ingress priority
  map,
- vlan_get_size() reads vlan->nr_*_mappings,
- vlan_fill_info() will soon run without RTNL.

Add the missing READ_ONCE()/WRITE_ONCE() annotations.

vlan_dev_change_flags() is also made a bit more readable by using
a local new_flags variable, avoiding the repeated re-reads of
vlan->flags after it has been published.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan.h         |  2 +-
 net/8021q/vlan_core.c    |  2 +-
 net/8021q/vlan_dev.c     | 37 ++++++++++++++++++++++---------------
 net/8021q/vlan_netlink.c |  4 ++--
 net/8021q/vlanproc.c     | 18 +++++++++---------
 5 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index d874ab323d320f7a21c658d31656350754df0c20..4930e6e8610913000f1e789c71cab0f94978e4f4 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -158,7 +158,7 @@ static inline u32 vlan_get_ingress_priority(struct net_device *dev,
 {
 	struct vlan_dev_priv *vip = vlan_dev_priv(dev);
 
-	return vip->ingress_priority_map[(vlan_tci >> VLAN_PRIO_SHIFT) & 0x7];
+	return READ_ONCE(vip->ingress_priority_map[(vlan_tci >> VLAN_PRIO_SHIFT) & 0x7]);
 }
 
 #ifdef CONFIG_VLAN_8021Q_GVRP
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index d23965e76c167b3124afb74ae447ed211a701cc7..1fc6ebd3313218255a404255619d330527a73f38 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -38,7 +38,7 @@ bool vlan_do_receive(struct sk_buff **skbp)
 			skb->pkt_type = PACKET_HOST;
 	}
 
-	if (!(vlan_dev_priv(vlan_dev)->flags & VLAN_FLAG_REORDER_HDR) &&
+	if (!(READ_ONCE(vlan_dev_priv(vlan_dev)->flags) & VLAN_FLAG_REORDER_HDR) &&
 	    !netif_is_macvlan_port(vlan_dev) &&
 	    !netif_is_bridge_port(vlan_dev)) {
 		unsigned int offset = skb->data - skb_mac_header(skb);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 2859cbac3f266b7c4e3f44f41280d33ab69c5270..16e917e9c23036c1a62de2c28ac27c29f728bc8e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -54,7 +54,7 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	u16 vlan_tci = 0;
 	int rc;
 
-	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+	if (!(READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR)) {
 		vhdr = skb_push(skb, VLAN_HLEN);
 
 		vlan_tci = vlan->vlan_id;
@@ -110,7 +110,7 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
 	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
 	 */
-	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
+	if (READ_ONCE(vlan->flags) & VLAN_FLAG_REORDER_HDR ||
 	    veth->h_vlan_proto != vlan->vlan_proto) {
 		u16 vlan_tci;
 		vlan_tci = vlan->vlan_id;
@@ -159,13 +159,16 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	u32 *map = &vlan->ingress_priority_map[vlan_prio & 0x7];
 
-	if (vlan->ingress_priority_map[vlan_prio & 0x7] && !skb_prio)
-		vlan->nr_ingress_mappings--;
-	else if (!vlan->ingress_priority_map[vlan_prio & 0x7] && skb_prio)
-		vlan->nr_ingress_mappings++;
+	if (*map && !skb_prio)
+		WRITE_ONCE(vlan->nr_ingress_mappings,
+			   vlan->nr_ingress_mappings - 1);
+	else if (!*map && skb_prio)
+		WRITE_ONCE(vlan->nr_ingress_mappings,
+			   vlan->nr_ingress_mappings + 1);
 
-	vlan->ingress_priority_map[vlan_prio & 0x7] = skb_prio;
+	WRITE_ONCE(*map, skb_prio);
 }
 
 int vlan_dev_set_egress_priority(const struct net_device *dev,
@@ -185,7 +188,8 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 		if (mp->priority == skb_prio) {
 			if (!vlan_qos) {
 				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
-				vlan->nr_egress_mappings--;
+				WRITE_ONCE(vlan->nr_egress_mappings,
+					   vlan->nr_egress_mappings - 1);
 				kfree_rcu(mp, rcu);
 			} else {
 				WRITE_ONCE(mp->vlan_qos, vlan_qos);
@@ -209,7 +213,8 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 	RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
 	rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
 	if (vlan_qos)
-		vlan->nr_egress_mappings++;
+		WRITE_ONCE(vlan->nr_egress_mappings,
+			   vlan->nr_egress_mappings + 1);
 	return 0;
 }
 
@@ -220,23 +225,25 @@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	u32 old_flags = vlan->flags;
+	u32 new_flags;
 
 	if (mask & ~(VLAN_FLAG_REORDER_HDR | VLAN_FLAG_GVRP |
 		     VLAN_FLAG_LOOSE_BINDING | VLAN_FLAG_MVRP |
 		     VLAN_FLAG_BRIDGE_BINDING))
 		return -EINVAL;
 
-	vlan->flags = (old_flags & ~mask) | (flags & mask);
+	new_flags = (old_flags & ~mask) | (flags & mask);
+	WRITE_ONCE(vlan->flags, new_flags);
 
-	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
-		if (vlan->flags & VLAN_FLAG_GVRP)
+	if (netif_running(dev) && (new_flags ^ old_flags) & VLAN_FLAG_GVRP) {
+		if (new_flags & VLAN_FLAG_GVRP)
 			vlan_gvrp_request_join(dev);
 		else
 			vlan_gvrp_request_leave(dev);
 	}
 
-	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
-		if (vlan->flags & VLAN_FLAG_MVRP)
+	if (netif_running(dev) && (new_flags ^ old_flags) & VLAN_FLAG_MVRP) {
+		if (new_flags & VLAN_FLAG_MVRP)
 			vlan_mvrp_request_join(dev);
 		else
 			vlan_mvrp_request_leave(dev);
@@ -599,7 +606,7 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 			pm = next;
 		}
 	}
-	vlan->nr_egress_mappings = 0;
+	WRITE_ONCE(vlan->nr_egress_mappings, 0);
 }
 
 static void vlan_dev_uninit(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 368d53ca7d870998d4ce12bb9a48f946fedcb8ee..71cb98950511fe30f9b117834ce8b9107889f0cb 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -214,8 +214,8 @@ static size_t vlan_get_size(const struct net_device *dev)
 	return nla_total_size(2) +	/* IFLA_VLAN_PROTOCOL */
 	       nla_total_size(2) +	/* IFLA_VLAN_ID */
 	       nla_total_size(sizeof(struct ifla_vlan_flags)) + /* IFLA_VLAN_FLAGS */
-	       vlan_qos_map_size(vlan->nr_ingress_mappings) +
-	       vlan_qos_map_size(vlan->nr_egress_mappings);
+	       vlan_qos_map_size(READ_ONCE(vlan->nr_ingress_mappings)) +
+	       vlan_qos_map_size(READ_ONCE(vlan->nr_egress_mappings));
 }
 
 static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index 0e424e0895b7e860138c89743c2646bcb83750cd..5dd27438db9b39982fe978317587dfd341c17d92 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -240,7 +240,7 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",
 		   vlandev->name, vlan->vlan_id,
-		   (int)(vlan->flags & 1), (u32)vlandev->priv_flags);
+		   (int)(READ_ONCE(vlan->flags) & 1), (u32)vlandev->priv_flags);
 
 	seq_printf(seq, fmt64, "total frames received", stats->rx_packets);
 	seq_printf(seq, fmt64, "total bytes received", stats->rx_bytes);
@@ -252,14 +252,14 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 	/* now show all PRIORITY mappings relating to this VLAN */
 	seq_printf(seq, "\nINGRESS priority mappings: "
 			"0:%u  1:%u  2:%u  3:%u  4:%u  5:%u  6:%u 7:%u\n",
-		   vlan->ingress_priority_map[0],
-		   vlan->ingress_priority_map[1],
-		   vlan->ingress_priority_map[2],
-		   vlan->ingress_priority_map[3],
-		   vlan->ingress_priority_map[4],
-		   vlan->ingress_priority_map[5],
-		   vlan->ingress_priority_map[6],
-		   vlan->ingress_priority_map[7]);
+		   READ_ONCE(vlan->ingress_priority_map[0]),
+		   READ_ONCE(vlan->ingress_priority_map[1]),
+		   READ_ONCE(vlan->ingress_priority_map[2]),
+		   READ_ONCE(vlan->ingress_priority_map[3]),
+		   READ_ONCE(vlan->ingress_priority_map[4]),
+		   READ_ONCE(vlan->ingress_priority_map[5]),
+		   READ_ONCE(vlan->ingress_priority_map[6]),
+		   READ_ONCE(vlan->ingress_priority_map[7]));
 
 	seq_printf(seq, " EGRESS priority mappings: ");
 	rcu_read_lock();
-- 
2.55.0.1032.g73a4cd73de-goog

