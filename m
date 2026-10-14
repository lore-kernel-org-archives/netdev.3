Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4544B1D0E;
	Wed, 14 Oct 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966006; cv=none; b=VwcRp5OUUQ9maO20WTl1fzZScsj/M3ai2ogLbHptENXfo0Ilfzh7SwUkWToYXkfHZTN+YyH161mG60deRy9klyiY20Y9tSYQD7QGDpqsiha/WLvJDASKwp7HhoYVetA1sFViFiAwhv/6e3I7cXKNEpA2AoQmvhfR3xt4vsB/gwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966006; c=relaxed/simple;
	bh=cdQzrQMT2CXz/MbauGQ1IxOm/NoK+Ufobb6WhgWnoRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbItV4zDkq3vA/ihG5gRVxAMrpW2U6IS8ht2X6aRyjVleLecdH8TAktIpHPt73hj+MwlVl6Fu0JwDUa0xO08etR6OAW2h62kMm3LtH4u4zXykUjVZECt2qtAfGIjP3sg9Vb6zN93AVbBs7mRjkqkiZ+l02zq7JamGUBcCxro+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uR8OO3aC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uR8OO3aC"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8JBaL41418223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965951; bh=81o9bw16OnwpVVhG06PYQWjymMO6x+6GmqNfLJN27+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uR8OO3aCyWbhgxT7N7D4kK1mI/UNqnN3anGkT2jqez20PonV30KHEEbpPw9L7+IP3
	 9QYeY7vseUbDZojpJOsw1+7U+WpIzKExVVI8CN2jvL5iL0tAWOaV3tsitrF0DSKOQO
	 l8q5e7Z1H7NmnfS+MbC4rEzkzx3qK+2aMLSaAgCdrQk0RIUUNjr3+FFFZUNjHgI/rm
	 aJFBRfy9RIPCfIRS0Q6pGRe4ooiBgr03/19VyqxyN3fZxlWTNer6hU7oU/X978Rsp/
	 B21VfDl+K7bq6EDqGNbY78o+vkVGvqaBp7kVaB0Tz6FIRCvnFmr7Uv098UsWE+57Qy
	 IO/bN9kdBr2nA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8JBaL41418223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:11 +0800
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
Subject: [PATCH net-next v7 05/10] r8152: fix up and down register settings for RTL8156/8156B/8157/8159
Date: Wed, 14 Oct 2026 16:18:59 +0800
Message-ID: <20261014081904.6491-6-nic_swsd@realtek.com>
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

The per-generation split was kept behaviour-neutral, so the new
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
 drivers/net/usb/r8152.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index b245b63fb6aaf..045460a35f383 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6872,8 +6872,7 @@ static void r8156_exit_oob(struct r8152 *tp)
 
 	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
 
-	if (tp->version >= RTL_VER_16)
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -6938,8 +6937,18 @@ static void r8156_enter_oob(struct r8152 *tp)
 	rtl_disable(tp);
 	rtl_reset_bmu(tp);
 
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
+	switch (tp->version) {
+	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
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
@@ -6947,7 +6956,10 @@ static void r8156_enter_oob(struct r8152 *tp)
 	 */
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
 
-	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			  NOW_IS_OOB | DIS_MCU_CLROOB);
 
 	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
 
@@ -6983,11 +6995,10 @@ static void rtl8157_up(struct r8152 *tp)
 
 	r8153b_u1u2en(tp, false);
 	r8153_aldps_en(tp, false);
-
 	r8156_exit_oob(tp);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			  RG_PWRDN_EN | ALL_SPEED_OFF);
 
 	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
 
@@ -6997,6 +7008,11 @@ static void rtl8157_up(struct r8152 *tp)
 	}
 
 	r8153_aldps_en(tp, true);
+
+	/* Enable Clear_SDR */
+	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
+	/* Clear SDR bit */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
 }
 
 static void rtl8157_down(struct r8152 *tp)
@@ -7006,9 +7022,6 @@ static void rtl8157_down(struct r8152 *tp)
 		return;
 	}
 
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
-
 	r8153b_u1u2en(tp, false);
 	r8153_aldps_en(tp, false);
 	r8156_enter_oob(tp);
-- 
2.34.1

