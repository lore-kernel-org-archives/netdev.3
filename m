Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CC305694;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=PJy7j2pJ8I6XoE/qroLjoT9qLfxUulqbzfmYOq4Wo06T9aRu4LPFx5ognVaDSw5PJuE1ByIBXPN5PBCmMMi2xa2jY09mTT4Av1I9GuQGgcI8QWTAAXJuU4fx48PL6zo+CyPWSiouUTNDCp7n9HfsT69XfCxK8Pt/ltyj6SECXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=ifMhxS+DRCkQ8AAyt0KpaIw9DM+lD+OKUG0V9jkgQ4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJwFVzP+Hg4IEVW8zMvqtpcR5PO3BW4tmSFg/MalooUGWynMLJ3Ir9hbDHbc2NodIiM0NqCnlj8oiWv+jHqOpoV7SJ3WndFx/4pjybbo08crhcx/YX0Xh/bFT++xWSaRQ2A29xidok/y1XZhVjN9M/yPofteFR4NOOfODy0o1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiS71qPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiS71qPB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E5B2C2BCF6;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=ifMhxS+DRCkQ8AAyt0KpaIw9DM+lD+OKUG0V9jkgQ4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MiS71qPBAOZSdobSXakTm8SpLdPFIjRQFX0ePzlPFOj80Hbto7ZBrnIwudD3kZjiE
	 45ipiPgsqNV9sS7rfiRbybain1PW1OZgjED6vG/A8S5tS4Q1WQV1WpfrQByL1aZ7BL
	 Bxw52U5ybd82k6ZgN9hxwcy8AlLLK/cP5oDDhrUVvEm4Mr8Gt1JQ2gv0nb6HU4k3Ru
	 9Ziog2cfuIBaQaPiH84GOddK7HJc9EPwPo/wJbuS7X07+Z0smsRAygOpTaok8zjv+f
	 z5a8rXdL6vD8fClYi+IPAczrldSsSkvqvI6ndtC8Vjb75/11ZrI4Z6eab0whu+69iU
	 oaCRgJ0s0dG/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87659CD8C8D;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:38 -0700
Subject: [PATCH net-next v4 07/16] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-7-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=3139;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=nbQfy8zsWMbmAyspM8wQU+sSMRnj53ReA9nG6bU9G9A=;
 b=ckfq+FmcO98bmlF271aK9dudpewPWOwYZLOqjE0b9ajRHJWt4VAFWPAVNDYZrUM9bwn8WIbsk
 nLNC+Vr9MJVD2K36i0f9XwMV0KbLKadaTI2vVTU3fuKwWyOe77vF8vh
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

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 20 +++++++++++++++++---
 include/linux/oa_tc6.h               |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 9410cecfdc2a..2f9ace655e81 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -202,6 +202,17 @@ int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_ioctl);
 
+/**
+ * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
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
@@ -455,7 +466,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 				     val);
 }
 
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 	switch (devnum) {
 	case MDIO_MMD_PCS:
@@ -468,6 +479,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 	case MDIO_MMD_POWER_UNIT:
 		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+	case MDIO_MMD_VEND1:
+		return tc6->vend1_mms;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -480,7 +493,7 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	u32 regval;
 	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
+	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (ret < 0)
 		return ret;
 
@@ -497,7 +510,7 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(devnum);
+	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (ret < 0)
 		return ret;
 
@@ -1281,6 +1294,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
+	tc6->vend1_mms = -EOPNOTSUPP;
 	tc6->tx_ts_idx = OA_TC6_TTSCA_REG_ID;
 	INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 4047c22a366a..a89151267713 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -47,5 +47,6 @@ void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
 			 struct ethtool_ts_stats *ts_stats);
 int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
 			struct kernel_hwtstamp_config *cfg);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
 void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
 #endif /* _LINUX_OA_TC6_H */

-- 
2.43.0


