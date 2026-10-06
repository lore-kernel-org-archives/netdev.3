Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA746AA62;
	Tue,  6 Oct 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294690; cv=none; b=VimOYO3Y03LUkSY94yaA49qiKHSvyyioCbZ7Xc0eg3PxcrcScIARKbqRA7XTi21/LLxJlg/lULh69iNjARFdVXDNuRoqPb/7nIjuF0BOBjo0rmfVKDhCXHs5Nc0xBft2M40flugzxS9J3psVax+rjaRAvzSZiezkiuiKdIdZsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294690; c=relaxed/simple;
	bh=m6FE9cL1x7aH7ONN3OH7lKbPDZrNTsqNSnvD3j828ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZlOETjy9r3MovemgSVfc6Pa4xuzTqUHSNVc8zvPQVFTNiUv+Crj81yEIAxSC/49tcsN5ecpGpgRVk+Ta77RbHJj5YrvCDCUup8hAD8AJkQyskMqXqdPU56tdcl8TKzZHVyE1g32KjPcp/dU3YWYS5FalCJat1UzrgYfYkSeSQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KBd3R94s; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KBd3R94s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791294693; x=1822830693;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=m6FE9cL1x7aH7ONN3OH7lKbPDZrNTsqNSnvD3j828ms=;
  b=KBd3R94sBuDnQXYzb5auHQcEyEUdhTLzGAJASdXdnsPHLXpcJ34P4Rau
   IxcZ0qdPOQ+4AMaxD4ylBoG5wqAcUpB7YJeAMz2Yndga0rfiyzEfgCYJo
   T1z6eaQIiJf8Q7PyTTxqlj1GygAa70ZOIlbeYMQstvWefpgc7/EE8z0Pe
   XByg3D/0ssdarM7BINmfUFT9sekYH62ICxhsrltcGg1okNG+86iRxDrHB
   posxys7HP8DGBPv0CVFkmqbW8hcwzVxFCyUCqU0TNRMmk6dorUdixZ/nz
   YVILH0O8ksCa+shkKEfKbZ6ygfLr7+ec1RhMwQvhqQsF+wbm0jLaSyg3o
   A==;
X-CSE-ConnectionGUID: h4q83h5oSveAlzBQtAGwZw==
X-CSE-MsgGUID: AN5fj3fGRImZ0EnZWku6CA==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="64936500"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 06:51:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 6 Oct 2026 06:51:26 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 06:51:24 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 6 Oct 2026 15:51:06 +0200
Subject: [PATCH net-next 1/3] net: sparx5: Add registers used by TAS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-sparx5-tas-v1-1-5eef1126dfd5@microchip.com>
References: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
In-Reply-To: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

Add the registers and offset definitions used to configure the Time
Aware Shaper (802.1Qbv) in hardware, on both sparx5 and lan969x.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_regs.c        |  10 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 204 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  10 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  10 +
 4 files changed, 234 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
index 3fc2c006ba12..175fcf8bdd61 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
@@ -96,6 +96,9 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_HSCH_MMGT] = 36260,
 	[GA_HSCH_TAS_CONFIG] = 37696,
 	[GA_HSCH_TAS_PROFILE_CFG] = 37712,
+	[GA_HSCH_TAS_LIST_CFG] = 36288,
+	[GA_HSCH_TAS_GCL_CFG] = 36240,
+	[GA_HSCH_HSCH_TAS_STATE] = 36256,
 	[GA_PTP_PTP_CFG] = 512,
 	[GA_PTP_PTP_TOD_DOMAINS] = 528,
 	[GA_PTP_PHASE_DETECTOR_CTRL] = 628,
@@ -147,6 +150,7 @@ const unsigned int lan969x_gsize[GSIZE_LAST] = {
 	[GW_GCB_CHIP_REGS] = 180,
 	[GW_HSCH_TAS_CONFIG] = 16,
 	[GW_HSCH_TAS_PROFILE_CFG] = 68,
+	[GW_HSCH_TAS_GCL_CFG] = 16,
 	[GW_PTP_PHASE_DETECTOR_CTRL] = 12,
 	[GW_QSYS_PAUSE_CFG] = 988,
 };
@@ -201,6 +205,12 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_HSCH_HSCH_LEAK_CFG_LEAK_FIRST] = 14,
 	[FW_HSCH_FLUSH_CTRL_FLUSH_PORT] = 6,
 	[FW_HSCH_FLUSH_CTRL_FLUSH_HIER] = 14,
+	[FW_HSCH_TAS_CFG_CTRL_LIST_NUM_MAX] = 6,
+	[FW_HSCH_TAS_CFG_CTRL_LIST_NUM] = 6,
+	[FW_HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM] = 12,
+	[FW_HSCH_TAS_GATE_STATE_CTRL_HSCH_POS] = 11,
+	[FW_HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX] = 6,
+	[FW_HSCH_TAS_LIST_CFG_LIST_BASE_ADDR] = 12,
 	[FW_LRN_COMMON_ACCESS_CTRL_CPU_ACCESS_DIRECT_ROW] = 13,
 	[FW_LRN_MAC_ACCESS_CFG_3_MAC_ENTRY_ISDX_LIMIT_IDX] = 8,
 	[FW_LRN_AUTOAGE_CFG_2_NEXT_ROW] = 13,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index d34467513648..1464fd1a1d44 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -5358,6 +5358,50 @@ extern const struct sparx5_regs *regs;
 #define HSCH_RESET_CFG_CORE_ENA_GET(x)\
 	FIELD_GET(HSCH_RESET_CFG_CORE_ENA, x)
 
+/* HSCH:TAS_CONFIG:TAS_CFG_CTRL */
+#define HSCH_TAS_CFG_CTRL                                                      \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_CONFIG], 0, 1,        \
+	      regs->gsize[GW_HSCH_TAS_CONFIG], 0, 0, 1, 4)
+
+#define HSCH_TAS_CFG_CTRL_LIST_NUM_MAX\
+	GENMASK(regs->fsize[FW_HSCH_TAS_CFG_CTRL_LIST_NUM_MAX] + 22 - 1, 22)
+#define HSCH_TAS_CFG_CTRL_LIST_NUM_MAX_SET(x)\
+	spx5_field_prep(HSCH_TAS_CFG_CTRL_LIST_NUM_MAX, x)
+#define HSCH_TAS_CFG_CTRL_LIST_NUM_MAX_GET(x)\
+	spx5_field_get(HSCH_TAS_CFG_CTRL_LIST_NUM_MAX, x)
+
+#define HSCH_TAS_CFG_CTRL_LIST_NUM\
+	GENMASK(regs->fsize[FW_HSCH_TAS_CFG_CTRL_LIST_NUM] + 15 - 1, 15)
+#define HSCH_TAS_CFG_CTRL_LIST_NUM_SET(x)\
+	spx5_field_prep(HSCH_TAS_CFG_CTRL_LIST_NUM, x)
+#define HSCH_TAS_CFG_CTRL_LIST_NUM_GET(x)\
+	spx5_field_get(HSCH_TAS_CFG_CTRL_LIST_NUM, x)
+
+#define HSCH_TAS_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q BIT(14)
+#define HSCH_TAS_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q_SET(x)\
+	FIELD_PREP(HSCH_TAS_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q, x)
+#define HSCH_TAS_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q_GET(x)\
+	FIELD_GET(HSCH_TAS_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q, x)
+
+#define HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM\
+	GENMASK(regs->fsize[FW_HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM] + 0 - 1, 0)
+#define HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM_SET(x)\
+	spx5_field_prep(HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM, x)
+#define HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM_GET(x)\
+	spx5_field_get(HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM, x)
+
+/* HSCH:TAS_CONFIG:TAS_GATE_STATE_CTRL */
+#define HSCH_TAS_GATE_STATE_CTRL                                               \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_CONFIG], 0, 1,        \
+	      regs->gsize[GW_HSCH_TAS_CONFIG], 4, 0, 1, 4)
+
+#define HSCH_TAS_GATE_STATE_CTRL_HSCH_POS\
+	GENMASK(regs->fsize[FW_HSCH_TAS_GATE_STATE_CTRL_HSCH_POS] + 0 - 1, 0)
+#define HSCH_TAS_GATE_STATE_CTRL_HSCH_POS_SET(x)\
+	spx5_field_prep(HSCH_TAS_GATE_STATE_CTRL_HSCH_POS, x)
+#define HSCH_TAS_GATE_STATE_CTRL_HSCH_POS_GET(x)\
+	spx5_field_get(HSCH_TAS_GATE_STATE_CTRL_HSCH_POS, x)
+
 /* HSCH:TAS_CONFIG:TAS_STATEMACHINE_CFG */
 #define HSCH_TAS_STATEMACHINE_CFG                                              \
 	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_CONFIG], 0, 1,        \
@@ -5375,12 +5419,172 @@ extern const struct sparx5_regs *regs;
 	      regs->gcnt[GC_HSCH_TAS_PROFILE_CFG],                              \
 	      regs->gsize[GW_HSCH_TAS_PROFILE_CFG], 32, 0, 1, 4)
 
+/* SPARX5 ONLY */
+#define HSCH_TAS_PROFILE_CONFIG_PORT_NUM         GENMASK(17, 11)
+#define HSCH_TAS_PROFILE_CONFIG_PORT_NUM_SET(x)\
+	FIELD_PREP(HSCH_TAS_PROFILE_CONFIG_PORT_NUM, x)
+#define HSCH_TAS_PROFILE_CONFIG_PORT_NUM_GET(x)\
+	FIELD_GET(HSCH_TAS_PROFILE_CONFIG_PORT_NUM, x)
+
 #define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED       GENMASK(10, 8)
 #define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_SET(x)\
 	FIELD_PREP(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED, x)
 #define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_GET(x)\
 	FIELD_GET(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED, x)
 
+/* HSCH:TAS_LIST_CFG:TAS_BASE_TIME_NSEC */
+#define HSCH_TAS_BASE_TIME_NSEC                                                \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      0, 0, 1, 4)
+
+#define HSCH_TAS_BASE_TIME_NSEC_BASE_TIME_NSEC   GENMASK(29, 0)
+#define HSCH_TAS_BASE_TIME_NSEC_BASE_TIME_NSEC_SET(x)\
+	FIELD_PREP(HSCH_TAS_BASE_TIME_NSEC_BASE_TIME_NSEC, x)
+#define HSCH_TAS_BASE_TIME_NSEC_BASE_TIME_NSEC_GET(x)\
+	FIELD_GET(HSCH_TAS_BASE_TIME_NSEC_BASE_TIME_NSEC, x)
+
+/* HSCH:TAS_LIST_CFG:TAS_BASE_TIME_SEC_LSB */
+#define HSCH_TAS_BASE_TIME_SEC_LSB                                             \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      4, 0, 1, 4)
+
+/* HSCH:TAS_LIST_CFG:TAS_BASE_TIME_SEC_MSB */
+#define HSCH_TAS_BASE_TIME_SEC_MSB                                             \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      8, 0, 1, 4)
+
+#define HSCH_TAS_BASE_TIME_SEC_MSB_BASE_TIME_SEC_MSB GENMASK(15, 0)
+#define HSCH_TAS_BASE_TIME_SEC_MSB_BASE_TIME_SEC_MSB_SET(x)\
+	FIELD_PREP(HSCH_TAS_BASE_TIME_SEC_MSB_BASE_TIME_SEC_MSB, x)
+#define HSCH_TAS_BASE_TIME_SEC_MSB_BASE_TIME_SEC_MSB_GET(x)\
+	FIELD_GET(HSCH_TAS_BASE_TIME_SEC_MSB_BASE_TIME_SEC_MSB, x)
+
+/* HSCH:TAS_LIST_CFG:TAS_CYCLE_TIME_CFG */
+#define HSCH_TAS_CYCLE_TIME_CFG                                                \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      24, 0, 1, 4)
+
+/* HSCH:TAS_LIST_CFG:TAS_STARTUP_CFG */
+#define HSCH_TAS_STARTUP_CFG                                                   \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      28, 0, 1, 4)
+
+#define HSCH_TAS_STARTUP_CFG_STARTUP_TIME        GENMASK(21, 0)
+#define HSCH_TAS_STARTUP_CFG_STARTUP_TIME_SET(x)\
+	FIELD_PREP(HSCH_TAS_STARTUP_CFG_STARTUP_TIME, x)
+#define HSCH_TAS_STARTUP_CFG_STARTUP_TIME_GET(x)\
+	FIELD_GET(HSCH_TAS_STARTUP_CFG_STARTUP_TIME, x)
+
+#define HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX\
+	GENMASK(regs->fsize[FW_HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX] + 23 - 1, 23)
+#define HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX_SET(x)\
+	spx5_field_prep(HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX, x)
+#define HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX_GET(x)\
+	spx5_field_get(HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX, x)
+
+#define HSCH_TAS_STARTUP_CFG_STARTUP_ERROR       BIT(22)
+#define HSCH_TAS_STARTUP_CFG_STARTUP_ERROR_SET(x)\
+	FIELD_PREP(HSCH_TAS_STARTUP_CFG_STARTUP_ERROR, x)
+#define HSCH_TAS_STARTUP_CFG_STARTUP_ERROR_GET(x)\
+	FIELD_GET(HSCH_TAS_STARTUP_CFG_STARTUP_ERROR, x)
+
+/* HSCH:TAS_LIST_CFG:TAS_LIST_CFG */
+#define HSCH_TAS_LIST_CFG                                                      \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      32, 0, 1, 4)
+
+#define HSCH_TAS_LIST_CFG_LIST_BASE_ADDR\
+	GENMASK(regs->fsize[FW_HSCH_TAS_LIST_CFG_LIST_BASE_ADDR] + 0 - 1, 0)
+#define HSCH_TAS_LIST_CFG_LIST_BASE_ADDR_SET(x)\
+	spx5_field_prep(HSCH_TAS_LIST_CFG_LIST_BASE_ADDR, x)
+#define HSCH_TAS_LIST_CFG_LIST_BASE_ADDR_GET(x)\
+	spx5_field_get(HSCH_TAS_LIST_CFG_LIST_BASE_ADDR, x)
+
+/* SPARX5 ONLY */
+#define HSCH_TAS_LIST_CFG_LIST_LENGTH            GENMASK(29, 16)
+#define HSCH_TAS_LIST_CFG_LIST_LENGTH_SET(x)\
+	FIELD_PREP(HSCH_TAS_LIST_CFG_LIST_LENGTH, x)
+#define HSCH_TAS_LIST_CFG_LIST_LENGTH_GET(x)\
+	FIELD_GET(HSCH_TAS_LIST_CFG_LIST_LENGTH, x)
+
+/* LAN969X ONLY */
+#define HSCH_TAS_LIST_CFG_LIST_HSCH_POS          GENMASK(31, 21)
+#define HSCH_TAS_LIST_CFG_LIST_HSCH_POS_SET(x)\
+	FIELD_PREP(HSCH_TAS_LIST_CFG_LIST_HSCH_POS, x)
+#define HSCH_TAS_LIST_CFG_LIST_HSCH_POS_GET(x)\
+	FIELD_GET(HSCH_TAS_LIST_CFG_LIST_HSCH_POS, x)
+
+/* LAN969X ONLY */
+#define HSCH_TAS_LIST_CFG_LIST_PORT_NUM          GENMASK(20, 16)
+#define HSCH_TAS_LIST_CFG_LIST_PORT_NUM_SET(x)\
+	FIELD_PREP(HSCH_TAS_LIST_CFG_LIST_PORT_NUM, x)
+#define HSCH_TAS_LIST_CFG_LIST_PORT_NUM_GET(x)\
+	FIELD_GET(HSCH_TAS_LIST_CFG_LIST_PORT_NUM, x)
+
+/* HSCH:TAS_LIST_CFG:TAS_LIST_STATE */
+#define HSCH_TAS_LIST_STATE                                                    \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_LIST_CFG], 0, 1, 64,  \
+	      36, 0, 1, 4)
+
+#define HSCH_TAS_LIST_STATE_LIST_STATE           GENMASK(2, 0)
+#define HSCH_TAS_LIST_STATE_LIST_STATE_SET(x)\
+	FIELD_PREP(HSCH_TAS_LIST_STATE_LIST_STATE, x)
+#define HSCH_TAS_LIST_STATE_LIST_STATE_GET(x)\
+	FIELD_GET(HSCH_TAS_LIST_STATE_LIST_STATE, x)
+
+/* HSCH:TAS_GCL_CFG:TAS_GCL_CTRL_CFG */
+#define HSCH_TAS_GCL_CTRL_CFG                                                  \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_GCL_CFG], 0, 1,       \
+	      regs->gsize[GW_HSCH_TAS_GCL_CFG], 0, 0, 1, 4)
+
+#define HSCH_TAS_GCL_CTRL_CFG_GATE_STATE         GENMASK(27, 20)
+#define HSCH_TAS_GCL_CTRL_CFG_GATE_STATE_SET(x)\
+	FIELD_PREP(HSCH_TAS_GCL_CTRL_CFG_GATE_STATE, x)
+#define HSCH_TAS_GCL_CTRL_CFG_GATE_STATE_GET(x)\
+	FIELD_GET(HSCH_TAS_GCL_CTRL_CFG_GATE_STATE, x)
+
+/* SPARX5 ONLY */
+#define HSCH_TAS_GCL_CTRL_CFG_PORT_PROFILE       GENMASK(19, 13)
+#define HSCH_TAS_GCL_CTRL_CFG_PORT_PROFILE_SET(x)\
+	FIELD_PREP(HSCH_TAS_GCL_CTRL_CFG_PORT_PROFILE, x)
+#define HSCH_TAS_GCL_CTRL_CFG_PORT_PROFILE_GET(x)\
+	FIELD_GET(HSCH_TAS_GCL_CTRL_CFG_PORT_PROFILE, x)
+
+/* SPARX5 ONLY */
+#define HSCH_TAS_GCL_CTRL_CFG_HSCH_POS           GENMASK(12, 0)
+#define HSCH_TAS_GCL_CTRL_CFG_HSCH_POS_SET(x)\
+	FIELD_PREP(HSCH_TAS_GCL_CTRL_CFG_HSCH_POS, x)
+#define HSCH_TAS_GCL_CTRL_CFG_HSCH_POS_GET(x)\
+	FIELD_GET(HSCH_TAS_GCL_CTRL_CFG_HSCH_POS, x)
+
+/* HSCH:TAS_GCL_CFG:TAS_GCL_TIME_CFG */
+#define HSCH_TAS_GCL_TIME_CFG                                                  \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_GCL_CFG], 0, 1,       \
+	      regs->gsize[GW_HSCH_TAS_GCL_CFG], 4, 0, 1, 4)
+
+/* LAN969X ONLY */
+/* HSCH:TAS_GCL_CFG:TAS_GCL_CTRL_CFG2 */
+#define HSCH_TAS_GCL_CTRL_CFG2                                                 \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_GCL_CFG], 0, 1,       \
+	      regs->gsize[GW_HSCH_TAS_GCL_CFG], 8, 0, 1, 4)
+
+#define HSCH_TAS_GCL_CTRL_CFG2_NEXT_GCL          GENMASK(11, 0)
+#define HSCH_TAS_GCL_CTRL_CFG2_NEXT_GCL_SET(x)\
+	FIELD_PREP(HSCH_TAS_GCL_CTRL_CFG2_NEXT_GCL, x)
+#define HSCH_TAS_GCL_CTRL_CFG2_NEXT_GCL_GET(x)\
+	FIELD_GET(HSCH_TAS_GCL_CTRL_CFG2_NEXT_GCL, x)
+
+/* HSCH:HSCH_TAS_STATE:TAS_GATE_STATE */
+#define HSCH_TAS_GATE_STATE                                                    \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_HSCH_TAS_STATE], 0, 1, 4, \
+	      0, 0, 1, 4)
+
+#define HSCH_TAS_GATE_STATE_TAS_GATE_STATE       GENMASK(7, 0)
+#define HSCH_TAS_GATE_STATE_TAS_GATE_STATE_SET(x)\
+	FIELD_PREP(HSCH_TAS_GATE_STATE_TAS_GATE_STATE, x)
+#define HSCH_TAS_GATE_STATE_TAS_GATE_STATE_GET(x)\
+	FIELD_GET(HSCH_TAS_GATE_STATE_TAS_GATE_STATE, x)
+
 /* LAN969X ONLY */
 /* HSIOWRAP:XMII_CFG:XMII_CFG */
 #define HSIO_WRAP_XMII_CFG(g)                                                  \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index 3863f954bd83..75c1bd4f0053 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -96,6 +96,9 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_HSCH_MMGT] = 162368,
 	[GA_HSCH_TAS_CONFIG] = 162384,
 	[GA_HSCH_TAS_PROFILE_CFG] = 188416,
+	[GA_HSCH_TAS_LIST_CFG] = 161600,
+	[GA_HSCH_TAS_GCL_CFG] = 161584,
+	[GA_HSCH_HSCH_TAS_STATE] = 161580,
 	[GA_PTP_PTP_CFG] = 320,
 	[GA_PTP_PTP_TOD_DOMAINS] = 336,
 	[GA_PTP_PHASE_DETECTOR_CTRL] = 420,
@@ -147,6 +150,7 @@ const unsigned int sparx5_gsize[GSIZE_LAST] = {
 	[GW_GCB_CHIP_REGS] = 424,
 	[GW_HSCH_TAS_CONFIG] = 12,
 	[GW_HSCH_TAS_PROFILE_CFG] = 64,
+	[GW_HSCH_TAS_GCL_CFG] = 8,
 	[GW_PTP_PHASE_DETECTOR_CTRL] = 8,
 	[GW_QSYS_PAUSE_CFG] = 1128,
 };
@@ -201,6 +205,12 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_HSCH_HSCH_LEAK_CFG_LEAK_FIRST] = 16,
 	[FW_HSCH_FLUSH_CTRL_FLUSH_PORT] = 7,
 	[FW_HSCH_FLUSH_CTRL_FLUSH_HIER] = 16,
+	[FW_HSCH_TAS_CFG_CTRL_LIST_NUM_MAX] = 7,
+	[FW_HSCH_TAS_CFG_CTRL_LIST_NUM] = 7,
+	[FW_HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM] = 14,
+	[FW_HSCH_TAS_GATE_STATE_CTRL_HSCH_POS] = 13,
+	[FW_HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX] = 7,
+	[FW_HSCH_TAS_LIST_CFG_LIST_BASE_ADDR] = 14,
 	[FW_LRN_COMMON_ACCESS_CTRL_CPU_ACCESS_DIRECT_ROW] = 14,
 	[FW_LRN_MAC_ACCESS_CFG_3_MAC_ENTRY_ISDX_LIMIT_IDX] = 11,
 	[FW_LRN_AUTOAGE_CFG_2_NEXT_ROW] = 14,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index 585589a31e90..97d496ebb750 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -105,6 +105,9 @@ enum sparx5_gaddr_enum {
 	GA_HSCH_MMGT,
 	GA_HSCH_TAS_CONFIG,
 	GA_HSCH_TAS_PROFILE_CFG,
+	GA_HSCH_TAS_LIST_CFG,
+	GA_HSCH_TAS_GCL_CFG,
+	GA_HSCH_HSCH_TAS_STATE,
 	GA_PTP_PTP_CFG,
 	GA_PTP_PTP_TOD_DOMAINS,
 	GA_PTP_PHASE_DETECTOR_CTRL,
@@ -158,6 +161,7 @@ enum sparx5_gsize_enum {
 	GW_GCB_CHIP_REGS,
 	GW_HSCH_TAS_CONFIG,
 	GW_HSCH_TAS_PROFILE_CFG,
+	GW_HSCH_TAS_GCL_CFG,
 	GW_PTP_PHASE_DETECTOR_CTRL,
 	GW_QSYS_PAUSE_CFG,
 	GSIZE_LAST,
@@ -214,6 +218,12 @@ enum sparx5_fsize_enum {
 	FW_HSCH_HSCH_LEAK_CFG_LEAK_FIRST,
 	FW_HSCH_FLUSH_CTRL_FLUSH_PORT,
 	FW_HSCH_FLUSH_CTRL_FLUSH_HIER,
+	FW_HSCH_TAS_CFG_CTRL_LIST_NUM_MAX,
+	FW_HSCH_TAS_CFG_CTRL_LIST_NUM,
+	FW_HSCH_TAS_CFG_CTRL_GCL_ENTRY_NUM,
+	FW_HSCH_TAS_GATE_STATE_CTRL_HSCH_POS,
+	FW_HSCH_TAS_STARTUP_CFG_OBSOLETE_IDX,
+	FW_HSCH_TAS_LIST_CFG_LIST_BASE_ADDR,
 	FW_LRN_COMMON_ACCESS_CTRL_CPU_ACCESS_DIRECT_ROW,
 	FW_LRN_MAC_ACCESS_CFG_3_MAC_ENTRY_ISDX_LIMIT_IDX,
 	FW_LRN_AUTOAGE_CFG_2_NEXT_ROW,

-- 
2.34.1

