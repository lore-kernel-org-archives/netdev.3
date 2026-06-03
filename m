Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7740803D;
	Wed,  3 Jun 2026 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=GBUnkBxNU3NS9P0byUAKZFfTtqmajvMnXljDmsN9axgXpcWebb1h1DSmsgYZ4ABvyH+l/zkauCtAuLz0R3justP4zPsY4z5ZvooGEyL5sRxRTFy+UwOpqoVisDkecTENoWgHw/8oP29P0HVNjqOjSn1G0sL/2YVyv9+l+565wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=r/ddSYzwIeaKtr/l1g1hn0tBeZ8YM/3rtrN0hXfJAiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SREdqtHXDCXSJwl5wpd5Vb/neXwngfhv82PhWmC9eZpfWmWfgnSveUXWLsqTc/+RFoyXY7On71Enmp1oP7w25wNa0PrMgKStqYeKMu19Sfhslk0q88vOH7vipeO7nXPn8k24J8ljP+HgNUdVp46LrVwyuxqu+G0xFa+sPnvXILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=M+SOgw5R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="M+SOgw5R"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xJ0413643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469960;
	bh=5doYc48c90hZ+yYPfA4Q8tkMnMLQGTUwzlqK67jg5eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=M+SOgw5RLVd45UCTye3LNaBg5uOSVWIjDZU5+h2K7YNAXlQPMVLHMpKhmWulFLEKu
	 ArNjlpjDT5Fp4BWEF2Q4mnY+l0SYMNJ7tW9GYcySAgfwIsU6LehaFObfcINHaB/gI1
	 qwzuwvs6FKgn0+QdxiEpZNeHYbagN0Ksq5nAoSEcMSVYoIl7RX4tOlT6uGXnfAizR6
	 WbUOP33FApDjjje/4/gd2u25pkyxsyYsyx0vr2fNE4gKp2YE3B8wJZV7To1vI0cHyN
	 PxMVkqrXL57AOkn9pGZbBZ8GvjRCO+DaFAO2e0LJFbyZbIBVBJP4VP/DqhQv0B7tEV
	 URB+TMYnwD60A==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xJ0413643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:19 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/5] r8169: fix RTL8116af link readiness bug
Date: Wed, 3 Jun 2026 14:59:14 +0800
Message-ID: <20260603065916.334-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260603065916.334-1-javen_xu@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

For saving power, RTL8116af can not read link status from standard phy
register. Instead, we should read link status through mac register.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 73 +++++++++++++++++++----
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1e2e4074d343..56653608633a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -454,6 +454,12 @@ enum rtl8125_registers {
 
 #define RX_FETCH_DFLT_8125	(8 << 27)
 
+#define OCP_SDS_ADDR_REG	0xEB10
+#define OCP_SDS_CMD_REG		0xEB0E
+#define OCP_SDS_DATA_REG	0xEB14
+#define SDS_CMD_READ		0x0001
+#define RTL_SDS_C22_BASE	0x40
+
 enum rtl_register_content {
 	/* InterruptStatusBits */
 	SYSErr		= 0x8000,
@@ -728,6 +734,12 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rtl_sfp_mode {
+	RTL_SFP_NONE,
+	RTL_SFP_8116_AF,
+	RTL_SFP_8127_ATF,
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -736,6 +748,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -762,7 +775,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1195,13 +1207,42 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 	return val;
 }
 
+static u16 rtl8116af_sds_read(struct rtl8169_private *tp, u16 sds_reg)
+{
+	r8168_mac_ocp_write(tp, OCP_SDS_ADDR_REG, sds_reg);
+	r8168_mac_ocp_write(tp, OCP_SDS_CMD_REG, SDS_CMD_READ);
+	return r8168_mac_ocp_read(tp, OCP_SDS_DATA_REG);
+}
+
+static bool rtl_is_8116af(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
+		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
+		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
+}
+
 static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 {
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
+	if (tp->sfp_mode == RTL_SFP_8116_AF) {
+		switch (reg) {
+		case OCP_STD_PHY_BASE + 2 * MII_PHYSID1:
+			return upper_16_bits(PHY_ID_RTL8116AF_DUMMY);
+		case OCP_STD_PHY_BASE + 2 * MII_PHYSID2:
+			return lower_16_bits(PHY_ID_RTL8116AF_DUMMY);
+		case OCP_STD_PHY_BASE + 2 * MII_BMSR:
+			return rtl8116af_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+		case OCP_STD_PHY_BASE + 2 * MII_BMCR:
+			return rtl8116af_sds_read(tp, RTL_SDS_C22_BASE + MII_BMCR);
+		default:
+			break;
+		}
+	}
+
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1578,6 +1619,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
+{
+	if (rtl_is_8125(tp)) {
+		u16 data = r8168_mac_ocp_read(tp, 0xd006);
+
+		if ((data & 0xff) == 0x07)
+			return RTL_SFP_8127_ATF;
+	} else if (rtl_is_8116af(tp)) {
+		return RTL_SFP_8116_AF;
+	}
+
+	return RTL_SFP_NONE;
+}
+
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
@@ -2394,7 +2449,7 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int duplex = cmd->base.duplex;
 	int speed = cmd->base.speed;
 
-	if (!tp->sfp_mode)
+	if (tp->sfp_mode != RTL_SFP_8127_ATF)
 		return phy_ethtool_ksettings_set(phydev, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
@@ -2552,7 +2607,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_init(tp);
 
 	/* We may have called phy_speed_down before */
@@ -5010,7 +5065,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	phy_stop(tp->phydev);
 
 	/* Reset SerDes PHY to bring down fiber link */
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_reset(tp);
 
 	rtl8169_update_counters(tp);
@@ -5679,13 +5734,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	tp->aspm_manageable = !rc;
 
-	if (rtl_is_8125(tp)) {
-		u16 data = r8168_mac_ocp_read(tp, 0xd006);
-
-		if ((data & 0xff) == 0x07)
-			tp->sfp_mode = true;
-	}
-
+	tp->sfp_mode = rtl_get_sfp_mode(tp);
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
-- 
2.43.0

