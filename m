Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD913DDAE
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999227; cv=none; b=NduxFqrEqWJGR9liNwFMNsAQEAu7SGk3jTWkvNMD9D3HKVLBom+xTMNchsk6CUgGSOEXM/iV5Sb+Cd1K640uMaOwQd/m/O/XZYaGDZctY+BHGazrzPvZpRr6VKX38CHmOqewP3/NfGumvcV5Yr6ZpfNL8qimhNNBDrmgmC2vQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999227; c=relaxed/simple;
	bh=b/3hMH7blquyYqdOL+TkQxAHNrPDRc/AgizERjDBB2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJ96/d+NCswlYzh2vD4hqGJ3aj5n9GulkJ2nJ5H2dpx61A6OkCdG4XFovkKn7wY3esAfM2UicQZfFCA1kpCpVNWhZ4ZfBiw8Dbj78xzxFTgJiO1pjohPH0PyLqwqNMnOIU8aUhy1DH7zRz/rjA3zxQWv+oihIAc29zgvF1wrVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 68LDwo0q030578;
	Mon, 21 Sep 2026 07:00:13 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v2 07/11] cxgb4: extend ethtool support for T7 adapters
Date: Mon, 21 Sep 2026 19:30:37 -0400
Message-Id: <20260921233041.61093-8-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260921233041.61093-1-bharat@chelsio.com>
References: <20260921233041.61093-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 171 ++++++++++++++++--
 1 file changed, 157 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 0092bc16f887..dcde06c8de47 100644
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
 
@@ -563,6 +572,12 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 		break;
 
 	case FW_PORT_TYPE_BP40_BA:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G, 40000baseKR4_Full);
+		break;
+
 	case FW_PORT_TYPE_QSFP:
 		SET_LMM(FIBRE);
 		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
@@ -580,7 +595,7 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 
 	case FW_PORT_TYPE_KR_SFP28:
 		SET_LMM(Backplane);
-		FW_CAPS_TO_LMM(SPEED_1G, 1000baseT_Full);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
 		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
 		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
 		break;
@@ -597,7 +612,30 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
 		break;
 
+	case FW_PORT_TYPE_SFP56:
+		SET_LMM(FIBRE);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
+		break;
+
+	case FW_PORT_TYPE_QSFP56:
+		SET_LMM(FIBRE);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
+		break;
+
 	case FW_PORT_TYPE_KR4_100G:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G, 40000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR4_Full);
+		break;
+
 	case FW_PORT_TYPE_CR4_QSFP:
 		SET_LMM(FIBRE);
 		FW_CAPS_TO_LMM(SPEED_1G,  1000baseT_Full);
@@ -608,6 +646,51 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR4_Full);
 		break;
 
+	case FW_PORT_TYPE_KR_50G:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR_Full);
+		break;
+
+	case FW_PORT_TYPE_KR2_100G:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR2_Full);
+		break;
+
+	case FW_PORT_TYPE_KR4_200G:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G, 40000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseKR4_Full);
+		break;
+
+	case FW_PORT_TYPE_KR8_400G:
+		SET_LMM(Backplane);
+		FW_CAPS_TO_LMM(SPEED_1G, 1000baseKX_Full);
+		FW_CAPS_TO_LMM(SPEED_10G, 10000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_40G, 40000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseKR4_Full);
+		FW_CAPS_TO_LMM(SPEED_400G, 400000baseKR8_Full);
+		break;
+
 	default:
 		break;
 	}
@@ -800,7 +883,7 @@ static inline unsigned int eth_to_cc_fec(unsigned int eth_fec)
 {
 	unsigned int cc_fec = 0;
 
-	if (eth_fec & ETHTOOL_FEC_OFF)
+	if (eth_fec == ETHTOOL_FEC_OFF)
 		return cc_fec;
 
 	if (eth_fec & ETHTOOL_FEC_AUTO)
@@ -1576,6 +1659,11 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
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
@@ -1590,8 +1678,19 @@ static int get_rss_table(struct net_device *dev,
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
@@ -1607,10 +1706,19 @@ static int set_rss_table(struct net_device *dev,
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
 
@@ -2022,12 +2130,13 @@ static int cxgb4_get_module_info(struct net_device *dev,
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
@@ -2046,11 +2155,12 @@ static int cxgb4_get_module_info(struct net_device *dev,
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
@@ -2083,14 +2193,14 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
 
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
@@ -2101,10 +2211,41 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
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
@@ -2205,6 +2346,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_rxnfc         = get_rxnfc,
 	.set_rxnfc         = set_rxnfc,
 	.get_rx_ring_count = get_rx_ring_count,
+	.get_rxfh_key_size = get_rss_key_size,
 	.get_rxfh_indir_size = get_rss_table_size,
 	.get_rxfh	   = get_rss_table,
 	.set_rxfh	   = set_rss_table,
@@ -2217,6 +2359,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_dump_data     = get_dump_data,
 	.get_module_info   = cxgb4_get_module_info,
 	.get_module_eeprom = cxgb4_get_module_eeprom,
+	.get_module_eeprom_by_page  = cxgb4_get_module_eeprom_by_page,
 	.get_priv_flags    = cxgb4_get_priv_flags,
 	.set_priv_flags    = cxgb4_set_priv_flags,
 };
-- 
2.47.3

