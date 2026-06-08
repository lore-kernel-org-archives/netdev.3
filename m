Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457E3C09E4;
	Mon,  8 Jun 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913105; cv=none; b=IRHWOXn9skxcvGGV/O4Ds49G9a/nVWvHJflAdHb5dYbV6gOlif3r50GvFWc+S3GkUx5YOC/FMjWbmdfRt4VNr4/B0tEO2+FJh9/oxtTjPkrwTmjgKgfPDG51CxWkSKRNSXEK0tWAUvvEeFg2YIoU90Xm2RkC8660xYlAHAejWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913105; c=relaxed/simple;
	bh=pK8CS9MvrORCEFFnC1jlR8gB8rCvCJSOg0OUvw8+l04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehvMgwAUVwE1D3bwf54pY8yIEFhfzyfjU84HcEpCv+OjTwZ/KG4JjgCm70GaN8gWuMVXHpI9yJfrM2M6RkoNCjAu9H6/kSOgL1HezN+ENkgRMz2WgosGsVoU+YFhIkHnUM51+FqyZPQrg0+PPWFmqnSADo0HE5sPv1akFhZQAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=USU4APxM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="USU4APxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780913103; x=1812449103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pK8CS9MvrORCEFFnC1jlR8gB8rCvCJSOg0OUvw8+l04=;
  b=USU4APxMhOyUZWPESrLTbliddCOkkTn+35DKC4WFA9EOFLwF0UMQDl8s
   YQUGAOCLISlhiMfb4lgL4rQ4FaXWK2bkBbTo1pv/fsy1a5WcFD0TBNtef
   O/+oX7Bd9U9Dwl4mUJz3ZXt5I/u6iIVilXn3ueqBmbp2DDQ2Uxs1Qmr9l
   W+pg2o80Xuy2WDLSm7JoBnbisb/I3BUOYkIRcez+yUXwXSB4Pho4pupMb
   NROJvFiazkNIvCo2i2RbWbNpEgArQaKSo5aYvlr8MbYkLo7TTKXZiobIO
   iqesMyQJYSK5rYVA+FVzXH5AkImjPqnvL6nwCYKvumLDCwilfSY4ue8du
   w==;
X-CSE-ConnectionGUID: 2tqGft09R7G4Mrjz4VQQ4w==
X-CSE-MsgGUID: f9ediMdxQTWlm2z2n5zojA==
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="225960970"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2026 03:05:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Jun 2026 03:05:02 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Jun 2026 03:04:59 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 2/2] net: lan743x: add support for RMII interface
Date: Mon, 8 Jun 2026 15:34:35 +0530
Message-ID: <20260608100435.11214-3-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608100435.11214-1-thangaraj.s@microchip.com>
References: <20260608100435.11214-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
Changes in v3:
  - Update commit message to document that EEE is disabled by setting
    lpi_capabilities = 0

Changes in v2:
  - Remove redundant mac_capabilities &= ~MAC_1000FD; phylink already
    handles capability reduction for RMII via phy_caps_from_interface()

 drivers/net/ethernet/microchip/lan743x_main.c | 17 +++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 0798f3f1f435..ad3f833c8d86 100644
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
 
@@ -3562,6 +3574,11 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
 		}
 		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+		if (adapter->is_rmii_en) {
+			rmii_ctl = lan743x_csr_read(adapter, RMII_CTL);
+			rmii_ctl |= RMII_CTL_RMII_ENABLE_;
+			lan743x_csr_write(adapter, RMII_CTL, rmii_ctl);
+		}
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
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

