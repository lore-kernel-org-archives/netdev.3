Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE645DF4A;
	Fri, 14 Aug 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704212; cv=none; b=pbAlMQ8QEKaV9c6eJuZK5wycLPLQEqhQBJbY9D8s6TswMFtwmUB0LBnoVyAYF0v5sgdjEl4aymqQ/9TQhsYKEGesD/o+d+LYC8OAL/tQ6YRDHO5EJy790w5SV4xU0R2/cB3Oky6U9W0iAFlIbnNHk72LXO3kw4J42wGDyVh5HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704212; c=relaxed/simple;
	bh=Dy21Mg5DDuPbRZcXhpqeoipweoxMCzWo0edmWPef7dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cTC32lhfblYqMZ+SxKRLPo5hKF1AJ0oTW4B+VrC62JDX25OG2fkbv6Muh5b/h/XCNc1r+3eWhl11eJJZt3Gb+N1fWH2wYAzbtE7gGp66DFs7SwT1KjsJvYnKIbjcnTjxTuXhsQ9fdHPGoXBUNHu5+FUgTDougw9G503E7kvHX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QW12YKD+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QW12YKD+"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbxpP3240625;
	Fri, 14 Aug 2026 03:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5J9V+Qzz67b8z6mcg7UjbzE
	6VTYRqfJf+Xk+wXXMHHk=; b=QW12YKD+SCooUnF9P3MoOO8WQWyO8GbfA5o/zcN
	CRlAdFPRXJsPo49IlprB0pGtPXGRQqImvvNiU2uD3HWNcwmoucVh7GPhUTiZf9Fw
	U3eR7QNfJEB7gR2BGpEsZ6wInYUqoHn3HOS7jMPVt5v+8jqbzjIeIw6/cdvj3Q1W
	uJjDVV+ouQuAb3w86ysjxGY0hWIlSJjHIWkzw9D2tuUwKtJHFBIzqardqlCY77AV
	9/X5V5UC0PhJP2TmVki7jZAgWR5FxVB+PXNMg2p4Ey8gnSdCQDh/rdB6reAxCRrL
	f4wWOdURTrDtYUdgyWozWpqfRzLeUBAgk19kGwI4OhDaKIw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g205u864b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 03:43:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 14 Aug 2026 03:43:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 14 Aug 2026 03:43:07 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 4EA383F7052;
	Fri, 14 Aug 2026 03:43:02 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Viswajith Murali <viswajithm@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH net-next] octeontx2-pf: add devlink param to reset MAC stats
Date: Fri, 14 Aug 2026 16:12:55 +0530
Message-ID: <20260814104256.743844-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HYLc1B5oG1b2xAujV9vWqHvaCG_RhYnH
X-Proofpoint-ORIG-GUID: HYLc1B5oG1b2xAujV9vWqHvaCG_RhYnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MCBTYWx0ZWRfX73jcL/aVqOfA
 2CekTzfjAu2i8tndIkLJw3JQUSdbC7r7N1slYAsMwT77c9fYtYQl/zzi1qjw17RBBv20u7mRQaZ
 QZzHB8aD07XvTQIT11TJvu5a588SBV7RqepNGsoFYduQj/7RZRZcOKH/A/3Du4wOtrhnslPKjoG
 lI2I3+IPbnHfhD1CrXYnBYflkisWsQEmdCrAtIG9NpgXmeXRE6E24eMHZpSYSkIrQ1/6vtBAlZ4
 C/ky/7+uUvzyt/kyd3jNNJryztpC5EVaUB9RK4LvSvxvOI8d+2GlZtRZGEY0uKkPk2OnWwvRNac
 cVC5Jq4cOkKsoK8Nz79MMUAAsvGqqQtb6JYuFjEbVWf4lHATk74CmIwJANXGs0sBfA3mHkILPkZ
 XZWFFlbiufVFZBin3S2w4WQ29zlce+cdO7eZHZt3WAHAMp82K3o4Z/32lwQuGJRM22+KmW2F33a
 Rk7l5HqNTLbOmu/d8fA==
X-Authority-Analysis: v=2.4 cv=NNflPU6g c=1 sm=1 tr=0 ts=6a7ef13c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=9tI-C5XkHQVoPAy0zBMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MCBTYWx0ZWRfX2sueJPVzvCTo
 P8bIYBjHxsdJ7NPnveHul2ntGLioLZep0jZZU825ICfYYzJrIu4Ddu/QiDZzU508SJvdQYmGjvb
 cBOtCQAkxF1KLd0lStn5ROaWKn2NVQo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01

From: Viswajith Murali <viswajithm@marvell.com>

Add a runtime devlink parameter to reset CGX/RPM MAC hardware
statistics.

Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Viswajith Murali <viswajithm@marvell.com>
---
 .../networking/devlink/octeontx2.rst          |  9 +++++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  2 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      | 39 +++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/octeontx2.rst b/Documentation/networking/devlink/octeontx2.rst
index 84206537aedb..1463cb52ae54 100644
--- a/Documentation/networking/devlink/octeontx2.rst
+++ b/Documentation/networking/devlink/octeontx2.rst
@@ -77,3 +77,12 @@ The ``octeontx2 PF`` driver implements the following driver-specific parameters.
      - Set the maximum number of unicast filters that can be programmed for
        the device. This can be used to achieve better device resource
        utilization, avoiding over consumption of unused MCAM table entries.
+   * - ``mac_stats_reset``
+     - bool
+     - runtime
+     - One-shot trigger to reset CGX/RPM MAC hardware statistics.
+       Write true to reset the counters; reading this parameter always returns
+       false. Supported only on CGX/RPM mapped PF netdevs. The reset fails with
+       ``-EBUSY`` when the CGX port is in use by more than one interface, such
+       as when the PF netdev and one or more VF netdevs are active. Other
+       failures return ``-EIO``.
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 87d21889dc49..7e09ca25101d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -649,7 +649,7 @@ int rvu_mbox_handler_cgx_stats_rst(struct rvu *rvu, struct msg_req *req,
 	 */
 	if (parent_pf->cgx_users > 1) {
 		dev_info(rvu->dev, "CGX busy, could not reset statistics\n");
-		return 0;
+		return -EBUSY;
 	}
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4a5ce0e67dda..daa8fb37f392 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -125,10 +125,43 @@ static int otx2_dl_ucast_flt_cnt_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int otx2_dl_mac_stats_reset_get(struct devlink *devlink, u32 id,
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
+{
+	/* This is a one-shot trigger, so it has no state */
+	ctx->val.vbool = false;
+	return 0;
+}
+
+static int otx2_dl_mac_stats_reset_set(struct devlink *devlink, u32 id,
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	int err;
+
+	if (!ctx->val.vbool)
+		return 0;
+
+	err = otx2_reset_mac_stats(pfvf);
+	if (err == -EBUSY) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "CGX port shared by multiple interfaces, cannot reset MAC stats");
+		return -EBUSY;
+	} else if (err) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
 enum otx2_dl_param_id {
 	OTX2_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_DEVLINK_PARAM_ID_MCAM_COUNT,
 	OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
+	OTX2_DEVLINK_PARAM_ID_MAC_STATS_RST,
 };
 
 static const struct devlink_param otx2_dl_params[] = {
@@ -142,6 +175,12 @@ static const struct devlink_param otx2_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     otx2_dl_ucast_flt_cnt_get, otx2_dl_ucast_flt_cnt_set,
 			     otx2_dl_ucast_flt_cnt_validate),
+	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_MAC_STATS_RST,
+			     "mac_stats_reset", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_dl_mac_stats_reset_get,
+			     otx2_dl_mac_stats_reset_set,
+			     NULL),
 };
 
 #ifdef CONFIG_RVU_ESWITCH
-- 
2.48.1

