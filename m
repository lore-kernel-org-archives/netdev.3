Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281106;
	b=oDthCxgGo9AmEUjyUC/zM0Cik3nJKe87QaWQVB2mLZqhUIqwv4hvlgrEM0Uok+0uuedL
	 qdOd78IgOVpz6nKwKY0XsUfh3npOCyKYVSADzGlGvu88ebC5zr7xTCpxukPDLTct+gwvy
	 0qwnKtAsZBiVYJ1EFZVPpLV05AWXKff3RYCrbsUhggZHaCw8VAe4BGfcBGn8Jvbs1owpH
	 ZBpyJ8htn5hVYvEN0vW9K/27fB10YyrUVmEtvf9A+AFsddw480IdKNCkR5DewfZ4O6cry
	 CYRQIF4Zxufnadgl/YRw/AmsjvFo5v2SV2oXHfYNI/+gzFtNv3vrrGVQeZE7xPPpPGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281106;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=MUWhkoLt5h47Jl2FnKXiZGou5uN67cVms54fLzD/6ZU=;
	b=rKAoBVPGjxloW+Jfg0JOSTMoS7OqLzJwKqPX5tdpHqHPZQIx28eldxAzVIQ+6IFfobVO
	 0HgtAZsXEALFKZYnEf1qsPXtDoYK4BZcmeZVvLIjfAjvwQwemLcmD0CTPfCWohEYV6i/P
	 o7cMRjS7yzRPWX37/YkVgfsNIANHAeCYCzvLC1xSRI173eKBtjIkXTDnmrQOHPX1xH0Vk
	 txAES4JqikbDeoSiXQRddMYty7M+dKXwX0mIDoWkWlAVK5HgJ2idwHF8NTsNbIBd/PobF
	 ISV5KbcuRitMFlQXV9OXCvtDnpZ8ynF+ppF2pKugBkGueryLAxTO2f8PuHw1bYSpCRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ch8jxBPZ;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB92606A321;
	Tue, 10 Nov 2026 03:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB92606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ch8jxBPZ
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3OJ2a8884546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281059; bh=MUWhkoLt5h47Jl2FnKXiZGou5uN67cVms54fLzD/6ZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ch8jxBPZopcs4L6zXGONrX5xQ54SBdPwlXtBhzdQlPTbjM7E/2kWCFhFUd50KsGzw
	 o+IjWHxgxe29HywUEqdCa0J7nveYr6FhzIikaSQ9WjMFWDRrYe5AKGQ4r7aLmYGveO
	 wTy50z+Zc75D3fmGDJb5LdBmCLHfbxwLfjSUiSVaBBGNZYIl0qOS9jK073W/aLHtDS
	 i5/GNsClNDcT5y2r38wfwcpRwCmmmfRAPkkXBeh2QHNSRjuGDbIlQYKorsiQAgBT0l
	 t/NezrnkpFZNLLYqmFS+UbG6DXzROiUMXcCfjapSG00XB88mKq4BsXpX2T4QhwE+l6
	 vn6aAHhnbzsGw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3OJ2a8884546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:18 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:17 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 01/11] r8152: fix RTL8156/RTL8156B/RTL8157/RTL8159 up and down settings
Date: Tue, 10 Nov 2026 11:24:06 +0800
Message-ID: <20261110032416.16968-2-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110032416.16968-1-nic_swsd@realtek.com>
References: <20261110032416.16968-1-nic_swsd@realtek.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Several settings the datasheet requires for these chips were either
missing or gated on the wrong version range in the shared
rtl8156_up()/rtl8156_down():

- PLA_RCR1 BIT(3) must be cleared on up for all of them. It was
  cleared only for RTL_VER_16 and later, so RTL8156/RTL8156B never
  reached it.
- USB_SPEED_OPTION's RG_PWRDN_EN and ALL_SPEED_OFF must be cleared on
  up for RTL8157/RTL8159 as well. The "version < RTL_VER_16" check
  excluded precisely the chips that need it.
- Clear_SDR must be enabled on up: USB 0xd3ca BIT(15) on RTL8156B
  (VER_13/15), and USB 0xd378 BIT(7) set plus USB 0xcd06 BIT(15)
  cleared on RTL8157/RTL8159.
- Entering OOB needs PLA_BDC_CR's ALDPS_PROXY_MODE and PLA_OOB_CTRL's
  DIS_MCU_CLROOB. Only r8152b_enter_oob() and r8153_enter_oob() set
  them; the RTL8156 family down path set NOW_IS_OOB alone.
- RTL8157/RTL8159 OOB RX settings are PLA_RMS 1526 and PLA_MTPS 10K,
  not the 1522 and 6K they inherited.
- PLA_MCU_SPDWN_EN is not used by RTL8157/RTL8159, so stop managing
  it on up/down for them.

Fixes: 195aae321c82 ("r8152: support new chips")
Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 52 ++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4815235e8e730..d00cc911ae135 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6820,8 +6820,7 @@ static void rtl8156_up(struct r8152 *tp)
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	if (tp->version >= RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -6843,11 +6842,12 @@ static void rtl8156_up(struct r8152 *tp)
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
 		      0x08);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
-
 	if (tp->version < RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
-				  RG_PWRDN_EN | ALL_SPEED_OFF);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+				  PLA_MCU_SPDWN_EN);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -6860,6 +6860,23 @@ static void rtl8156_up(struct r8152 *tp)
 	if (tp->version < RTL_VER_16)
 		r8153_u2p3en(tp, true);
 
+	switch (tp->version) {
+	case RTL_VER_13:
+	case RTL_VER_15:
+		/* Enable Clear_SDR */
+		ocp_word_set_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(15));
+		break;
+	case RTL_VER_16:
+	case RTL_VER_17:
+		/* Enable Clear_SDR */
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
+		/* Clear SDR bit */
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
+		break;
+	default:
+		break;
+	}
+
 	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
@@ -6871,8 +6888,9 @@ static void rtl8156_down(struct r8152 *tp)
 		return;
 	}
 
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
+	if (tp->version < RTL_VER_16)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+				  PLA_MCU_SPDWN_EN);
 
 	r8153b_u1u2en(tp, false);
 	if (tp->version < RTL_VER_16) {
@@ -6891,8 +6909,17 @@ static void rtl8156_down(struct r8152 *tp)
 	rtl_disable(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
+	switch (tp->version) {
+	case RTL_VER_16:
+	case RTL_VER_17:
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);
+		break;
+	default:
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
+		break;
+	}
 
 	/* Clear teredo wake event. bit[15:8] is the teredo wakeup
 	 * type. Set it to zero. bits[7:0] are the W1C bits about
@@ -6900,7 +6927,10 @@ static void rtl8156_down(struct r8152 *tp)
 	 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
 
-	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
-- 
2.34.1

