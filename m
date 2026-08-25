Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31230D411
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632643; cv=none; b=QOBY49nmL3Wxzcb42YL+EeYREnd9eq819kgc/DW3c4+r4oRImCKbqTyw+4HCCocCF5aXcrc+nsMba6mneyGhsTkiauFxf2sgp8NUpwioWprSkpYr11t2t3vJ1+esmZYWQZz8NJdytUCvp+gjq0f7vI/Y/NmteXRGdeQdIPt2bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632643; c=relaxed/simple;
	bh=iaAE/Uche0PY0TljDFZb3ZUZ3wftmWwRuJpy/bs+0rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psVVKPk/bHLFikbB1geX+s9iG9FDhW/7KDMOviF55libQ8vwFK5Nnn0VhESJajjefMgUKorrdBMt2Cej8nu8qSoIP5frUyE/8DcTLYUOCGuNMs/tNjFyOG4gr2KS8q3EA02ZQMbLysZ22W1FgcAWxP1KrFhLlI54+qSC6jOjntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkkDGcyo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkkDGcyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787632640; x=1819168640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iaAE/Uche0PY0TljDFZb3ZUZ3wftmWwRuJpy/bs+0rk=;
  b=BkkDGcyoxMdMDkh7AYMZtITn0pfK1sc+p/7/Ukw6vz8J7MccGEGLxKUj
   oeF5vPZ0I4+/StFMMwSpvRe1678ZMktSRy3no/KjCywKLfkLTx+Lawv4q
   dC0CZV3OmE73a7K76DYMP3M5+wjwKoEKIMBJvZ1sMJKlVsRax4XSOEiwA
   7aSuAuuA7g1jnodTjCI8j0qbDKZm5FAZTYxoPhtt/cHTVwPi8h9wviLT5
   oUXnDftoCmvIe5DBMGSnQuCGLQBzAyblPZIdDi1LeD++9ECgdfMnJm3kS
   AslYjWDxRgJgCoMjdI2zXdeZNm10XTRmuFB+FEII0XR3EyLhoyYQPuBdM
   g==;
X-CSE-ConnectionGUID: F1MS6e1AQ9GyjI8WOUNzAw==
X-CSE-MsgGUID: 12s/TLtgT4ernjTGFmdo6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99440888"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99440888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:20 -0700
X-CSE-ConnectionGUID: U0p+TjM7TfmHY8zZ2SYeiA==
X-CSE-MsgGUID: 1eClylFZRqSR2/pD7UG/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="272400147"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 21:37:19 -0700
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
Subject: [RFC PATCH net-next 2/2] ethtool: add PHY test framework (phy-test-get, phy-test-act)
Date: Mon, 24 Aug 2026 23:37:08 -0500
Message-Id: <20260825043708.1512634-3-shubham.das@intel.com>
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

Add ETHTOOL_MSG_PHY_TEST_GET and ETHTOOL_MSG_PHY_TEST_ACT to
configure and monitor PHY test functions on individual interface
blocks and lanes.

The framework uses the block identifier returned by
ETHTOOL_MSG_INTF_CAPS_GET to select the hardware block under test.
This allows userspace to target test operations at specific PHY, MAC,
or module datapath components exposed by the driver.

Supported test patterns:
  - PRBS: prbs7, prbs9, prbs11, prbs13, prbs15, prbs23, prbs31
  - PRBS quaternary (PAM4): prbs13q, prbs31q
  - SSPRQ (Short Stress Pattern Random Quaternary)
  - Square wave: square-nrz, square-pam4 (JP03A)
  - TX linearity (LIN, IEEE 802.3 94.2.9.4)
  - Scrambled idle
  - 8b/10b comma: K28.5, K28.7

Supported test actions:
  - bert start / stop: bit error ratio measurement
  - inject-errors N: inject bit errors into the TX stream
  - active-tests: bitmask showing which tests are running

Usage flow:
  1. ethtool --get-intf-caps eth1     # discover testable blocks
  2. ethtool --phy-test eth1 block 3 lane 0 tx-pattern prbs31
  3. ethtool --phy-test eth2 block 3 lane 0 rx-pattern prbs31
  4. ethtool --phy-test eth2 block 3 lane 0 bert start
  5. ethtool --show-phy-test eth2 block 3  # read BERT counters
  6. ethtool --phy-test eth2 block 3 lane 0 inject-errors 5  # verify checker
  7. ethtool --show-phy-test eth2 block 3  # confirm error count increased
  8. ethtool --phy-test eth2 block 3 lane 0 bert stop

Signed-off-by: Shubham Das <shubham.das@intel.com>
---
 Documentation/netlink/specs/ethtool.yaml      | 107 +++++++++++
 include/linux/ethtool.h                       |  43 +++++
 .../uapi/linux/ethtool_netlink_generated.h    |  56 ++++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/netlink.c                         |  14 ++
 net/ethtool/netlink.h                         |   5 +
 net/ethtool/phytest.c                         | 171 ++++++++++++++++++
 7 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/phytest.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 77d77a896fb0..361eb3c66577 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -229,6 +229,36 @@ definitions:
       - fec
       - pma
       - pmd
+  -
+    name: phy-test-pattern
+    type: enum
+    doc: PHY test pattern types for PRBS generation/checking.
+    entries:
+      - off
+      - prbs7
+      - prbs9
+      - prbs11
+      - prbs13
+      - prbs15
+      - prbs23
+      - prbs31
+      - ssprq
+      - prbs13q
+      - prbs31q
+      - square-nrz
+      - square-pam4
+      - tx-linearity
+      - scrambled-idle
+      - k28-5
+      - k28-7
+  -
+    name: phy-test-action
+    type: enum
+    doc: BERT control actions.
+    entries:
+      - none
+      - start
+      - stop
 
 attribute-sets:
   -
@@ -1991,6 +2021,48 @@ attribute-sets:
         type: nest
         nested-attributes: intf-block
         multi-attr: true
+  -
+    name: phy-test
+    doc: PHY test configuration and status.
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: block-id
+        type: u32
+      -
+        name: lane
+        type: u32
+      -
+        name: tx-pattern
+        type: u32
+        enum: phy-test-pattern
+      -
+        name: rx-pattern
+        type: u32
+        enum: phy-test-pattern
+      -
+        name: bert-action
+        type: u32
+        enum: phy-test-action
+      -
+        name: inject-error-count
+        type: u32
+      -
+        name: active-tests
+        type: u32
+        doc: Bitmask of currently running tests (bit 0 = BERT).
+      -
+        name: checker-lock
+        type: u8
+      -
+        name: error-count
+        type: u64
+      -
+        name: total-bits-sent
+        type: u64
 
 operations:
   enum-model: directional
@@ -2958,6 +3030,41 @@ operations:
             - header
             - blocks
       dump: *intf-caps-get-op
+    -
+      name: phy-test-get
+      doc: Get PHY test status (patterns, BERT counters).
+      attribute-set: phy-test
+      do:
+        request:
+          attributes:
+            - header
+            - block-id
+            - lane
+        reply:
+          attributes:
+            - header
+            - block-id
+            - lane
+            - tx-pattern
+            - rx-pattern
+            - active-tests
+            - checker-lock
+            - error-count
+            - total-bits-sent
+    -
+      name: phy-test-act
+      doc: Configure PHY test (set patterns, start/stop BERT, inject errors).
+      attribute-set: phy-test
+      do:
+        request:
+          attributes:
+            - header
+            - block-id
+            - lane
+            - tx-pattern
+            - rx-pattern
+            - bert-action
+            - inject-error-count
 
 mcast-groups:
   list:
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 3465f9c2f0aa..f9748e739f03 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1244,6 +1244,45 @@ struct ethtool_intf_caps {
 	struct ethtool_intf_block blocks[INTF_CAPS_MAX_BLOCKS];
 };
 
+/* Bitmask of which ethtool_phy_test fields were explicitly specified */
+#define PHY_TEST_CMD_TX_PATTERN		BIT(0)
+#define PHY_TEST_CMD_RX_PATTERN		BIT(1)
+#define PHY_TEST_CMD_BERT_ACTION		BIT(2)
+#define PHY_TEST_CMD_INJECT_COUNT		BIT(3)
+#define PHY_TEST_CMD_LANE			BIT(4)
+#define PHY_TEST_CMD_BLOCK_ID			BIT(5)
+
+/* Bitmask of currently active tests (read-only) */
+#define PHY_TEST_ACTIVE_BERT		BIT(0)
+
+/**
+ * struct ethtool_phy_test - PHY test configuration and status
+ * @cmd: Bitmask of which fields are valid (PHY_TEST_CMD_*)
+ * @block_id: Block to operate on (from intf-caps-get)
+ * @lane: Lane number (0-based)
+ * @tx_pattern: TX pattern generator setting
+ * @rx_pattern: RX pattern checker setting
+ * @bert_action: BERT start/stop control
+ * @inject_error_count: Number of errors to inject
+ * @active_tests: Bitmask of running tests (PHY_TEST_ACTIVE_*)
+ * @checker_lock: RX checker lock status (read-only)
+ * @error_count: BERT error counter (read-only)
+ * @total_bits_sent: BERT total bits counter (read-only)
+ */
+struct ethtool_phy_test {
+	u32 cmd;
+	u32 block_id;
+	u32 lane;
+	enum phy_test_pattern tx_pattern;
+	enum phy_test_pattern rx_pattern;
+	enum phy_test_action bert_action;
+	u32 inject_error_count;
+	u32 active_tests;
+	u8 checker_lock;
+	u64 error_count;
+	u64 total_bits_sent;
+};
+
 struct ethtool_ops {
 	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
@@ -1403,6 +1442,10 @@ struct ethtool_ops {
 	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
 	int	(*get_intf_caps)(struct net_device *dev,
 				 struct ethtool_intf_caps *caps);
+	int	(*get_phy_test)(struct net_device *dev,
+				struct ethtool_phy_test *test);
+	int	(*set_phy_test)(struct net_device *dev,
+				struct ethtool_phy_test *test);
 };
 
 int ethtool_check_ops(const struct ethtool_ops *ops);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index bd4cca1cc4fc..3102bb7ba337 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -894,6 +894,8 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
 	ETHTOOL_MSG_INTF_CAPS_GET,
+	ETHTOOL_MSG_PHY_TEST_GET,
+	ETHTOOL_MSG_PHY_TEST_ACT,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -956,6 +958,7 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
 	ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
+	ETHTOOL_MSG_PHY_TEST_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
@@ -1009,4 +1012,57 @@ enum {
 	ETHTOOL_A_INTF_CAPS_MAX = (__ETHTOOL_A_INTF_CAPS_CNT - 1)
 };
 
+/* PHY test pattern types */
+enum phy_test_pattern {
+	PHY_TEST_PATTERN_OFF,
+	PHY_TEST_PATTERN_PRBS7,
+	PHY_TEST_PATTERN_PRBS9,
+	PHY_TEST_PATTERN_PRBS11,
+	PHY_TEST_PATTERN_PRBS13,
+	PHY_TEST_PATTERN_PRBS15,
+	PHY_TEST_PATTERN_PRBS23,
+	PHY_TEST_PATTERN_PRBS31,
+	PHY_TEST_PATTERN_SSPRQ,
+	PHY_TEST_PATTERN_PRBS13Q,
+	PHY_TEST_PATTERN_PRBS31Q,
+	PHY_TEST_PATTERN_SQUARE_NRZ,
+	PHY_TEST_PATTERN_SQUARE_PAM4,
+	PHY_TEST_PATTERN_TX_LINEARITY,
+	PHY_TEST_PATTERN_SCRAMBLED_IDLE,
+	PHY_TEST_PATTERN_K28_5,
+	PHY_TEST_PATTERN_K28_7,
+
+	__PHY_TEST_PATTERN_COUNT,
+	PHY_TEST_PATTERN_MAX = (__PHY_TEST_PATTERN_COUNT - 1)
+};
+
+/* PHY test BERT actions */
+enum phy_test_action {
+	PHY_TEST_ACTION_NONE,
+	PHY_TEST_ACTION_START,
+	PHY_TEST_ACTION_STOP,
+
+	__PHY_TEST_ACTION_COUNT,
+	PHY_TEST_ACTION_MAX = (__PHY_TEST_ACTION_COUNT - 1)
+};
+
+/* Attributes of phy-test-get / phy-test-act messages */
+enum {
+	ETHTOOL_A_PHY_TEST_UNSPEC,
+	ETHTOOL_A_PHY_TEST_HEADER,
+	ETHTOOL_A_PHY_TEST_BLOCK_ID,
+	ETHTOOL_A_PHY_TEST_LANE,
+	ETHTOOL_A_PHY_TEST_TX_PATTERN,
+	ETHTOOL_A_PHY_TEST_RX_PATTERN,
+	ETHTOOL_A_PHY_TEST_BERT_ACTION,
+	ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT,
+	ETHTOOL_A_PHY_TEST_ACTIVE_TESTS,
+	ETHTOOL_A_PHY_TEST_CHECKER_LOCK,
+	ETHTOOL_A_PHY_TEST_ERROR_COUNT,
+	ETHTOOL_A_PHY_TEST_TOTAL_BITS_SENT,
+
+	__ETHTOOL_A_PHY_TEST_CNT,
+	ETHTOOL_A_PHY_TEST_MAX = (__ETHTOOL_A_PHY_TEST_CNT - 1)
+};
+
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 773b21c7ab7c..7dd2c5624ced 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -9,4 +9,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
 		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
-		   phy.o tsconfig.o mse.o intf_caps.o
+		   phy.o tsconfig.o mse.o intf_caps.o phytest.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e90dae573452..56e5c811454b 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -432,6 +432,7 @@ ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_PHY_GET]		= &ethnl_phy_request_ops,
 	[ETHTOOL_MSG_MSE_GET]		= &ethnl_mse_request_ops,
 	[ETHTOOL_MSG_INTF_CAPS_GET]	= &ethnl_intf_caps_request_ops,
+	[ETHTOOL_MSG_PHY_TEST_GET]	= &ethnl_phy_test_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -1582,6 +1583,19 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_intf_caps_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_intf_caps_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_TEST_GET,
+		.doit	= ethnl_default_doit,
+		.policy = ethnl_phy_test_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_test_get_policy) - 1,
+	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_TEST_ACT,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_act_phy_test,
+		.policy = ethnl_phy_test_act_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_test_act_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 32b16f81f453..1caba60d83c4 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -475,6 +475,7 @@ extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
 extern const struct ethnl_request_ops ethnl_intf_caps_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_test_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -532,6 +533,10 @@ extern const struct nla_policy ethnl_tsconfig_get_policy[ETHTOOL_A_TSCONFIG_HEAD
 extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1];
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
 extern const struct nla_policy ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1];
+extern const struct nla_policy ethnl_phy_test_get_policy[ETHTOOL_A_PHY_TEST_LANE + 1];
+extern const struct nla_policy ethnl_phy_test_act_policy[ETHTOOL_A_PHY_TEST_MAX + 1];
+
+int ethnl_act_phy_test(struct sk_buff *skb, struct genl_info *info);
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/phytest.c b/net/ethtool/phytest.c
new file mode 100644
index 000000000000..dedcd036b7c2
--- /dev/null
+++ b/net/ethtool/phytest.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "netlink.h"
+#include "common.h"
+
+struct phy_test_req_info {
+	struct ethnl_req_info base;
+};
+
+struct phy_test_reply_data {
+	struct ethnl_reply_data base;
+	struct ethtool_phy_test test;
+};
+
+#define PHY_TEST_REPDATA(__reply_base) \
+	container_of(__reply_base, struct phy_test_reply_data, base)
+
+/* PHY_TEST_GET */
+
+const struct nla_policy ethnl_phy_test_get_policy[ETHTOOL_A_PHY_TEST_LANE + 1] = {
+	[ETHTOOL_A_PHY_TEST_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PHY_TEST_BLOCK_ID]	= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_LANE]	= { .type = NLA_U32 },
+};
+
+static int phy_test_reply_size(const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	return nla_total_size(sizeof(u32)) +	/* block_id */
+	       nla_total_size(sizeof(u32)) +	/* lane */
+	       nla_total_size(sizeof(u32)) +	/* tx_pattern */
+	       nla_total_size(sizeof(u32)) +	/* rx_pattern */
+	       nla_total_size(sizeof(u32)) +	/* active_tests */
+	       nla_total_size(sizeof(u8))  +	/* checker_lock */
+	       nla_total_size(sizeof(u64)) +	/* error_count */
+	       nla_total_size(sizeof(u64));	/* total_bits_sent */
+}
+
+static int phy_test_prepare_data(const struct ethnl_req_info *req_base,
+				 struct ethnl_reply_data *reply_base,
+				 const struct genl_info *info)
+{
+	struct phy_test_reply_data *data = PHY_TEST_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+
+	if (!dev->ethtool_ops->get_phy_test)
+		return -EOPNOTSUPP;
+
+	memset(&data->test, 0, sizeof(data->test));
+
+	if (tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]) {
+		data->test.block_id = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]);
+		data->test.cmd |= PHY_TEST_CMD_BLOCK_ID;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_LANE]) {
+		data->test.lane = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_LANE]);
+		data->test.cmd |= PHY_TEST_CMD_LANE;
+	}
+
+	return dev->ethtool_ops->get_phy_test(dev, &data->test);
+}
+
+static int phy_test_fill_reply(struct sk_buff *skb,
+			       const struct ethnl_req_info *req_base,
+			       const struct ethnl_reply_data *reply_base)
+{
+	const struct phy_test_reply_data *data = PHY_TEST_REPDATA(reply_base);
+	const struct ethtool_phy_test *t = &data->test;
+
+	if (nla_put_u32(skb, ETHTOOL_A_PHY_TEST_BLOCK_ID, t->block_id) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_TEST_LANE, t->lane) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_TEST_TX_PATTERN, t->tx_pattern) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_TEST_RX_PATTERN, t->rx_pattern) ||
+	    nla_put_u32(skb, ETHTOOL_A_PHY_TEST_ACTIVE_TESTS,
+			t->active_tests) ||
+	    nla_put_u8(skb, ETHTOOL_A_PHY_TEST_CHECKER_LOCK, t->checker_lock) ||
+	    nla_put_u64_64bit(skb, ETHTOOL_A_PHY_TEST_ERROR_COUNT,
+			      t->error_count, ETHTOOL_A_PHY_TEST_UNSPEC) ||
+	    nla_put_u64_64bit(skb, ETHTOOL_A_PHY_TEST_TOTAL_BITS_SENT,
+			      t->total_bits_sent, ETHTOOL_A_PHY_TEST_UNSPEC))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+const struct ethnl_request_ops ethnl_phy_test_request_ops = {
+	.request_cmd	= ETHTOOL_MSG_PHY_TEST_GET,
+	.reply_cmd	= ETHTOOL_MSG_PHY_TEST_GET_REPLY,
+	.hdr_attr	= ETHTOOL_A_PHY_TEST_HEADER,
+	.req_info_size	= sizeof(struct phy_test_req_info),
+	.reply_data_size = sizeof(struct phy_test_reply_data),
+	.prepare_data	= phy_test_prepare_data,
+	.reply_size	= phy_test_reply_size,
+	.fill_reply	= phy_test_fill_reply,
+};
+
+/* PHY_TEST_ACT */
+
+const struct nla_policy ethnl_phy_test_act_policy[ETHTOOL_A_PHY_TEST_MAX + 1] = {
+	[ETHTOOL_A_PHY_TEST_HEADER]		= NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PHY_TEST_BLOCK_ID]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_LANE]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_TX_PATTERN]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_RX_PATTERN]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_BERT_ACTION]	= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT]	= { .type = NLA_U32 },
+};
+
+int ethnl_act_phy_test(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethnl_req_info req_info = {};
+	struct nlattr **tb = info->attrs;
+	struct ethtool_phy_test test = {};
+	struct net_device *dev;
+	int ret;
+
+	ret = ethnl_parse_header_dev_get(&req_info,
+					 tb[ETHTOOL_A_PHY_TEST_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		return ret;
+
+	dev = req_info.dev;
+
+	if (!dev->ethtool_ops->set_phy_test) {
+		ret = -EOPNOTSUPP;
+		goto out_dev;
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]) {
+		test.block_id = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]);
+		test.cmd |= PHY_TEST_CMD_BLOCK_ID;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_LANE]) {
+		test.lane = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_LANE]);
+		test.cmd |= PHY_TEST_CMD_LANE;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_TX_PATTERN]) {
+		test.tx_pattern = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_TX_PATTERN]);
+		test.cmd |= PHY_TEST_CMD_TX_PATTERN;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_RX_PATTERN]) {
+		test.rx_pattern = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_RX_PATTERN]);
+		test.cmd |= PHY_TEST_CMD_RX_PATTERN;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_BERT_ACTION]) {
+		test.bert_action = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_BERT_ACTION]);
+		test.cmd |= PHY_TEST_CMD_BERT_ACTION;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT]) {
+		test.inject_error_count =
+			nla_get_u32(tb[ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT]);
+		test.cmd |= PHY_TEST_CMD_INJECT_COUNT;
+	}
+
+	rtnl_lock();
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto out_rtnl;
+
+	ret = dev->ethtool_ops->set_phy_test(dev, &test);
+	ethnl_ops_complete(dev);
+
+out_rtnl:
+	rtnl_unlock();
+out_dev:
+	ethnl_parse_header_dev_put(&req_info);
+	return ret;
+}
-- 
2.25.1

