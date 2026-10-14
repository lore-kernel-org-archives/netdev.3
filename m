Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A64B95C7;
	Wed, 14 Oct 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966007; cv=none; b=L3DEsLIXfSsgdOixOOSL1PSFrQuXC2nLwsY7b1whzN9O8Cx6VyD/pABAtbASlcVYbqSoomc0rlF0+kqzJi3d3GK8I9wsZHfZveWk29eTEjASz8YeXC2aZSd0MDw/gH1FqnHqZ+I5Z8eTeFofk/YHI4pvtzzeBxSxKuoSq2P94xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966007; c=relaxed/simple;
	bh=TcuqlD28/5Tyx0kr8ew6unLtQ7RfGU4ivpBXKvsNtbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc2oKQV1+mWnX1W26jNNDfFebX0LF9EB+cC3qjKZxWQwL2tcMJwB0cxy2gFkZ5JR4z6JAhj+eo7j8AXiIN7AEJvQKwd3nrFR5rREw/eFkffJGbcb6yW+EMVlrNWZZFJZzHNhVSmX3YoxEIq8y2zeP/s2iUExjouwDVyEGSo6R8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GvF2lFGZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GvF2lFGZ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8JAaM41418223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965951; bh=hGNUvg2BFcPLmD2XW72j0F2Jmq4aB0ZAtRfnlX6MLds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GvF2lFGZ1pLVNv73Wld6I8Rv7Gch13LhUarWWUAxmvET9WSoq5Rb7x++NHCKTBovL
	 KHpbU6LQ3wRZaojpVav3pfaoJlrAEG3QxUOi+8KrCF51rOXp82wnq2SXRa/5dBB8R0
	 ktdpQQK1PITd5y2V92KHIgMzEK74+Q/OMmsqs2nlr4QBNgusPZH3g+U1x90WdX1vKJ
	 HR4oyZzJ32+FHKZEL0gJDS1aNK+MWgn4POQQkO7DtUOnEQbrENj/uljAlT+HjzFHFn
	 Bjq11RpEvaamY+4vzl/laAB52Fdpj5ipW2Cnn+W7hEwd4qgltZk14i7aApmkuA/FfH
	 x/SrB5ndtuINA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8JAaM41418223
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
Subject: [PATCH net-next v7 06/10] r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants
Date: Wed, 14 Oct 2026 16:19:00 +0800
Message-ID: <20261014081904.6491-7-nic_swsd@realtek.com>
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
index 045460a35f383..c31ce65d6a586 100644
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
@@ -8074,11 +8085,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8094,7 +8108,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x8078, 0xff00, 0x3000);
 
 		/* green mode */
-		sram2_write_w0w1(tp, 0x89e9, 0xff00, 0);
+		sram2_clr_bits(tp, 0x89e9, 0xff00);
 		sram2_write_w0w1(tp, 0x8ffd, 0xff00, 0x0100);
 		sram2_write_w0w1(tp, 0x8ffe, 0xff00, 0x0200);
 		sram2_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
@@ -8200,12 +8214,85 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8215,22 +8302,35 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8294,10 +8394,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8306,14 +8406,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8324,7 +8424,7 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		/* improve UBE */
 		ocp_reg_set_bits(tp, 0xbf0c, 0x7 << 11);
 		/* close Sparse NEC, improve connect 5EUU cable performance */
-		sram2_write_w0w1(tp, 0x88de, 0xff00, 0);
+		sram2_clr_bits(tp, 0x88de, 0xff00);
 		/* 5G slave compatibility issue */
 		sram2_write(tp, 0x80b4, 0x5195);
 
@@ -8383,8 +8483,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -8394,9 +8501,9 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
 
-	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000, EN_10M_CLKDIV);
-
-	tp->ups_info._10m_ckdiv = true;
+	ocp_reg_clr_bits(tp, OCP_DOWN_SPEED,
+			 EN_EEE_100 | EN_EEE_1000 | EN_10M_CLKDIV);
+	tp->ups_info._10m_ckdiv = false;
 	tp->ups_info.eee_plloff_100 = false;
 	tp->ups_info.eee_plloff_giga = false;
 
@@ -8408,11 +8515,10 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
@@ -10102,7 +10208,7 @@ static int rtl_ops_init(struct r8152 *tp)
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

