Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7D38D3FE
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745407; cv=none; b=fD+zCfHoG5ZvA62VChCBuaMnNAk/0/56EUOxIVmkVAPAltxEhJwguT6vtXzARU9hZjtWP86NEt1TCGfyyRmCSM+wc0tsVHAr823wn5zApMM7UnOr0WqhSwZ6pbdg+Onp19PtkiAJ/K6MF2kuULdmyo+U7eiVOMWVlgFJDCqib1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745407; c=relaxed/simple;
	bh=rm6Nv1SvwKFTtqSI4jt9zM7PIAyrtw0ibi+j1MLLYEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp6ekxwR2mjCoKnJaRcQA9QTJe2YmGnDCSiTOcWDHkJT00N1KPFY+YHvsvV+yySMWqC/UQFgOo+jlunoVt5yM5pL9n//awid0LowCsGciyzu6MUoOx0j3MfgFGWDKhzpECzEdu7iyojdLsrm+IBf4mXXKO/qFFa+HKz7tXzBhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C9B8oQaR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="C9B8oQaR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so447248f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745403; x=1790350203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61teZ3KradatiuBeuQ1pWwzM+izxt2+LiZ5ASD5j0iQ=;
        b=C9B8oQaRznxXK8hSNQ8vHxVSNuTXK4F/8nDPavm9Ln3N+0rr0U+n60KhSJoTMq1EsF
         KHsarxvVui/j5vKpOq1nfpwkHM9S6Wa2o38XwRXlnkUn9qLenYW6e8haA8OauV1SGkHW
         WCnelelvvoiSLp/GB7WkfenFrmmTOvgSN0/ZhG1yl5CMfuQluL18PYbtSUZni2aCTgUn
         oJnzDDdLuMjL2V9UxD6lp2QO2k1dvG/ckKcbF+ppwQboz+N0OFcYz7vB6mzWkOfHt7JI
         W7cprEkxp+sEAGH2LIkT8Nky2Ww7gkKxv5Ks/CqcclGOly/UaJNjkNiNZYt3v6em0gr5
         O9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745403; x=1790350203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=61teZ3KradatiuBeuQ1pWwzM+izxt2+LiZ5ASD5j0iQ=;
        b=iBCJqTf29ypqf/13ewBg+IKFPsMIglIw6PjRa1kwIu1IiAmr3JBDfRrMAtbPICkASn
         Mn/NXsP7Z3kxasnb3PuKmfDd777TNhqydDuQygD2La28gi3L1Pt7JEAcLXR7MyYcWFdc
         0j0fcazpbeL+a6+YkodIV6ilD5/ZEtukzna10YiTAGSPUR95q31IWMM/6uydEn+nj/HI
         RkTYs4pOW8ldvipfuCflmfSCeWzP+BhNCQTf49HyL4515i+VrhyR/IQVqlorKwKxiQYZ
         1qRmnQLyawKxSE4iAKLOTugwf/NjlxB/NAYyON9Ioz44GC8Et7Hb8v8eg1qAra0Hy87i
         9mFA==
X-Gm-Message-State: AFuF++mdBnHm36ffszIQxchknJDRXdnHFINHrFGDl0IakFvbLahs1p0W
	FO493N6aaiVDZ7p1Iv9lyFQQU/s3tDEWunfxjSpl2KADHyBHXDjX6oe5hgjRIFyhxHW3FggxYBP
	MbOJU
X-Gm-Gg: AYBFou1Ku4TzuPxeJw1qYcwS9R4wiDZ/7CElf3M3iDHhmmqKt8N8TGD5aisajSJRGdh
	7BamySosFrx1MeJvTLT2fJ0GLxIZimIS9tnFOy0YKtayqIuRwnmC608BnwgiCz73ghZkMi8FKhY
	iINMlD+Q50TWkqEx5irLXELfOG4ImIAYTlkkbAbJ77Btywpcl9Sh0zrUaHJxpaK4Z+c7WhH7qb9
	yYxe+uAFT2/MR3W2yO+RlPh5jYhWxvhEkeAvh9HAOMzACV5nNT9ycKMQq6rB5buYKXVPk/oAF0c
	3/KeTgQDSE6ittVWxd2+OoH1lJNVd6IbCdR96ux2IxsEUpPQ6KRee/KxQu+VHaVEpdyYxDoCRDT
	8i64vC7Z3FdzTAIvvgHxCGGfHaaUdnuLpJ6guHiKcg5y9ljz/BteS0/jzWDJ+q1XbOI7nA6bpyd
	8dOvW46WWluojxH1gAOR5xK+Zp9BoHQ83aidKs3xRD+HdVWtMSkVHlxxDRt2lxiiJMbAb4cnHkg
	EK2/WwMzW14Hnb7If3z5w==
X-Received: by 2002:a05:6000:220f:b0:487:34c:81e with SMTP id ffacd0b85a97d-4871e226b3bmr4026728f8f.20.1789745403063;
        Fri, 18 Sep 2026 08:30:03 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48720072501sm4764014f8f.22.2026.09.18.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:30:02 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 7/9] net: bridge: introduce a forwarding destination structure
Date: Fri, 18 Sep 2026 18:29:48 +0300
Message-ID: <20260918152950.1938259-8-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct br_fwd_dst to keep an egress port together with its
corresponding VLAN while passing it through the forwarding helpers. This
allows paths which already resolved the port VLAN to preserve that
information for later egress processing. maybe_deliver() now returns the
clone error directly and we pass it separately to br_flood_finish()
avoiding the error-pointer encoding and decoding which overloaded the
previous port pointer.
No functional changes intended.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 146 +++++++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 56 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e8f30f2df1ed..845193baf992 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -7,7 +7,6 @@
  *	Lennert Buytenhek		<buytenh@gnu.org>
  */
 
-#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -17,10 +16,16 @@
 #include <linux/netfilter_bridge.h>
 #include "br_private.h"
 
+struct br_fwd_dst {
+	const struct net_bridge_port *port;
+	struct net_bridge_vlan *vlan;
+};
+
 /* Don't forward packets to originating port or forwarding disabled */
-static inline int should_deliver(const struct net_bridge_port *p,
+static inline int should_deliver(const struct br_fwd_dst *fwd,
 				 const struct sk_buff *skb)
 {
+	const struct net_bridge_port *p = fwd->port;
 	struct net_bridge_vlan_group *vg;
 
 	vg = nbp_vlan_group_rcu(p);
@@ -70,9 +75,10 @@ int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(br_forward_finish);
 
-static void __br_forward(const struct net_bridge_port *to,
+static void __br_forward(const struct br_fwd_dst *fwd,
 			 struct sk_buff *skb, bool local_orig)
 {
+	const struct net_bridge_port *to = fwd->port;
 	struct net_bridge_vlan_group *vg;
 	struct net_device *indev;
 	struct net *net;
@@ -117,7 +123,7 @@ static void __br_forward(const struct net_bridge_port *to,
 		br_forward_finish);
 }
 
-static int deliver_clone(const struct net_bridge_port *prev,
+static int deliver_clone(const struct br_fwd_dst *fwd,
 			 struct sk_buff *skb, bool local_orig)
 {
 	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
@@ -128,7 +134,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 		return -ENOMEM;
 	}
 
-	__br_forward(prev, skb, local_orig);
+	__br_forward(fwd, skb, local_orig);
 	return 0;
 }
 
@@ -144,6 +150,8 @@ static int deliver_clone(const struct net_bridge_port *prev,
 void br_forward(const struct net_bridge_port *to,
 		struct sk_buff *skb, bool local_rcv, bool local_orig)
 {
+	struct br_fwd_dst fwd;
+
 	if (unlikely(!to))
 		goto out;
 
@@ -159,11 +167,13 @@ void br_forward(const struct net_bridge_port *to,
 		to = backup_port;
 	}
 
-	if (should_deliver(to, skb)) {
+	fwd.port = to;
+	fwd.vlan = NULL;
+	if (should_deliver(&fwd, skb)) {
 		if (local_rcv)
-			deliver_clone(to, skb, local_orig);
+			deliver_clone(&fwd, skb, local_orig);
 		else
-			__br_forward(to, skb, local_orig);
+			__br_forward(&fwd, skb, local_orig);
 		return;
 	}
 
@@ -173,40 +183,41 @@ void br_forward(const struct net_bridge_port *to,
 }
 EXPORT_SYMBOL_GPL(br_forward);
 
-static struct net_bridge_port *maybe_deliver(
-	struct net_bridge_port *prev, struct net_bridge_port *p,
-	struct sk_buff *skb, bool local_orig)
+static int maybe_deliver(struct br_fwd_dst *prev, const struct br_fwd_dst *fwd,
+			 struct sk_buff *skb, bool local_orig)
 {
+	const struct net_bridge_port *p = fwd->port;
 	u8 igmp_type = br_multicast_igmp_type(skb);
 	int err;
 
-	if (!should_deliver(p, skb))
-		return prev;
+	if (!should_deliver(fwd, skb))
+		return 0;
 
 	nbp_switchdev_frame_mark_tx_fwd_to_hwdom(p, skb);
 
-	if (!prev)
+	if (!prev->port)
 		goto out;
 
 	err = deliver_clone(prev, skb, local_orig);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 out:
 	br_multicast_count(p->br, p, skb, igmp_type, BR_MCAST_DIR_TX);
+	*prev = *fwd;
 
-	return p;
+	return 0;
 }
 
-static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
+static void br_flood_finish(const struct br_fwd_dst *fwd, int err,
+			    struct sk_buff *skb,
 			    bool local_rcv, bool local_orig)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 
-	if (IS_ERR_OR_NULL(prev)) {
-		if (IS_ERR(prev)) {
-			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
-				 SKB_DROP_REASON_NOT_SPECIFIED;
-		}
+	if (err || !fwd->port) {
+		if (err)
+			reason = err == -ENOMEM ? SKB_DROP_REASON_NOMEM :
+						  SKB_DROP_REASON_NOT_SPECIFIED;
 
 		if (!local_rcv)
 			kfree_skb_reason(skb, reason);
@@ -214,59 +225,64 @@ static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
 	}
 
 	if (local_rcv)
-		deliver_clone(prev, skb, local_orig);
+		deliver_clone(fwd, skb, local_orig);
 	else
-		__br_forward(prev, skb, local_orig);
+		__br_forward(fwd, skb, local_orig);
 }
 
-static void br_flood_port(struct net_bridge_port **prev,
-			  struct net_bridge_port *p, struct sk_buff *skb,
-			  enum br_pkt_type pkt_type, bool local_orig, u16 vid)
+static int br_flood_port(struct br_fwd_dst *prev,
+			 const struct br_fwd_dst *fwd, struct sk_buff *skb,
+			 enum br_pkt_type pkt_type, bool local_orig)
 {
+	const struct net_bridge_port *p = fwd->port;
+	u16 vid = fwd->vlan ? fwd->vlan->vid : 0;
+
 	/* Do not flood unicast traffic to ports that turn it off, nor
 	 * other traffic if flood off, except for traffic we originate
 	 */
 	switch (pkt_type) {
 	case BR_PKT_UNICAST:
 		if (!test_bit(BR_FLOOD_BIT, &p->flags))
-			return;
+			return 0;
 		break;
 	case BR_PKT_MULTICAST:
 		if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) &&
 		    skb->dev != p->br->dev)
-			return;
+			return 0;
 		break;
 	case BR_PKT_BROADCAST:
 		if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) &&
 		    skb->dev != p->br->dev)
-			return;
+			return 0;
 		break;
 	}
 
 	/* Do not flood to ports that enable proxy ARP */
 	if (test_bit(BR_PROXYARP_BIT, &p->flags))
-		return;
+		return 0;
 	if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
 		if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
-			return;
+			return 0;
 		/* For gratuitous ARPs/NAs, check neigh_forward_grat.
 		 * For regular ARPs/NDs, check only neigh_suppress.
 		 */
 		if (br_is_neigh_suppress_enabled(p, vid) &&
 		    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
 		     !br_is_neigh_forward_grat_enabled(p, vid)))
-			return;
+			return 0;
 	}
 
-	*prev = maybe_deliver(*prev, p, skb, local_orig);
+	return maybe_deliver(prev, fwd, skb, local_orig);
 }
 
-static void br_flood_vlan(struct net_bridge_port **prev,
-			  struct net_bridge_vlan *v, struct sk_buff *skb,
-			  enum br_pkt_type pkt_type, bool local_orig)
+static int br_flood_vlan(struct br_fwd_dst *prev,
+			 struct net_bridge_vlan *v, struct sk_buff *skb,
+			 enum br_pkt_type pkt_type, bool local_orig)
 {
 	struct net_bridge_vlan_port_array *array;
 	struct net_bridge_vlan *masterv, *pv;
+	struct br_fwd_dst dst;
+	int err;
 
 	masterv = br_vlan_is_master(v) ? v : v->brvlan;
 	array = rcu_dereference(masterv->port_array);
@@ -275,19 +291,25 @@ static void br_flood_vlan(struct net_bridge_port **prev,
 
 		for (i = 0; i < array->count; i++) {
 			pv = array->vlans[i];
-			br_flood_port(prev, pv->port, skb, pkt_type,
-				      local_orig, v->vid);
-			if (IS_ERR(*prev))
-				break;
+			dst.port = pv->port;
+			dst.vlan = pv;
+			err = br_flood_port(prev, &dst, skb, pkt_type,
+					    local_orig);
+			if (err)
+				return err;
 		}
 	} else {
 		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
-			br_flood_port(prev, pv->port, skb, pkt_type,
-				      local_orig, v->vid);
-			if (IS_ERR(*prev))
-				break;
+			dst.port = pv->port;
+			dst.vlan = pv;
+			err = br_flood_port(prev, &dst, skb, pkt_type,
+					    local_orig);
+			if (err)
+				return err;
 		}
 	}
+
+	return 0;
 }
 
 /* called under rcu_read_lock */
@@ -295,23 +317,29 @@ void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
 	      struct sk_buff *skb, enum br_pkt_type pkt_type,
 	      bool local_rcv, bool local_orig)
 {
-	struct net_bridge_port *prev = NULL;
+	struct br_fwd_dst prev = {};
+	int err = 0;
 
 	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
 
 	if (v) {
-		br_flood_vlan(&prev, v, skb, pkt_type, local_orig);
+		err = br_flood_vlan(&prev, v, skb, pkt_type, local_orig);
 	} else {
 		struct net_bridge_port *p;
 
 		list_for_each_entry_rcu(p, &br->port_list, list) {
-			br_flood_port(&prev, p, skb, pkt_type, local_orig, 0);
-			if (IS_ERR(prev))
+			struct br_fwd_dst fwd = {
+				.port = p,
+			};
+
+			err = br_flood_port(&prev, &fwd, skb, pkt_type,
+					    local_orig);
+			if (err)
 				break;
 		}
 	}
 
-	br_flood_finish(prev, skb, local_rcv, local_orig);
+	br_flood_finish(&prev, err, skb, local_rcv, local_orig);
 }
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -320,9 +348,12 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 {
 	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
 	const unsigned char *src = eth_hdr(skb)->h_source;
+	struct br_fwd_dst fwd = {
+		.port = p,
+	};
 	struct sk_buff *nskb;
 
-	if (!should_deliver(p, skb))
+	if (!should_deliver(&fwd, skb))
 		return;
 
 	/* Even with hairpin, no soliloquies - prevent breaking IPv6 DAD */
@@ -342,7 +373,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(addr))
 		memcpy(eth_hdr(skb)->h_dest, addr, ETH_ALEN);
 
-	__br_forward(p, skb, local_orig);
+	__br_forward(&fwd, skb, local_orig);
 }
 
 /* called with rcu_read_lock */
@@ -351,10 +382,11 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			struct net_bridge_mcast *brmctx,
 			bool local_rcv, bool local_orig)
 {
-	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
 	bool allow_mode_include = true;
+	struct br_fwd_dst prev = {};
 	struct hlist_node *rp;
+	int err = 0;
 
 	rp = br_multicast_get_first_rport_node(brmctx, skb);
 
@@ -370,6 +402,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 
 	while (p || rp) {
 		struct net_bridge_port *port, *lport, *rport;
+		struct br_fwd_dst fwd = {};
 
 		lport = p ? p->key.port : NULL;
 		rport = br_multicast_rport_from_node_skb(rp, skb);
@@ -391,8 +424,9 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			port = rport;
 		}
 
-		prev = maybe_deliver(prev, port, skb, local_orig);
-		if (IS_ERR(prev))
+		fwd.port = port;
+		err = maybe_deliver(&prev, &fwd, skb, local_orig);
+		if (err)
 			break;
 
 delivered:
@@ -402,6 +436,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			rp = rcu_dereference(hlist_next_rcu(rp));
 	}
 
-	br_flood_finish(prev, skb, local_rcv, local_orig);
+	br_flood_finish(&prev, err, skb, local_rcv, local_orig);
 }
 #endif
-- 
2.47.3

