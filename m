Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EB341ABB;
	Thu, 23 Jul 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783328; cv=none; b=XRKqSv1rtK83cZApnuUjaxsDjDnjGyHMSlAOg/ybnm+2eiikNDIiJm4BQ7mS8NVA8t2L+BOdqzf7I/frBlB2lJXVkLX3gvUqf257vgAXN3ftGvRHYU12A6FVBCRPWw1HEXxXXRekrAxzljpk4uYuZyKaDfzX0TNarNF+WuyIsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783328; c=relaxed/simple;
	bh=FjZ7hwck9Hacj/PcUVKtD8C9FfuKObhd9X7BROUX/es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAxZBvfP+mLZ0lTch7b/HEUCso03xGsKINyscbqTHGukXyuI9s23OH3POkZXOIEfLGgkC9e0PnlhB6EsqspvcBz1SusjbuY4i01/4PMLWw4u1cablOYD+95O+oRnb0KJWZMzeQAzKVpTg6Mg71guYZ4s2Ye+OI/DPlR/h3nF4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F95MHUCC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F95MHUCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784783329; x=1816319329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FjZ7hwck9Hacj/PcUVKtD8C9FfuKObhd9X7BROUX/es=;
  b=F95MHUCC5rwAF23+Q/eDxKz+TJ/37Gv7PYdaCxn/wNf6hS5Ze4351baG
   T5UdtAIxTr/NKS9Fhkc7hqu90UFCJDrexfnVz8kPj6tRiEVAcm55vtrDX
   OmqgNBnJd3BwnExM/ahjKU0wfZUiKXPbT/XF0f6QbfvsFqLqg8yo63/V3
   nbrmryGxhmhzoXiZ6Os0j37jOCOqcLzphTV8otUr/XgEcfy4QJrDxLIJ3
   s4V4u2bYQdIbaIT32rpYWYQXbf0Om6vOGmakUwU7JA1AQmQP+1kBKOdH6
   QUZwJ27FF3M8SuTQKvJ/4SuZmrEh/CPq/Je110RYUkH4oHIsZ/dJ9MHiG
   g==;
X-CSE-ConnectionGUID: NzAPWS/kTjOC8nn1DKwDvA==
X-CSE-MsgGUID: MOLn/xMdTba9jLgu1gtcUQ==
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="292422643"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:08:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 22:08:45 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 22:08:42 -0700
From: Thangaraj Samynathan <Thangaraj.S@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH net-next v5 2/2] net: lan743x: add support for RMII interface
Date: Thu, 23 Jul 2026 10:38:27 +0530
Message-ID: <20260723050827.694832-3-Thangaraj.S@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723050827.694832-1-Thangaraj.S@microchip.com>
References: <20260723050827.694832-1-Thangaraj.S@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Thangaraj Samynathan <thangaraj.s@microchip.com>

Enable RMII interface in the lan743x driver for PHY and MAC
configuration.

- Select RMII interface in lan743x_phy_interface_select().
- Update phylink supported_interfaces and MAC capabilities.
- Enable RMII via RMII_CTL in lan743x_hardware_init().
- Define RMII_CTL register and enable bit in lan743x_main.h.

EEE is not supported with RMII on PCI11x1x: the hardware does not
implement LPI signaling over RMII. Clear RMII from lpi_interfaces to
prevent phylink from enabling EEE on this interface.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 23 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 3a418105cd11..24ae56a3c9ed 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1402,6 +1402,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 
 	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
 		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
+	else if (adapter->is_pci11x1x && adapter->is_rmii_en)
+		adapter->phy_interface = PHY_INTERFACE_MODE_RMII;
 	else if (id_rev == ID_REV_ID_LAN7430_)
 		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
 	else if ((id_rev == ID_REV_ID_LAN7431_) && (data & MAC_CR_MII_EN_))
@@ -3190,6 +3192,12 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  adapter->phylink_config.supported_interfaces);
 		break;
+	case PHY_INTERFACE_MODE_RMII:
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  adapter->phylink_config.supported_interfaces);
+		adapter->phylink_config.lpi_capabilities = 0;
+		break;
+
 	default:
 		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
 	}
@@ -3197,6 +3205,9 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	memcpy(adapter->phylink_config.lpi_interfaces,
 	       adapter->phylink_config.supported_interfaces,
 	       sizeof(adapter->phylink_config.lpi_interfaces));
+	if (adapter->phy_interface == PHY_INTERFACE_MODE_RMII)
+		__clear_bit(PHY_INTERFACE_MODE_RMII,
+			    adapter->phylink_config.lpi_interfaces);
 
 	pl = phylink_create(&adapter->phylink_config, NULL,
 			    adapter->phy_interface, &lan743x_phylink_mac_ops);
@@ -3541,6 +3552,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 {
 	struct lan743x_tx *tx;
 	u32 sgmii_ctl;
+	u32 rmii_ctl;
 	int index;
 	int ret;
 
@@ -3562,6 +3574,12 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
 		}
 		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+		rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
+		if (adapter->is_rmii_en)
+			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
+		else
+			rmii_ctl &= ~RMII_CTL_RMII_ENABLE_;
+		lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
@@ -3628,8 +3646,9 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
 			dev_dbg(&adapter->pdev->dev, "lan743x-mdiobus-c45\n");
 		} else {
-			dev_dbg(&adapter->pdev->dev, "RGMII operation\n");
-			// Only C22 support when RGMII I/F
+			dev_dbg(&adapter->pdev->dev, "%s operation\n",
+				adapter->is_rmii_en ? "RMII" : "RGMII");
+			// Only C22 support when RGMII/RMII I/F
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1f8d9294a6ef..d9495cf96b41 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -325,6 +325,9 @@
 #define MAC_WUCSR2_IPV6_TCPSYN_RCD_	BIT(5)
 #define MAC_WUCSR2_IPV4_TCPSYN_RCD_	BIT(4)
 
+#define RMII_CTL			(0x710)
+#define RMII_CTL_RMII_ENABLE_		BIT(0)
+
 #define SGMII_ACC			(0x720)
 #define SGMII_ACC_SGMII_BZY_		BIT(31)
 #define SGMII_ACC_SGMII_WR_		BIT(30)
-- 
2.34.1

