Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501F1DDC37;
	Mon, 28 Sep 2026 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579106; cv=none; b=nkkEvQEWEkUW+YaAflX5viRpXwPNJ2NsgweqnkDbtbPmggCEqiL318ccxSr7IgSeUbcBSjLzc22LXebN+9KXVrx0b5GL+54FxMYLdpm0CQSh80AaTGMqFvFxokVeYP8TTNfMBhEo+q8FITnC4cZvSPhpIk7vafIL7lZ9542CTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579106; c=relaxed/simple;
	bh=wvqtZPkmpYzPjOPAv4gnSXFC7dvGnZrYiTA+GiinzYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIu1QekCNg3kuyc8ylovjHnOkpw6XTf4CX514/4UAi0LB9lrnilXAj87OLcObzHwY3eg7hsf/CWR+Xyr7lFeESj8Xkv86LD1fsn66ecsjeleDZ5N0H/e/h/blzH8zuXxVh3PCcl/V0mWMvAXIwvP/dFOsaW0lEAu7edYoaadIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=kYXSLcMh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="kYXSLcMh"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68S74RmtC217875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1790579067;
	bh=33EWe2Y8CJ1/iEVYg8lpMTICXqJEIrXkRUWVJLCUp4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kYXSLcMh8FuEF2g179bBqld7nTjTo5nqT0D25dSJVFADAjnAMud73pLlX6wLmU6uL
	 VXWnjOiXxuzCjm2S+/KPdXAcuJHXq6SN3vLy3H9y/QdfF3MtwzMDAa6F0+AtSi9J75
	 aRumZd27Ajm7ln/cNvOo/VIKfzS1bJvPBxjkZwaTwv0BtltG5GSxIjY9mI7VH7JDUj
	 Nkim/Zy05KNL5zrcfp2Kk+0DrOMgViNZGglOPY1w5C83ts102i6+gnRPUL806WNDsY
	 wWcgQpadcXly2FpayHV9xkpgPOBT5SF/YB3Ulyo+mU4fu/Kyk/uJpZLxv5w0o96BxE
	 XdUUpaIAPv/Rg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68S74RmtC217875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 15:04:27 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 15:04:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 15:04:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v15 6/7] r8169: move struct ethtool_ops
Date: Mon, 28 Sep 2026 15:04:22 +0800
Message-ID: <20260928070423.202-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260928070423.202-1-javen_xu@realsil.com.cn>
References: <20260928070423.202-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

The patch moves the rtl8169_ethtool_ops definition further down in
r8169_main.c so that subsequent additions of rtl8169_get_channels and
rtl8169_set_channels can be referenced from the ops struct without
needing forward declarations.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - modify commit message

Changes in v7:
 - no changes

Changes in v8:
 - no changes

Changes in v9:
 - no changes

Changes in v10:
 - no changes

Changes in v11:
 - no changes

Changes in v12:
 - no changes

Changes in v13:
 - no changes

Changes in v14:
 - no changes
 
Changes in v15:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 56 +++++++++++------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1024cf4596b9..f14178f41801 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2637,34 +2637,6 @@ static int rtl8169_nway_reset(struct net_device *dev)
 	return phylink_ethtool_nway_reset(tp->phylink);
 }
 
-static const struct ethtool_ops rtl8169_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.get_drvinfo		= rtl8169_get_drvinfo,
-	.get_regs_len		= rtl8169_get_regs_len,
-	.get_link		= ethtool_op_get_link,
-	.get_coalesce		= rtl_get_coalesce,
-	.set_coalesce		= rtl_set_coalesce,
-	.get_regs		= rtl8169_get_regs,
-	.get_wol		= rtl8169_get_wol,
-	.set_wol		= rtl8169_set_wol,
-	.get_strings		= rtl8169_get_strings,
-	.get_sset_count		= rtl8169_get_sset_count,
-	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
-	.get_ts_info		= ethtool_op_get_ts_info,
-	.nway_reset		= rtl8169_nway_reset,
-	.get_eee		= rtl8169_get_eee,
-	.set_eee		= rtl8169_set_eee,
-	.get_link_ksettings	= rtl8169_get_link_ksettings,
-	.set_link_ksettings	= rtl8169_set_link_ksettings,
-	.get_ringparam		= rtl8169_get_ringparam,
-	.get_pause_stats	= rtl8169_get_pause_stats,
-	.get_pauseparam		= rtl8169_get_pauseparam,
-	.set_pauseparam		= rtl8169_set_pauseparam,
-	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
-	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
-};
-
 static const struct rtl_chip_info *rtl8169_get_chip_version(u32 xid, bool gmii)
 {
 	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
@@ -6761,6 +6733,34 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static const struct ethtool_ops rtl8169_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.get_drvinfo		= rtl8169_get_drvinfo,
+	.get_regs_len		= rtl8169_get_regs_len,
+	.get_link		= ethtool_op_get_link,
+	.get_coalesce		= rtl_get_coalesce,
+	.set_coalesce		= rtl_set_coalesce,
+	.get_regs		= rtl8169_get_regs,
+	.get_wol		= rtl8169_get_wol,
+	.set_wol		= rtl8169_set_wol,
+	.get_strings		= rtl8169_get_strings,
+	.get_sset_count		= rtl8169_get_sset_count,
+	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.nway_reset		= rtl8169_nway_reset,
+	.get_eee		= rtl8169_get_eee,
+	.set_eee		= rtl8169_set_eee,
+	.get_link_ksettings	= rtl8169_get_link_ksettings,
+	.set_link_ksettings	= rtl8169_set_link_ksettings,
+	.get_ringparam		= rtl8169_get_ringparam,
+	.get_pause_stats	= rtl8169_get_pause_stats,
+	.get_pauseparam		= rtl8169_get_pauseparam,
+	.set_pauseparam		= rtl8169_set_pauseparam,
+	.get_eth_mac_stats	= rtl8169_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
+};
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
-- 
2.43.0

