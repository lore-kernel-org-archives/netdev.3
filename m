Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F54582CB;
	Thu,  8 Oct 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447411; cv=none; b=CMDKWTRzxDw8KRJDuwhYh/yHDH4IPVg+8pSv6VehWWsVV63QRQmqrhvRaxb1o1nQk6d5QpSsuA3OQy0g5jpszvZgZzTewsAunH4Kp7pvx8bw3b5t9yDDNZDUo9XJISUl7s0mCbiP4P4tC3S177GQl2za3nUQHJZvRlnci4QmTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447411; c=relaxed/simple;
	bh=h0rQ9E/kBNieMany/jKn94VWj/cybMtwREDQEiDMcWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2/TN8zoRpww4YwqGT8DywfOsEWhwWJJwdQswUWBrZQLldxa4GJ+4dwSdHcUOub3tLa4lyJPYU9oGkG1A/+Iez6EGt407zhfK71SV9eoeZhh3VT7obqqUZDVfGTYdb7GX7MUMMdG7xyr3ALVjA1w+tqenRD9rdd1bZREfbE3n+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FQHAQn9s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FQHAQn9s"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988G5mgC315459, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791447365; bh=dl/PSvr6rBEjLte3TGpj7FjEXO9dc/1lpx2SXzsil0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FQHAQn9s5psIeb27ZYnqbAW5dIMqSsvj/YVLBImCTG63ZEVE4SmCFdZw2Gof3SD4F
	 LNsWsS7j/aYnz5eR/MBIvJUjX6E2trhuxUARJGjeQjvQI+fkJe1Wjr1d8F35t1bfaY
	 wzOnnPvSHrYmbWD6UakvUCW3jbeJhSSg8H11LaIUQpFe+obXgvp1L+AQagPuhpQRUs
	 TY1T45hfEEVFGhjwyLZpg1NnTisSK9SGF7rxlS7JAGJEgRzcRIlLjcZqGShyhym0cJ
	 KHTGcjcxFPGyMRVV8OH6fJFcz7RKvtkDlcJ04NP/HkE04GT4rKaMieB3NdLpfOUm6C
	 2DxcRmtSmLIYw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988G5mgC315459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:16:05 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:00 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:16:00 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 06/10] r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants
Date: Thu, 8 Oct 2026 16:15:52 +0800
Message-ID: <20261008081556.47901-7-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008081556.47901-1-nic_swsd@realtek.com>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

r8157_hw_phy_cfg() served both RTL8157 (VER_16) and RTL8159
(VER_17_QFN68/QFN100) via a tp->version switch inside a single
function, but per the datasheet RTL8159's PHY tuning differs from
RTL8157's in more than the per-version blocks already captured.

Split it into r8157_hw_phy_cfg() (VER_16 only) and a new
r8159_hw_phy_cfg() (VER_17_QFN68/QFN100), each with its own copy of
the shared prologue/epilogue. rtl_ops_init() assigns each one to its
own chips only. Per the datasheet, RTL8159 diverges from RTL8157 in
this split in several ways:

- RTL8159 doesn't need EEE disabled before reprogramming PHY
  parameters, so r8159_hw_phy_cfg() drops the rtl_eee_enable(tp,
  false) call that r8157_hw_phy_cfg() keeps.
- Since EEE isn't forced off up front, r8159_hw_phy_cfg() ends with
  rtl_eee_enable(tp, tp->eee_en) instead of only enabling EEE when
  eee_en is set, so the configured state is applied in both
  directions.
- RTL8159's EEE clock-divider and 0xa5ea encoding differ from
  RTL8157's: r8159_hw_phy_cfg() clears EN_10M_CLKDIV (ups_info.
  _10m_ckdiv = false) instead of setting it, and clears an extra bit
  (BIT(2)) of 0xa5ea.
- "Disable bypass_turn_off_clk_in_aldps" (0xd3c8 BIT(0)) is needed by
  both chips, so it moves from the VER_17-only switch case into the
  shared prologue and now also runs for RTL8157.

Newly added PHY tuning parameters for RTL8159:
- shorten CLKS latency
- CMP_Timer on MP_Timer=333
- spdchg_pga1_lpf_cap
- ENET PLL jitter improvement

Moreover, change sram2 0x8ffe[15:0] = 0xf450 to 0xf4ff.

Along the way, add sram2_set_bits()/sram2_clr_bits() helpers
mirroring the existing sram_set_bits()/sram_clr_bits(), and use the
named OCP_POWER_CFG/EN_10M_PLLOFF/EN_ALDPS_PLLOFF macros in place of
the raw "ocp_reg_set_bits(tp, 0xa430, BIT(0) | BIT(1))".

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 168 ++++++++++++++++++++++++++++++++--------
 1 file changed, 137 insertions(+), 31 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 17162df4826a4..673be55453ef0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -655,6 +655,7 @@ enum spd_duplex {
 /* OCP_POWER_CFG */
 #define EEE_CLKDIV_EN		0x8000
 #define EN_ALDPS		0x0004
+#define EN_ALDPS_PLLOFF         0x0002
 #define EN_10M_PLLOFF		0x0001
 
 /* OCP_EEE_CONFIG1 */
@@ -1964,6 +1965,16 @@ static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
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
@@ -8131,11 +8142,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8151,7 +8165,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x8078, 0xff00, 0x3000);
 
 		/* green mode */
-		sram2_write_w0w1(tp, 0x89e9, 0xff00, 0);
+		sram2_clr_bits(tp, 0x89e9, 0xff00);
 		sram2_write_w0w1(tp, 0x8ffd, 0xff00, 0x0100);
 		sram2_write_w0w1(tp, 0x8ffe, 0xff00, 0x0200);
 		sram2_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
@@ -8257,12 +8271,85 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	r8153_aldps_en(tp, false);
+
+	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
+	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);
 
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
@@ -8272,22 +8359,35 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8351,10 +8451,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8363,14 +8463,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8381,7 +8481,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		/* improve UBE */
 		ocp_reg_set_bits(tp, 0xbf0c, 0x7 << 11);
 		/* close Sparse NEC, improve connect 5EUU cable performance */
-		sram2_write_w0w1(tp, 0x88de, 0xff00, 0);
+		sram2_clr_bits(tp, 0x88de, 0xff00);
 		/* 5G slave compatibility issue */
 		sram2_write(tp, 0x80b4, 0x5195);
 
@@ -8440,8 +8540,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8451,9 +8558,9 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
 
-	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
-
-	tp->ups_info._10m_ckdiv = true;
+	ocp_reg_clr_bits(tp, OCP_DOWN_SPEED,
+			 EN_EEE_100 | EN_EEE_1000 | EN_10M_CLKDIV);
+	tp->ups_info._10m_ckdiv = false;
 	tp->ups_info.eee_plloff_100 = false;
 	tp->ups_info.eee_plloff_giga = false;
 
@@ -8465,11 +8572,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));
 
 	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
-	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0) | BIT(1) | BIT(2));
 	tp->ups_info.lite_mode = 0;
 
-	if (tp->eee_en)
-		rtl_eee_enable(tp, true);
+	rtl_eee_enable(tp, tp->eee_en);
 
 	r8153_aldps_en(tp, true);
 	r8152b_enable_fc(tp);
@@ -10262,7 +10368,7 @@ static int rtl_ops_init(struct r8152 *tp)
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

