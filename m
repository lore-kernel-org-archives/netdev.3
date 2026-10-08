Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D43EC802;
	Thu,  8 Oct 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447431; cv=none; b=gayi54dWdM1blKQSn5mHd+50d4DZMrTi18qJa06Tq+AKXo7m2Q6bLj5XQAZ5DwzOwj/80Cpu5Bqf76fSq2BLjgw1yPEgo3zpKqSTzgYoqJQZpzoyjv+Du/dnz5NRcueoh9sGrRuPIh7zEDI8z9ekMSePuv2ny3xWxedznsrFM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447431; c=relaxed/simple;
	bh=/G0tnC5fjlk26WNqeoNyyjSCdnTzTKQ7TwQ6Irzhgmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOsdtyOZWJfTz4h39u9Vf5aNLnNh9xWajZVTD04Bwwcx6E7kpYkb9WdpWiwvwtKyCoVATuY5b/LIRbh+Hl/ckEP5e3Ft8k6nHfaOJN4FLBtWy7Zxnkqc0UEXF/bO7j5dGatkrdPD/pyMz9CR9ARkfVt/8IUxgdVyDr1xqZk3MAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GcORA5RB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GcORA5RB"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988Gi5hA315416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791447404; bh=8/wVo5nahnOZP/bZeQp6CPas8w3I0yB6r0jCaQIDUrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GcORA5RBYHClf7VZrvOQWmrggKRnhagAYOSdOEsoURUsGH3oCHSBAKfgFzW1FiPcV
	 MBcyuG7qFnoY4yjI8U3ZkbmW668whR/i2BLni8j8tObDzSTHtH2PFCW8bFPM8sl4lm
	 kwyAeN8U7LJc+HP32dzM/mpajeFLJYcGlhCXieSUe4PnTr/u1YNp8LfF2N9xF7QXHq
	 nXcfTsbB/lBxmN4zTAn+aFgMWKXK0u8dGXwLqEl4qaI0fhiNfAC7wvn8xQ8HQtZwNU
	 IpzCndONYhvzVaqz4FnNc64WgKE8+d8D4LZUJV81iP1H/duyQg52hOCNqklz4F0jMZ
	 uQ3Ceaptj6Fgg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988Gi5hA315416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:16:44 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:00 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:15:59 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 05/10] r8152: fix up and down register settings for RTL8156/8156B/8157/8159
Date: Thu, 8 Oct 2026 16:15:51 +0800
Message-ID: <20261008081556.47901-6-nic_swsd@realtek.com>
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

The per-chip-family split was kept behaviour-neutral, so the new
callbacks still carry the settings that the shared functions applied
under tp->version range checks. Several of those were wrong or
missing for the chips that now have functions of their own, and were
invisible as long as one function served four chip families.

Per the datasheet:

- RTL8156/8156B need PLA_RCR1 BIT(3) cleared on up. The shared
  function had this clear under "version >= RTL_VER_16", so the
  RTL8156/8156B path never reached it.
- RTL8156B (VER_13/15) need Clear_SDR enabled on up, which nothing
  ever did for them.
- RTL8157/8159 need USB_SPEED_OPTION's RG_PWRDN_EN and ALL_SPEED_OFF
  cleared on up. The shared function had this under
  "version < RTL_VER_16", which excluded precisely the chips that
  need it.
- RTL8157/8159 need their own Clear_SDR enables on up: USB 0xd378
  BIT(7) set and USB 0xcd06 BIT(15) cleared.
- Entering OOB on RTL8156/8156B/8157/8159 also needs PLA_BDC_CR's
  ALDPS_PROXY_MODE and PLA_OOB_CTRL's DIS_MCU_CLROOB. Only
  r8152b_enter_oob() and r8153_enter_oob() set these today; the
  RTL8156 family down paths set NOW_IS_OOB alone.
- RTL8157/8159 OOB RX settings are PLA_RMS 1526 and PLA_MTPS 10K,
  not the 1522 and 6K they inherited from the shared function.

PLA_MCU_SPDWN_EN is not used by RTL8157/8159, so drop the up/down
management of it that rtl8157_up()/rtl8157_down() carried over;
keeping it would suggest the bit is meaningful on these chips.

Fixes: 195aae321c82 ("r8152: support new chips")
Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 5c26267ff0cdd..17162df4826a4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6892,6 +6892,8 @@ static void rtl8156_up(struct r8152 *tp)
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
 	rtl_rx_vlan_en(tp, tp->netdev->features & NETIF_F_HW_VLAN_CTAG_RX);
@@ -6927,6 +6929,16 @@ static void rtl8156_up(struct r8152 *tp)
 	r8153_aldps_en(tp, true);
 	r8153_u2p3en(tp, true);
 
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
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 }
@@ -6964,7 +6976,10 @@ static void rtl8156_down(struct r8152 *tp)
 	 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
 
-	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -7007,8 +7022,8 @@ static void rtl8157_up(struct r8152 *tp)
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
 		      0x08);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -7018,6 +7033,11 @@ static void rtl8157_up(struct r8152 *tp)
 	}
 
 	r8153_aldps_en(tp, true);
+
+	/* Enable Clear_SDR */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
+	/* Clear SDR bit */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
 }
 
 static void rtl8157_down(struct r8152 *tp)
@@ -7027,9 +7047,6 @@ static void rtl8157_down(struct r8152 *tp)
 		return;
 	}
 
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
-
 	r8153b_u1u2en(tp, false);
 	r8153_aldps_en(tp, false);
 
@@ -7043,8 +7060,8 @@ static void rtl8157_down(struct r8152 *tp)
 	rtl_disable(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);
 
 	/* Clear teredo wake event. bit[15:8] is the teredo wakeup
 	 * type. Set it to zero. bits[7:0] are the W1C bits about
@@ -7052,7 +7069,10 @@ static void rtl8157_down(struct r8152 *tp)
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

