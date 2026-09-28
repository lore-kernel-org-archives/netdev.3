Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864E5038E5;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634324; cv=none; b=pP6UJb7Or21Pv97ymQAfuwRTVDCD5zuLv3tDWT7g8sHjqCsc0DytqBDvhrbD0B4C+pb6Mtvlu9DXac89+TNmRUI0ulXaFtleiYctB9p1RFdN+rK+aDNwD/Oo6ItxF3o1LOD5OnF1IBhDhNuz2l4je6qyIRC3SluyJE1PcJ/43CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634324; c=relaxed/simple;
	bh=xCK4ZN45BBmZH4eqj3BHK8o5ZoGntyVni20+PCKEE1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8M1peeHgbiMHlvnc1GGiEXn5pEDw7RdMV44IpzhBT7vGL8W/KSxOnL+N23/0GheOC7WQnWj7/Ngvw/7kNkBvl0/AwH9y081avf2ZRb70UHmx0Wt5Z13oTFdJzrRnbhK8xADyiCM2hVXxL1S3dexi6rwnrppEu7G4/xBdpcu/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMVf5MXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMVf5MXP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B029C4AF62;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790634324;
	bh=xCK4ZN45BBmZH4eqj3BHK8o5ZoGntyVni20+PCKEE1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EMVf5MXPogjwHK+oWebf4kW88c9W5XGRDWJdqlJG9IlmxL9pYq3EwR4z6J8V4ticw
	 wYejL94cQdwh61KRAHaoIUaKtj12OVACRadTgKRUCZmfdDD3iO9qIUstWCC2q4zsro
	 2vI8XGRf1FcTyQl+PO2TaLdFw0FFcwS3s+V+5HBY9WW2fQf1Hfas8WZEp5BxmfcXDS
	 vIr7jUNNXsLdSZHvyxWzkNilo1OW+8G3Cs5VtRIC/nEAC0BhLfLmuhdeGKDLtlOgaP
	 j1WzdRYed9XuS5MKNkecyzmG1zKvQJV+U67E7p+T5DUdlg0HGTZ4aCaRJJX4Iehujw
	 EKRltsLBPN2Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77144CA5FA1;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 28 Sep 2026 15:25:13 -0700
Subject: [PATCH net-next v8 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-s2500-mac-phy-support-v8-6-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790634319; l=3615;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=NqQh5AjrG3OFsRhaNIoGIEp2Di6NevhQyuBM33Wjyoo=;
 b=/IHASgfAyLNstEy0MQHet0KBtVIdhtFtgxzgiG22gPO48XqRuVNJq26RL2w4iDgVs3Ont7orE
 ApuGKrAsV5FCTVsLuHOYvp+2kiVsEWmScGGV31KDxnlgPAdXHYDbKuN
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OPEN Alliance 10BASE-T1x Serial Interface specification, table 6
allows vendors to use any memory map select (MMS) value between
10 and 15. This new API interface enables vendor to map one of
thes MMS values to MDIO_MMD_VEND1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v8
  - No change
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - no change
changes in v4
  - no change
changes in v3
  - no change
changes in v2
  - Moved the handling of vendor specific MMS mapping to separate patch
  - new patch
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c         | 20 +++++++++++++++++---
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h |  1 +
 include/linux/oa_tc6.h                       |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 5cbe049f76ef..c1774fe84ba4 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -250,6 +250,18 @@ static int oa_tc6_update_standard_capability(struct oa_tc6 *tc6)
 	return 0;
 }
 
+/**
+ * oa_tc6_set_vend1_mms - Add vendor specific MDIO_MMD to OA TC6 MMS
+ * mapper value.
+ * @tc6: oa_tc6 struct.
+ * @mms: vendor defined MMS value for VEND1 mdio device.
+ */
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
+{
+	tc6->vend1_mms = mms;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_set_vend1_mms);
+
 static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 					 enum oa_tc6_register_op reg_op)
 {
@@ -577,7 +589,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 				     val);
 }
 
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 	switch (devnum) {
 	case MDIO_MMD_PCS:
@@ -590,6 +602,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 	case MDIO_MMD_POWER_UNIT:
 		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+	case MDIO_MMD_VEND1:
+		return tc6->vend1_mms;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -603,7 +617,7 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	int mms;
 	int ret;
 
-	mms = oa_tc6_get_phy_c45_mms(devnum);
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (mms < 0)
 		return mms;
 
@@ -621,7 +635,7 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int mms;
 
-	mms = oa_tc6_get_phy_c45_mms(devnum);
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (mms < 0)
 		return mms;
 
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
index 06fe88f1ed7c..192cc2eaa041 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -127,6 +127,7 @@ struct oa_tc6 {
 	u64 tx_hwtstamp_err;
 	u8 ts_ttsc_pending;
 	u8 ttsc_current_id;
+	int vend1_mms;
 };
 
 enum oa_tc6_header_type {
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 365abdbf60d3..88e7d5491b20 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -114,5 +114,6 @@ void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
 			 struct ethtool_ts_stats *stats);
 int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
 			struct kernel_hwtstamp_config *cfg);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
 void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
 #endif /* _LINUX_OA_TC6_H */

-- 
2.43.0


