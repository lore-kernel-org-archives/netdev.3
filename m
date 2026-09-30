Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D054F85D0
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774554; cv=none; b=u7gbFEPVaSl6kgXs4tA7wpIuAYjJzoWrU/h86eGMF2tEJeD0h1ytZepmGjT6onlynbJDXZcLjZwJPikemAuEDgm3RhpAYqrXWZg3tHVJqYmD/k39H0eOrCbLnw3McD44u3q0oe5SnEo8A/0efxt18O5PoFGYVoTokMeUzwvMr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774554; c=relaxed/simple;
	bh=kuLVLXbdm5WI2s+67EuSl6dBZ+b6Khu7gZbaJ47Uyfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHnEAYjPQmPmCXbiOl3hg67mmIngTbhvcbW4Yh2xo+Ay50ho+EGnJnU93cl6w04PnaeZvMxZPHilBY1I2Txsfnm/lWfEz5YczNlT3CYaw4/jmaGT+HJBhqxxiJ/a2knfPoFKbB/ITPtsPfB18dWlutSK9HEwm9U06JtWq/X50M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgbJYYr+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgbJYYr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774545; x=1822310545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kuLVLXbdm5WI2s+67EuSl6dBZ+b6Khu7gZbaJ47Uyfw=;
  b=QgbJYYr+vSV6ridHmi2u8XXBHEw/Q5DrKG1MUSGvkSVpwiSIZTj/BqKp
   cZQCxDmZN5kaWQOgT7kNnOk+JCfeqOwL4vu5PlTJrjBWkhxyGuNEKrKGc
   By5JeE7rwKv/6YFkqQSnVTjfwtzRM3XZcTsC6n6JS3I5U5czRJDECC72U
   mpAeWAQIW8jVy/KPL2W9CEvhs7iWzKKizvGFtFuTqjoLVsklKZVq/wsXt
   8iJCrhbncHVQBCCMg3XPALo8g0HlB8JZU14hlsf4WJPYyubgCEDWLa945
   6656ApOHNmV+pqyVaGS1AVxBPoP2Tu+Naum27USqY0iU5xn9VwSIFqsS4
   A==;
X-CSE-ConnectionGUID: ljX4IakwRCWcT+XQGpnBMA==
X-CSE-MsgGUID: 7F+3agnsTuOSmZ6h+4j4/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91375481"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="91375481"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:21 -0700
X-CSE-ConnectionGUID: BHKJR9x4RXemNqqHHXvlsQ==
X-CSE-MsgGUID: yyQ8maaVQRGE/lnvG71XyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275730850"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:20 -0700
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
Subject: [RFC net-next 2/2] ethtool: add PHY test framework
Date: Wed, 30 Sep 2026 08:21:48 -0500
Message-Id: <20260930132151.932792-3-shubham.das@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930132151.932792-1-shubham.das@intel.com>
References: <20260930132151.932792-1-shubham.das@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ETHTOOL_MSG_PHY_TEST_GET and ETHTOOL_MSG_PHY_TEST_SET to
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
  6. ethtool --phy-test eth2 block 3 lane 0 inject-errors 5
     # verify checker
  7. ethtool --show-phy-test eth2 block 3  # confirm error count increased
  8. ethtool --phy-test eth2 block 3 lane 0 bert stop

Signed-off-by: Shubham Das <shubham.das@intel.com>
---
 Documentation/netlink/specs/ethtool.yaml      | 112 +++++++++++
 include/linux/ethtool.h                       |  45 +++++
 include/linux/phy.h                           |   8 +
 include/linux/phylink.h                       |   4 +
 .../uapi/linux/ethtool_netlink_generated.h    |  58 ++++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/netlink.c                         |  14 ++
 net/ethtool/netlink.h                         |   7 +
 net/ethtool/phytest.c                         | 183 ++++++++++++++++++
 9 files changed, 432 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/phytest.c

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 77d77a896fb0..6b6949ca27b2 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -229,6 +229,37 @@ definitions:
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
+      - clear
 
 attribute-sets:
   -
@@ -1991,6 +2022,51 @@ attribute-sets:
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
+      -
+        name: supported-test-patterns
+        type: u32
 
 operations:
   enum-model: directional
@@ -2958,6 +3034,42 @@ operations:
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
+            - supported-test-patterns
+            - active-tests
+            - checker-lock
+            - error-count
+            - total-bits-sent
+    -
+      name: phy-test-set
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
index 61730c4500dc..53eaf5526d1a 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1244,6 +1244,47 @@ struct ethtool_intf_caps {
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
+ * @supported_test_patterns: Bitmask of supported patterns (GET only)
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
+	u32 supported_test_patterns;
+	u32 active_tests;
+	u8 checker_lock;
+	u64 error_count;
+	u64 total_bits_sent;
+};
+
 struct ethtool_ops {
 	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
@@ -1403,6 +1444,10 @@ struct ethtool_ops {
 	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
 	int	(*get_intf_caps)(struct net_device *dev,
 				 struct ethtool_intf_caps *caps);
+	int	(*get_phy_test)(struct net_device *dev,
+				struct ethtool_phy_test *test);
+	int	(*set_phy_test)(struct net_device *dev,
+				struct ethtool_phy_test *test);
 };
 
 int ethtool_check_ops(const struct ethtool_ops *ops);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f3c5bc976b4a..032f3a57a90b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1399,6 +1399,14 @@ struct phy_driver {
 			     struct ethtool_intf_block *blocks,
 			     u32 max_blocks);
 
+	/** @set_phy_test: Configure PRBS/BERT on this PHY. */
+	int (*set_phy_test)(struct phy_device *dev,
+			    struct ethtool_phy_test *test);
+
+	/** @get_phy_test: Get PRBS/BERT status from this PHY. */
+	int (*get_phy_test)(struct phy_device *dev,
+			    struct ethtool_phy_test *test);
+
 	/** @get_sqi: Get the signal quality indication */
 	int (*get_sqi)(struct phy_device *dev);
 	/** @get_sqi_max: Get the maximum signal quality indication */
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 86a91a4436fe..0df8cbf09c56 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -768,6 +768,10 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
 int phylink_ethtool_get_intf_caps(struct phylink *pl,
 				  struct ethtool_intf_block *blocks,
 				  u32 max_blocks);
+int phylink_ethtool_get_phy_test(struct phylink *pl,
+				 struct ethtool_phy_test *test);
+int phylink_ethtool_set_phy_test(struct phylink *pl,
+				 struct ethtool_phy_test *test);
 int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
 int phylink_speed_down(struct phylink *pl, bool sync);
 int phylink_speed_up(struct phylink *pl);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index bd4cca1cc4fc..e9dff073d577 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -894,6 +894,8 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
 	ETHTOOL_MSG_INTF_CAPS_GET,
+	ETHTOOL_MSG_PHY_TEST_GET,
+	ETHTOOL_MSG_PHY_TEST_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -956,6 +958,7 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
 	ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
+	ETHTOOL_MSG_PHY_TEST_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
@@ -1009,4 +1012,59 @@ enum {
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
+	PHY_TEST_ACTION_CLEAR,
+
+	__PHY_TEST_ACTION_COUNT,
+	PHY_TEST_ACTION_MAX = (__PHY_TEST_ACTION_COUNT - 1)
+};
+
+/* Attributes of phy-test-get / phy-test-set messages */
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
+	ETHTOOL_A_PHY_TEST_SUPPORTED_TEST_PATTERNS,
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
index bf0040a519fa..c15c1488e267 100644
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
 		.maxattr = ETHTOOL_A_INTF_CAPS_HEADER,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_TEST_GET,
+		.doit	= ethnl_default_doit,
+		.policy = ethnl_phy_test_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_test_get_policy) - 1,
+	},
+	{
+		.cmd	= ETHTOOL_MSG_PHY_TEST_SET,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_set_phy_test,
+		.policy = ethnl_phy_test_set_policy,
+		.maxattr = ARRAY_SIZE(ethnl_phy_test_set_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 73fd23dbc1e3..99055ee080a1 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -475,6 +475,7 @@ extern const struct ethnl_request_ops ethnl_phy_request_ops;
 extern const struct ethnl_request_ops ethnl_tsconfig_request_ops;
 extern const struct ethnl_request_ops ethnl_mse_request_ops;
 extern const struct ethnl_request_ops ethnl_intf_caps_request_ops;
+extern const struct ethnl_request_ops ethnl_phy_test_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -533,6 +534,12 @@ extern const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX
 extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
 extern const struct nla_policy
 ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1];
+extern const struct nla_policy
+ethnl_phy_test_get_policy[ETHTOOL_A_PHY_TEST_LANE + 1];
+extern const struct nla_policy
+ethnl_phy_test_set_policy[ETHTOOL_A_PHY_TEST_MAX + 1];
+
+int ethnl_set_phy_test(struct sk_buff *skb, struct genl_info *info);
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/phytest.c b/net/ethtool/phytest.c
new file mode 100644
index 000000000000..9c9e83d38164
--- /dev/null
+++ b/net/ethtool/phytest.c
@@ -0,0 +1,183 @@
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
+const struct nla_policy
+ethnl_phy_test_get_policy[ETHTOOL_A_PHY_TEST_LANE + 1] = {
+	[ETHTOOL_A_PHY_TEST_HEADER]	=
+		NLA_POLICY_NESTED(ethnl_header_policy),
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
+	       nla_total_size(sizeof(u32)) +	/* supported_test_patterns */
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
+		struct nlattr *attr = tb[ETHTOOL_A_PHY_TEST_BLOCK_ID];
+
+		data->test.block_id = nla_get_u32(attr);
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_LANE])
+		data->test.lane = nla_get_u32(tb[ETHTOOL_A_PHY_TEST_LANE]);
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
+	    nla_put_u32(skb, ETHTOOL_A_PHY_TEST_SUPPORTED_TEST_PATTERNS,
+			t->supported_test_patterns) ||
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
+/* PHY_TEST_SET */
+
+const struct nla_policy
+ethnl_phy_test_set_policy[ETHTOOL_A_PHY_TEST_MAX + 1] = {
+	[ETHTOOL_A_PHY_TEST_HEADER]		=
+			NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_PHY_TEST_BLOCK_ID]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_LANE]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_TX_PATTERN]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_RX_PATTERN]		= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_BERT_ACTION]	= { .type = NLA_U32 },
+	[ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT]	= { .type = NLA_U32 },
+};
+
+int ethnl_set_phy_test(struct sk_buff *skb, struct genl_info *info)
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
+		struct nlattr *attr = tb[ETHTOOL_A_PHY_TEST_TX_PATTERN];
+
+		test.tx_pattern = nla_get_u32(attr);
+		test.cmd |= PHY_TEST_CMD_TX_PATTERN;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_RX_PATTERN]) {
+		struct nlattr *attr = tb[ETHTOOL_A_PHY_TEST_RX_PATTERN];
+
+		test.rx_pattern = nla_get_u32(attr);
+		test.cmd |= PHY_TEST_CMD_RX_PATTERN;
+	}
+	if (tb[ETHTOOL_A_PHY_TEST_BERT_ACTION]) {
+		struct nlattr *attr = tb[ETHTOOL_A_PHY_TEST_BERT_ACTION];
+
+		test.bert_action = nla_get_u32(attr);
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

