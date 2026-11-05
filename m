Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884793;
	b=00uUHmIAZfFaG8rFY/abWCbX37lBic5y+st0DO9LAX3nta5K/DGm8u17qfxxiWMPVRWS
	 CmrxRQgp2pZwRWeQ5h7UPzYqgzNwxQAQT3GSl0fyRmIa2+bmVuAEHeCks1JG6H7/1Bg4E
	 S3l+4mpjhNgTZwtYfVeOeCWliklLos8vEkmvB8xeuVanYzgQQJ3wSB7lO1t9jx2wWamfg
	 j2n/ashXCnr2wm1hWr04Cgqt5cSSq+AIn8TCAoa7DOBH6/knMZwN74wnfWBu+S1yXNt0J
	 ybZ6+aOSjMsA/7HZbQG8BA6dfN3k+3FULcwp2CD7sqR3BfalEw4yGgz56Bd+Ozf+J0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884793;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=jOzcNOCXsZw9GBo68EteljZLCQUWx+mYfOI1+N6fGLw=;
	b=FeFeKyp+BNAZ7slQZYhyjq/F0YVZPpaGHtkZbrAAW0dUao6A5Z1X4jEs2GE+XrKWzgAR
	 3WDy3byEsMAH91Q5UMPOKSBE7iXEmytifO7G4G1TJqymRsvIlfr1Vt0rYzjKX7+PZpFUs
	 JOiSSMTU6A50pfpgZ0WZcvc0wW5z6rUGYe77VrQf8SGG1E8ruoGbUs42jDL++1DAe4X0v
	 dbYpqsxnBxm8fGFdrSRuSp7AcG1Zkw+bQ/78Cv1kN3XqVAQ22OCOU5aVSleS17uhGWTQ1
	 LOGzkTJ3vWvD4uHlXzEsqkMbRU2SeQOSFVkfKJxZN3oKJTI9kyVxuiWZwEaQW5KmJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=lfWArwRN;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE93606A332;
	Thu,  5 Nov 2026 13:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE93606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=lfWArwRN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793884793; x=1825420793;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9kKNX21gIxuuwn3cG5eWlinoOGPTdfcBaKnMy7wtyTg=;
  b=lfWArwRNTLrSR8g9th4criD9gsLifEchhJTzZcVWsYUKjI4LHG6QIYtI
   pFuiSsJWSWxIXXnNK5XhmUfiwxgoMdZsrv0cfbGCebiSzzQ79f/H09RRu
   kCIFc6iGst3qdaZM/88b7r/24CWWhi31y+Q8kqZxqr2+lxUMwcB+TktcE
   xEFnpawaxceNJEgJdKFD3faxNazS3Dzb0xfdvO+mHtabQm3CyX7ez4Xb0
   EuHsbVv2fpo7h9PJV4Mn+Lhx2/fuA2fiKjHHoNIItA4olrLi2ewgG2pcK
   aD6MzZJllqjuvqfkD0Qyyb2VsqwyPLmsk7gFZHaJzK1ZwK/EYlWr5lEYf
   Q==;
X-CSE-ConnectionGUID: Zs7CKJcjQVOoY6yduItvYA==
X-CSE-MsgGUID: Nr1lq1vJRLmuP167nOZUjw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="65110995"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:19:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:19:52 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:19:49 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:19:36 +0100
Subject: [PATCH net-next v3 2/5] net: sparx5: Add registers used by the
 port policer
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-2-b45a3a26bed5@microchip.com>
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
In-Reply-To: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
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
index 175fcf8bdd61c..5650550d4294d 100644
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
@@ -121,6 +126,7 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_ANA_ACL_KEY_SEL] = 99,
 	[GC_ANA_ACL_CNT_A] = 1024,
 	[GC_ANA_ACL_CNT_B] = 1024,
+	[GC_ANA_AC_POL_POL_PORT_CTRL] = 35,
 	[GC_ANA_AC_SDLB_LBGRP_TBL] = 5,
 	[GC_ANA_AC_SDLB_LBSET_TBL] = 496,
 	[GC_ANA_CL_PORT] = 35,
@@ -186,6 +192,7 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_ANA_AC_TSN_SF_STATUS_TSN_SFID] = 8,
 	[FW_ANA_AC_SG_ACCESS_CTRL_SGID] = 8,
 	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 17,
+	[FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE] = 19,
 	[FW_ANA_AC_SDLB_XLB_START_LBSET_START] = 9,
 	[FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT] = 3,
 	[FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT] = 9,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 219c7f0e516e9..1bf7dabf622e6 100644
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
index 75c1bd4f0053c..ce5f0bbf0e65b 100644
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
@@ -121,6 +126,7 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_ANA_ACL_KEY_SEL] = 134,
 	[GC_ANA_ACL_CNT_A] = 4096,
 	[GC_ANA_ACL_CNT_B] = 4096,
+	[GC_ANA_AC_POL_POL_PORT_CTRL] = 70,
 	[GC_ANA_AC_SDLB_LBGRP_TBL] = 10,
 	[GC_ANA_AC_SDLB_LBSET_TBL] = 4616,
 	[GC_ANA_CL_PORT] = 70,
@@ -186,6 +192,7 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_ANA_AC_TSN_SF_STATUS_TSN_SFID] = 10,
 	[FW_ANA_AC_SG_ACCESS_CTRL_SGID] = 10,
 	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 16,
+	[FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE] = 20,
 	[FW_ANA_AC_SDLB_XLB_START_LBSET_START] = 13,
 	[FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT] = 5,
 	[FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT] = 13,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index 97d496ebb7508..17abaa5798cbe 100644
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
@@ -131,6 +136,7 @@ enum sparx5_gcnt_enum {
 	GC_ANA_ACL_KEY_SEL,
 	GC_ANA_ACL_CNT_A,
 	GC_ANA_ACL_CNT_B,
+	GC_ANA_AC_POL_POL_PORT_CTRL,
 	GC_ANA_AC_SDLB_LBGRP_TBL,
 	GC_ANA_AC_SDLB_LBSET_TBL,
 	GC_ANA_CL_PORT,
@@ -199,6 +205,7 @@ enum sparx5_fsize_enum {
 	FW_ANA_AC_TSN_SF_STATUS_TSN_SFID,
 	FW_ANA_AC_SG_ACCESS_CTRL_SGID,
 	FW_ANA_AC_PORT_SGE_CFG_MASK,
+	FW_ANA_AC_POL_PORT_RATE_CFG_PORT_RATE,
 	FW_ANA_AC_SDLB_XLB_START_LBSET_START,
 	FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT,
 	FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT,

-- 
2.34.1

