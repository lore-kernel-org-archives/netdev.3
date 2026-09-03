Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52062C11D9;
	Thu,  3 Sep 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420574; cv=none; b=ia3YJaiXWhM4qGnVqLfNprpr6V5rDQVJUbhH5MyZVHxLVIQImCxmVbwC0MNILQw+Srbi9kx389NDncCSW7Eg4+md7LydcHxKemkyNbsdgoaoFEsL6vn/CsoP5KMzW9vfsY0dMqXLdAKXg6HCKp8kOi+LAb7571SpbRJ4aies9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420574; c=relaxed/simple;
	bh=BbjjJ79cm15eriAHuJKXfgFOMaOZg7vkOrpmusay28c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0FkYIRlws2+O6WWutmSO/x0KDKyTNBRL9LSg0Ua4RBVLJh/3fc/Y9aJd6RRaQrwxYuZNeZIF/DyK9r5ArVBwEeZZ2drpj2/3lEhitMNv+eB8NFUOdfa9CRuUvKz/Xs6O6MAq0xCXfb2P5YTSdhGAwppD2OoujEl3HHendC+B1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=B4SLvvME; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="B4SLvvME"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6837Ssy463295537, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788420535; bh=iRSiIwxnRpNVNZYJxk+jr57GtkneHvn17KjyLTSvcEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=B4SLvvMEJTeO8fgFhRqbHbD9LRqW6sWSe3DD7M6N+WKiIln8c9jCZoJsxhM3fCNru
	 OQrPdIeByNCPwe7WhVFqSqcWTfgvAarCm+Wyyh+302ESQDMzKVAjG9bTyU6Q1dyW1U
	 bUbLfrSIvDkxknCK9mVd9Cq8p+eH4FTCSOK/KJaohfnT0p1jB1T7OeC7e0rA0WgQcq
	 uLOB9vyfcoWfdvSneOVzUL1CK0aLoKs+I2dd0PE+CasyRquCZyFczeo+9PHgh4Z7IH
	 1V/ERMWMRFgRzSDWjyIE2WCqPOkTJE9DQe6XN03ChnaCcOlSHKz0uTdzM74dgW8wSv
	 WtiGZT0vJAxTw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6837Ssy463295537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 15:28:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 15:28:54 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 15:28:54 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 4/8] r8152: refactor r8157_hw_phy_cfg
Date: Thu, 3 Sep 2026 15:28:48 +0800
Message-ID: <20260903072852.58695-5-nic_swsd@realtek.com>
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

RTL8159 has a different hw_phy_cfg sequence from RTL8157. Split
r8157_hw_phy_cfg into r8157_hw_phy_cfg (VER_16) and r8159_hw_phy_cfg
(VER_17_*), update PHY parameters for RTL8156B/57/59, and add sram2
bitwise operation helpers.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 168 +++++++++++++++++++++++++++++++++-------
 1 file changed, 139 insertions(+), 29 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index aee8d57684205..00bd3afe79033 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -655,6 +655,7 @@ enum spd_duplex {
 /* OCP_POWER_CFG */
 #define EEE_CLKDIV_EN		0x8000
 #define EN_ALDPS		0x0004
+#define EN_ALDPS_PLLOFF         0x0002
 #define EN_10M_PLLOFF		0x0001
 
 /* OCP_EEE_CONFIG1 */
@@ -1992,6 +1993,16 @@ static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
 	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
 }
 
+static void sram2_set_bits(struct r8152 *tp, u16 addr, u16 set)
+{
+	sram2_write_w0w1(tp, addr, 0, set);
+}
+
+static void sram2_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+{
+	sram2_write_w0w1(tp, addr, clear, 0);
+}
+
 static void r8152_mdio_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
 {
 	int data;
@@ -8082,6 +8093,9 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		sram_write(tp, 0x8074, 0x2417);
 		sram_write(tp, 0x807a, 0x2417);
 
+		/* Nway DACONB parameters */
+		ocp_reg_w0w1(tp, 0xa4ca, 0x6000, 0x0040);
+
 		/* XG PLL */
 		ocp_reg_w0w1(tp, 0xbf84, 0xe000, 0xa000);
 		break;
@@ -8158,11 +8172,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
 
 	/* Advanced Power Saving parameter */
-	ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1));
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_10M_PLLOFF | EN_ALDPS_PLLOFF);
 
 	/* Disable ALDPS force mode */
 	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
 
+	/* Disable bypass_turn_off_clk_in_aldps */
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
+
 	switch (tp->version) {
 	case RTL_VER_16:
 		/* XG_INRX parameter */
@@ -8178,7 +8195,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x8078, 0xff00, 0x3000);
 
 		/* green mode */
-		sram2_write_w0w1(tp, 0x89e9, 0xff00, 0);
+		sram2_clr_bits(tp, 0x89e9, 0xff00);
 		sram2_write_w0w1(tp, 0x8ffd, 0xff00, 0x0100);
 		sram2_write_w0w1(tp, 0x8ffe, 0xff00, 0x0200);
 		sram2_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
@@ -8284,12 +8301,85 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x807c, 0xff00, 0x5000);
 		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
 		break;
+	default:
+		break;
+	}
+
+	if (rtl_phy_patch_request(tp, true, true))
+		return;
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
+
+	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
+
+	tp->ups_info._10m_ckdiv = true;
+	tp->ups_info.eee_plloff_100 = false;
+	tp->ups_info.eee_plloff_giga = false;
+
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
+	tp->ups_info.eee_ckdiv = true;
+
+	rtl_phy_patch_request(tp, false, true);
+
+	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
+
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
+	tp->ups_info.lite_mode = 0;
+
+	if (tp->eee_en)
+		rtl_eee_enable(tp, true);
+
+	r8153_aldps_en(tp, true);
+	r8152b_enable_fc(tp);
+
+	set_bit(PHY_RESET, &tp->flags);
+}
+
+static void r8159_hw_phy_cfg(struct r8152 *tp)
+{
+	u16 data;
+
+	r8156b_wait_loading_flash(tp);
+
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
+
+	data = r8153_phy_status(tp, 0);
+	switch (data) {
+	case PHY_STAT_EXT_INIT:
+		rtl8152_apply_firmware(tp, true);
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		break;
+	case PHY_STAT_LAN_ON:
+	case PHY_STAT_PWRDN:
+	default:
+		rtl8152_apply_firmware(tp, false);
+		break;
+	}
 
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	r8153_aldps_en(tp, false);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
+
+	/* PFM mode */
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
+
+	/* Advanced Power Saving parameter */
+	ocp_reg_set_bits(tp, OCP_POWER_CFG, EN_10M_PLLOFF | EN_ALDPS_PLLOFF);
+
+	/* Disable ALDPS force mode */
+	ocp_reg_clr_bits(tp, 0xa44a, BIT(2));
+
+	/* Disable bypass_turn_off_clk_in_aldps */
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
+
+	switch (tp->version) {
 	case RTL_VER_17_QFN68:
 	case RTL_VER_17_QFN100:
-		/* Disable bypass turn off clk in ALDPS */
-		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
-
 		/* Power level tuning
 		 * test mode power level
 		 */
@@ -8299,22 +8389,35 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram_write_w0w1(tp, 0x81ae, 0xff00, 0x0f00);
 		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
 		/* normal link TX filter */
-		sram2_write_w0w1(tp, 0x83b0, 0x0e00, 0);
-		sram2_write_w0w1(tp, 0x83c5, 0x0e00, 0);
-		sram2_write_w0w1(tp, 0x83da, 0x0e00, 0);
-		sram2_write_w0w1(tp, 0x83ef, 0x0e00, 0);
+		sram2_clr_bits(tp, 0x83b0, 0x0e00);
+		sram2_clr_bits(tp, 0x83c5, 0x0e00);
+		sram2_clr_bits(tp, 0x83da, 0x0e00);
+		sram2_clr_bits(tp, 0x83ef, 0x0e00);
+
+		ocp_reg_w0w1(tp, 0xbf38, 0x01f0, 0x0160);
+		ocp_reg_w0w1(tp, 0xbf3a, 0x001f, 0x0014);
+		/* shorten CLKS latency */
+		ocp_reg_clr_bits(tp, 0xbf28, BIT(14) | BIT(13));
+		ocp_reg_clr_bits(tp, 0xbf2c, BIT(15) | BIT(14));
+		/* CMP_Timer on MP_Timer=333
+		 * GPHY OCP 0xbf28 bit[0] = 0x1
+		 * GPHY OCP 0xbf28 bit[6:1] = 0x3
+		 * GPHY OCP 0xbf28 bit[12:7] = 0x3
+		 */
+		ocp_reg_w0w1(tp, 0xbf28, 0x1fff, 0x0187);
+		ocp_reg_w0w1(tp, 0xbf2a, 0x3f, 0x03);
 
 		/* AFE power saving for 2.5G & 5G */
 		sram_write(tp, 0x8173, 0x8620);
 		sram_write(tp, 0x8175, 0x8671);
 
-		sram_write_w0w1(tp, 0x817c, 0, BIT(13));
-		sram_write_w0w1(tp, 0x8187, 0, BIT(13));
-		sram_write_w0w1(tp, 0x8192, 0, BIT(13));
-		sram_write_w0w1(tp, 0x819d, 0, BIT(13));
-		sram_write_w0w1(tp, 0x81a8, BIT(13), 0);
-		sram_write_w0w1(tp, 0x81b3, BIT(13), 0);
-		sram_write_w0w1(tp, 0x81be, 0, BIT(13));
+		sram_set_bits(tp, 0x817c, BIT(13));
+		sram_set_bits(tp, 0x8187, BIT(13));
+		sram_set_bits(tp, 0x8192, BIT(13));
+		sram_set_bits(tp, 0x819d, BIT(13));
+		sram_clr_bits(tp, 0x81a8, BIT(13));
+		sram_clr_bits(tp, 0x81b3, BIT(13));
+		sram_set_bits(tp, 0x81be, BIT(13));
 
 		sram_write_w0w1(tp, 0x817d, 0xff00, 0xa600);
 		sram_write_w0w1(tp, 0x8188, 0xff00, 0xa600);
@@ -8378,10 +8481,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x84b2, 0xff00, 0x6000);
 		/* Training AAGC PAR (with uc2 patch) */
 		sram2_write(tp, 0x8ffc, 0x6008);
-		sram2_write(tp, 0x8ffe, 0xf450);
+		sram2_write(tp, 0x8ffe, 0xf4ff);
 		/* DAC BGK */
-		sram2_write_w0w1(tp, 0x8015, 0, BIT(9));
-		sram2_write_w0w1(tp, 0x8016, 0, BIT(11));
+		sram2_set_bits(tp, 0x8015, BIT(9));
+		sram2_set_bits(tp, 0x8016, BIT(11));
 		sram2_write_w0w1(tp, 0x8fe6, 0xff00, 0x0800);
 		sram2_write(tp, 0x8fe4, 0x2114);
 		/* 10G PBO table */
@@ -8390,14 +8493,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x864b, 0xff00, 0xdc00);
 		/* 2.5G ado power window size */
 		sram2_write_w0w1(tp, 0x8154, 0xc000, 0x4000);
-		sram2_write_w0w1(tp, 0x8158, 0xc000, 0);
+		sram2_clr_bits(tp, 0x8158, 0xc000);
 		/* 10G lock far */
 		sram2_write(tp, 0x826c, 0xffff);
 		sram2_write(tp, 0x826e, 0xffff);
 		/* XG INRX parameter */
 		sram2_write_w0w1(tp, 0x8872, 0xff00, 0x0e00);
-		sram_write_w0w1(tp, 0x8012, 0, BIT(11));
-		sram_write_w0w1(tp, 0x8012, 0, BIT(14));
+		sram_set_bits(tp, 0x8012, BIT(11));
+		sram_set_bits(tp, 0x8012, BIT(14));
 		ocp_reg_set_bits(tp, 0xb576, BIT(0));
 		sram_write_w0w1(tp, 0x834a, 0xff00, 0x0700);
 		sram2_write_w0w1(tp, 0x8217, 0x3f00, 0x2a00);
@@ -8408,7 +8511,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		/* improve UBE */
 		ocp_reg_set_bits(tp, 0xbf0c, 0x7 << 11);
 		/* close Sparse NEC, improve connect 5EUU cable performance */
-		sram2_write_w0w1(tp, 0x88de, 0xff00, 0);
+		sram2_clr_bits(tp, 0x88de, 0xff00);
 		/* 5G slave compatibility issue */
 		sram2_write(tp, 0x80b4, 0x5195);
 
@@ -8467,8 +8570,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write(tp, 0x8ff8, 0xaa5a);
 
 		sram2_write_w0w1(tp, 0x88d5, 0xff00, 0x0200);
-		break;
 
+		/* spdchg_pga1_lpf_cap */
+		sram_write_w0w1(tp, 0x84bb, 0xff00, 0x0a00);
+		sram_write_w0w1(tp, 0x84c0, 0xff00, 0x1600);
+
+		/* ENET PLL jitter improvement */
+		ocp_reg_w0w1(tp, 0xbf8a, 0xfc00, 0x2000);
+		ocp_reg_set_bits(tp, 0xbf88, BIT(2));
+		break;
 	default:
 		break;
 	}
@@ -8478,9 +8588,9 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
 
-	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
-
-	tp->ups_info._10m_ckdiv = true;
+	ocp_reg_clr_bits(tp, OCP_DOWN_SPEED,
+			 EN_EEE_100 | EN_EEE_1000 | EN_10M_CLKDIV);
+	tp->ups_info._10m_ckdiv = false;
 	tp->ups_info.eee_plloff_100 = false;
 	tp->ups_info.eee_plloff_giga = false;
 
@@ -8492,7 +8602,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
 
 	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
-	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1) | BIT(2));
 	tp->ups_info.lite_mode = 0;
 
 	if (tp->eee_en)
@@ -10297,7 +10407,7 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->eee_get		= r8153_get_eee;
 		ops->eee_set		= r8152_set_eee;
 		ops->in_nway		= rtl8153_in_nway;
-		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
+		ops->hw_phy_cfg		= r8159_hw_phy_cfg;
 		ops->autosuspend_en	= rtl8157_runtime_enable;
 		ops->change_mtu		= rtl8156_change_mtu;
 		tp->rx_buf_sz		= 48 * 1024;
-- 
2.34.1

