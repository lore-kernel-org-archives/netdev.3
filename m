Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62744CCDEC;
	Fri,  9 Oct 2026 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546851; cv=none; b=h52CkXdoGr/+D/YDpXlSZF/vK00O+iuZbJN/WcB8yL3WQc62/9IVx47iuBv7A6fCNv0lgr1YIOZPQildR3QFJ8Yiy1hCo7r7EpjZGrevLDFf4hw+N2zvBnm6gXuHiBRe4MgXitisYsEslIgMZDAahsLf15SuePxW8lipYLdYQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546851; c=relaxed/simple;
	bh=Muf4eTZjWTRQViJhVwEpnl6gA3ibKcyLmoXGsME+l4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mvR6lhcbGc3A4I85nK73Ao6KfkNpbh+PFGFx6vdsysOTqDz5Y/ozh8jj771BJaA5eYnlXl/fJMu5xPpIDFJasKzD65WlkkItkfFgb5Fy+J+6APiJ5ALRKv3qt/CLZcy7PTPFxs0F6yGI4EoVOUFucMaxuWLXhI6BrikckXI9exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bHWmPyI5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bHWmPyI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791546844; x=1823082844;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Muf4eTZjWTRQViJhVwEpnl6gA3ibKcyLmoXGsME+l4Q=;
  b=bHWmPyI52OdBWGdJ9jpOLQBodINd4a5jT1dBolaHWkIynT8NYu/G13dJ
   6Ct5+ci+fBTdlrHwwGFQYH+pjOyc+GNWzomHLq+ZBi0zXVaTBfYkZPvFO
   5PwBsjaPIuFz8cHtCb1Gy4betAY7t4HxzA11MVCtQDo5j7KjR1+saTJ3/
   /vJtZcY945K1ZTFfxWCcB2SK/faneMRlPMFNSEl6EHUJW43h1e0C+ZbZK
   Tuo5X5vip+EplCik6qcSFJAIZ07tYH0BJECOUos+9+F1oEb/uyV1z9E1y
   gs0u2exPO4qd7Rx4L52cCHKa0miNO9owMNicURMA6XwHFuiN69qYWIW5a
   g==;
X-CSE-ConnectionGUID: 7XIxRreZQpWqdKmhiMymwA==
X-CSE-MsgGUID: MSWhVsDNQHuhusO57ocGjA==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="75126491"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 9 Oct 2026 04:54:03 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 04:54:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 9 Oct 2026 13:52:02 +0200
Subject: [PATCH net-next 2/5] net: sparx5: Add registers used by the port
 policer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-2-4916708a7ea2@microchip.com>
References: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
In-Reply-To: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14.3

Add the registers used to configure the ingress port policers and to
read back their statistics, on both sparx5 and lan969x: the
POL_PORT_CFG and POL_PORT_CTRL groups of ANA_AC_POL, the shared
POL_ALL_CFG register, and the MSB part of the ANA_AC port statistics
counters.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_regs.c        |   7 ++
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 105 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   7 ++
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   7 ++
 4 files changed, 126 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
index 3fc2c006ba12..4d82dba7d081 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
@@ -28,6 +28,9 @@ const unsigned int lan969x_rcnt[RCNT_LAST] = {
 	[RC_ANA_AC_OWN_UPSID] = 1,
 	[RC_ANA_ACL_VCAP_S2_CFG] = 35,
 	[RC_ANA_ACL_OWN_UPSID] = 1,
+	[RC_ANA_AC_POL_PORT_THRES_CFG_0] = 140,
+	[RC_ANA_AC_POL_PORT_THRES_CFG_1] = 140,
+	[RC_ANA_AC_POL_PORT_RATE_CFG] = 140,
 	[RC_ANA_CL_OWN_UPSID] = 1,
 	[RC_ANA_L2_OWN_UPSID] = 1,
 	[RC_ASM_PORT_CFG] = 32,
@@ -70,6 +73,8 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_ANA_ACL_CNT_B] = 4096,
 	[GA_ANA_ACL_STICKY] = 10852,
 	[GA_ANA_AC_POL_POL_ALL_CFG] = 17504,
+	[GA_ANA_AC_POL_POL_PORT_CFG] = 0,
+	[GA_ANA_AC_POL_POL_PORT_CTRL] = 16384,
 	[GA_ANA_AC_POL_COMMON_BDLB] = 19464,
 	[GA_ANA_AC_POL_COMMON_BUM_SLB] = 19472,
 	[GA_ANA_AC_SDLB_LBGRP_TBL] = 31788,
@@ -118,6 +123,7 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_ANA_ACL_KEY_SEL] = 99,
 	[GC_ANA_ACL_CNT_A] = 1024,
 	[GC_ANA_ACL_CNT_B] = 1024,
+	[GC_ANA_AC_POL_POL_PORT_CTRL] = 35,
 	[GC_ANA_AC_SDLB_LBGRP_TBL] = 5,
 	[GC_ANA_AC_SDLB_LBSET_TBL] = 496,
 	[GC_ANA_CL_PORT] = 35,
@@ -182,6 +188,7 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_ANA_AC_TSN_SF_STATUS_TSN_SFID] = 8,
 	[FW_ANA_AC_SG_ACCESS_CTRL_SGID] = 8,
 	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 17,
+	[FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE] = 19,
 	[FW_ANA_AC_SDLB_XLB_START_LBSET_START] = 9,
 	[FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT] = 3,
 	[FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT] = 9,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 7ae4f7ed8e50..37a020354c37 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -554,6 +554,17 @@ extern const struct sparx5_regs *regs;
 	__REG(TARGET_ANA_AC, 0, 1, regs->gaddr[GA_ANA_AC_STAT_CNT_CFG_PORT], g,\
 	      regs->gcnt[GC_ANA_AC_STAT_CNT_CFG_PORT], 64, 20, r, 4, 4)
 
+/* ANA_AC:STAT_CNT_CFG_PORT:STAT_MSB_CNT */
+#define ANA_AC_PORT_STAT_MSB_CNT(g, r)                                         \
+	__REG(TARGET_ANA_AC, 0, 1, regs->gaddr[GA_ANA_AC_STAT_CNT_CFG_PORT], g,\
+	      regs->gcnt[GC_ANA_AC_STAT_CNT_CFG_PORT], 64, 36, r, 4, 4)
+
+#define ANA_AC_PORT_STAT_MSB_CNT_MSB_CNT         GENMASK(7, 0)
+#define ANA_AC_PORT_STAT_MSB_CNT_MSB_CNT_SET(x)\
+	FIELD_PREP(ANA_AC_PORT_STAT_MSB_CNT_MSB_CNT, x)
+#define ANA_AC_PORT_STAT_MSB_CNT_MSB_CNT_GET(x)\
+	FIELD_GET(ANA_AC_PORT_STAT_MSB_CNT_MSB_CNT, x)
+
 /* ANA_AC:STAT_GLOBAL_CFG_ACL:GLOBAL_CNT_FRM_TYPE_CFG */
 #define ANA_AC_ACL_GLOBAL_CNT_FRM_TYPE_CFG(r)                                  \
 	__REG(TARGET_ANA_AC, 0, 1, regs->gaddr[GA_ANA_AC_STAT_GLOBAL_CFG_ACL], \
@@ -938,6 +949,35 @@ extern const struct sparx5_regs *regs;
 #define ANA_ACL_SEC_LOOKUP_STICKY_SEC_TYPE_MAC_ETYPE_STICKY_GET(x)\
 	FIELD_GET(ANA_ACL_SEC_LOOKUP_STICKY_SEC_TYPE_MAC_ETYPE_STICKY, x)
 
+/* ANA_AC_POL:POL_ALL_CFG:POL_ALL_CFG */
+#define ANA_AC_POL_ALL_CFG                                                     \
+	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_ALL_CFG],\
+	      0, 1, 1160, 1144, 0, 1, 4)
+
+#define ANA_AC_POL_ALL_CFG_PORT_FC_ENA            BIT(14)
+#define ANA_AC_POL_ALL_CFG_PORT_FC_ENA_SET(x)\
+	FIELD_PREP(ANA_AC_POL_ALL_CFG_PORT_FC_ENA, x)
+#define ANA_AC_POL_ALL_CFG_PORT_FC_ENA_GET(x)\
+	FIELD_GET(ANA_AC_POL_ALL_CFG_PORT_FC_ENA, x)
+
+#define ANA_AC_POL_ALL_CFG_ACL_FORCE_INIT          BIT(4)
+#define ANA_AC_POL_ALL_CFG_ACL_FORCE_INIT_SET(x)\
+	FIELD_PREP(ANA_AC_POL_ALL_CFG_ACL_FORCE_INIT, x)
+#define ANA_AC_POL_ALL_CFG_ACL_FORCE_INIT_GET(x)\
+	FIELD_GET(ANA_AC_POL_ALL_CFG_ACL_FORCE_INIT, x)
+
+#define ANA_AC_POL_ALL_CFG_LPORT_POLICE_ENA        BIT(1)
+#define ANA_AC_POL_ALL_CFG_LPORT_POLICE_ENA_SET(x)\
+	FIELD_PREP(ANA_AC_POL_ALL_CFG_LPORT_POLICE_ENA, x)
+#define ANA_AC_POL_ALL_CFG_LPORT_POLICE_ENA_GET(x)\
+	FIELD_GET(ANA_AC_POL_ALL_CFG_LPORT_POLICE_ENA, x)
+
+#define ANA_AC_POL_ALL_CFG_FORCE_INIT              BIT(0)
+#define ANA_AC_POL_ALL_CFG_FORCE_INIT_SET(x)\
+	FIELD_PREP(ANA_AC_POL_ALL_CFG_FORCE_INIT, x)
+#define ANA_AC_POL_ALL_CFG_FORCE_INIT_GET(x)\
+	FIELD_GET(ANA_AC_POL_ALL_CFG_FORCE_INIT, x)
+
 /* ANA_AC_POL:POL_ALL_CFG:POL_UPD_INT_CFG */
 #define ANA_AC_POL_UPD_INT_CFG                                                 \
 	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_ALL_CFG], \
@@ -949,6 +989,71 @@ extern const struct sparx5_regs *regs;
 #define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_GET(x)\
 	FIELD_GET(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT, x)
 
+/* ANA_AC_POL:POL_PORT_CFG:POL_PORT_THRES_CFG_0 */
+#define ANA_AC_POL_PORT_THRES_CFG_0(r)                                         \
+	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_PORT_CFG],\
+	      0, 1, 8192, 0, r, regs->rcnt[RC_ANA_AC_POL_PORT_THRES_CFG_0], 4)
+
+#define ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0   GENMASK(5, 0)
+#define ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0_SET(x)\
+	FIELD_PREP(ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0, x)
+#define ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0_GET(x)\
+	FIELD_GET(ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0, x)
+
+/* ANA_AC_POL:POL_PORT_CFG:POL_PORT_THRES_CFG_1 */
+#define ANA_AC_POL_PORT_THRES_CFG_1(r)                                         \
+	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_PORT_CFG],\
+	      0, 1, 8192, 2048, r,\
+	      regs->rcnt[RC_ANA_AC_POL_PORT_THRES_CFG_1], 4)
+
+#define ANA_AC_POL_PORT_THRES_CFG_1_PORT_THRES1   GENMASK(5, 0)
+#define ANA_AC_POL_PORT_THRES_CFG_1_PORT_THRES1_SET(x)\
+	FIELD_PREP(ANA_AC_POL_PORT_THRES_CFG_1_PORT_THRES1, x)
+#define ANA_AC_POL_PORT_THRES_CFG_1_PORT_THRES1_GET(x)\
+	FIELD_GET(ANA_AC_POL_PORT_THRES_CFG_1_PORT_THRES1, x)
+
+/* ANA_AC_POL:POL_PORT_CFG:POL_PORT_RATE_CFG */
+#define ANA_AC_POL_PORT_RATE_CFG(r)                                            \
+	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_PORT_CFG],\
+	      0, 1, 8192, 4096, r, regs->rcnt[RC_ANA_AC_POL_PORT_RATE_CFG], 4)
+
+#define ANA_AC_POL_PORT_RATE_CFG_PORT_RATE\
+	GENMASK(regs->fsize[FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE] + 0 - 1, 0)
+#define ANA_AC_POL_PORT_RATE_CFG_PORT_RATE_SET(x)\
+	spx5_field_prep(ANA_AC_POL_PORT_RATE_CFG_PORT_RATE, x)
+#define ANA_AC_POL_PORT_RATE_CFG_PORT_RATE_GET(x)\
+	spx5_field_get(ANA_AC_POL_PORT_RATE_CFG_PORT_RATE, x)
+
+/* ANA_AC_POL:POL_PORT_CTRL:POL_PORT_GAP */
+#define ANA_AC_POL_PORT_GAP(g)                                                 \
+	__REG(TARGET_ANA_AC_POL, 0, 1,\
+	      regs->gaddr[GA_ANA_AC_POL_POL_PORT_CTRL], g,                     \
+	      regs->gcnt[GC_ANA_AC_POL_POL_PORT_CTRL], 32, 0, 0, 1, 4)
+
+#define ANA_AC_POL_PORT_GAP_PORT_PIPELINE_PT       GENMASK(11, 7)
+#define ANA_AC_POL_PORT_GAP_PORT_PIPELINE_PT_SET(x)\
+	FIELD_PREP(ANA_AC_POL_PORT_GAP_PORT_PIPELINE_PT, x)
+#define ANA_AC_POL_PORT_GAP_PORT_PIPELINE_PT_GET(x)\
+	FIELD_GET(ANA_AC_POL_PORT_GAP_PORT_PIPELINE_PT, x)
+
+#define ANA_AC_POL_PORT_GAP_GAP_VALUE              GENMASK(6, 0)
+#define ANA_AC_POL_PORT_GAP_GAP_VALUE_SET(x)\
+	FIELD_PREP(ANA_AC_POL_PORT_GAP_GAP_VALUE, x)
+#define ANA_AC_POL_PORT_GAP_GAP_VALUE_GET(x)\
+	FIELD_GET(ANA_AC_POL_PORT_GAP_GAP_VALUE, x)
+
+/* ANA_AC_POL:POL_PORT_CTRL:POL_PORT_CFG */
+#define ANA_AC_POL_PORT_CFG(g, r)                                              \
+	__REG(TARGET_ANA_AC_POL, 0, 1,\
+	      regs->gaddr[GA_ANA_AC_POL_POL_PORT_CTRL], g,                     \
+	      regs->gcnt[GC_ANA_AC_POL_POL_PORT_CTRL], 32, 4, r, 4, 4)
+
+#define ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK      GENMASK(7, 0)
+#define ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK_SET(x)\
+	FIELD_PREP(ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK, x)
+#define ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK_GET(x)\
+	FIELD_GET(ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK, x)
+
 /* ANA_AC_POL:COMMON_BDLB:DLB_CTRL */
 #define ANA_AC_POL_BDLB_DLB_CTRL                                               \
 	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_COMMON_BDLB], \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index 3863f954bd83..38e68f5d445f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -28,6 +28,9 @@ const unsigned int sparx5_rcnt[RCNT_LAST] = {
 	[RC_ANA_AC_OWN_UPSID] = 3,
 	[RC_ANA_ACL_VCAP_S2_CFG] = 70,
 	[RC_ANA_ACL_OWN_UPSID] = 3,
+	[RC_ANA_AC_POL_PORT_THRES_CFG_0] = 280,
+	[RC_ANA_AC_POL_PORT_THRES_CFG_1] = 280,
+	[RC_ANA_AC_POL_PORT_RATE_CFG] = 280,
 	[RC_ANA_CL_OWN_UPSID] = 3,
 	[RC_ANA_L2_OWN_UPSID] = 3,
 	[RC_ASM_PORT_CFG] = 67,
@@ -70,6 +73,8 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_ANA_ACL_CNT_B] = 16384,
 	[GA_ANA_ACL_STICKY] = 36408,
 	[GA_ANA_AC_POL_POL_ALL_CFG] = 75968,
+	[GA_ANA_AC_POL_POL_PORT_CFG] = 65536,
+	[GA_ANA_AC_POL_POL_PORT_CTRL] = 73728,
 	[GA_ANA_AC_POL_COMMON_BDLB] = 79048,
 	[GA_ANA_AC_POL_COMMON_BUM_SLB] = 79056,
 	[GA_ANA_AC_SDLB_LBGRP_TBL] = 295468,
@@ -118,6 +123,7 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_ANA_ACL_KEY_SEL] = 134,
 	[GC_ANA_ACL_CNT_A] = 4096,
 	[GC_ANA_ACL_CNT_B] = 4096,
+	[GC_ANA_AC_POL_POL_PORT_CTRL] = 70,
 	[GC_ANA_AC_SDLB_LBGRP_TBL] = 10,
 	[GC_ANA_AC_SDLB_LBSET_TBL] = 4616,
 	[GC_ANA_CL_PORT] = 70,
@@ -182,6 +188,7 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_ANA_AC_TSN_SF_STATUS_TSN_SFID] = 10,
 	[FW_ANA_AC_SG_ACCESS_CTRL_SGID] = 10,
 	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 16,
+	[FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE] = 20,
 	[FW_ANA_AC_SDLB_XLB_START_LBSET_START] = 13,
 	[FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT] = 5,
 	[FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT] = 13,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index 585589a31e90..917183d8e147 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -36,6 +36,9 @@ enum sparx5_rcnt_enum {
 	RC_ANA_AC_OWN_UPSID,
 	RC_ANA_ACL_VCAP_S2_CFG,
 	RC_ANA_ACL_OWN_UPSID,
+	RC_ANA_AC_POL_PORT_THRES_CFG_0,
+	RC_ANA_AC_POL_PORT_THRES_CFG_1,
+	RC_ANA_AC_POL_PORT_RATE_CFG,
 	RC_ANA_CL_OWN_UPSID,
 	RC_ANA_L2_OWN_UPSID,
 	RC_ASM_PORT_CFG,
@@ -79,6 +82,8 @@ enum sparx5_gaddr_enum {
 	GA_ANA_ACL_CNT_B,
 	GA_ANA_ACL_STICKY,
 	GA_ANA_AC_POL_POL_ALL_CFG,
+	GA_ANA_AC_POL_POL_PORT_CFG,
+	GA_ANA_AC_POL_POL_PORT_CTRL,
 	GA_ANA_AC_POL_COMMON_BDLB,
 	GA_ANA_AC_POL_COMMON_BUM_SLB,
 	GA_ANA_AC_SDLB_LBGRP_TBL,
@@ -128,6 +133,7 @@ enum sparx5_gcnt_enum {
 	GC_ANA_ACL_KEY_SEL,
 	GC_ANA_ACL_CNT_A,
 	GC_ANA_ACL_CNT_B,
+	GC_ANA_AC_POL_POL_PORT_CTRL,
 	GC_ANA_AC_SDLB_LBGRP_TBL,
 	GC_ANA_AC_SDLB_LBSET_TBL,
 	GC_ANA_CL_PORT,
@@ -195,6 +201,7 @@ enum sparx5_fsize_enum {
 	FW_ANA_AC_TSN_SF_STATUS_TSN_SFID,
 	FW_ANA_AC_SG_ACCESS_CTRL_SGID,
 	FW_ANA_AC_PORT_SGE_CFG_MASK,
+	FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE,
 	FW_ANA_AC_SDLB_XLB_START_LBSET_START,
 	FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT,
 	FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT,

-- 
2.34.1

