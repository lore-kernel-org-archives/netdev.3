Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B24AEBCE;
	Thu,  1 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845946; cv=none; b=MVSVRw5vniXnPxDaMwWDscMR49uyHY2oWbGjqRmwjxWKjJMuIqWGoMGvkHTR91gzCGsA1bN71OSU6/ZQNGHEvWeqnxo0PVytDnFUMPneTsUXud3jDtJnvZRsXPfuLYx3DuBH5P3yg/1wxww3ST+KWATtx6OkJNA658oTaYUzsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845946; c=relaxed/simple;
	bh=FA6j5JqcHt1yCioA7W/XdRkn8yWoeJyPx0QDqns3stM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhMQz6hR3EbwblzcGPk7zVqQ4TeS9lCbyIHQNtOdKqi1LrLRz77FdfxraKNmkL2YlfpAZij0Q5B404u4zly4ckWXDsQEnzpV7kFrdIqTdwZkcnA1QX4L7MfF1o1mgVmu1fIWyslVTrE00AwcNKWuMIcIOKOhBK21+J3tz7SQZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vEpIwHxa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vEpIwHxa"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6919BkFQ22836516, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790845906; bh=nBW1g1nPxPMwNxXnses9MWzP0qVk986oDrR6fAgpMlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vEpIwHxaEZAcxbEoyXPK3oOWFxAjIN8T4BLyZsfpo4ED9XCk+Z2xdfbsTlWiVu8GU
	 k9PFWVouqBxXwGz1qXvETcHm0FnrYKEwu/ip9HHw8PVUqguBmzFsj0MfUSiwtS+gDH
	 LZ3is87kuddM334jGmIgXK1dBCV2L7XkRfFeLCyivgcwMDxQGZU3X6hR4dUd3Fzbck
	 5n+XZpk/B/IYN4BHjT+jLnQr4X73NQ/uG8aQIn3v7h5MxQLjVmfTTplkpXPialeLTm
	 CMwW9A9Yzl87RuNmz/bMPIdNaR+JS16TFg3QPhjTnZ3i37n/JX9QJwI5DPCj/mHFdB
	 RtVUdQR7Gw0LA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6919BkFQ22836516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 17:11:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:46 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:11:46 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v5 3/9] r8152: split rtl8156_enable/up/down into per-chip-family functions
Date: Thu, 1 Oct 2026 17:11:38 +0800
Message-ID: <20261001091144.28191-4-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001091144.28191-1-nic_swsd@realtek.com>
References: <20261001091144.28191-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

rtl8156_enable(), rtl8156_up() and rtl8156_down() had accumulated
tp->version range checks to cover RTL8156, RTL8156B, and
RTL8157/RTL8159, including an early bail-out in rtl8156_enable()
that skipped most of the function body for RTL8157/RTL8159. The
result hides which settings belong to which chip, so chip-specific
register differences cannot be reviewed, and cannot be added without
touching the other families.

Give each family its own ops callback: rtl8156b_enable() for
VER_12/13/15, and rtl8157_enable()/rtl8157_up()/rtl8157_down() for
VER_16/17. rtl8156_enable() keeps serving RTL8156 (VER_10/11) and
rtl8156_up()/rtl8156_down() keep serving RTL8156 and RTL8156B
(VER_10/11/12/13/15).

Each extracted function reproduces what its chips already did, with
the guards that were true for them inlined and the ones that were
false dropped as unreachable. The one judgement call is
r8156_fc_parameter(): its "tp->version < RTL_VER_12" guard becomes
unreachable in rtl8156b_enable(), so the call is dropped rather than
carried over as dead code.

No functional change intended.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 206 ++++++++++++++++++++++++++++++++--------
 1 file changed, 168 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30af6ed3a638f..cb5e5985e1049 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6413,25 +6413,16 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
-	if (tp->version < RTL_VER_12)
-		r8156_fc_parameter(tp);
-
+	r8156_fc_parameter(tp);
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17_QFN100)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM,
-				  RX_AGGR_NUM_MASK);
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
@@ -6439,12 +6430,10 @@ static int rtl8156_enable(struct r8152 *tp)
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
@@ -6469,6 +6458,67 @@ static void rtl8156_disable(struct r8152 *tp)
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
@@ -6829,8 +6879,7 @@ static void rtl8156_up(struct r8152 *tp)
 		return;
 
 	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, false);
+	r8153_u2p3en(tp, false);
 	r8153_aldps_en(tp, false);
 
 	rxdy_gated_en(tp, true);
@@ -6843,9 +6892,6 @@ static void rtl8156_up(struct r8152 *tp)
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	if (tp->version >= RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
-
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
@@ -6866,11 +6912,11 @@ static void rtl8156_up(struct r8152 *tp)
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
 
@@ -6880,10 +6926,9 @@ static void rtl8156_up(struct r8152 *tp)
 	}
 
 	r8153_aldps_en(tp, true);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, true);
+	r8153_u2p3en(tp, true);
 
-	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
+	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
 
@@ -6896,12 +6941,97 @@ static void rtl8156_down(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
 			  PLA_MCU_SPDWN_EN);
+	r8153b_u1u2en(tp, false);
+	r8153_u2p3en(tp, false);
+	r8153b_power_cut_en(tp, false);
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
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
+
+	/* Clear teredo wake event. bit[15:8] is the teredo wakeup
+	 * type. Set it to zero. bits[7:0] are the W1C bits about
+	 * the events. Set them to all 1 to clear them.
+	 */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
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
 
 	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16) {
-		r8153_u2p3en(tp, false);
-		r8153b_power_cut_en(tp, false);
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
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
+
+	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
+
+	if (tp->saved_wolopts != __rtl_get_wol(tp)) {
+		netif_warn(tp, ifup, tp->netdev, "wol setting is changed\n");
+		__rtl_set_wol(tp, tp->saved_wolopts);
 	}
+
+	r8153_aldps_en(tp, true);
+}
+
+static void rtl8157_down(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
+		rtl_drop_queued_tx(tp);
+		return;
+	}
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
+
+	r8153b_u1u2en(tp, false);
 	r8153_aldps_en(tp, false);
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
@@ -10045,7 +10175,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
 		tp->eee_adv2		= MDIO_EEE_2_5GT;
 		ops->init		= r8156b_init;
-		ops->enable		= rtl8156_enable;
+		ops->enable		= rtl8156b_enable;
 		ops->disable		= rtl8153_disable;
 		ops->up			= rtl8156_up;
 		ops->down		= rtl8156_down;
@@ -10084,10 +10214,10 @@ static int rtl_ops_init(struct r8152 *tp)
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
@@ -10107,10 +10237,10 @@ static int rtl_ops_init(struct r8152 *tp)
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

