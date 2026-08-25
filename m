Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED61A23A6
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632638; cv=none; b=IPWP21bdoB5iFwMEfas6JR04XEV3PVFbHe8aBnynpRTPw7XvErvTRDyCFtL6ybejlq2OLWHHyrqhInbkVLJIsiZIi0ntpGYYOAXuvJz6B4H8vtLdu5372AaNdP7m2A+K/DZCvRqO83anAgGvNAgQeyfySrBGOniCfNAbhshG9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632638; c=relaxed/simple;
	bh=k9I7BywSP/weUdmtQRp2jnF+4bq2ra4QJLeRToqHbj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlhujHiHNMbAsi8BzhlAdiA2DEhdKIrjfyMNm5ccd/AIctWgW51u63sqT8LrcEa7SSTiz7LQ2Sq8941JbOdCdX8uvDar+QRBmdMxGDNhdAmyn7O5QVmhe6rDegzyGlCRBn0hziJJCIJcqMUxXKqmRfqebo9Eiwn4F3K9zRivtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEn1Hgej; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEn1Hgej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787632635; x=1819168635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9I7BywSP/weUdmtQRp2jnF+4bq2ra4QJLeRToqHbj4=;
  b=dEn1HgejhXHOvmvhvaRLYD32kG4S+T87y5hcZuHHZ48mBRj+y6pMbAga
   wlqrog4e/3quDLekVgNWGLRR7XuXWDaIF9pFhUf7bc56CqE576YXfuxCh
   I+eFVtFuKs6AG9OamfzzedpVniEToqt0rs0FMlwiKp8mCk9H90w6GN3FX
   pklES8EfGSiBiDTcqHS45PIqWX9E4hT7QpnUyYO8LRhLolgbr58JzVZOO
   AtfZtxajGgfqkVh+huAss/jQBz+P7K3RuJNX5AQuomfs+PJmAb2FOq4sN
   2ojth1DKUx/e6JFEV4r1M2mMKL/jqCfsGr+7psXpzfV2TNQzgX/5g5dlX
   g==;
X-CSE-ConnectionGUID: h8Wu2vAXTluFYgQi6VEsAQ==
X-CSE-MsgGUID: HsdO1dwhSiGUgAp+tRHCIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="105622527"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="105622527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:15 -0700
X-CSE-ConnectionGUID: jz/C0aEmR5CZHh/b77Cfhg==
X-CSE-MsgGUID: PIWHK5TmQtebK2e7HaTXHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="262871923"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:15 -0700
From: Shubham Das <shubham.das@intel.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	alexander.duyck@gmail.com,
	lee@trager.us
Cc: siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com,
	dasshubhamk@gmail.com,
	magnus.k.lindberg@ericsson.com,
	jonas.wirandi@ericsson.com,
	Shubham Das <shubham.das@intel.com>
Subject: [RFC PATCH net-next 1/2] ethtool: add interface capabilities query (intf-caps-get)
Date: Mon, 24 Aug 2026 23:37:07 -0500
Message-Id: <20260825043708.1512634-2-shubham.das@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260825043708.1512634-1-shubham.das@intel.com>
References: <20260825043708.1512634-1-shubham.das@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern network interfaces contain multiple functional blocks along
the data path (MAC, PHY, MODULE), each at different 802.3 sublayers
(RS, PCS, FEC, PMA, PMD). Currently there is no standard way for
userspace to discover this topology or query which blocks support
loopback, pattern generation, or BERT.

Add ETHTOOL_MSG_INTF_CAPS_GET so drivers can expose the block layout
and per-block capabilities. This allows userspace to discover the
interface topology and testing capabilities dynamically, rather than
relying on device-specific knowledge.

Each block reports:
  - id: unique block identifier for per-block commands
  - component: MAC, PHY, or MODULE
  - sublayer: RS, PCS, FEC, PMA, PMD, or NONE
  - instance: distinguishes multiple instances of the same component
    (e.g., internal vs external PHY, host vs port MAC)
  - name: driver-chosen label (e.g., host-pma, ext-phy-pma)
  - depth: ordering within same (component, sublayer) tuple
  - lanes: number of SerDes lanes at this block
  - loopback_supported: bitmask of supported loopback directions
  - supported_tx_patterns: bitmask of patterns block can generate
  - supported_rx_patterns: bitmask of patterns block can check
  - error_inject_supported: block supports bit error injection
  - bert_supported: block supports BERT (Bit Error Ratio Test)

Signed-off-by: Shubham Das <shubham.das@intel.com>
---
 Documentation/netlink/specs/ethtool.yaml      |  99 +++++++++++++
 include/linux/ethtool.h                       |  49 +++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  48 +++++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/intf_caps.c                       | 130 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 ++
 net/ethtool/netlink.h                         |   2 +
 7 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/intf_caps.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..77d77a896fb0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -210,6 +210,25 @@ definitions:
       -
         name: discard
         value: 31
+  -
+    name: intf-component
+    type: enum
+    doc: Type of hardware component in the interface.
+    entries:
+      - mac
+      - phy
+      - module
+  -
+    name: intf-sublayer
+    type: enum
+    doc: 802.3 sublayer within a component.
+    entries:
+      - none
+      - rs
+      - pcs
+      - fec
+      - pma
+      - pmd
 
 attribute-sets:
   -
@@ -1905,6 +1924,73 @@ attribute-sets:
         name: link
         type: nest
         nested-attributes: mse-snapshot
+  -
+    name: intf-block
+    doc: A single functional block in the interface.
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: component
+        type: u32
+        enum: intf-component
+      -
+        name: sublayer
+        type: u32
+        enum: intf-sublayer
+      -
+        name: instance
+        type: u32
+        doc: |
+          Identifies the hardware entity when multiple instances of
+          the same component exist in the interface. The driver
+          assigns instance numbers sequentially based on position in
+          the physical path. Defaults to 0 when only one instance of
+          a given component exists.
+          For PHY: instance 0 is the internal/host-side PHY,
+          instance 1 is an external PHY further along the path
+          toward the line side.
+          For MAC: instance 0 is the host-facing MAC, instance 1 is
+          a secondary MAC further along the data path (e.g., behind
+          an embedded switch).
+      -
+        name: name
+        type: string
+      -
+        name: depth
+        type: u8
+      -
+        name: lanes
+        type: u32
+      -
+        name: loopback-supported
+        type: u32
+      -
+        name: supported-tx-patterns
+        type: u32
+      -
+        name: supported-rx-patterns
+        type: u32
+      -
+        name: error-inject-supported
+        type: flag
+      -
+        name: bert-supported
+        type: flag
+  -
+    name: intf-caps
+    doc: Interface capabilities message.
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: blocks
+        type: nest
+        nested-attributes: intf-block
+        multi-attr: true
 
 operations:
   enum-model: directional
@@ -2859,6 +2945,19 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: intf-caps-get
+      doc: Get interface capabilities (functional block layout).
+      attribute-set: intf-caps
+      do: &intf-caps-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - blocks
+      dump: *intf-caps-get-op
 
 mcast-groups:
   list:
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12683b5d125e..3465f9c2f0aa 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1197,6 +1197,53 @@ struct kernel_ethtool_ts_info {
  * See &struct net_device and &struct net_device_ops for documentation
  * of the generic netdev features interface.
  */
+
+#define INTF_CAPS_MAX_BLOCKS	16
+#define INTF_BLOCK_NAME_LEN	32
+
+#define LOOPBACK_SUPPORT_LOCAL	BIT(0)
+#define LOOPBACK_SUPPORT_REMOTE	BIT(1)
+
+/**
+ * struct ethtool_intf_block - Single functional block in the interface
+ * @id: Unique block identifier
+ * @component: Hardware component (MAC, PHY, MODULE)
+ * @sublayer: 802.3 sublayer (RS, PCS, FEC, PMA, PMD, or NONE)
+ * @instance: Index when multiple instances of same component exist
+ * @name: Driver-chosen label
+ * @depth: Ordering within same (component, sublayer) tuple
+ * @lanes: Number of lanes
+ * @loopback_supported: Bitmask of supported loopback directions
+ * @supported_tx_patterns: Bitmask of patterns this block can generate
+ * @supported_rx_patterns: Bitmask of patterns this block can check
+ * @error_inject_supported: Block supports bit error injection
+ * @bert_supported: Block supports BERT counters
+ */
+struct ethtool_intf_block {
+	u32 id;
+	enum intf_component component;
+	enum intf_sublayer sublayer;
+	u32 instance;
+	char name[INTF_BLOCK_NAME_LEN];
+	u8 depth;
+	u32 lanes;
+	u32 loopback_supported;
+	u32 supported_tx_patterns;
+	u32 supported_rx_patterns;
+	bool error_inject_supported;
+	bool bert_supported;
+};
+
+/**
+ * struct ethtool_intf_caps - Interface capabilities (all blocks)
+ * @num_blocks: Number of valid entries in blocks[]
+ * @blocks: Array of functional blocks
+ */
+struct ethtool_intf_caps {
+	u32 num_blocks;
+	struct ethtool_intf_block blocks[INTF_CAPS_MAX_BLOCKS];
+};
+
 struct ethtool_ops {
 	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
@@ -1354,6 +1401,8 @@ struct ethtool_ops {
 	int	(*set_mm)(struct net_device *dev, struct ethtool_mm_cfg *cfg,
 			  struct netlink_ext_ack *extack);
 	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
+	int	(*get_intf_caps)(struct net_device *dev,
+				 struct ethtool_intf_caps *caps);
 };
 
 int ethtool_check_ops(const struct ethtool_ops *ops);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..bd4cca1cc4fc 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -893,6 +893,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_INTF_CAPS_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +955,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
@@ -961,4 +963,50 @@ enum {
 
 #define ETHTOOL_MCGRP_MONITOR_NAME	"monitor"
 
+/* Interface component types */
+enum intf_component {
+	INTF_COMPONENT_MAC,
+	INTF_COMPONENT_PHY,
+	INTF_COMPONENT_MODULE,
+};
+
+/* Interface sublayer types */
+enum intf_sublayer {
+	INTF_SUBLAYER_NONE,
+	INTF_SUBLAYER_RS,
+	INTF_SUBLAYER_PCS,
+	INTF_SUBLAYER_FEC,
+	INTF_SUBLAYER_PMA,
+	INTF_SUBLAYER_PMD,
+};
+
+/* Attributes of a single interface block */
+enum {
+	ETHTOOL_A_INTF_BLOCK_ID,
+	ETHTOOL_A_INTF_BLOCK_COMPONENT,
+	ETHTOOL_A_INTF_BLOCK_SUBLAYER,
+	ETHTOOL_A_INTF_BLOCK_INSTANCE,
+	ETHTOOL_A_INTF_BLOCK_NAME,
+	ETHTOOL_A_INTF_BLOCK_DEPTH,
+	ETHTOOL_A_INTF_BLOCK_LANES,
+	ETHTOOL_A_INTF_BLOCK_LOOPBACK_SUPPORTED,
+	ETHTOOL_A_INTF_BLOCK_TX_PATTERNS,
+	ETHTOOL_A_INTF_BLOCK_RX_PATTERNS,
+	ETHTOOL_A_INTF_BLOCK_ERROR_INJECT,
+	ETHTOOL_A_INTF_BLOCK_BERT,
+
+	__ETHTOOL_A_INTF_BLOCK_CNT,
+	ETHTOOL_A_INTF_BLOCK_MAX = (__ETHTOOL_A_INTF_BLOCK_CNT - 1)
+};
+
+/* Attributes of intf-caps-get message */
+enum {
+	ETHTOOL_A_INTF_CAPS_UNSPEC,
+	ETHTOOL_A_INTF_CAPS_HEADER,
+	ETHTOOL_A_INTF_CAPS_BLOCKS,
+
+	__ETHTOOL_A_INTF_CAPS_CNT,
+	ETHTOOL_A_INTF_CAPS_MAX = (__ETHTOOL_A_INTF_CAPS_CNT - 1)
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 629c10916670..773b21c7ab7c 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o mse.o
+		   phy.o tsconfig.o mse.o intf_caps.o
diff --git a/net/ethtool/intf_caps.c b/net/ethtool/intf_caps.c
new file mode 100644
index 000000000000..e45ccc4b88c9
--- /dev/null
+++ b/net/ethtool/intf_caps.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "netlink.h"
+#include "common.h"
+
+struct intf_caps_req_info {
+	struct ethnl_req_info base;
+};
+
+struct intf_caps_reply_data {
+	struct ethnl_reply_data base;
+	struct ethtool_intf_caps caps;
+};
+
+#define INTF_CAPS_REPDATA(__reply_base) \
+	container_of(__reply_base, struct intf_caps_reply_data, base)
+
+const struct nla_policy ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1] = {
+	[ETHTOOL_A_INTF_CAPS_HEADER] =
+		NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+static int intf_caps_reply_size(const struct ethnl_req_info *req_base,
+				const struct ethnl_reply_data *reply_base)
+{
+	const struct intf_caps_reply_data *data = INTF_CAPS_REPDATA(reply_base);
+	int len = 0;
+	u32 i;
+
+	for (i = 0; i < data->caps.num_blocks; i++) {
+		len += nla_total_size(0);		/* nested block */
+		len += nla_total_size(sizeof(u32));	/* id */
+		len += nla_total_size(sizeof(u32));	/* component */
+		len += nla_total_size(sizeof(u32));	/* sublayer */
+		len += nla_total_size(sizeof(u32));	/* instance */
+		len += nla_total_size(INTF_BLOCK_NAME_LEN); /* name */
+		len += nla_total_size(sizeof(u8));	/* depth */
+		len += nla_total_size(sizeof(u32));	/* lanes */
+		len += nla_total_size(sizeof(u32));	/* loopback_supported */
+		len += nla_total_size(sizeof(u32));	/* tx_patterns */
+		len += nla_total_size(sizeof(u32));	/* rx_patterns */
+		len += nla_total_size(0);		/* error_inject (flag) */
+		len += nla_total_size(0);		/* bert (flag) */
+	}
+
+	/* outer BLOCKS nest */
+	len += nla_total_size(0);
+
+	return len;
+}
+
+static int intf_caps_prepare_data(const struct ethnl_req_info *req_base,
+				  struct ethnl_reply_data *reply_base,
+				  const struct genl_info *info)
+{
+	struct intf_caps_reply_data *data = INTF_CAPS_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+
+	if (!dev->ethtool_ops->get_intf_caps)
+		return -EOPNOTSUPP;
+
+	return dev->ethtool_ops->get_intf_caps(dev, &data->caps);
+}
+
+static int intf_caps_fill_reply(struct sk_buff *skb,
+				const struct ethnl_req_info *req_base,
+				const struct ethnl_reply_data *reply_base)
+{
+	const struct intf_caps_reply_data *data = INTF_CAPS_REPDATA(reply_base);
+	struct nlattr *blocks_attr;
+	u32 i;
+
+	blocks_attr = nla_nest_start(skb, ETHTOOL_A_INTF_CAPS_BLOCKS);
+	if (!blocks_attr)
+		return -EMSGSIZE;
+
+	for (i = 0; i < data->caps.num_blocks; i++) {
+		const struct ethtool_intf_block *b = &data->caps.blocks[i];
+		struct nlattr *block_attr;
+
+		block_attr = nla_nest_start(skb, 0);
+		if (!block_attr)
+			goto nla_put_failure;
+
+		if (nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_ID, b->id) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_COMPONENT,
+				b->component) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_SUBLAYER,
+				b->sublayer) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_INSTANCE,
+				b->instance) ||
+		    nla_put_string(skb, ETHTOOL_A_INTF_BLOCK_NAME, b->name) ||
+		    nla_put_u8(skb, ETHTOOL_A_INTF_BLOCK_DEPTH, b->depth) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_LANES, b->lanes) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_LOOPBACK_SUPPORTED,
+				b->loopback_supported) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_TX_PATTERNS,
+				b->supported_tx_patterns) ||
+		    nla_put_u32(skb, ETHTOOL_A_INTF_BLOCK_RX_PATTERNS,
+				b->supported_rx_patterns))
+			goto nla_put_failure;
+		if (b->error_inject_supported &&
+		    nla_put_flag(skb, ETHTOOL_A_INTF_BLOCK_ERROR_INJECT))
+			goto nla_put_failure;
+		if (b->bert_supported &&
+		    nla_put_flag(skb, ETHTOOL_A_INTF_BLOCK_BERT))
+			goto nla_put_failure;
+			goto nla_put_failure;
+
+		nla_nest_end(skb, block_attr);
+	}
+
+	nla_nest_end(skb, blocks_attr);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(skb, blocks_attr);
+	return -EMSGSIZE;
+}
+
+const struct ethnl_request_ops ethnl_intf_caps_request_ops = {
+	.request_cmd	= ETHTOOL_MSG_INTF_CAPS_GET,
+	.reply_cmd	= ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
+	.hdr_attr	= ETHTOOL_A_INTF_CAPS_HEADER,
+	.req_info_size	= sizeof(struct intf_caps_req_info),
+	.reply_data_size = sizeof(struct intf_caps_reply_data),
+	.prepare_data	= intf_caps_prepare_data,
+	.reply_size	= intf_caps_reply_size,
+	.fill_reply	= intf_caps_fill_reply,
+};
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1af395b54330..e90dae573452 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -431,6 +431,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_TSCONFIG_SET]	= &ethnl_tsconfig_request_ops,
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
+	[ETHTOOL_MSG_INTF_CAPS_GET]	= &ethnl_intf_caps_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1572,6 +1573,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_INTF_CAPS_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_intf_caps_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_intf_caps_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 3e969a070f9f..32b16f81f453 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -474,6 +474,7 @@ extern const struct ethnl_request_ops ethnl_mm_request_ops;
 extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
+extern const struct ethnl_request_ops ethnl_intf_caps_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -530,6 +531,7 @@ extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEADER + 1];
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
+extern const struct nla_policy ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
-- 
2.25.1

