Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A14119F3;
	Thu,  3 Sep 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420581; cv=none; b=iQHcjsfJaX2WP0IMRE5sqlr9HwTgXD8oE8l94Q+YKYBJlfGGG+WgACAbB/YhZS+5ndVtTZRC1WgHLfI/51DXelLFvOXOCN9fxRolxYFg/Wyas9HypVsMOtJOvBGY069lfZl/rtM7GhgZb4mW3MriT09nJvpaHVWfLBGI9Q34b9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420581; c=relaxed/simple;
	bh=qKNdar3rw/NxENAjemjeEJBAo/H6LYU7D0n6l4s7FM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZfPqyLwPeazTm3CG4yby07lSLlkKMOekcxSUjVwG0vQ8hXah9NzU5qmGSIibm8Cl3EJvOwU9kKDvl7g2UfMCiRONFP40eY7Z1nWY9Iust0+BtWi8sLI+IqZW3Gjhi2h2ynsuX/OZatKLrKXWNWIQcq4FKMPj13VjPTi3Fwidr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YaiBl2CU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YaiBl2CU"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6837SsxzE3295537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788420534; bh=mQq/r51KBnX7DJUQOd04fDEjw2M7VSDiFa2AU4lTGgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YaiBl2CUm8KXfl1KRS8lJdxgDA+LtvEhCjN3wC+u6xaHRV3AGHAdaMdBYIhUB+Nlb
	 pmnApzFwrsm5XhbImGfroEpQ4MkV7VFrU2VLsjsOp0cIRj1J1UC3Tk7ayK8zTTZLZS
	 Xt9RhgR7EYsRCvGrjP3Q2aO5jZrT9+idqWsemQI+DpRU8vpqhXT+Sy3ZP6DF0C6R/7
	 K1inTZwaPyn3qB5i7ynz/wt88oXzXmj2CfxghLzelU3v1tQ/YjtLeALeJ8c/eQlrFm
	 N840T/Jtsb3LV+jZGcDkdpq3g6oBXQcT0vfihBGfwEBu4TvoI7HQGdlUbxIGGe1Bzx
	 lnQHUMOmoKsyg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6837SsxzE3295537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 15:28:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 15:28:53 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 15:28:53 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 1/8] r8152: refactor r8156_init
Date: Thu, 3 Sep 2026 15:28:45 +0800
Message-ID: <20260903072852.58695-2-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903072852.58695-1-nic_swsd@realtek.com>
References: <20260903072852.58695-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 have different init sequences from RTL8156. Split
r8156_init into per-chip functions: r8156_init (VER_10/11), r8156b_init
(VER_12/13/15), r8157_init (VER_16), and r8159_init (VER_17).

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 488 ++++++++++++++++++++++++++++------------
 1 file changed, 349 insertions(+), 139 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 57d04af6368c3..d4289323895e3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -78,6 +78,7 @@
 #define PLA_EEE_TXTWSYS_2P5G	0xe058
 #define PLA_EEEP_CR		0xe080
 #define PLA_MAC_PWR_CTRL	0xe0c0
+#define PLA_RMT_WAKE		0xe0c8
 #define PLA_MAC_PWR_CTRL2	0xe0ca
 #define PLA_MAC_PWR_CTRL3	0xe0cc
 #define PLA_MAC_PWR_CTRL4	0xe0ce
@@ -371,6 +372,9 @@
 #define MCU_CLK_RATIO_MASK	0x0f0f0f0f
 #define ALDPS_SPDWN_RATIO	0x0f87
 
+/* PLA_RMT_WAKE */
+#define RMT_WAKE_EN		BIT(0)
+
 /* PLA_MAC_PWR_CTRL2 */
 #define EEE_SPDWN_RATIO		0x8007
 #define MAC_CLK_SPDWN_EN	BIT(15)
@@ -417,6 +421,7 @@
 
 /* PLA_INDICATE_FALG */
 #define UPCOMING_RUNTIME_D3	BIT(0)
+#define PREBOOT_OPTION		BIT(1)
 
 /* PLA_MACDBG_PRE and PLA_MACDBG_POST */
 #define DEBUG_OE		BIT(0)
@@ -542,6 +547,7 @@
 #define RX_AGG_DISABLE		0x0010
 #define RX_ZERO_EN		0x0080
 #define RX_DESC_16B		0x0400
+#define RX_END_TRANSFER_EN	BIT(11)
 
 /* USB_U2P3_CTRL */
 #define U2P3_ENABLE		0x0001
@@ -4200,6 +4206,22 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 	return data;
 }
 
+static int wait_autoload_done(struct r8152 *tp)
+{
+	u16 ocp_data;
+	int ret;
+
+	ret = read_poll_timeout(ocp_read_word, ocp_data,
+				ocp_data & AUTOLOAD_DONE, 20000,
+				10 * USEC_PER_SEC, false, tp, MCU_TYPE_PLA,
+				PLA_BOOT_CTRL);
+
+	if (ret)
+		dev_err(&tp->intf->dev, "autoload done timeout\n");
+
+	return ret;
+}
+
 static void r8153b_ups_en(struct r8152 *tp, bool enable)
 {
 	if (enable) {
@@ -4218,16 +4240,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
-			int i;
-
-			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-					return;
-				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-				    AUTOLOAD_DONE)
-					break;
-				msleep(20);
-			}
+			if (wait_autoload_done(tp))
+				return;
 
 			tp->rtl_ops.hw_phy_cfg(tp);
 
@@ -4255,16 +4269,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 				  UPS_FORCE_PWR_DOWN);
 
 		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
-			int i;
-
-			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-					return;
-				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-				    AUTOLOAD_DONE)
-					break;
-				msleep(20);
-			}
+			if (wait_autoload_done(tp))
+				return;
 
 			tp->rtl_ops.hw_phy_cfg(tp);
 
@@ -7253,22 +7259,14 @@ static void r8152b_init(struct r8152 *tp)
 static void r8153_init(struct r8152 *tp)
 {
 	u32 ocp_data;
-	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			break;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -7369,22 +7367,13 @@ static void r8153_init(struct r8152 *tp)
 
 static void r8153b_init(struct r8152 *tp)
 {
-	int i;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			break;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -7439,8 +7428,6 @@ static void r8153b_init(struct r8152 *tp)
 
 static void r8153c_init(struct r8152 *tp)
 {
-	int i;
-
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
@@ -7453,15 +7440,8 @@ static void r8153c_init(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_USB, 0xcbf0, BIT(1));
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return;
-	}
+	if (wait_autoload_done(tp))
+		return;
 
 	r8153_phy_status(tp, 0);
 
@@ -8358,90 +8338,132 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
-static int r8159_wait_backup_restore(struct r8152 *tp)
+static void r8156_init(struct r8152 *tp)
 {
-	u32 ocp_data;
+	u16 data;
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if (!(ocp_data & PCUT_STATUS))
-		return 0;
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
 
-	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
-			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
+
+	r8153b_u1u2en(tp, false);
+
+	if (wait_autoload_done(tp))
+		return;
+
+	data = r8153_phy_status(tp, 0);
+	if (data == PHY_STAT_EXT_INIT)
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+
+	r8153_u2p3en(tp, false);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	/* U1/U2/L1 idle timer. 500 us */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
+
+	r8153b_power_cut_en(tp, false);
+	r8156_ups_en(tp, false);
+	r8153_queue_wake(tp, false);
+	rtl_runtime_suspend_enable(tp, false);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	if (tp->udev->speed >= USB_SPEED_SUPER)
+		r8153b_u1u2en(tp, true);
+
+	usb_enable_lpm(tp->udev);
+
+	r8156_mac_clk_spd(tp, true);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
+
+	if (rtl8152_get_speed(tp) & LINK_STATUS)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
+	else
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, CUR_LINK_OK,
+			      POLL_LINK_CHG);
+
+	set_bit(GREEN_ETHERNET, &tp->flags);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
+
+	r8156_mdio_force_mode(tp);
+	rtl_tally_reset(tp);
+
+	tp->coalesce = 15000; /* 15 us */
 }
 
-static void r8156_init(struct r8152 *tp)
+static void r8156b_u2phy_backup(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_USB, 0xd3ce, 0x181b);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d0, 0x616ccd99);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d4, 0x08fc8101);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d8, 0x159b1100);
+	ocp_write_word(tp, MCU_TYPE_USB, 0xd3dc, 0x0a00);
+}
+
+static void r8156b_init(struct r8152 *tp)
 {
 	u32 ocp_data;
 	u16 data;
-	int i;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
-	if (tp->version == RTL_VER_16 || tp->version == RTL_VER_17) {
-		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
-	}
-
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
 
-	if (tp->version < RTL_VER_16)
-		ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
 
 	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15)
-		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
 
 	r8153b_u1u2en(tp, false);
 
 	switch (tp->version) {
 	case RTL_VER_13:
 	case RTL_VER_15:
-	case RTL_VER_16:
-	case RTL_VER_17:
 		r8156b_wait_loading_flash(tp);
 		break;
 	default:
 		break;
 	}
 
-	for (i = 0; i < 500; i++) {
-		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
-		    AUTOLOAD_DONE)
-			break;
-
-		msleep(20);
-		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-			return;
-	}
-
-	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
-		rtl_set_inaccessible(tp);
-		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
+	if (wait_autoload_done(tp))
 		return;
-	}
 
 	data = r8153_phy_status(tp, 0);
 	if (data == PHY_STAT_EXT_INIT) {
 		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
-		if (tp->version >= RTL_VER_12)
-			ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
 	}
 
-	data = r8152_mdio_read(tp, MII_BMCR);
-	if (data & BMCR_PDOWN) {
-		data &= ~BMCR_PDOWN;
-		r8152_mdio_write(tp, MII_BMCR, data);
-	}
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
 
 	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
 
-	if (tp->version >= RTL_VER_16)
-		r8157_u2p3en(tp, false);
-	else
-		r8153_u2p3en(tp, false);
+	r8153_u2p3en(tp, false);
+
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
 
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
@@ -8449,73 +8471,261 @@ static void r8156_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
-	if (tp->version >= RTL_VER_16)
-		r8157_power_cut_en(tp, false);
-	else
-		r8153b_power_cut_en(tp, false);
+	r8156b_u2phy_backup(tp);
 
+	r8153b_power_cut_en(tp, false);
 	r8156_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
 	usb_enable_lpm(tp->udev);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15) {
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
 
-		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
 
-		/* enable fc timer and set timer to 600 ms. */
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER, CTRL_TIMER_EN | (600 / 8));
+	/* enable fc timer and set timer to 600 ms. */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
+		       CTRL_TIMER_EN | (600 / 8));
 
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-		if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
-			ocp_data |= FLOW_CTRL_PATCH_2;
-		ocp_data &= ~AUTO_SPEEDUP;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
+	if (!(ocp_data & DACK_DET_EN))
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+				  FLOW_CTRL_PATCH_2);
 
-		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
-	}
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
 
 	r8156_mac_clk_spd(tp, true);
 
-	if (tp->version < RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS);
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
-		ocp_data |= CUR_LINK_OK;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_data &= ~CUR_LINK_OK;
-	ocp_data |= POLL_LINK_CHG;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS, ocp_data);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+			      CUR_LINK_OK, POLL_LINK_CHG);
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	/* RX aggregation / 16 bytes RX descriptor
-	 * BIT(11) is specific to RTL8159, with unknown meaning
-	 */
-	if (tp->version == RTL_VER_17)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
-				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
-	else if (tp->version == RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
+
+	r8156_mdio_force_mode(tp);
+	rtl_tally_reset(tp);
+
+	tp->coalesce = 15000;	/* 15 us */
+}
+
+static void r8157_init(struct r8152 *tp)
+{
+	u16 data;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	/* Enable SW reset */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
+
+	r8153b_u1u2en(tp, false);
+
+	if (wait_autoload_done(tp))
+		return;
+
+	r8156b_wait_loading_flash(tp);
+
+	data = r8153_phy_status(tp, 0);
+	if (data == PHY_STAT_EXT_INIT) {
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+	}
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+
+	r8157_u2p3en(tp, false);
+
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	/* U1/U2/L1 idle timer. 500 us */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
+
+	r8157_power_cut_en(tp, false);
+	r8156_ups_en(tp, false);
+	r8153_queue_wake(tp, false);
+	rtl_runtime_suspend_enable(tp, false);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	/* Clear Warm RST / Bus RST event flag */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(11));
+
+	if (tp->udev->speed >= USB_SPEED_SUPER)
+		r8153b_u1u2en(tp, true);
+
+	usb_enable_lpm(tp->udev);
+
+	r8156_mac_clk_spd(tp, true);
+
+	if (rtl8152_get_speed(tp) & LINK_STATUS)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
 	else
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_ZERO_EN);
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+			      CUR_LINK_OK, POLL_LINK_CHG);
 
-	if (tp->version < RTL_VER_12)
-		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG, ACT_ODMA);
+	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	if (tp->version >= RTL_VER_16) {
-		/* Disable Rx Zero Len */
-		rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
-		/* TX descriptor Signature */
-		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
+	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);
+
+	/* Disable Rx Zero Len */
+	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
+
+	/* TX descriptor Signature */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
+
+	r8156_mdio_force_mode(tp);
+	rtl_tally_reset(tp);
+
+	tp->coalesce = 15000;	/* 15 us */
+}
+
+static int r8159_wait_backup_restore(struct r8152 *tp)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
+	if (!(ocp_data & PCUT_STATUS))
+		return 0;
+
+	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
+			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
+}
+
+static void r8159_init(struct r8152 *tp)
+{
+	u16 data;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	/* Enable SW reset */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
+
+	r8153b_u1u2en(tp, false);
+
+	if (wait_autoload_done(tp))
+		return;
+
+	if (r8159_wait_backup_restore(tp)) {
+		rtl_set_inaccessible(tp);
+		dev_err(&tp->intf->dev,
+			"init failed, backup-restore timed out\n");
+		return;
 	}
 
+	r8156b_wait_loading_flash(tp);
+
+	data = r8153_phy_status(tp, 0);
+	if (data == PHY_STAT_EXT_INIT) {
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+	}
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+
+	r8157_u2p3en(tp, false);
+
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	/* U1/U2/L1 idle timer. 500 us */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
+
+	r8157_power_cut_en(tp, false);
+	r8156_ups_en(tp, false);
+	r8153_queue_wake(tp, false);
+	rtl_runtime_suspend_enable(tp, false);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	/* Clear Warm RST / Bus RST event flag */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(11));
+
+	/* Disable FW u1u2 patch option */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xb9a6, BIT(0));
+
+	if (tp->udev->speed >= USB_SPEED_SUPER)
+		r8153b_u1u2en(tp, true);
+
+	usb_enable_lpm(tp->udev);
+
+	r8156_mac_clk_spd(tp, true);
+
+	if (rtl8152_get_speed(tp) & LINK_STATUS)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+				  CUR_LINK_OK | POLL_LINK_CHG);
+	else
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
+			      CUR_LINK_OK, POLL_LINK_CHG);
+
+	set_bit(GREEN_ETHERNET, &tp->flags);
+
+	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);
+
+	/* Disable Rx Zero Len */
+	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
+
+	/* TX descriptor Signature */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
+
+	/* Enable u3phy patch backup */
+	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
+
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
 
@@ -9846,7 +10056,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT;
-		ops->init		= r8156_init;
+		ops->init		= r8156b_init;
 		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
@@ -9885,7 +10095,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
-		ops->init		= r8156_init;
+		ops->init		= r8157_init;
 		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
@@ -9907,7 +10117,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
-		ops->init		= r8156_init;
+		ops->init		= r8159_init;
 		ops->enable		= rtl8156_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
-- 
2.34.1

