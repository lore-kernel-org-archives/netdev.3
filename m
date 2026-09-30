Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1924E322D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774578; cv=none; b=CKs/wO2cKt0k5ZpsceClFDKAbnLKWSSAhEstaGX/Fc5uSoXHFG0Mn3l+1Zu2oNhQoJjEO3CWDCLnq8c5EZjtWUhiBBItrlCgDj/LHKgXSnQCrfp1pOCTrlc5rdfxc1V1zRNmBmpMyQzn/u8YN3Qn/NnE2XWQw/zZvq4xG/5SUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774578; c=relaxed/simple;
	bh=pnW4WjQT0WtyeKt40hdbsM526JXlXiOo1n9XwSafWXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioEGtYhipepzz2OrOqOnZRlNBhzBPQjiKe84NvGeVimT7L6FqtDqsVkPeBrMZ5tNktmG4VpYuosrFWsMrvsc5vjhv0A+Xq6/3PsVp24Hk+2WWYtrnxfWUlbx1lwkKbg0nNQYTQWi+IMuZpDExIq0/nCB+4VaRcELy9jNzF6zrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOVzusm6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOVzusm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790774567; x=1822310567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnW4WjQT0WtyeKt40hdbsM526JXlXiOo1n9XwSafWXU=;
  b=lOVzusm67pGPS9LF/gunHh2cULzTZ8E1Z/ZLOntLQhleiRmWthYnnWT+
   897T0gz2mzv5EF/tcENC4b8mAs/whJLbkDpllz2CJBuFBQBko8kwgvDM0
   bqIDa5EYTA8eg8w+uIhWRfa9RUFP52dpCXtqrd7ca3r4LFqQ2QskuNdbT
   xbjKRYIBaHbiB3rJhGP3idZ3G1bxWU1Za7bVXCV88QMKjbDdVGt6f0HWD
   tDPQs9deskPcB1jepcgn+b87GDymR8tUkWaxCLdz/tIRGzqzJbrFQiQJ+
   079pRXMLp/x2I6QO0fYMB876vLzqa0LomRLuIcSqx2Gembfb9vX4Ljb38
   A==;
X-CSE-ConnectionGUID: JA/V4f26RlCQmAC4PkJDjw==
X-CSE-MsgGUID: Jf+7LNI9TpyeSU0yPxZxyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102185818"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102185818"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:43 -0700
X-CSE-ConnectionGUID: 5U5f6WdKR2ePUAYLljWp4Q==
X-CSE-MsgGUID: 8X1/S3WEQy6hmJadHFXTdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275827269"
Received: from txa-pn-adk06.an.intel.com ([10.123.72.220])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:22:43 -0700
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
Subject: [RFC ethtool 2/2] ethtool: Add PHY test and BERT support
Date: Wed, 30 Sep 2026 08:21:51 -0500
Message-Id: <20260930132151.932792-6-shubham.das@intel.com>
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
configure and monitor PHY test functions, including TX/RX patterns,
BERT control, error injection, and test status reporting.

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
 Makefile.am                            |   1 +
 ethtool.c                              |  16 ++
 netlink/desc-ethtool.c                 |  18 ++
 netlink/extapi.h                       |   4 +
 netlink/phytest.c                      | 354 +++++++++++++++++++++++++
 uapi/linux/ethtool_netlink_generated.h |  31 +++
 6 files changed, 424 insertions(+)
 create mode 100644 netlink/phytest.c

diff --git a/Makefile.am b/Makefile.am
index 67f1be4..b20f561 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -55,6 +55,7 @@ ethtool_SOURCES += \
 		  netlink/pse-pd.c \
 		  netlink/phy.c \
 		  netlink/tsconfig.c \
+		  netlink/phytest.c \
 		  netlink/intf_caps.c \
 		  netlink/mse.c \
 		  uapi/linux/const.h uapi/linux/ethtool.h \
diff --git a/ethtool.c b/ethtool.c
index bb36754..ff6194f 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6514,6 +6514,22 @@ static const struct option args[] = {
 		.nlfunc	= nl_gmse,
 		.help	= "Show Mean Square Error (MSE) diagnostics",
 	},
+	{
+		.opts	= "--show-phy-test",
+		.nlfunc	= nl_get_phy_test,
+		.help	= "Show PHY test configuration and supported patterns",
+	},
+	{
+		.opts	= "--phy-test",
+		.nlfunc	= nl_set_phy_test,
+		.help	= "Configure PHY test patterns and BERT",
+		.xhelp  = "             [ block N ]\n"
+			  "             lane N\n"
+			  "             [ tx-pattern off|prbs7|prbs9|prbs11|prbs13|prbs15|prbs23|prbs31|ssprq|prbs13q|prbs31q|square ]\n"
+			  "             [ rx-pattern off|prbs7|prbs9|prbs11|prbs13|prbs15|prbs23|prbs31|ssprq|prbs13q|prbs31q|square ]\n"
+			  "             [ bert start|stop ]\n"
+			  "             [ inject-errors N ]\n"
+	},
 	{
 		.opts	= "--interface-capabilities",
 		.nlfunc	= nl_get_intf_caps,
diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
index e8d6c59..f8320c8 100644
--- a/netlink/desc-ethtool.c
+++ b/netlink/desc-ethtool.c
@@ -666,6 +666,21 @@ static const struct pretty_nla_desc __mse_desc[] = {
 	NLATTR_DESC_NESTED(ETHTOOL_A_MSE_LINK, mse_snapshot),
 };
 
+static const struct pretty_nla_desc __phy_test_desc[] = {
+	NLATTR_DESC_INVALID(ETHTOOL_A_PHY_TEST_UNSPEC),
+	NLATTR_DESC_NESTED(ETHTOOL_A_PHY_TEST_HEADER, header),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_BLOCK_ID),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_LANE),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_TX_PATTERN),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_RX_PATTERN),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_BERT_ACTION),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT),
+	NLATTR_DESC_U32(ETHTOOL_A_PHY_TEST_ACTIVE_TESTS),
+	NLATTR_DESC_U8(ETHTOOL_A_PHY_TEST_CHECKER_LOCK),
+	NLATTR_DESC_U64(ETHTOOL_A_PHY_TEST_ERROR_COUNT),
+	NLATTR_DESC_U64(ETHTOOL_A_PHY_TEST_TOTAL_BITS_SENT),
+};
+
 const struct pretty_nlmsg_desc ethnl_umsg_desc[] = {
 	NLMSG_DESC_INVALID(ETHTOOL_MSG_USER_NONE),
 	NLMSG_DESC(ETHTOOL_MSG_STRSET_GET, strset),
@@ -719,6 +734,8 @@ const struct pretty_nlmsg_desc ethnl_umsg_desc[] = {
 	NLMSG_DESC(ETHTOOL_MSG_RSS_CREATE_ACT, rss),
 	NLMSG_DESC(ETHTOOL_MSG_RSS_DELETE_ACT, rss),
 	NLMSG_DESC(ETHTOOL_MSG_MSE_GET, mse),
+	NLMSG_DESC(ETHTOOL_MSG_PHY_TEST_SET, phy_test),
+	NLMSG_DESC(ETHTOOL_MSG_PHY_TEST_GET, phy_test),
 };
 
 const unsigned int ethnl_umsg_n_desc = ARRAY_SIZE(ethnl_umsg_desc);
@@ -779,6 +796,7 @@ const struct pretty_nlmsg_desc ethnl_kmsg_desc[] = {
 	NLMSG_DESC(ETHTOOL_MSG_RSS_CREATE_NTF, rss),
 	NLMSG_DESC(ETHTOOL_MSG_RSS_DELETE_NTF, rss),
 	NLMSG_DESC(ETHTOOL_MSG_MSE_GET_REPLY, mse),
+	NLMSG_DESC(ETHTOOL_MSG_PHY_TEST_GET_REPLY, phy_test),
 };
 
 const unsigned int ethnl_kmsg_n_desc = ARRAY_SIZE(ethnl_kmsg_desc);
diff --git a/netlink/extapi.h b/netlink/extapi.h
index 696f829..3700f6f 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -67,6 +67,8 @@ void nl_monitor_usage(void);
 int nl_get_eeprom_page(struct cmd_context *ctx,
 		       struct ethtool_module_eeprom *request);
 
+int nl_get_phy_test(struct cmd_context *ctx);
+int nl_set_phy_test(struct cmd_context *ctx);
 int nl_get_intf_caps(struct cmd_context *ctx);
 #else /* ETHTOOL_ENABLE_NETLINK */
 
@@ -143,6 +145,8 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_flash_module_fw	NULL
 #define nl_get_phy		NULL
 #define nl_gmse			NULL
+#define nl_get_phy_test		NULL
+#define nl_set_phy_test		NULL
 #define nl_get_intf_caps	NULL
 
 #endif /* ETHTOOL_ENABLE_NETLINK */
diff --git a/netlink/phytest.c b/netlink/phytest.c
new file mode 100644
index 0000000..3dcd2ad
--- /dev/null
+++ b/netlink/phytest.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * phytest.c - netlink implementation of PHY test
+ *
+ * Implementation of
+ * "ethtool --show-phy-test <dev> [lane N]" and
+ * "ethtool --phy-test <dev> lane N
+ *                           [tx-pattern <pattern>]
+ *                           [rx-pattern <pattern>] [bert start|stop|stats]
+ *                           [inject-errors N]"
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
+#include "parser.h"
+
+static const char *phy_test_pattern_to_str(uint32_t pattern)
+{
+	switch (pattern) {
+	case PHY_TEST_PATTERN_OFF:		return "off";
+	case PHY_TEST_PATTERN_PRBS7:		return "prbs7";
+	case PHY_TEST_PATTERN_PRBS9:		return "prbs9";
+	case PHY_TEST_PATTERN_PRBS11:		return "prbs11";
+	case PHY_TEST_PATTERN_PRBS13:		return "prbs13";
+	case PHY_TEST_PATTERN_PRBS15:		return "prbs15";
+	case PHY_TEST_PATTERN_PRBS23:		return "prbs23";
+	case PHY_TEST_PATTERN_PRBS31:		return "prbs31";
+	case PHY_TEST_PATTERN_SSPRQ:		return "ssprq";
+	case PHY_TEST_PATTERN_PRBS13Q:		return "prbs13q";
+	case PHY_TEST_PATTERN_PRBS31Q:		return "prbs31q";
+	case PHY_TEST_PATTERN_SQUARE_NRZ:	return "square-nrz";
+	case PHY_TEST_PATTERN_SQUARE_PAM4:	return "square-pam4";
+	case PHY_TEST_PATTERN_TX_LINEARITY:	return "tx-linearity";
+	case PHY_TEST_PATTERN_SCRAMBLED_IDLE:	return "scrambled-idle";
+	case PHY_TEST_PATTERN_K28_5:		return "k28.5";
+	case PHY_TEST_PATTERN_K28_7:		return "k28.7";
+	default:				return "unknown";
+	}
+}
+
+/* PHY_TEST_GET reply callback */
+static int phy_test_get_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_PHY_TEST_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
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
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PHY_TEST_HEADER]);
+	if (!dev_ok(nlctx))
+		return err_ret;
+
+	if (silent)
+		print_nl();
+
+	printf("PHY test settings for %s:\n", nlctx->devname);
+
+	if (tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]) {
+		printf("  block: %u\n",
+		       mnl_attr_get_u32(tb[ETHTOOL_A_PHY_TEST_BLOCK_ID]));
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_LANE]) {
+		printf("  lane: %u\n",
+		       mnl_attr_get_u32(tb[ETHTOOL_A_PHY_TEST_LANE]));
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_TX_PATTERN]) {
+		u32 pattern;
+
+		pattern = mnl_attr_get_u32(tb[ETHTOOL_A_PHY_TEST_TX_PATTERN]);
+
+		print_string(PRINT_ANY, "tx-pattern",
+			     "  tx-pattern: %s\n",
+			     phy_test_pattern_to_str(pattern));
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_RX_PATTERN]) {
+		u32 pattern;
+
+		pattern = mnl_attr_get_u32(tb[ETHTOOL_A_PHY_TEST_RX_PATTERN]);
+
+		print_string(PRINT_ANY, "rx-pattern",
+			     "  rx-pattern: %s\n",
+			     phy_test_pattern_to_str(pattern));
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_ACTIVE_TESTS]) {
+		u32 active;
+
+		active = mnl_attr_get_u32(tb[ETHTOOL_A_PHY_TEST_ACTIVE_TESTS]);
+
+		printf("  active-tests:");
+		if (active & 0x1)
+			printf(" bert\n");
+		else
+			printf(" (none)\n");
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_CHECKER_LOCK]) {
+		u8 checker_lock =
+			mnl_attr_get_u8(tb[ETHTOOL_A_PHY_TEST_CHECKER_LOCK]);
+
+		print_string(PRINT_ANY, "checker-lock",
+			     "  checker-lock: %s\n",
+			     checker_lock ?
+			     "locked" : "not locked");
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_ERROR_COUNT]) {
+		u64 error_count =
+			mnl_attr_get_u64(tb[ETHTOOL_A_PHY_TEST_ERROR_COUNT]);
+
+		printf("  error-count: %llu\n",
+		       (unsigned long long)error_count);
+	}
+
+	if (tb[ETHTOOL_A_PHY_TEST_TOTAL_BITS_SENT]) {
+		const struct nlattr *attr;
+		u64 total_bits_sent;
+
+		attr = tb[ETHTOOL_A_PHY_TEST_TOTAL_BITS_SENT];
+		total_bits_sent = mnl_attr_get_u64(attr);
+
+		printf("  total-bits-sent: %llu\n",
+		       (unsigned long long)total_bits_sent);
+	}
+
+	return MNL_CB_OK;
+}
+
+int nl_get_phy_test(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	struct nl_msg_buff *msgbuff = &nlsk->msgbuff;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_PHY_TEST_GET, true))
+		return -EOPNOTSUPP;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_PHY_TEST_GET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PHY_TEST_HEADER,
+			       ctx->devname, 0))
+		return -EMSGSIZE;
+
+	/* Parse "block N" (mandatory) and "lane N" (optional) parameters */
+	if (ctx->argc < 2 || strcmp(ctx->argp[0], "block")) {
+		fprintf(stderr,
+			"ethtool (--show-phy-test): block parameter is required\n"
+			"Usage: ethtool --show-phy-test DEVNAME block N [lane N]\n");
+		return -EINVAL;
+	}
+
+	while (ctx->argc >= 2) {
+		if (!strcmp(ctx->argp[0], "block")) {
+			u32 block_id;
+
+			if (parse_u32(ctx->argp[1], &block_id)) {
+				fprintf(stderr,
+					"ethtool: invalid block value '%s'\n",
+					ctx->argp[1]);
+				return -EINVAL;
+			}
+			if (ethnla_put_u32(msgbuff, ETHTOOL_A_PHY_TEST_BLOCK_ID,
+					   block_id))
+				return -EMSGSIZE;
+			ctx->argp += 2;
+			ctx->argc -= 2;
+		} else if (!strcmp(ctx->argp[0], "lane")) {
+			u32 lane;
+
+			if (parse_u32(ctx->argp[1], &lane)) {
+				fprintf(stderr,
+					"ethtool: invalid lane value '%s'\n",
+					ctx->argp[1]);
+				return -EINVAL;
+			}
+			if (ethnla_put_u32(msgbuff, ETHTOOL_A_PHY_TEST_LANE,
+					   lane))
+				return -EMSGSIZE;
+			ctx->argp += 2;
+			ctx->argc -= 2;
+		} else {
+			break;
+		}
+	}
+
+	if (ctx->argc > 0) {
+		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
+			*ctx->argp);
+		return 1;
+	}
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return ret;
+
+	return nlsock_process_reply(nlsk, phy_test_get_reply_cb, nlctx);
+}
+
+/* PHY_TEST_SET */
+static const struct lookup_entry_u32 pattern_values[] = {
+	{ .arg = "off",			.val = PHY_TEST_PATTERN_OFF },
+	{ .arg = "prbs7",		.val = PHY_TEST_PATTERN_PRBS7 },
+	{ .arg = "prbs9",		.val = PHY_TEST_PATTERN_PRBS9 },
+	{ .arg = "prbs11",		.val = PHY_TEST_PATTERN_PRBS11 },
+	{ .arg = "prbs13",		.val = PHY_TEST_PATTERN_PRBS13 },
+	{ .arg = "prbs15",		.val = PHY_TEST_PATTERN_PRBS15 },
+	{ .arg = "prbs23",		.val = PHY_TEST_PATTERN_PRBS23 },
+	{ .arg = "prbs31",		.val = PHY_TEST_PATTERN_PRBS31 },
+	{ .arg = "ssprq",		.val = PHY_TEST_PATTERN_SSPRQ },
+	{ .arg = "prbs13q",		.val = PHY_TEST_PATTERN_PRBS13Q },
+	{ .arg = "prbs31q",		.val = PHY_TEST_PATTERN_PRBS31Q },
+	{ .arg = "square-nrz",		.val = PHY_TEST_PATTERN_SQUARE_NRZ },
+	{ .arg = "square-pam4",		.val = PHY_TEST_PATTERN_SQUARE_PAM4 },
+	{ .arg = "tx-linearity",	.val = PHY_TEST_PATTERN_TX_LINEARITY },
+	{ .arg = "scrambled-idle",
+	  .val = PHY_TEST_PATTERN_SCRAMBLED_IDLE },
+	{ .arg = "k28.5",		.val = PHY_TEST_PATTERN_K28_5 },
+	{ .arg = "k28.7",		.val = PHY_TEST_PATTERN_K28_7 },
+	{}
+};
+
+static const struct lookup_entry_u32 bert_action_values[] = {
+	{ .arg = "start",	.val = PHY_TEST_ACTION_START },
+	{ .arg = "stop",	.val = PHY_TEST_ACTION_STOP },
+	{ .arg = "clear",	.val = PHY_TEST_ACTION_CLEAR },
+	{}
+};
+
+static const struct param_parser phy_test_params[] = {
+	{
+		.arg		= "block",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_BLOCK_ID,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "lane",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_LANE,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "tx-pattern",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_TX_PATTERN,
+		.handler	= nl_parse_lookup_u32,
+		.handler_data	= pattern_values,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "rx-pattern",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_RX_PATTERN,
+		.handler	= nl_parse_lookup_u32,
+		.handler_data	= pattern_values,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "bert",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_BERT_ACTION,
+		.handler	= nl_parse_lookup_u32,
+		.handler_data	= bert_action_values,
+		.min_argc	= 1,
+	},
+	{
+		.arg		= "inject-errors",
+		.group		= ETHTOOL_MSG_PHY_TEST_SET,
+		.type		= ETHTOOL_A_PHY_TEST_INJECT_ERROR_COUNT,
+		.handler	= nl_parse_direct_u32,
+		.min_argc	= 1,
+	},
+	{}
+};
+
+int nl_set_phy_test(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_msg_buff *msgbuff;
+	struct nl_socket *nlsk;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_PHY_TEST_SET, false))
+		return -EOPNOTSUPP;
+
+	if (ctx->argc < 2) {
+		fprintf(stderr,
+			"ethtool (--phy-test): parameters missing\n"
+			"Usage: ethtool --phy-test DEVNAME block N lane N [tx-pattern ...] [rx-pattern ...] [bert ...]\n");
+		return -EINVAL;
+	}
+
+	if (strcmp(ctx->argp[0], "block")) {
+		fprintf(stderr,
+			"ethtool (--phy-test): block parameter is required as first argument\n"
+			"Usage: ethtool --phy-test DEVNAME block N lane N [tx-pattern ...] [rx-pattern ...] [bert ...]\n");
+		return -EINVAL;
+	}
+
+	nlctx->cmd = "--phy-test";
+	nlctx->argp = ctx->argp;
+	nlctx->argc = ctx->argc;
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_PHY_TEST_SET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return ret;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PHY_TEST_HEADER,
+			       ctx->devname, 0)) {
+		return -EMSGSIZE;
+	}
+
+	ret = nl_parser(nlctx, phy_test_params, NULL, PARSER_GROUP_NONE, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = nlsock_process_reply(nlsk, nomsg_reply_cb, nlctx);
+	if (ret)
+		return nlctx->exit_code;
+
+	return 0;
+}
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index 7b9860a..3ec5cb5 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -909,8 +909,36 @@ enum phy_test_pattern {
 	PHY_TEST_PATTERN_MAX = (__PHY_TEST_PATTERN_COUNT - 1)
 };
 
+enum phy_test_action {
+	PHY_TEST_ACTION_NONE,
+	PHY_TEST_ACTION_START,
+	PHY_TEST_ACTION_STOP,
+	PHY_TEST_ACTION_CLEAR,
+	__PHY_TEST_ACTION_COUNT,
+	PHY_TEST_ACTION_MAX = (__PHY_TEST_ACTION_COUNT - 1)
+};
+
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
+	__ETHTOOL_A_PHY_TEST_CNT,
+	ETHTOOL_A_PHY_TEST_MAX = (__ETHTOOL_A_PHY_TEST_CNT - 1)
+};
+
 #define LOOPBACK_SUPPORT_LOCAL         1U
 #define LOOPBACK_SUPPORT_REMOTE        2U
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -965,6 +993,8 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
 	ETHTOOL_MSG_INTF_CAPS_GET,
+	ETHTOOL_MSG_PHY_TEST_GET,
+	ETHTOOL_MSG_PHY_TEST_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -1027,6 +1057,7 @@ enum {
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
 	ETHTOOL_MSG_INTF_CAPS_GET_REPLY,
+	ETHTOOL_MSG_PHY_TEST_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.25.1

