Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC404BB27E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774572; cv=none; b=mtgPdyByIT5UuKgeP15shA0A8j/ZQfwt0IkecjEwC0brXJn2i0g0tDXgef6a+KO5VBuYvTmFZIXiiONEW0jSx/PKt++INn1mitxrSEhNJ+pU0m1kS0YlkAAXqA5zCV9p2Mm0lofdW/JxHXjmS6Y8OllC3HT+g4coigDWRB1xARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774572; c=relaxed/simple;
	bh=Q4XgcLKyHCjWxaVlmKi5c70sHz9uJddyJFz0xvEBh+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oD1b7nclwtnC7T+uw8n3ByxpO7HNvMJJswG/Tyq/s3CSk7uSslX+C+hM5lfm8BjmiOu3QxNEJGsgbQJuWb76cjl2yZdfECiFh/22H9lZ2QG76pZJpsjYxbe6/zWWoKzJdTM1UVtdCc4G31yds0yFpx40bK2lXRYhHccSJtAYtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAqd9ZmC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAqd9ZmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774563; x=1822310563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4XgcLKyHCjWxaVlmKi5c70sHz9uJddyJFz0xvEBh+k=;
  b=YAqd9ZmC4Ij4IZLtAhvTRrRMg0RZ0+C7tRut/w+Uh1O91cxzDv44LIOk
   5Zpd8530R4kwI4kbWK3FwLFdc4SOPVZp1NYFWy6E2BziEiQe1KZspNf0g
   I0OPqiKmm4uLpo12cnA5Lp4S9PSzV7xDrulC9SV5Ya6QVrSvaphoM002t
   v7pZEB8UDeY0MrJN3kwdo3qh1E6wehv3fiW8ZT/hkAWghevUO1UocLuHv
   HvZyKmtihv3v0AMOdelVjXCwg8CKyiutaMvs+gSpFnTL9/EXWxEf2pUqB
   CkS3dHXKHHSIAYyK8TGbv3c5ThPmm6o6eYdSWxtjJX1MpLgzvGjJKzk8Q
   Q==;
X-CSE-ConnectionGUID: 1DtpSlGmRB6iq8CGKcY67g==
X-CSE-MsgGUID: PLSo0HpZTHmofhGvTVY0uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102185803"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102185803"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:37 -0700
X-CSE-ConnectionGUID: H80K5EhcQyyy/4zddrUKbw==
X-CSE-MsgGUID: mjjOb92ORuKDlsn+VU6qSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275242864"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:36 -0700
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
Subject: [RFC ethtool 1/2] ethtool: Add interface capability get support
Date: Wed, 30 Sep 2026 08:21:50 -0500
Message-Id: <20260930132151.932792-5-shubham.das@intel.com>
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

Add the --interface-capabilities command to display the interface
block topology and per-block support for loopback, PRBS, BERT, and
error injection.

Each block reports:
  - id: unique block identifier for per-block commands
  - component: MAC, PHY, or MODULE
  - sublayer: RS, PCS, FEC, PMA, PMD, or NONE
  - instance: distinguishes multiple instances of the same component
    (for example, internal vs external PHY, host vs port MAC)
  - name: driver-chosen label (for example, host-pma, ext-phy-pma)
  - depth: ordering within the same (component, sublayer) tuple
  - lanes: number of SerDes lanes at this block
  - loopback_supported: supported loopback direction bitmask
  - supported_tx_patterns: patterns the block can generate
  - supported_rx_patterns: patterns the block can check
  - error_inject_supported: block supports bit error injection
  - bert_supported: block supports BERT (Bit Error Ratio Test)

Example:
  ethtool --interface-capabilities eth1

Signed-off-by: Shubham Das <shubham.das@intel.com>
---
 Makefile.am                            |   1 +
 ethtool.c                              |   5 +
 netlink/extapi.h                       |   2 +
 netlink/intf_caps.c                    | 230 +++++++++++++++++++++++++
 uapi/linux/ethtool_netlink_generated.h |  73 ++++++++
 5 files changed, 311 insertions(+)
 create mode 100644 netlink/intf_caps.c

diff --git a/Makefile.am b/Makefile.am
index db22be4..67f1be4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -55,6 +55,7 @@ ethtool_SOURCES += \
 		  netlink/pse-pd.c \
 		  netlink/phy.c \
 		  netlink/tsconfig.c \
+		  netlink/intf_caps.c \
 		  netlink/mse.c \
 		  uapi/linux/const.h uapi/linux/ethtool.h \
 		  uapi/linux/ethtool_netlink.h \
diff --git a/ethtool.c b/ethtool.c
index 30a1d97..bb36754 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6514,6 +6514,11 @@ static const struct option args[] = {
 		.nlfunc	= nl_gmse,
 		.help	= "Show Mean Square Error (MSE) diagnostics",
 	},
+	{
+		.opts	= "--interface-capabilities",
+		.nlfunc	= nl_get_intf_caps,
+		.help	= "Show interface block capabilities",
+	},
 	{
 		.opts	= "-h|--help",
 		.no_dev	= true,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index e10af62..696f829 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -67,6 +67,7 @@ void nl_monitor_usage(void);
 int nl_get_eeprom_page(struct cmd_context *ctx,
 		       struct ethtool_module_eeprom *request);
 
+int nl_get_intf_caps(struct cmd_context *ctx);
 #else /* ETHTOOL_ENABLE_NETLINK */
 
 static inline void netlink_run_handler(struct cmd_context *ctx __maybe_unused,
@@ -142,6 +143,7 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_flash_module_fw	NULL
 #define nl_get_phy		NULL
 #define nl_gmse			NULL
+#define nl_get_intf_caps	NULL
 
 #endif /* ETHTOOL_ENABLE_NETLINK */
 
diff --git a/netlink/intf_caps.c b/netlink/intf_caps.c
new file mode 100644
index 0000000..a78d605
--- /dev/null
+++ b/netlink/intf_caps.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * intf_caps.c - netlink implementation of interface capabilities
+ *
+ * Implementation of "ethtool --interface-capabilities <dev>"
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "../internal.h"
+#include "../common.h"
+#include "netlink.h"
+
+static const char *component_to_str(uint32_t component)
+{
+	switch (component) {
+	case INTF_COMPONENT_MAC:	return "MAC";
+	case INTF_COMPONENT_PHY:	return "PHY";
+	case INTF_COMPONENT_MODULE:	return "MODULE";
+	default:			return "UNKNOWN";
+	}
+}
+
+static const char *sublayer_to_str(uint32_t sublayer)
+{
+	switch (sublayer) {
+	case INTF_SUBLAYER_NONE:	return "(none)";
+	case INTF_SUBLAYER_RS:		return "RS";
+	case INTF_SUBLAYER_PCS:		return "PCS";
+	case INTF_SUBLAYER_FEC:		return "FEC";
+	case INTF_SUBLAYER_PMA:		return "PMA";
+	case INTF_SUBLAYER_PMD:		return "PMD";
+	default:			return "UNKNOWN";
+	}
+}
+
+static const char * const pattern_names[] = {
+	[PHY_TEST_PATTERN_OFF]		= "off",
+	[PHY_TEST_PATTERN_PRBS7]	= "prbs7",
+	[PHY_TEST_PATTERN_PRBS9]	= "prbs9",
+	[PHY_TEST_PATTERN_PRBS11]	= "prbs11",
+	[PHY_TEST_PATTERN_PRBS13]	= "prbs13",
+	[PHY_TEST_PATTERN_PRBS15]	= "prbs15",
+	[PHY_TEST_PATTERN_PRBS23]	= "prbs23",
+	[PHY_TEST_PATTERN_PRBS31]	= "prbs31",
+	[PHY_TEST_PATTERN_SSPRQ]		= "ssprq",
+	[PHY_TEST_PATTERN_PRBS13Q]		= "prbs13q",
+	[PHY_TEST_PATTERN_PRBS31Q]		= "prbs31q",
+	[PHY_TEST_PATTERN_SQUARE_NRZ]		= "square-nrz",
+	[PHY_TEST_PATTERN_SQUARE_PAM4]		= "square-pam4",
+	[PHY_TEST_PATTERN_TX_LINEARITY]		= "tx-linearity",
+	[PHY_TEST_PATTERN_SCRAMBLED_IDLE]	= "scrambled-idle",
+	[PHY_TEST_PATTERN_K28_5]		= "k28.5",
+	[PHY_TEST_PATTERN_K28_7]		= "k28.7",
+};
+
+static void print_pattern_bitmask(const char *label, u32 bitmask)
+{
+	bool first = true;
+	unsigned int i;
+
+	printf("    %s:", label);
+	if (!bitmask) {
+		printf(" (none)\n");
+		return;
+	}
+
+	for (i = 1; i < ARRAY_SIZE(pattern_names); i++) {
+		if (bitmask & (1U << i)) {
+			const char *name = pattern_names[i];
+
+			printf("%s %s", first ? "" : ",",
+			       name ? name : "???");
+			first = false;
+		}
+	}
+	printf("\n");
+}
+
+static void print_loopback_supported(u32 loopback)
+{
+	printf("    Supported loopback:");
+	if (!loopback) {
+		printf(" (none)\n");
+		return;
+	}
+	if (loopback & LOOPBACK_SUPPORT_LOCAL)
+		printf(" local");
+	if (loopback & LOOPBACK_SUPPORT_REMOTE)
+		printf(" remote");
+	printf("\n");
+}
+
+static int parse_intf_block(const struct nlattr *block_attr)
+{
+	const struct nlattr *tb[ETHTOOL_A_INTF_BLOCK_MAX + 1] = {};
+	struct nlattr *attr;
+
+	mnl_attr_for_each_nested(attr, block_attr) {
+		u16 type = mnl_attr_get_type(attr);
+
+		if (type <= ETHTOOL_A_INTF_BLOCK_MAX)
+			tb[type] = attr;
+	}
+
+	/* Block ID */
+	u32 id = tb[ETHTOOL_A_INTF_BLOCK_ID]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_ID]) : 0;
+	u32 component = tb[ETHTOOL_A_INTF_BLOCK_COMPONENT]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_COMPONENT]) : 0;
+	u32 sublayer = tb[ETHTOOL_A_INTF_BLOCK_SUBLAYER]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_SUBLAYER]) : 0;
+	u32 instance = tb[ETHTOOL_A_INTF_BLOCK_INSTANCE]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_INSTANCE]) : 0;
+	const char *name = tb[ETHTOOL_A_INTF_BLOCK_NAME]
+		? mnl_attr_get_str(tb[ETHTOOL_A_INTF_BLOCK_NAME]) : "";
+	u8 depth = tb[ETHTOOL_A_INTF_BLOCK_DEPTH]
+		? mnl_attr_get_u8(tb[ETHTOOL_A_INTF_BLOCK_DEPTH]) : 0;
+	u32 lanes = tb[ETHTOOL_A_INTF_BLOCK_LANES]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_LANES]) : 0;
+	u32 loopback = 0;
+	u32 tx_pat = tb[ETHTOOL_A_INTF_BLOCK_TX_PATTERNS]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_TX_PATTERNS]) : 0;
+	u32 rx_pat = tb[ETHTOOL_A_INTF_BLOCK_RX_PATTERNS]
+		? mnl_attr_get_u32(tb[ETHTOOL_A_INTF_BLOCK_RX_PATTERNS]) : 0;
+	bool bert = !!tb[ETHTOOL_A_INTF_BLOCK_BERT];
+	bool inject = !!tb[ETHTOOL_A_INTF_BLOCK_ERROR_INJECT];
+
+	if (tb[ETHTOOL_A_INTF_BLOCK_LOOPBACK_SUPPORTED]) {
+		const struct nlattr *attr =
+			tb[ETHTOOL_A_INTF_BLOCK_LOOPBACK_SUPPORTED];
+
+		loopback = mnl_attr_get_u32(attr);
+	}
+
+	printf("  Block %u: %s\n", id, name);
+	printf("    component: %s\n", component_to_str(component));
+	printf("    instance: %u\n", instance);
+	printf("    sublayer: %s\n", sublayer_to_str(sublayer));
+	printf("    depth: %u\n", depth);
+	printf("    lanes: %u\n", lanes);
+
+	print_loopback_supported(loopback);
+	print_pattern_bitmask("Supported TX patterns", tx_pat);
+	print_pattern_bitmask("Supported RX patterns", rx_pat);
+
+	printf("    Supported tests:");
+	if (!bert && !inject) {
+		printf(" (none)\n");
+	} else {
+		if (bert)
+			printf(" bert");
+		if (inject)
+			printf(" error-inject");
+		printf("\n");
+	}
+	printf("\n");
+
+	return 0;
+}
+
+static int intf_caps_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_INTF_CAPS_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	struct nlattr *attr;
+	bool silent;
+	int err_ret;
+	int ret;
+
+	silent = nlctx->is_dump;
+	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return err_ret;
+
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_INTF_CAPS_HEADER]);
+	if (!dev_ok(nlctx))
+		return err_ret;
+
+	if (silent)
+		print_nl();
+
+	printf("Interface capabilities for %s:\n\n", nlctx->devname);
+
+	if (tb[ETHTOOL_A_INTF_CAPS_BLOCKS]) {
+		mnl_attr_for_each_nested(attr, tb[ETHTOOL_A_INTF_CAPS_BLOCKS]) {
+			parse_intf_block(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+int nl_get_intf_caps(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	struct nl_msg_buff *msgbuff = &nlsk->msgbuff;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_INTF_CAPS_GET, true))
+		return -EOPNOTSUPP;
+
+	if (ctx->argc > 0) {
+		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
+			*ctx->argp);
+		return 1;
+	}
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_INTF_CAPS_GET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_INTF_CAPS_HEADER,
+			       ctx->devname, 0))
+		return -EMSGSIZE;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return ret;
+
+	return nlsock_process_reply(nlsk, intf_caps_reply_cb, nlctx);
+}
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index 572c5f9..7b9860a 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -840,6 +840,77 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum intf_component {
+	INTF_COMPONENT_MAC,
+	INTF_COMPONENT_PHY,
+	INTF_COMPONENT_MODULE,
+	__INTF_COMPONENT_COUNT,
+	INTF_COMPONENT_MAX = (__INTF_COMPONENT_COUNT - 1)
+};
+
+enum intf_sublayer {
+	INTF_SUBLAYER_NONE,
+	INTF_SUBLAYER_RS,
+	INTF_SUBLAYER_PCS,
+	INTF_SUBLAYER_FEC,
+	INTF_SUBLAYER_PMA,
+	INTF_SUBLAYER_PMD,
+	__INTF_SUBLAYER_COUNT,
+	INTF_SUBLAYER_MAX = (__INTF_SUBLAYER_COUNT - 1)
+};
+
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
+	__ETHTOOL_A_INTF_BLOCK_CNT,
+	ETHTOOL_A_INTF_BLOCK_MAX = (__ETHTOOL_A_INTF_BLOCK_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_INTF_CAPS_UNSPEC,
+	ETHTOOL_A_INTF_CAPS_HEADER,
+	ETHTOOL_A_INTF_CAPS_BLOCKS,
+	__ETHTOOL_A_INTF_CAPS_CNT,
+	ETHTOOL_A_INTF_CAPS_MAX = (__ETHTOOL_A_INTF_CAPS_CNT - 1)
+};
+
+#define LOOPBACK_SUPPORT_LOCAL         1U
+#define LOOPBACK_SUPPORT_REMOTE        2U
+
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
+	__PHY_TEST_PATTERN_COUNT,
+	PHY_TEST_PATTERN_MAX = (__PHY_TEST_PATTERN_COUNT - 1)
+};
+
+#define LOOPBACK_SUPPORT_LOCAL         1U
+#define LOOPBACK_SUPPORT_REMOTE        2U
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -893,6 +964,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_INTF_CAPS_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +1026,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.25.1

