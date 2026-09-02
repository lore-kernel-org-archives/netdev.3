Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2532BE051;
	Wed,  2 Sep 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340039; cv=none; b=k9Lx53g2sRTqxBV8YYzbp1i5YZZSGGeSDZ878oA0VQ5H9mPlHAV2pxKseIKLnPC4GHy9qbYkDyjqLeCJwH+R2rNrAQDfFuiAcs++giic8WK1cJlOBhLprgGswI0BBGAlLxgG7mCe/euCDTwgG09VBdT4jcSF1flk2sAn4u1+6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340039; c=relaxed/simple;
	bh=9lgCrvi7RMOUrDe4iulHeeIjVWH6ay7NR6fmkh+shdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy4GjnfGyAqe2no/Nfs5c1x6DUbIlSoTYku6o2xh8OLVqpNSgA88E0OqhfP5x+wxUpOZdk469pigFGDVXugdF3l8HdPQIy7N9Jh7C1IJ4YVY6okwKwYz0Z5Q/IREZc6uoe3C/ikxWv15RK9CEk2jVh3xRdmUn0kJ6ZQANS2TpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aFeJHPlH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aFeJHPlH"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68296h7G22526937, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788340003; bh=MHPfgcMYhFTrknliraJ6QNZ6YXnda8VXdBW0J2BVbRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aFeJHPlHUpSwfxnnJfq+Y7vmfGRna4i4q1cinV8aC03miqmAJreGnqg3Ux81ws/uI
	 SmW8KL2w0m0htvBTlbP5YZ+XUlbzS3eBvNLNeAFOmPA7nz2V9gJB96ViSPHIX8p3lQ
	 QeVaCw/JIeLCE/LoRXpKRryFLcxn5uGlqtqIh0tATTUL9szEJTKtAkNg5gvIfYFsDk
	 uMGurRa60no8SmgWkSyxq2vRfHA9707/b4yFp6OtmCR6A9SD8YoS6daxJZdPqvDAAw
	 g0ALP/k6879u2jMpSfuqtUYAeZPbjsUojUs/sePySJnJsErHL3fMKATHyH9j7kx0lx
	 LYe/tlAmOm0Bg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68296h7G22526937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 17:06:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 17:06:43 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 2 Sep 2026 17:06:43 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 3/8] r8152: refactor rtl8156_enable, rtl8156_up, and rtl8156_down
Date: Wed, 2 Sep 2026 17:06:27 +0800
Message-ID: <20260902090632.41844-4-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902090632.41844-1-nic_swsd@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 235 ++++++++++++++++++++++++++++++++--------
 1 file changed, 189 insertions(+), 46 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 38e78b0f20b30..53835453913c8 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6440,31 +6440,16 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
-	if (tp->version < RTL_VER_12)
-		r8156_fc_parameter(tp);
-
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	switch (tp->version) {
-	case RTL_VER_10:
-	case RTL_VER_11:
-		break;
-	default:
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM,
-				  RX_AGGR_NUM_MASK);
-		break;
-	}
-
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
 
 	speed = rtl8152_get_speed(tp);
 	rtl_set_ifg(tp, speed);
 
-	if (tp->version >= RTL_VER_16)
-		return rtl_enable(tp);
-
 	if (speed & _2500bps)
 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
 				  IDLE_SPDWN_EN);
@@ -6472,12 +6457,10 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
 				  IDLE_SPDWN_EN);
 
-	if (tp->version < RTL_VER_12) {
-		if (speed & _1000bps)
-			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
-		else if (speed & _500bps)
-			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);
-	}
+	if (speed & _1000bps)
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
+	else if (speed & _500bps)
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);
 
 	if (tp->udev->speed == USB_SPEED_HIGH) {
 		/* USB 0xb45e[3:0] l1_nyet_hird */
@@ -6502,6 +6485,67 @@ static void rtl8156_disable(struct r8152 *tp)
 	rtl8153_disable(tp);
 }
 
+static int rtl8156b_enable(struct r8152 *tp)
+{
+	u16 speed;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return -ENODEV;
+
+	set_tx_qlen(tp);
+	rtl_set_eee_plus(tp);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+
+	r8153_set_rx_early_timeout(tp);
+	r8153_set_rx_early_size(tp);
+
+	speed = rtl8152_get_speed(tp);
+	rtl_set_ifg(tp, speed);
+
+	if (speed & _2500bps)
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
+	else
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  IDLE_SPDWN_EN);
+
+	if (tp->udev->speed == USB_SPEED_HIGH) {
+		/* USB 0xb45e[3:0] l1_nyet_hird */
+		if (is_flow_control(speed))
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0xf);
+		else
+			ocp_word_w0w1(tp, MCU_TYPE_USB, USB_L1_CTRL, 0xf, 0x1);
+	}
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	usleep_range(1000, 2000);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+
+	return rtl_enable(tp);
+}
+
+static int rtl8157_enable(struct r8152 *tp)
+{
+	u16 speed;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return -ENODEV;
+
+	set_tx_qlen(tp);
+	rtl_set_eee_plus(tp);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+
+	r8153_set_rx_early_timeout(tp);
+	r8153_set_rx_early_size(tp);
+
+	speed = rtl8152_get_speed(tp);
+	rtl_set_ifg(tp, speed);
+
+	return rtl_enable(tp);
+}
+
 static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 			     u32 advertising)
 {
@@ -6862,8 +6906,7 @@ static void rtl8156_up(struct r8152 *tp)
 		return;
 
 	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, false);
+	r8153_u2p3en(tp, false);
 	r8153_aldps_en(tp, false);
 
 	rxdy_gated_en(tp, true);
@@ -6876,8 +6919,7 @@ static void rtl8156_up(struct r8152 *tp)
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	if (tp->version >= RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -6899,11 +6941,11 @@ static void rtl8156_up(struct r8152 *tp)
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
 		      0x08);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
 
-	if (tp->version < RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
-				  RG_PWRDN_EN | ALL_SPEED_OFF);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -6913,10 +6955,19 @@ static void rtl8156_up(struct r8152 *tp)
 	}
 
 	r8153_aldps_en(tp, true);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, true);
+	r8153_u2p3en(tp, true);
 
-	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
+	switch (tp->version) {
+	case RTL_VER_13:
+	case RTL_VER_15:
+		/* Enable Clear_SDR */
+		ocp_word_set_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(15));
+		break;
+	default:
+		break;
+	}
+
+	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
 
@@ -6929,12 +6980,9 @@ static void rtl8156_down(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
 			  PLA_MCU_SPDWN_EN);
-
 	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16) {
-		r8153_u2p3en(tp, false);
-		r8153b_power_cut_en(tp, false);
-	}
+	r8153_u2p3en(tp, false);
+	r8153b_power_cut_en(tp, false);
 	r8153_aldps_en(tp, false);
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
@@ -6956,7 +7004,102 @@ static void rtl8156_down(struct r8152 *tp)
 	 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
 
-	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
+
+	rtl_rx_vlan_en(tp, true);
+	rxdy_gated_en(tp, false);
+
+	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
+			   RCR_APM | RCR_AM | RCR_AB);
+
+	r8153_aldps_en(tp, true);
+}
+
+static void rtl8157_up(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	r8153b_u1u2en(tp, false);
+	r8153_aldps_en(tp, false);
+
+	rxdy_gated_en(tp, true);
+	r8153_teredo_off(tp);
+
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
+
+	rtl8152_nic_reset(tp);
+	rtl_reset_bmu(tp);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
+
+	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
+
+	rtl8156_change_mtu(tp);
+
+	/* share FIFO settings */
+	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
+		      0x08);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
+
+	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
+
+	if (tp->saved_wolopts != __rtl_get_wol(tp)) {
+		netif_warn(tp, ifup, tp->netdev, "wol setting is changed\n");
+		__rtl_set_wol(tp, tp->saved_wolopts);
+	}
+
+	r8153_aldps_en(tp, true);
+
+	/* Clear_SDR */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
+}
+
+static void rtl8157_down(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
+		rtl_drop_queued_tx(tp);
+		return;
+	}
+
+	r8153b_u1u2en(tp, false);
+	r8153_aldps_en(tp, false);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+
+	/* RX FIFO settings for OOB */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, 64 / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 1024 / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 4096 / 16);
+
+	rtl_disable(tp);
+	rtl_reset_bmu(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);
+
+	/* Clear teredo wake event. bit[15:8] is the teredo wakeup
+	 * type. Set it to zero. bits[7:0] are the W1C bits about
+	 * the events. Set them to all 1 to clear them.
+	 */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -10142,7 +10285,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT;
 		ops->init		= r8156b_init;
-		ops->enable		= rtl8156_enable;
+		ops->enable		= rtl8156b_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
@@ -10181,10 +10324,10 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
 		ops->init		= r8157_init;
-		ops->enable		= rtl8156_enable;
+		ops->enable		= rtl8157_enable;
 		ops->disable		= rtl8153_disable;
-		ops->up			= rtl8156_up;
-		ops->down		= rtl8156_down;
+		ops->up			= rtl8157_up;
+		ops->down		= rtl8157_down;
 		ops->unload		= rtl8153_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
@@ -10204,10 +10347,10 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
 		ops->init		= r8159_init;
-		ops->enable		= rtl8156_enable;
+		ops->enable		= rtl8157_enable;
 		ops->disable		= rtl8153_disable;
-		ops->up			= rtl8156_up;
-		ops->down		= rtl8156_down;
+		ops->up			= rtl8157_up;
+		ops->down		= rtl8157_down;
 		ops->unload		= rtl8153_unload;
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
-- 
2.34.1

