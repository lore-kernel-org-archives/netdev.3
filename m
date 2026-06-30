Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECD3B52FA
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802683; cv=none; b=suaN+6DzkbCv/MzwJIPKs82wJ/8RMTAKaA7bx70b1zhy+ANTEOGv9L7XzxvI1swQE09vpToqYNDAQ0L7CsSKPtwRdVKozIyoCC08HAKBaw0eJE/Jmv+Xy1Xb5XYayAvq9OYedBNDqku1biaECykgdNnUTyekfp7OB99R3kRwUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802683; c=relaxed/simple;
	bh=k2puRy9roCqo1TmJQwz5Au2uDKrjMO7oV6i8D2XzG3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcEd8b34iQwi18u10LwSqvrtrpvXUXU1fHnfMU7RLkPXfKUigmsB+K/Y5mZ8+NPgfeXnuS8v3dmm0eMmitzTWBaZjdFDXk5zhHgY1SZvGC42CgiBSo6ARdZ5AvlDXR7fsx9wewHWWMZcCTQhxzcKkv+7HW20pJ53vjN80eD62Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0DirsZL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0DirsZL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso183517f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802680; x=1783407480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wpDkwfgHI7sKJsUdxhPlr3RzF4vUZ59JqIq4w/25rI=;
        b=K0DirsZLEMe5g5xU5jhiVMcWPze00GozSu5wITCehrcpclaFalpAKGRxH+qg7v2jmK
         bDDVZdKTvXMaMs7xH81IUm1sbwKLVv/sfq0avkvgLjx2+DNtc6k5EAThe6D+3eo/hovt
         VeooWLJBh3W3sDmIeLkm3AEDfiGIbEoREn4joTM5lxrfGhpUdVNi+Olw1/c7Xka6dq0i
         fGsT3mc487mHO4G46G4jgIvUuxk0qvK0OfYotUCtSaOdBds/TxhcPwcnLAidZcLFHP7k
         xIXLPIMekGvDn1I8BbSUiKVkh5ltOZXyxgFkw7czQdOYCo0F+/bIilZRUxmUIwon7hW6
         i5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802680; x=1783407480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wpDkwfgHI7sKJsUdxhPlr3RzF4vUZ59JqIq4w/25rI=;
        b=qGbhGeNwr35ZlcaIpLS2SqAIB4ZSHqSQ5q5RY36Zv2mjWKUfa4YWXVF0fjJEA/Z7Ny
         MrP1RJl1xoJsmFb+I9Hse7vvciIEvUSeAXeoJBUGMYzbvQLsTeP6Vxk8+mEDvPJ9KxR9
         nIJ5cVvY+nFg8qQul7GsOwmfxaAAvWgjzN2c8BbtqFdCAzTaBcjo5/bst5N/4EvGoNNR
         xaMHA7L9wYON26ORZl7WxgNxR1tcKeqDieT9mlmPHa2LnCVc6iwMuGevxxf6QYUDbIoH
         EgkM2dgl/vQk6P5WBANEiFIrTUnI912lUaCtevq33xV302s6pZalHCYVUf3a2VuLezfO
         JImw==
X-Forwarded-Encrypted: i=1; AHgh+RpocdMfhAEuDwITYhx8yNEQo0GQrGYZ5j/knKNunn0QYDrTttv/QQ8bIb58/SA8fYnT0zUgtBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdAynCrgPYxfAER+dDYb1ugDIBWC+BmnAilSdSbJfv2PbEGyV
	eo3Gc/wWzMDhfpKDp86AysSmh+TGGO9lhWDzvXb5F8MD2zbkrKCNbkft
X-Gm-Gg: AfdE7clSbJFnzFSsHTKEoqFX9veWlebudQjHq1PmQWThV9szD+cgEg+1rcwP7e1jsTI
	155JdvJNEJ/HCuFLtVONK2WYA9CF7uf2L7Lgek6mWqElU1JM03QvkHqE/sg+oXvPofAhEnjGzTJ
	eOG4MQGh0LhmMa9E0xvSMYI3GrcP1mb7Pz+CdCxil1Sb1K95MeOpoaaFA0h14yOUQGMl1FoU/iU
	jMamg9y75DPp1c5a8kUXskFb+e5JlmLHPjjJuIWgBJ4aS+j/baKr2zeGg/O5yImNHtS4tL6XENs
	wkgjyEb2JwI5rg7bSnCBc3Ti1zHG4l3z0nIyGJ2mMuYegdSeG7YWPmI8Sp60js1eglYkv63cmnT
	SR1N2JYCTmbdzo3PyWIUp+CZ9o+qFAR7U+23uGd6DOVfkvFCMshyCX9UxEdEYL3i62SBNspLi2L
	V0prBwgnNHzAFgSZ2RBw==
X-Received: by 2002:a5d:5d05:0:b0:474:6a5b:8604 with SMTP id ffacd0b85a97d-475507ddf66mr3025354f8f.11.1782802679649;
        Mon, 29 Jun 2026 23:57:59 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:57:59 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 2/5] net: bridge: add flow offload helpers
Date: Tue, 30 Jun 2026 08:57:32 +0200
Message-ID: <20260630065735.3341614-3-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630065735.3341614-1-pawlik.dan@gmail.com>
References: <20260630065735.3341614-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three helpers that expose the bridge state needed by nft_flow_offload
without requiring callers to include net/bridge/br_private.h. Each
performs a single br_port_get_rcu() lookup:

 - br_fdb_has_forwarding_entry_rcu(): resolves the VLAN id for the packet
   (skb tag or PVID when filtering is on, 0 otherwise) then checks whether
   the bridge FDB contains a forwarding entry (dst != NULL, non-local) for
   the resulting MAC/VLAN pair.

 - br_vlan_get_offload_info_rcu(): when VLAN filtering is active, returns
   the VLAN id (skb tag or PVID) and writes the bridge VLAN protocol to
   *proto in a single port lookup. Returns 0 when filtering is off.

 - br_vlan_is_enabled_rcu(): returns true when VLAN filtering is enabled
   on the bridge a port device belongs to.

Based on MediaTek SDK patches by Bo-Cun Chen <bc-bocun.chen@mediatek.com>
and the OpenWrt bridge offload series by Ryan Chen <rchen14b@gmail.com>.
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 include/linux/if_bridge.h | 23 +++++++++++++++++++
 net/bridge/br_fdb.c       | 34 ++++++++++++++++++++++++++++
 net/bridge/br_vlan.c      | 47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 75673b8bffcb..c1cae54749c5 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -148,6 +148,9 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
 int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 			 struct bridge_vlan_info *p_vinfo);
+u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+				 const struct sk_buff *skb, __be16 *proto);
+bool br_vlan_is_enabled_rcu(const struct net_device *dev);
 bool br_mst_enabled(const struct net_device *dev);
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids);
 int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state);
@@ -184,6 +187,17 @@ static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 	return -EINVAL;
 }
 
+static inline u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+						const struct sk_buff *skb,
+						__be16 *proto)
+{
+	return 0;
+}
+
+static inline bool br_vlan_is_enabled_rcu(const struct net_device *dev)
+{
+	return false;
+}
 static inline bool br_mst_enabled(const struct net_device *dev)
 {
 	return false;
@@ -209,6 +223,8 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
+bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+				     const struct sk_buff *skb, const u8 *addr);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -237,6 +253,13 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 {
 	return 0;
 }
+
+static inline bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+						   const struct sk_buff *skb,
+						   const u8 *addr)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4570bbed854..2a65b203274e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -267,6 +267,40 @@ struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 	return fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 }
 
+/**
+ * br_fdb_has_forwarding_entry_rcu - check if a MAC can be forwarded by the bridge
+ * @dev: bridge port network device
+ * @skb: packet buffer (used to determine VLAN id)
+ * @addr: destination MAC address
+ *
+ * Resolves the VLAN id for @skb on @dev (skb VLAN tag when present, PVID
+ * when VLAN filtering is enabled, 0 otherwise) then checks whether the bridge
+ * FDB contains a forwarding entry (dst != NULL, not a local/self entry) for
+ * @addr and that VLAN id. Single br_port_get_rcu() lookup.
+ * Must be called under RCU read lock.
+ *
+ * Returns: true if a forwarding entry exists for @addr, false otherwise.
+ */
+bool br_fdb_has_forwarding_entry_rcu(const struct net_device *dev,
+				     const struct sk_buff *skb, const u8 *addr)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+	struct net_bridge_fdb_entry *fdb;
+	u16 vid = 0;
+
+	if (!port)
+		return false;
+	if (br_opt_get(port->br, BROPT_VLAN_ENABLED)) {
+		if (skb_vlan_tag_present(skb))
+			vid = skb_vlan_tag_get_id(skb);
+		else
+			br_vlan_get_pvid_rcu(dev, &vid);
+	}
+	fdb = br_fdb_find_rcu(port->br, addr, vid);
+	return fdb && fdb->dst;
+}
+EXPORT_SYMBOL_GPL(br_fdb_has_forwarding_entry_rcu);
+
 /* When a static FDB entry is added, the mac address from the entry is
  * added to the bridge private HW address list and all required ports
  * are then updated with the new information.
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5560afcaaca3..974e57ea533a 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1559,6 +1559,53 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 }
 EXPORT_SYMBOL_GPL(br_vlan_get_info_rcu);
 
+/**
+ * br_vlan_get_offload_info_rcu - get VLAN id and protocol for bridge flow offload
+ * @dev: bridge port network device
+ * @skb: packet buffer
+ * @proto: output for the bridge VLAN protocol (set only when return value != 0)
+ *
+ * When VLAN filtering is enabled, resolves the VLAN id for flow offload (skb
+ * VLAN tag id if present, PVID otherwise) and writes the bridge VLAN protocol
+ * to @proto. Single br_port_get_rcu() lookup. Must be called under RCU read
+ * lock.
+ *
+ * Returns: the VLAN id, or 0 when filtering is off or @dev is not a bridge port.
+ */
+u16 br_vlan_get_offload_info_rcu(const struct net_device *dev,
+				 const struct sk_buff *skb, __be16 *proto)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+	u16 vid = 0;
+
+	if (!port || !br_opt_get(port->br, BROPT_VLAN_ENABLED))
+		return 0;
+	if (skb_vlan_tag_present(skb))
+		vid = skb_vlan_tag_get_id(skb);
+	else
+		br_vlan_get_pvid_rcu(dev, &vid);
+	if (vid)
+		*proto = port->br->vlan_proto;
+	return vid;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_offload_info_rcu);
+
+/**
+ * br_vlan_is_enabled_rcu - check if VLAN filtering is active on a port's bridge
+ * @dev: bridge port network device
+ *
+ * Must be called under RCU read lock.
+ *
+ * Returns: true if VLAN filtering is enabled, false otherwise.
+ */
+bool br_vlan_is_enabled_rcu(const struct net_device *dev)
+{
+	struct net_bridge_port *port = br_port_get_rcu(dev);
+
+	return port && br_opt_get(port->br, BROPT_VLAN_ENABLED);
+}
+EXPORT_SYMBOL_GPL(br_vlan_is_enabled_rcu);
+
 static int br_vlan_is_bind_vlan_dev(const struct net_device *dev)
 {
 	return is_vlan_dev(dev) &&
-- 
2.54.0

