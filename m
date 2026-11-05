Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850313;
	b=1KKgKv5YUga/ERb88fs+jJu+hiMLkWH44DkoP5A2JdyVO83/z55YC/gNP3obfRn4jBsT
	 xFHUfhTl/nwpEjPq9ejLtkz7ds6I+lVSkidTCXog5OjyFB49WjA7DLM9kWDhViTUQwp4I
	 yQamPKyVdJnwyGkzU3nJu8HZF2aT8PCcGkEAJHV8tgZXbg+Ezb2NoesDv4qcU2+pQsbrk
	 k9Mq7fejAXr0u79cP1xiLzlWs8DTgXMNJSboleaGIYEqylDlm9aOMCzP0jJ0O8vMnV4ab
	 ZKwcIKtG6rYV9oUXCq9umdesRWmKZhDit4NAzsOSBKpTBKlMCIUQVA3btwDK7Mm5OdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850313;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OlZuGcPvprLD3w/oGvi2YCG46Ut8Auwf4ISZWwmQTAs=;
	b=F0xZUTYr9/5z3bmgy8wGqLPkR4ke0Gtu6Yx/yU4JKEFBRlbaNzfuUJaw/Hu13nJQX9iZ
	 7iAO0UCKzzApCN8eoCy94IEfs9Txy9Pt4QXbpa3obbMRa9F79SO5q0qTOKd30s0wsQDJi
	 Jo69AZF1a4lYDmvDAwaxcJ1niE7xlroHYqpO2xJjMIXtXEx/jq3LdCzyjk9wxoxXKN1r/
	 bSTsClbSadQQY4dG+UaVdKgiwLEwrJbafjD9ZXerpxCNc3pPhw8/l7Cot77Hnem29FG4A
	 /F5zUTxWGQTIktojE0yFVd3vUDnUcKWGRwfjM3sinCRHyJSO6v5UIskHNQGAft4233w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AC606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E62AC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3t002480;
	Wed, 4 Nov 2026 19:44:59 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 07/12] cxgb4: extend ethtool support for T7 adapters
Date: Thu,  5 Nov 2026 08:15:44 -0500
Message-Id: <20261105131549.547554-8-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the ethtool implementation to support T7-specific port types,
link modes, and adapter capabilities.

Add support for new T7 port configurations including SFP56, QSFP56,
50G/100G/200G/400G backplane modes, and the associated ethtool link
mode mappings. Update port statistics handling and module type
reporting to account for the new hardware capabilities.

Extend RSS configuration support by implementing RSS hash key retrieval
and programming through ethtool. Also update module EEPROM handling for
new optical module types and CMIS-based devices.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 381 +++++++++++++-----
 1 file changed, 278 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 0092bc16f887..605c0783d3d5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -14,6 +14,8 @@
 #include "cxgb4_tc_flower.h"
 
 #define EEPROM_MAGIC 0x38E2F10C
+#define RSS_HASH_KEY_SIZE 40
+#define CMIS_PAGE_SELECT_REG 127
 
 static u32 get_msglevel(struct net_device *dev)
 {
@@ -358,7 +360,7 @@ static void get_stats(struct net_device *dev, struct ethtool_stats *stats,
 	int i;
 	u64 *p0;
 
-	t4_get_port_stats_offset(adapter, pi->tx_chan,
+	t4_get_port_stats_offset(adapter, pi->lport,
 				 (struct port_stats *)data,
 				 &pi->stats_base);
 
@@ -440,10 +442,13 @@ static int from_fw_port_mod_type(enum fw_port_type port_type,
 		   port_type == FW_PORT_TYPE_CR4_QSFP ||
 		   port_type == FW_PORT_TYPE_CR_QSFP ||
 		   port_type == FW_PORT_TYPE_CR2_QSFP ||
-		   port_type == FW_PORT_TYPE_SFP28) {
+		   port_type == FW_PORT_TYPE_SFP28 ||
+		   port_type == FW_PORT_TYPE_SFP56 ||
+		   port_type == FW_PORT_TYPE_QSFP56) {
 		if (mod_type == FW_PORT_MOD_TYPE_LR ||
 		    mod_type == FW_PORT_MOD_TYPE_SR ||
 		    mod_type == FW_PORT_MOD_TYPE_ER ||
+		    mod_type == FW_PORT_MOD_TYPE_DR ||
 		    mod_type == FW_PORT_MOD_TYPE_LRM)
 			return PORT_FIBRE;
 		else if (mod_type == FW_PORT_MOD_TYPE_TWINAX_PASSIVE ||
@@ -453,7 +458,11 @@ static int from_fw_port_mod_type(enum fw_port_type port_type,
 			return PORT_OTHER;
 	} else if (port_type == FW_PORT_TYPE_KR4_100G ||
 		   port_type == FW_PORT_TYPE_KR_SFP28 ||
-		   port_type == FW_PORT_TYPE_KR_XLAUI) {
+		   port_type == FW_PORT_TYPE_KR_XLAUI ||
+		   port_type == FW_PORT_TYPE_KR_50G ||
+		   port_type == FW_PORT_TYPE_KR2_100G ||
+		   port_type == FW_PORT_TYPE_KR4_200G ||
+		   port_type == FW_PORT_TYPE_KR8_400G) {
 		return PORT_NONE;
 	}
 
@@ -490,8 +499,100 @@ static unsigned int speed_to_fw_caps(int speed)
 	return 0;
 }
 
+enum link_medium {
+	LINK_MEDIUM_NONE,
+	LINK_MEDIUM_TP,		/* plain copper baseT               */
+	LINK_MEDIUM_KR,		/* electrical backplane             */
+	LINK_MEDIUM_CR,		/* copper direct-attach (TwinAx)    */
+	LINK_MEDIUM_SR,
+	LINK_MEDIUM_LR,		/* also covers ER FR                */
+	LINK_MEDIUM_DR,
+	LINK_MEDIUM_LRM,
+};
+
+static bool fw_port_is_backplane(enum fw_port_type port_type)
+{
+	switch (port_type) {
+	case FW_PORT_TYPE_KX:
+	case FW_PORT_TYPE_KX4:
+	case FW_PORT_TYPE_BP_AP:
+	case FW_PORT_TYPE_BP4_AP:
+	case FW_PORT_TYPE_BP40_BA:
+	case FW_PORT_TYPE_KR:
+	case FW_PORT_TYPE_KR_50G:
+	case FW_PORT_TYPE_KR_SFP28:
+	case FW_PORT_TYPE_KR_XLAUI:
+	case FW_PORT_TYPE_KR2_100G:
+	case FW_PORT_TYPE_KR4_100G:
+	case FW_PORT_TYPE_KR4_200G:
+	case FW_PORT_TYPE_KR8_400G:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fw_port_is_electrical_tp(enum fw_port_type port_type)
+{
+	switch (port_type) {
+	case FW_PORT_TYPE_BT_SGMII:
+	case FW_PORT_TYPE_BT_XFI:
+	case FW_PORT_TYPE_BT_XAUI:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fw_port_is_fixed_baset(enum fw_port_type port_type)
+{
+	switch (port_type) {
+	case FW_PORT_TYPE_FIBER_XFI:
+	case FW_PORT_TYPE_FIBER_XAUI:
+		return true;
+	default:
+		return fw_port_is_electrical_tp(port_type);
+	}
+}
+
+static int fw_port_class_bit(enum fw_port_type port_type)
+{
+	if (fw_port_is_backplane(port_type))
+		return ETHTOOL_LINK_MODE_Backplane_BIT;
+	if (fw_port_is_electrical_tp(port_type))
+		return ETHTOOL_LINK_MODE_TP_BIT;
+	return ETHTOOL_LINK_MODE_FIBRE_BIT;
+}
+
+static enum link_medium fw_port_medium(enum fw_port_type port_type,
+				       enum fw_port_module_type mod_type)
+{
+	if (fw_port_is_backplane(port_type))
+		return LINK_MEDIUM_KR;
+	if (fw_port_is_fixed_baset(port_type))
+		return LINK_MEDIUM_TP;
+
+	switch (mod_type) {
+	case FW_PORT_MOD_TYPE_TWINAX_PASSIVE:
+	case FW_PORT_MOD_TYPE_TWINAX_ACTIVE:
+		return LINK_MEDIUM_CR;
+	case FW_PORT_MOD_TYPE_SR:
+		return LINK_MEDIUM_SR;
+	case FW_PORT_MOD_TYPE_LR:
+	case FW_PORT_MOD_TYPE_ER:
+		return LINK_MEDIUM_LR;
+	case FW_PORT_MOD_TYPE_DR:
+		return LINK_MEDIUM_DR;
+	case FW_PORT_MOD_TYPE_LRM:
+		return LINK_MEDIUM_LRM;
+	default:
+		return LINK_MEDIUM_NONE;	/* no module / unreadable */
+	}
+}
+
 /**
  *	fw_caps_to_lmm - translate Firmware to ethtool Link Mode Mask
+ *	@mod_type: Firmware Module Type
  *	@port_type: Firmware Port Type
  *	@fw_caps: Firmware Port Capabilities
  *	@link_mode_mask: ethtool Link Mode Mask
@@ -500,114 +601,93 @@ static unsigned int speed_to_fw_caps(int speed)
  *	Link Mode Mask.
  */
 static void fw_caps_to_lmm(enum fw_port_type port_type,
+			   enum fw_port_module_type mod_type,
 			   fw_port_cap32_t fw_caps,
 			   unsigned long *link_mode_mask)
 {
-	#define SET_LMM(__lmm_name) \
-		do { \
-			__set_bit(ETHTOOL_LINK_MODE_ ## __lmm_name ## _BIT, \
-				  link_mode_mask); \
-		} while (0)
+	enum link_medium medium = fw_port_medium(port_type, mod_type);
 
 	#define FW_CAPS_TO_LMM(__fw_name, __lmm_name) \
 		do { \
 			if (fw_caps & FW_PORT_CAP32_ ## __fw_name) \
-				SET_LMM(__lmm_name); \
+				__set_bit(ETHTOOL_LINK_MODE_ ## __lmm_name ## _BIT, \
+					  link_mode_mask); \
 		} while (0)
 
-	switch (port_type) {
-	case FW_PORT_TYPE_BT_SGMII:
-	case FW_PORT_TYPE_BT_XFI:
-	case FW_PORT_TYPE_BT_XAUI:
-		SET_LMM(TP);
-		FW_CAPS_TO_LMM(SPEED_100M, 100baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseT_Full);
-		break;
-
-	case FW_PORT_TYPE_KX4:
-	case FW_PORT_TYPE_KX:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKX4_Full);
-		break;
-
-	case FW_PORT_TYPE_KR:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		break;
-
-	case FW_PORT_TYPE_BP_AP:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseR_FEC);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		break;
+	if (medium != LINK_MEDIUM_NONE)
+		__set_bit(fw_port_class_bit(port_type), link_mode_mask);
 
-	case FW_PORT_TYPE_BP4_AP:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseR_FEC);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKX4_Full);
+	switch (medium) {
+	case LINK_MEDIUM_TP:
+		FW_CAPS_TO_LMM(SPEED_100M, 100baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseT_Full);
 		break;
 
-	case FW_PORT_TYPE_FIBER_XFI:
-	case FW_PORT_TYPE_FIBER_XAUI:
-	case FW_PORT_TYPE_SFP:
-	case FW_PORT_TYPE_QSFP_10G:
-	case FW_PORT_TYPE_QSA:
-		SET_LMM(FIBRE);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseT_Full);
+	case LINK_MEDIUM_KR:
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseKX4_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseR_FEC);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G,  25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G,  40000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseKR8_Full);
 		break;
 
-	case FW_PORT_TYPE_BP40_BA:
-	case FW_PORT_TYPE_QSFP:
-		SET_LMM(FIBRE);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_40G, 40000baseSR4_Full);
-		break;
-
-	case FW_PORT_TYPE_CR_QSFP:
-	case FW_PORT_TYPE_SFP28:
-		SET_LMM(FIBRE);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
+	case LINK_MEDIUM_CR:
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseCR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G,  25000baseCR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G,  40000baseCR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseCR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseCR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseCR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseCR8_Full);
 		break;
 
-	case FW_PORT_TYPE_KR_SFP28:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+	case LINK_MEDIUM_SR:
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseSR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G,  25000baseSR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G,  40000baseSR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseSR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseSR4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseSR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseSR8_Full);
 		break;
 
-	case FW_PORT_TYPE_KR_XLAUI:
-		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		FW_CAPS_TO_LMM(SPEED_40G, 40000baseKR4_Full);
+	case LINK_MEDIUM_LR:
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseLR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G,  40000baseLR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G,  50000baseLR_ER_FR_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseLR2_ER2_FR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseLR4_ER4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseLR4_ER4_FR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseLR8_ER8_FR8_Full);
 		break;
 
-	case FW_PORT_TYPE_CR2_QSFP:
-		SET_LMM(FIBRE);
-		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
+	case LINK_MEDIUM_DR:
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseDR2_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseDR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseDR8_Full);
 		break;
 
-	case FW_PORT_TYPE_KR4_100G:
-	case FW_PORT_TYPE_CR4_QSFP:
-		SET_LMM(FIBRE);
-		FW_CAPS_TO_LMM(SPEED_1G,  1000baseT_Full);
-		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
-		FW_CAPS_TO_LMM(SPEED_40G, 40000baseSR4_Full);
-		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
-		FW_CAPS_TO_LMM(SPEED_50G, 50000baseCR2_Full);
-		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR4_Full);
+	case LINK_MEDIUM_LRM:
+		FW_CAPS_TO_LMM(SPEED_1G,   1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_10G,  10000baseLRM_Full);
 		break;
 
+	case LINK_MEDIUM_NONE:
 	default:
 		break;
 	}
@@ -616,7 +696,7 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 		FW_CAPS_TO_LMM(FEC_RS, FEC_RS);
 		FW_CAPS_TO_LMM(FEC_BASER_RS, FEC_BASER);
 	} else {
-		SET_LMM(FEC_NONE);
+		__set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT, link_mode_mask);
 	}
 
 	FW_CAPS_TO_LMM(ANEG, Autoneg);
@@ -624,7 +704,6 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 	FW_CAPS_TO_LMM(802_3_ASM_DIR, Asym_Pause);
 
 	#undef FW_CAPS_TO_LMM
-	#undef SET_LMM
 }
 
 /**
@@ -649,10 +728,46 @@ static unsigned int lmm_to_fw_caps(const unsigned long *link_mode_mask)
 	LMM_TO_FW_CAPS(100baseT_Full, SPEED_100M);
 	LMM_TO_FW_CAPS(1000baseT_Full, SPEED_1G);
 	LMM_TO_FW_CAPS(10000baseT_Full, SPEED_10G);
-	LMM_TO_FW_CAPS(40000baseSR4_Full, SPEED_40G);
+	LMM_TO_FW_CAPS(10000baseKX4_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseR_FEC, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseKR_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseCR_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseSR_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseLR_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(10000baseLRM_Full, SPEED_10G);
+	LMM_TO_FW_CAPS(25000baseKR_Full, SPEED_25G);
 	LMM_TO_FW_CAPS(25000baseCR_Full, SPEED_25G);
+	LMM_TO_FW_CAPS(25000baseSR_Full, SPEED_25G);
+	LMM_TO_FW_CAPS(40000baseKR4_Full, SPEED_40G);
+	LMM_TO_FW_CAPS(40000baseCR4_Full, SPEED_40G);
+	LMM_TO_FW_CAPS(40000baseSR4_Full, SPEED_40G);
+	LMM_TO_FW_CAPS(40000baseLR4_Full, SPEED_40G);
+	LMM_TO_FW_CAPS(50000baseKR_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(50000baseKR2_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(50000baseCR_Full, SPEED_50G);
 	LMM_TO_FW_CAPS(50000baseCR2_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(50000baseSR_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(50000baseSR2_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(50000baseLR_ER_FR_Full, SPEED_50G);
+	LMM_TO_FW_CAPS(100000baseKR2_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseKR4_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseCR2_Full, SPEED_100G);
 	LMM_TO_FW_CAPS(100000baseCR4_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseSR2_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseSR4_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseLR2_ER2_FR2_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseLR4_ER4_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(100000baseDR2_Full, SPEED_100G);
+	LMM_TO_FW_CAPS(200000baseKR4_Full, SPEED_200G);
+	LMM_TO_FW_CAPS(200000baseCR4_Full, SPEED_200G);
+	LMM_TO_FW_CAPS(200000baseSR4_Full, SPEED_200G);
+	LMM_TO_FW_CAPS(200000baseLR4_ER4_FR4_Full, SPEED_200G);
+	LMM_TO_FW_CAPS(200000baseDR4_Full, SPEED_200G);
+	LMM_TO_FW_CAPS(400000baseKR8_Full, SPEED_400G);
+	LMM_TO_FW_CAPS(400000baseCR8_Full, SPEED_400G);
+	LMM_TO_FW_CAPS(400000baseSR8_Full, SPEED_400G);
+	LMM_TO_FW_CAPS(400000baseLR8_ER8_FR8_Full, SPEED_400G);
+	LMM_TO_FW_CAPS(400000baseDR8_Full, SPEED_400G);
 
 	#undef LMM_TO_FW_CAPS
 
@@ -688,14 +803,14 @@ static int get_link_ksettings(struct net_device *dev,
 		base->mdio_support = 0;
 	}
 
-	fw_caps_to_lmm(pi->port_type, pi->link_cfg.pcaps,
+	fw_caps_to_lmm(pi->port_type, pi->mod_type, pi->link_cfg.pcaps,
 		       link_ksettings->link_modes.supported);
-	fw_caps_to_lmm(pi->port_type,
+	fw_caps_to_lmm(pi->port_type, pi->mod_type,
 		       t4_link_acaps(pi->adapter,
 				     pi->lport,
 				     &pi->link_cfg),
 		       link_ksettings->link_modes.advertising);
-	fw_caps_to_lmm(pi->port_type, pi->link_cfg.lpacaps,
+	fw_caps_to_lmm(pi->port_type, pi->mod_type, pi->link_cfg.lpacaps,
 		       link_ksettings->link_modes.lp_advertising);
 
 	base->speed = (netif_carrier_ok(dev)
@@ -800,7 +915,7 @@ static inline unsigned int eth_to_cc_fec(unsigned int eth_fec)
 {
 	unsigned int cc_fec = 0;
 
-	if (eth_fec & ETHTOOL_FEC_OFF)
+	if (eth_fec == ETHTOOL_FEC_OFF)
 		return cc_fec;
 
 	if (eth_fec & ETHTOOL_FEC_AUTO)
@@ -1576,6 +1691,11 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 	return 0;
 }
 
+static u32 get_rss_key_size(struct net_device *dev)
+{
+	return RSS_HASH_KEY_SIZE;
+}
+
 static u32 get_rss_table_size(struct net_device *dev)
 {
 	const struct port_info *pi = netdev_priv(dev);
@@ -1590,8 +1710,19 @@ static int get_rss_table(struct net_device *dev,
 	unsigned int n = pi->rss_size;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
+
+	if (rxfh->key) {
+		__be32 key[10];
+
+		t4_read_rss_key(pi->adapter, (u32 *)key, true);
+		/* RSS hash keys are read in order TP_RSS_SECRET_KEY9..0 */
+		for (int i = 0; i < 10; i++)
+			((u32 *)rxfh->key)[i] = be32_to_cpu(key[9 - i]);
+	}
+
 	if (!rxfh->indir)
 		return 0;
+
 	while (n--)
 		rxfh->indir[n] = pi->rss[n];
 	return 0;
@@ -1607,10 +1738,19 @@ static int set_rss_table(struct net_device *dev,
 	/* We require at least one supported parameter to be changed and no
 	 * change in any of the unsupported parameters
 	 */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
+
+	if (rxfh->key) {
+		__be32 key[10];
+
+		/* RSS hash keys are written in order TP_RSS_SECRET_KEY9..0 */
+		for (int i = 0; i < 10; i++)
+			key[i] = cpu_to_be32(((u32 *)rxfh->key)[9 - i]);
+		t4_write_rss_key(pi->adapter, (u32 *)key, -1, true);
+	}
+
 	if (!rxfh->indir)
 		return 0;
 
@@ -2022,12 +2162,13 @@ static int cxgb4_get_module_info(struct net_device *dev,
 	case FW_PORT_TYPE_SFP:
 	case FW_PORT_TYPE_QSA:
 	case FW_PORT_TYPE_SFP28:
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+	case FW_PORT_TYPE_SFP56:
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFF_8472_COMP_ADDR,
 				SFF_8472_COMP_LEN, &sff8472_comp);
 		if (ret)
 			return ret;
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFP_DIAG_TYPE_ADDR,
 				SFP_DIAG_TYPE_LEN, &sff_diag_type);
 		if (ret)
@@ -2046,11 +2187,12 @@ static int cxgb4_get_module_info(struct net_device *dev,
 		break;
 
 	case FW_PORT_TYPE_QSFP:
+	case FW_PORT_TYPE_QSFP56:
 	case FW_PORT_TYPE_QSFP_10G:
 	case FW_PORT_TYPE_CR_QSFP:
 	case FW_PORT_TYPE_CR2_QSFP:
 	case FW_PORT_TYPE_CR4_QSFP:
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFF_REV_ADDR,
 				SFF_REV_LEN, &sff_rev);
 		/* For QSFP type ports, revision value >= 3
@@ -2083,14 +2225,14 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
 
 	memset(data, 0, eprom->len);
 	if (offset + len <= I2C_PAGE_SIZE)
-		return t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		return t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				 I2C_DEV_ADDR_A0, offset, len, data);
 
 	/* offset + len spans 0xa0 and 0xa1 pages */
 	if (offset <= I2C_PAGE_SIZE) {
 		/* read 0xa0 page */
 		len = I2C_PAGE_SIZE - offset;
-		ret =  t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret =  t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				 I2C_DEV_ADDR_A0, offset, len, data);
 		if (ret)
 			return ret;
@@ -2101,10 +2243,41 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
 		len = eprom->len - len;
 	}
 	/* Read additional optical diagnostics from page 0xa2 if supported */
-	return t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan, I2C_DEV_ADDR_A2,
+	return t4_i2c_rd(adapter, adapter->mbox, pi->lport, I2C_DEV_ADDR_A2,
 			 offset, len, &data[eprom->len - len]);
 }
 
+static int
+cxgb4_get_module_eeprom_by_page(struct net_device *dev,
+				const struct ethtool_module_eeprom *page_data,
+				struct netlink_ext_ack *extack)
+{
+	struct port_info *pi = netdev_priv(dev);
+	struct adapter *adapter = pi->adapter;
+	int ret;
+
+	if (page_data->offset >= 128) {
+		u8 page = page_data->page;
+		/* Before reading EEPROM data first select the page in PageSelect register */
+		ret = t4_i2c_wr(adapter, adapter->mbox, pi->lport,
+				page_data->i2c_address << 1,
+				CMIS_PAGE_SELECT_REG,        /* CMIS Page Select register */
+				1,                           /* Page Select register length */
+				&page);
+		if (ret)
+			return ret;
+	}
+
+	ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
+			page_data->i2c_address << 1, page_data->offset,
+			page_data->length, page_data->data);
+
+	if (ret)
+		return ret;
+
+	return page_data->length;
+}
+
 static u32 cxgb4_get_priv_flags(struct net_device *netdev)
 {
 	struct port_info *pi = netdev_priv(netdev);
@@ -2205,6 +2378,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_rxnfc         = get_rxnfc,
 	.set_rxnfc         = set_rxnfc,
 	.get_rx_ring_count = get_rx_ring_count,
+	.get_rxfh_key_size = get_rss_key_size,
 	.get_rxfh_indir_size = get_rss_table_size,
 	.get_rxfh	   = get_rss_table,
 	.set_rxfh	   = set_rss_table,
@@ -2217,6 +2391,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_dump_data     = get_dump_data,
 	.get_module_info   = cxgb4_get_module_info,
 	.get_module_eeprom = cxgb4_get_module_eeprom,
+	.get_module_eeprom_by_page  = cxgb4_get_module_eeprom_by_page,
 	.get_priv_flags    = cxgb4_get_priv_flags,
 	.set_priv_flags    = cxgb4_set_priv_flags,
 };
-- 
2.39.1

