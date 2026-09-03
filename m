Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713803FA5FA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418600; cv=none; b=azl/JPpJqdeGKeIbAti2fhyw+AsSN9hkHdL6Mgaec9/M7IS24kX5JH2waOy9KqDG90kS5JzLzfiD5QxfIq1h9OhKiNq0kGLl0hnlyRNiterTE5xc1UpDc6iSoC1XacTZ9s3NkfrgbnY3e3hWdi8MFMYqfp9s5RQ5v0sWVKCe0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418600; c=relaxed/simple;
	bh=aPAu8O+Z31pFJBRkDjt55qEqr+1soQ8sBGwF4hc8Ef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gex/XZwfh7vCTLo/6iz3JPma3ulknLakQB7C7THtCaJ6O/iZjk4YDHENyy3MSOR5L97JKErCVL5FPoAIjdq+9Zrl7EiF7OCGaQR20krr3NroNEg/cDcRvL5D2KJbXl8k/l+JJtwicd9dPzmzraJvlX8cLYHlhQ94mvI+qE3qgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=INMVoJJe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="INMVoJJe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so18198945ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788418594; x=1789023394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2OEX0/sB0aUCvFZnFb+ZNiZz37uHRQ0yoP90qXgnBBI=;
        b=INMVoJJeNxRHo+fFfkZZTsYH3+d78YLFGgF1pv0YRYFwTfI22dCYemps0sRFPn8Mw5
         BDPpZPBiojKCNrBREAo/J0rmdn5ZT6Paf/SzJhybubJXoeDQMSsvZXCPExo50Cm7Bbiw
         4fEvjNqlGpMsR/XB0euYesRsIG/8DATq1BTFsPBk30+0bMBHqc9TIWwUAD7WzNcXpfXZ
         f+edPELqtnOvQ8gSfdX9FmpIh0foObB8AW5bHRfZyKqEVeTJDvzRP2mnSFO/Zf2g43kR
         MLAlIyeirARJnS5+CsCh1kxy2r1GJPx5y7oOgLbr8UPW2GwdY5EbtCTxActh1Mlo3pI+
         V+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418594; x=1789023394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2OEX0/sB0aUCvFZnFb+ZNiZz37uHRQ0yoP90qXgnBBI=;
        b=KhDvez8Dtl08Pw47PdXGH5raok+wvc1bFBXqajSQnJ3uG/CS0oU8JJ09oMxyobOnd1
         0KsEkLripV+VwpsSsJRYsh/zdbmqyBcyHaynbBprwjsC7OqbJgwuBWAHM7ydiKjzDxvD
         r1YRv5h3TVGwOjlHYCMh86OaU6QFpXvgeFgfV4/siRiLSNWf9GIz8Uhg/YgUztU+Dfnq
         y7baXdPYE8lpwbMOwv26kEFMqvqGvc2FIwBPg+xTyOBkqItFak2h+znD/3Auq3aarKQV
         VkhDl5mSxsH+fo22dmOqXKsci5oU2qv3fTUD0VIwg0KZ3G1qWGiwzKjZGkBZh2VnGgCy
         X8NA==
X-Forwarded-Encrypted: i=1; AKwUvBzkNS42gmWsjWZwreuMMKK4Ea/7JDnH48wxWaGpyNGNGfjAX1egJ54n0GNieAP/EtSQr+nopIo=@vger.kernel.org
X-Gm-Message-State: AFuF++nkiVgRETfQcHvZcJNIll5BZy+ElFDwOiJiWei1APT+EVDkFdlI
	aKLBs3h2JJ39XrO1PSYhtjiMj8TB804ZjH71XU3jF5BgLrkWqes4EYyGS3pnXXAhoiWk
X-Gm-Gg: AYBFou1HZ5gM24NEZQR8yotDuUOccDV+BPiem6sKj7Mc1pu5JK73+brJhFisSKEJwbe
	iLpWsnEK6HFWShGIqr2RJ3ECLfl7AZEwyNl24ejOIaFlJ0OYeV261DgZ0c9vG6XFeYStTxDkrk7
	Yp+280eaMua1xP/7hy4ztCm3Kzf/TjKH52YCj/Y83xiyNx3Xur012uNP/CJBAlpB0kBAE6i7Gxc
	Sxt6AuzqPt0dhjkC6MYXGK3lF+DWdCn48nvKmzjEBUnLO27FNiuVDfgIBJlueZJYTid9DJBcjLq
	fpj5fOpP3uTcnfMy08KG3TX7+TtSy4rTV+Tfv02iYU2IZjYG9KdJsDfLFVSLbMyt/ZxDpT0tceG
	6Mpd7vRN6M/andxpkBk5ZL5GKmXmVFtwCki/mf9kB1A2U8DBmRigEREr9HSTF4Hm6AO9toKxXNa
	KwqeJnlQCRvcUsJ3X7338fmf59Ae0lU1R+loxYQ2bWIot2Onb0CZDdhrzEuAA6jEn13DhtAnVod
	LYa
X-Received: by 2002:a17:902:f54b:b0:2da:f75f:adbc with SMTP id d9443c01a7336-2daf75faf3bmr82815665ad.15.1788418593509;
        Wed, 02 Sep 2026 23:56:33 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62dbc7sm5443565ad.28.2026.09.02.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:56:32 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	henrik.bjoernlund@microchip.com,
	horatiu.vultur@microchip.com,
	vega@nebusec.ai,
	zylzyl2333@gmail.com,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] net: bridge: use option bits for CFM/MRP frame handlers
Date: Thu,  3 Sep 2026 14:56:14 +0800
Message-ID: <0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1788417901.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788417901.git.zhilinz@nebusec.ai>
References: <cover.1788417901.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFM and MRP register a global br_frame_type whose hlist_node is linked
into the per-bridge frame_type_list when the first MEP/MRP instance is
created. Enabling the protocol on multiple bridges therefore inserts the
same node into multiple lists. Unregistering it on one bridge then
corrupts list state belonging to another.

These handlers can only be installed once per bridge, and they are
uncommon. Track their per-bridge enable state with net_bridge option
bits, which already live on the Rx hot cache line, and dispatch the
matching handler directly from the receive path. Check both bits
together first as an unlikely case.

Remove the generic frame_type_list and br_frame_type helpers, which
have had no other users since CFM and MRP were added. That shrinks
struct net_bridge by 8 bytes and drops the list walk from the fast
path. When neither protocol is compiled in, BR_CFM_MRP_OPTS is 0 and
the compiler prunes the branch.

Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Co-developed-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Always define BR_CFM_MRP_OPTS and keep the fast-path check
  unconditional. Read br->options with READ_ONCE().
- Drop CONFIG ifdefs around CFM/MRP dispatch. Provide header no-ops when
  the protocols are not compiled in so the compiler can prune them.
- v2 Link: https://lore.kernel.org/all/a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai/

changes in v2:
  - Replace the per-bridge br_frame_type object with net_bridge option
    bits.
  - Dispatch CFM/MRP handlers from the receive path. Check both option
    bits together first as an unlikely case.
  - Cover MRP, which has the same shared hlist_node bug.
  - Remove frame_type_list so CFM/MRP do not affect the fast path when
    they are disabled in .config.
  - v1 Link: https://lore.kernel.org/all/7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com/

 net/bridge/br_cfm.c     | 11 +++--------
 net/bridge/br_device.c  |  1 -
 net/bridge/br_input.c   | 35 ++++++++++++++---------------------
 net/bridge/br_mrp.c     | 13 +++----------
 net/bridge/br_private.h | 26 +++++++++++++++-----------
 5 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index dea56fffa1c19..9dcc97d63a6fc 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -367,7 +367,7 @@ static u32 ccm_tlv_extract(struct sk_buff *skb, u32 index,
 }
 
 /* note: already called with rcu_read_lock */
-static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 {
 	u32 mdlevel, interval, size, index, max;
 	const struct br_cfm_common_hdr *hdr;
@@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 	return 1;
 }
 
-static struct br_frame_type cfm_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_CFM),
-	.frame_handler = br_cfm_frame_rx,
-};
-
 int br_cfm_mep_create(struct net_bridge *br,
 		      const u32 instance,
 		      struct br_cfm_mep_create *const create,
@@ -559,7 +554,7 @@ int br_cfm_mep_create(struct net_bridge *br,
 	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
 
 	if (hlist_empty(&br->mep_list))
-		br_add_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, true);
 
 	hlist_add_tail_rcu(&mep->head, &br->mep_list);
 
@@ -588,7 +583,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 	kfree_rcu(mep, rcu);
 
 	if (hlist_empty(&br->mep_list))
-		br_del_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, false);
 }
 
 int br_cfm_mep_delete(struct net_bridge *br,
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ff55dab736326..e01c44a90d84b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -503,7 +503,6 @@ void br_dev_setup(struct net_device *dev)
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
 	INIT_HLIST_HEAD(&br->fdb_list);
-	INIT_HLIST_HEAD(&br->frame_type_list);
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	INIT_HLIST_HEAD(&br->mrp_list);
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index d87a5f9fa92b7..8bed72baf1615 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -317,17 +317,25 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	return RX_HANDLER_CONSUMED;
 }
 
+#define BR_CFM_MRP_OPTS \
+	((IS_ENABLED(CONFIG_BRIDGE_CFM) ? BIT(BROPT_CFM_ENABLED) : 0UL) | \
+	 (IS_ENABLED(CONFIG_BRIDGE_MRP) ? BIT(BROPT_MRP_ENABLED) : 0UL))
+
 /* Return 0 if the frame was not processed otherwise 1
  * note: already called with rcu_read_lock
  */
 static int br_process_frame_type(struct net_bridge_port *p,
 				 struct sk_buff *skb)
 {
-	struct br_frame_type *tmp;
+	struct net_bridge *br = p->br;
+
+	if (skb->protocol == htons(ETH_P_CFM) &&
+	    br_opt_get(br, BROPT_CFM_ENABLED))
+		return br_cfm_frame_rx(p, skb);
 
-	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
-		if (unlikely(tmp->type == skb->protocol))
-			return tmp->frame_handler(p, skb);
+	if (skb->protocol == htons(ETH_P_MRP) &&
+	    br_opt_get(br, BROPT_MRP_ENABLED))
+		return br_mrp_process(p, skb);
 
 	return 0;
 }
@@ -425,7 +433,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	if (unlikely(br_process_frame_type(p, skb)))
+	if (unlikely((READ_ONCE(p->br->options) & BR_CFM_MRP_OPTS) &&
+		     br_process_frame_type(p, skb)))
 		return RX_HANDLER_PASS;
 
 forward:
@@ -467,19 +476,3 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 
 	return br_handle_frame;
 }
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
-}
-
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	struct br_frame_type *tmp;
-
-	hlist_for_each_entry(tmp, &br->frame_type_list, list)
-		if (ft == tmp) {
-			hlist_del_rcu(&ft->list);
-			return;
-		}
-}
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index ef16d07039241..dce6efa96c4c6 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -6,13 +6,6 @@
 static const u8 mrp_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 };
 static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
 
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
-
-static struct br_frame_type mrp_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_MRP),
-	.frame_handler = br_mrp_process,
-};
-
 static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
 				struct net_bridge_port *s_port,
 				struct net_bridge_port *port)
@@ -486,7 +479,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	kfree_rcu(mrp, rcu);
 
 	if (hlist_empty(&br->mrp_list))
-		br_del_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, false);
 }
 
 /* Adds a new MRP instance.
@@ -536,7 +529,7 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	rcu_assign_pointer(mrp->s_port, p);
 
 	if (hlist_empty(&br->mrp_list))
-		br_add_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, true);
 
 	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
 	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
@@ -1241,7 +1234,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
  * normal forwarding.
  * note: already called with rcu_read_lock
  */
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	/* If there is no MRP instance do normal forwarding */
 	if (likely(!test_bit(BR_MRP_AWARE_BIT, &p->flags)))
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980d..b01997ea95089 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -495,12 +495,13 @@ enum net_bridge_opts {
 	BROPT_MST_ENABLED,
 	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 	BROPT_FDB_LOCAL_VLAN_0,
+	BROPT_CFM_ENABLED,
+	BROPT_MRP_ENABLED,
 };
 
 struct net_bridge {
 	spinlock_t			lock;
 	spinlock_t			hash_lock;
-	struct hlist_head		frame_type_list;
 	struct net_device		*dev;
 	unsigned long			options;
 	/* These fields are accessed on each packet */
@@ -932,16 +933,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
 
-struct br_frame_type {
-	__be16			type;
-	int			(*frame_handler)(struct net_bridge_port *port,
-						 struct sk_buff *skb);
-	struct hlist_node	list;
-};
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
-
 static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->rx_handler) == br_get_rx_handler(dev);
@@ -2080,6 +2071,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 bool br_mrp_enabled(struct net_bridge *br);
 void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 #else
 static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 			       struct nlattr *attr, int cmd,
@@ -2103,6 +2095,11 @@ static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 	return 0;
 }
 
+static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+{
+	return 0;
+}
+
 #endif
 
 /* br_cfm.c */
@@ -2111,6 +2108,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 bool br_cfm_created(struct net_bridge *br);
 void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
@@ -2135,6 +2133,12 @@ static inline void br_cfm_port_del(struct net_bridge *br,
 {
 }
 
+static inline int br_cfm_frame_rx(struct net_bridge_port *port,
+				  struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

