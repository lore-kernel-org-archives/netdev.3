Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADA4252B4
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007963; cv=none; b=Q3ksampJqLcfmi8eii2ORm0YpuSbSA044iKnHXEX2Ul4DzKeUlguQyuflgj5VeTgjbAZw5hIVfj+/fi62S8peumEm2hR9JnWeAlhD2HDtvE5WLWgpoWX8IBGGxU4F8iLStXQvoWnACfqY1X2orAJnDALySXOxnGjt2iLsIFVSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007963; c=relaxed/simple;
	bh=V8t4FzdbF5cjtWywo8+QjaofMs4/e6/Fgq21GJ43pSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtYc01CD7q+07e/Aacpc7qIKIgTyG3XKFozSfSLVlV3ALciwGy4WCreSC/Wtx3ncXt+Fatec9gk0D5/W1xqWDbvsfbmvIYROthvTSqMLXszhKBvHb2mrAx181urvppyR3B0cdEkBnlgYKV2cJKqPU/eX7Spna515QSnuoIQeaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUFRZ2WS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUFRZ2WS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790007962; x=1821543962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V8t4FzdbF5cjtWywo8+QjaofMs4/e6/Fgq21GJ43pSk=;
  b=HUFRZ2WSRw8CX05ny11Fn8g+Q4N15U5LbhQqbNlTjNZ2cRl7p1VoCaKk
   gSye8K+MyHPx8GtEtvh9CRGYVPJuARB6/i1/D8GjmW6djoESLmG5flNvJ
   zUcPD2mURvy8Ade575BZ8sVUpyJAI/gvOZO8LHrD4Vsc2QWimL0gnvjzu
   cT+yQX6AxTARrry6WemTP0+1K+IXZC9LPNEgjKJB5kglPAzTHub9BEXYR
   53E7W1wSiuTSZjdHmQcWhKfwEA+7jB1jQMFxXFX1KM/RcrCpBksyYl/0p
   jBMi7iUycN7TgqGFWy2021LCdQ23mP/aJEUktR7gFJrBck55pOa+RBF5o
   g==;
X-CSE-ConnectionGUID: WJ4S3GLOS2qBdE19hCtzsA==
X-CSE-MsgGUID: nQJ6ONeBR7CRo+iTMZFNNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101199883"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101199883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:25:59 -0700
X-CSE-ConnectionGUID: Q9MGj66qRKms9vWM8QVR6Q==
X-CSE-MsgGUID: GoAby5XGSEOEt1d1ZnLrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280778689"
Received: from txandevvm17u.an.intel.com ([10.122.196.193])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 09:25:53 -0700
From: Pei Lee Ling <pei.lee.ling@intel.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	shubham.das@intel.com,
	siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com,
	pei.lee.ling@intel.com
Subject: [RFC PATCH ethtool-next] ethtool: Add clear FEC stats Support
Date: Mon, 21 Sep 2026 11:25:48 -0500
Message-ID: <20260921162548.2376757-1-pei.lee.ling@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In high-speed links such as 25G, 100G, and 200G, FEC counters continuously
accumulate over time. When troubleshooting intermittent physical-layer
issues, users need to establish a clean baseline without resetting the
entire device interface. Therefore, this dedicated FEC-stats-clear
operation avoids unnecessary operational disruptions.

Introducing a fec-clear command would also help to standardize behavior 
across different network drivers, providing a more consistent and predictable
user experience.

To clear-fec-stats:
ethtool --clear-fec-stats <ETH1>

Signed-off-by: Pei Lee Ling <pei.lee.ling@intel.com>
---
 ethtool.c                              |  5 ++++
 netlink/extapi.h                       |  2 ++
 netlink/fec.c                          | 40 ++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink_generated.h |  1 +
 4 files changed, 48 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 3076c12..92d641f 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6389,6 +6389,11 @@ static const struct option args[] = {
 		.help	= "Set FEC settings",
 		.xhelp	= "		[ encoding auto|off|rs|baser|llrs [...] ]\n"
 	},
+	{
+		.opts   = "--clear-fec-stats",
+		.nlfunc = nl_cfecstats,
+		.help   = "Clear FEC statistics",
+	},
 	{
 		.opts	= "-Q|--per-queue",
 		.func	= do_perqueue,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index b0e4588..272677e 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -43,6 +43,7 @@ int nl_cable_test_tdr(struct cmd_context *ctx);
 int nl_gtunnels(struct cmd_context *ctx);
 int nl_gfec(struct cmd_context *ctx);
 int nl_sfec(struct cmd_context *ctx);
+int nl_cfecstats(struct cmd_context *ctx);
 bool nl_gstats_chk(struct cmd_context *ctx);
 int nl_gstats(struct cmd_context *ctx);
 int nl_gmodule(struct cmd_context *ctx);
@@ -124,6 +125,7 @@ nl_get_eeprom_page(struct cmd_context *ctx __maybe_unused,
 #define nl_gtunnels		NULL
 #define nl_gfec			NULL
 #define nl_sfec			NULL
+#define nl_cfecstats		NULL
 #define nl_gstats_chk		NULL
 #define nl_gstats		NULL
 #define nl_getmodule		NULL
diff --git a/netlink/fec.c b/netlink/fec.c
index c014749..60630d5 100644
--- a/netlink/fec.c
+++ b/netlink/fec.c
@@ -438,3 +438,43 @@ int nl_sfec(struct cmd_context *ctx)
 	else
 		return nlctx->exit_code ?: 83;
 }
+
+/* FEC_STATS_CLEAR */
+
+int nl_cfecstats(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_msg_buff *msgbuff;
+	struct nl_socket *nlsk;
+	u32 flags = 0;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_FEC_SET, false))
+		return -EOPNOTSUPP;
+
+	nlctx->devname = ctx->devname;
+	nlsk = nlctx->ethnl_socket;
+	msgbuff = &nlsk->msgbuff;
+
+	ret = msg_init(nlctx, msgbuff, ETHTOOL_MSG_FEC_SET,
+		       NLM_F_REQUEST | NLM_F_ACK);
+	if (ret < 0)
+		return 2;
+
+	if (ethnla_fill_header(msgbuff, ETHTOOL_A_FEC_HEADER,
+			       ctx->devname, 0))
+		return -EMSGSIZE;
+
+	if (ethnla_put_u8(msgbuff, ETHTOOL_A_FEC_STATS_CLEAR, flags))
+		return -EMSGSIZE;
+
+	ret = nlsock_sendmsg(nlsk, NULL);
+	if (ret < 0)
+		return 83;
+
+	ret = nlsock_process_reply(nlsk, nomsg_reply_cb, nlctx);
+	if (ret == 0)
+		return 0;
+	else
+		return nlctx->exit_code ?: 83;
+}
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index 572c5f9..2e66531 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -595,6 +595,7 @@ enum {
 	ETHTOOL_A_FEC_AUTO,
 	ETHTOOL_A_FEC_ACTIVE,
 	ETHTOOL_A_FEC_STATS,
+	ETHTOOL_A_FEC_STATS_CLEAR,
 
 	__ETHTOOL_A_FEC_CNT,
 	ETHTOOL_A_FEC_MAX = (__ETHTOOL_A_FEC_CNT - 1)
-- 
2.43.0

