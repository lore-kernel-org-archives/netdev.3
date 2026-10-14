Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383337E5CB;
	Wed, 14 Oct 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966001; cv=none; b=r12DiRz9Eu2J93H7FwHCXsvW7EJzr/DfFLhg2gms8kNRHcoJ5da2BCU77AqLGwUNH29QheDikMIe7V/Op7/O9NAVn9w473HhP+r0dGm9GveiqXh3wIbZdIqwDP2Nea/urymd20WtqQAZT7rfyFRaXdWY/TMOBF8+dHv0r0khVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966001; c=relaxed/simple;
	bh=E6M35NlOipcyqlTRHvGqsuDDoY1wgmpvWkD5pD4aWpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpMNl9U1KG7ZsJTj7FJz8+Q0K6GUu+8cp2qqXTVmmyrT+rAHhdEuyemNrDOSLqUi9vP+GlBpR98Xu8a4/E/NUDt0RIYe7ql2tSWUwQ50/l4XvmeDdcEJ9MGblJb8cZGeSqS1coAdXitFRZQe6uMJ+pGnfgp6BXHBEbyFcNNaRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NAeVFwnw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NAeVFwnw"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8JAaL41418223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965950; bh=V5nr0q6bTiN7bG1U1I+AYbqp7kW7LLgbXepjjJduhzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NAeVFwnwuZjmZzsATkizqk36cWDwbPOMLmZI1xSuk4KGQHhgMJ9JatMAbH/SannqW
	 G1SUaFfUmQPyf2dhQBoHHnfFr4Nj4o77dxLFIcQUaHIQoctx/5FarMJ74sGfQ4hdYz
	 t5yJJCdGpmOoLs/iqiz5kwV0iT4dKwd+DqlLsydvmpgRC/8p/dAyIqNSyH1RGkUNrt
	 apodUQZve0xhGO9jie735jX7DlFtjc/E5tO+6KVZH3e+eDEdF+vJU6F5ItWS7TVLWq
	 iweGbxpyZJshzXp+uatBlQQhdyUnCAdmSn+C15t+Mq5tCNXRiXq1uLZ45VMsDMLqaT
	 RCPEayTxQ7Z1Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8JAaL41418223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 16:19:07 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 16:19:07 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 04/10] r8152: split rtl8156_enable/up/down into per-generation functions
Date: Wed, 14 Oct 2026 16:18:58 +0800
Message-ID: <20261014081904.6491-5-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014081904.6491-1-nic_swsd@realtek.com>
References: <20261014081904.6491-1-nic_swsd@realtek.com>
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

Give each generation its own ops callback: rtl8156_enable() for
VER_10/11/12/13/15, and rtl8157_enable()/rtl8157_up()/rtl8157_down()
for VER_16/17. rtl8156_up()/rtl8156_down() keep serving RTL8156 and
RTL8156B (VER_10/11/12/13/15).

RTL8156/8156B/8157/8159 share most of the up/down sequence, so move
it into common helpers, as RTL8152B/8153 do with exit_oob/enter_oob.

Each extracted function reproduces what its chips already did, with
the guards that were true for them inlined and the ones that were
false dropped as unreachable.

No functional change intended.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 166 +++++++++++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 43 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 25fce499f7938..b245b63fb6aaf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6413,14 +6413,28 @@ static int rtl8156_enable(struct r8152 *tp)
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
-	if (tp->version < RTL_VER_12)
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
 		r8156_fc_parameter(tp);
+		break;
+	default:
+		break;
+	}
 
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17_QFN100)
+	switch (tp->version) {
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+		break;
+	default:
+		break;
+	}
 
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
@@ -6428,9 +6442,6 @@ static int rtl8156_enable(struct r8152 *tp)
 	speed = rtl8152_get_speed(tp);
 	rtl_set_ifg(tp, speed);
 
-	if (tp->version >= RTL_VER_16)
-		return rtl_enable(tp);
-
 	if (speed & _2500bps)
 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
 				  IDLE_SPDWN_EN);
@@ -6438,11 +6449,17 @@ static int rtl8156_enable(struct r8152 *tp)
 		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
 				  IDLE_SPDWN_EN);
 
-	if (tp->version < RTL_VER_12) {
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
 		if (speed & _1000bps)
 			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x11);
 		else if (speed & _500bps)
 			ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS, 0x3d);
+		break;
+	default:
+		break;
 	}
 
 	if (tp->udev->speed == USB_SPEED_HIGH) {
@@ -6468,6 +6485,27 @@ static void rtl8156_disable(struct r8152 *tp)
 	rtl8153_disable(tp);
 }
 
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
@@ -6822,16 +6860,8 @@ static void rtl8156_change_mtu(struct r8152 *tp)
 		       ALIGN(rx_max_size + tp->tx_desc.size, 1024) / 16);
 }
 
-static void rtl8156_up(struct r8152 *tp)
+static void r8156_exit_oob(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		return;
-
-	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, false);
-	r8153_aldps_en(tp, false);
-
 	rxdy_gated_en(tp, true);
 	r8153_teredo_off(tp);
 
@@ -6864,12 +6894,23 @@ static void rtl8156_up(struct r8152 *tp)
 	/* share FIFO settings */
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
 		      0x08);
+}
+
+static void rtl8156_up(struct r8152 *tp)
+{
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return;
+
+	r8153b_u1u2en(tp, false);
+	r8153_u2p3en(tp, false);
+	r8153_aldps_en(tp, false);
+
+	r8156_exit_oob(tp);
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
-	if (tp->version < RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
-				  RG_PWRDN_EN | ALL_SPEED_OFF);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -6879,30 +6920,14 @@ static void rtl8156_up(struct r8152 *tp)
 	}
 
 	r8153_aldps_en(tp, true);
-	if (tp->version < RTL_VER_16)
-		r8153_u2p3en(tp, true);
+	r8153_u2p3en(tp, true);
 
-	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
+	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
 
-static void rtl8156_down(struct r8152 *tp)
+static void r8156_enter_oob(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
-		rtl_drop_queued_tx(tp);
-		return;
-	}
-
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
-
-	r8153b_u1u2en(tp, false);
-	if (tp->version < RTL_VER_16) {
-		r8153_u2p3en(tp, false);
-		r8153b_power_cut_en(tp, false);
-	}
-	r8153_aldps_en(tp, false);
-
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
 	/* RX FIFO settings for OOB */
@@ -6931,7 +6956,62 @@ static void rtl8156_down(struct r8152 *tp)
 
 	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
 			   RCR_APM | RCR_AM | RCR_AB);
+}
 
+static void rtl8156_down(struct r8152 *tp)
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
+	r8153_u2p3en(tp, false);
+	r8153b_power_cut_en(tp, false);
+	r8153_aldps_en(tp, false);
+	r8156_enter_oob(tp);
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
+	r8156_exit_oob(tp);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+			  PLA_MCU_SPDWN_EN);
+
+	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
+
+	if (tp->saved_wolopts != __rtl_get_wol(tp)) {
+		netif_warn(tp, ifup, tp->netdev, "wol setting is changed\n");
+		__rtl_set_wol(tp, tp->saved_wolopts);
+	}
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
+	r8153_aldps_en(tp, false);
+	r8156_enter_oob(tp);
 	r8153_aldps_en(tp, true);
 }
 
@@ -9978,10 +10058,10 @@ static int rtl_ops_init(struct r8152 *tp)
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
@@ -10001,10 +10081,10 @@ static int rtl_ops_init(struct r8152 *tp)
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
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
-- 
2.34.1

