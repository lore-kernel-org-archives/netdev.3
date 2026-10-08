Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC83D0929;
	Thu,  8 Oct 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442993; cv=none; b=nAiIpnc+TZaH6BaWDx/xxS+nER4iOZAjvkwbJH4cV8S1afcrP28M2zdqWzrSI9pZ0cDywvGrWtHaf2kphDF4oDGLzJfcBMwDbGzRl0FklH9+2dYiOZBgPA3jUXT44NMjm24DEz/1rwlftljjclaJhZI4RvoOoXDr83/yUXIX8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442993; c=relaxed/simple;
	bh=xYKy2fpKhKFTe1C8NVY7vrWpFu7yeRL6dx9+nShdKx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJQXCSD9ePGqF3IJFhS7b8z4EaqdA9zmg3fo/SiNCKydrKyxpYdqlMU3mIWrAHS+lwIoGhIoKt/2l9sCg+BjwU4qBTbyFy9IjepS/0I8z4SamXuCpvE3uU44zNfnoEDsCEwbtjGdxNV0MaRX+o+HoXx4YfFQJxt+YtrJr2hbPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DTgLdMfv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="DTgLdMfv"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6986vQPT1281951, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1791442647;
	bh=O6NFmxmZ5r0OQDP8nbBcMDiKp2lqsJuJRyjEH5pccXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DTgLdMfvPs5H84iw/pSmgN2PKcm8I1L9ygJhNl98njJxfihlDEr7NG55op3I6fXwy
	 HencXZ1nMxb3oWdJXs5j6v4anecMuRzkKaxZiWKzPF4nqFxDa+c8O8LyyKzJjqtwSC
	 j8Qc/Smu0Y65B3oVXC3+s2ogoDcm6qC9HeJlK5KAbM8Tst5ZNjGhfCBnLW5rb3coan
	 84IiwxdCOlmmTSJ3OlGLzjTbarSE58fAyDqDjg1me7v4FG2jdLAwBKrH/mS0ZggvFL
	 o8uBICg5u9vOGz0Uf+JGajDW/6/BupXmCuOm4wGAHzd3cDlkPCja9CLhthISMOibvM
	 FRPGooITun38Q==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6986vQPT1281951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 14:57:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:57:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 14:57:26 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v16 6/7] r8169: move struct ethtool_ops
Date: Thu, 8 Oct 2026 14:57:21 +0800
Message-ID: <20261008065722.1026-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261008065722.1026-1-javen_xu@realsil.com.cn>
References: <20261008065722.1026-1-javen_xu@realsil.com.cn>
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
can be referenced from the ops struct without needing forward
declarations.

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

Changes in v16:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 56 +++++++++++------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 671a20c6e39a..de0c860328ba 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2636,34 +2636,6 @@ static int rtl8169_nway_reset(struct net_device *dev)
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
@@ -6769,6 +6741,34 @@ static void r8169_init_napi(struct rtl8169_private *tp)
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

