Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556443;
	b=oXUMK8KNMSycfspzAqD/taJIfKt4Lkf8vnXgG5tbA+1R6OOhGUV/ftl17CjDwd1IQ17j
	 YTynG/KecGqhoR13I8Nbi5pySNs2GY6U8bVyMbU5Waoe5oegfXG9yRL7+vy5EtTPmuid9
	 rZYPomeL5MQy2r9MV83q0BRgHitiwHGuXCUEQGdmxj28k3vpWoyF2ti0xARFQ9BouwYxQ
	 Vv9TR7LK2ukN0JHaYBmiWrTUZDBUs9L7NrMSvsYd450+MD0A0lHXJ+QsO3nuNYpeF+WCB
	 gCyCt11yCXfTn049B+gN8cJ4hE6qsdMhZcSfHNuej7Up53JTBV6Hm+sDqScQeYfUl+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5kWZEq95rr3xlJQdM3Zsq/uwItEBf5utbCoiS0ERH1o=;
	b=TfXsMFbHA+XGgeu2QjRAD7ObwVWGv9b5TvCLBD/XnYDHFxdL6cLORsNLmG2pPV29KxXs
	 XXa0vClh0hD/32yw8/L+RRuHDSnx0A6mOPWu9nR71as9VlM4LtNDXL/oagSGlYCGOl7Zf
	 jYec7g2GA66uQ0YR+EuFNGhf3kX75Rbx/zxrf3e2Kwu2m7SctV7dAMVNqb6kmnyrXees7
	 nlzvuLPIZGyBCGBZoLSpTps2Ewziti9kCa3NIDLcU0/Lnv4q/Gg6QI/fQzYu5RaLyqecn
	 BkA0eGyGyQ1NFMFwf9A4FntEmixzS9biK6s7egCXqfSDn64F6mSY7/vXBwJ3BapEefw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NyEPvden;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CF606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 522CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NyEPvden
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3ad6011ecebso83064a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792556441; x=1793161241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5kWZEq95rr3xlJQdM3Zsq/uwItEBf5utbCoiS0ERH1o=;
        b=NyEPvden8y7CjWZefZBy9Osn9CTzUVCiUmeVgovzu1SgWiHiW2HhnKuqH/XfxvuzZC
         xGnW3DrvoZYw/Wq9gTSVFxRw46a1yj6Pdt8nBq1+C6bGmlgcEwm+ieagze1lVvNGjNKO
         PXt9IZ2npE6Z9AWOBbO/XpVbqLzXG35dx+b+B5MfJ6Arvp64apM+DghgUTlqfTmX0qcu
         j8/pNmC92RUx5C6GXiMzJCMyyCqCVrbvHpxDA+pHrseckQ6zrAKIHv3zH0jbnNkNQTNA
         wah/JLTp5ORKj5g+RZSaxDKjYu+WYP8FJZYcN3MOxxJ6n8ZVzDBofDw6NosbWojigcVr
         kkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792556441; x=1793161241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5kWZEq95rr3xlJQdM3Zsq/uwItEBf5utbCoiS0ERH1o=;
        b=jUSgIYuLZBpDjn2gEoP3w9qUoREqbNUxxx9wEqwAd1nYxqegf/7n5VkgqNE+guJ2OB
         0C66bfmcgTwaTaZdwttErTxPPAbjDqW8cznSmyizgM07sh91Tv/GFXgfC2QW27BtF92x
         ZIY8rWEzuULWBfx8VSCQ9ikwt9wP0qa/Zec0i0qMsk7w0hr6LOWLf2UmAwWsxkqEDYp4
         Kvi2zxBcS1qWkZ9mc+lOBg48YFLFT7s0WB0zLeZ4eU9eBmooEjrLG39O6EoV8EblmGAO
         4rYkn2kfTn0krwvYcGHmK99NRJ9PFplOuArv+2Txs/nroQe1UHcGfChPlzE17DRQV1AG
         bFTw==
X-Forwarded-Encrypted: i=1; AKwUvBw/iby9kpoA7ZDM9DzvSDJxIxTQblJeXTeQTOBhD+BkFx1+Wu4RLS9OPdwrFUSm7zIzTm5jM2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4p8lCOwX+EnPKcOCSV1AcrtEO2x8Q+3QF56FhzMtOzXfINkQ7
	iokJAlMAzxb9Y5sTMkTCbp93bGNv0MZvB/3T3D5op49VVU4s7n7AcSQ+
X-Gm-Gg: AYBFou1Sob1H3f5sqN2ZwUQWHwO9Nudkzc4fd0oS1S+h25HVNsAL8NkDrUPgu7TnxL9
	WzPZDQ+uIFDHNKbw9tdAHS55EiNqASTEmOYt4yCiRcTDC2OM9xPTf95sZGfbJ2FYaUqagawLK+J
	oL4CR3reNYG8EyY3YBz44yRD7zYpl/fQh2Wlbj0L+sp5wElzXOxOd44p1YbAJx+ZZZiMvPVn992
	J/kmt2Hls8ffSS9Vf5SP/IN7O1pzn8SD1jUHoGAtwZePzcC8mtrHT5sZ7cG5ivz74OCyjKmUFhU
	8t9kEy30BmHMKA+95r6UHBM7PqHBZsWIYIoQUWXGyvjcvNjdZhO0HtGu1x4ravVsFYFAW86yfn/
	VGGJCDLb+Z7XaRb+hL5YgZzqD2dStXfNeraE+7WNkZS1tepit0X+/u9p/eS8HgpiSCHFS+/QpLM
	hyTYP7wk2Gn3g6dL6vHEi57SfC0SUBEYoTnnirjZ0f3wEbIilhSDUGosnV+CcaSOSBTNeEH7a0V
	81XQTGCpsY1P2VRS1qxdCwufzdRrsk/W0zGl5cX2MjQj5JuuNLrbhYUYmJcz/fuGRHOKNzftHjS
X-Received: by 2002:a05:6a21:b95:b0:3e2:76f0:ac27 with SMTP id adf61e73a8af0-3e287dd61f3mr772979637.40.1792556441505;
        Tue, 20 Oct 2026 21:20:41 -0700 (PDT)
Received: from AERO17.taila7786d.ts.net ([152.175.65.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933aec9sm318936b3a.2.2026.10.20.21.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:20:39 -0700 (PDT)
From: Pufan Jin <cyan2254650260@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: phy: realtek: Add support for JLSemi JL2101 and JL2121 PHYs
Date: Wed, 21 Oct 2026 12:20:29 +0800
Message-ID: <20261021042029.44853-1-cyan2254650260@gmail.com>
X-Mailer: git-send-email 2.56.0
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

JLSemi (JingLue Semiconductor) JL2101 and JL2121 Gigabit Ethernet PHYs
are register-compatible second-source alternatives to the Realtek
RTL8211F. They share the same paged register layout (page select at
register 0x1f), RGMII TX/RX internal delay registers (page 0xd08
regs 11/15), and specific status register (0x1a). Wake-on-LAN (WoL)
events (page 0xd8a regs 16/17 and page 0xd8c reg 16) and LED control
registers (page 0xd04 reg 0x10) match RTL8211F.

Unlike RTL8211F where PHYSR (0x1a) can be read directly on page 0,
JL2101/JL2121 requires reading PHYSR from page 0xa43 via
phy_read_paged(). Reading 0x1a on page 0 yields 0x0000, which causes
rtlgen_decode_physr() to erroneously downshift to 10Mbps half duplex.
Introduce jlsemi_read_status() to read PHYSR with page 0xa43.

Extend the Realtek PHY driver to bind JL2101 and JL2121 by their PHY IDs
to the RTL8211F-compatible driver operations, and add their PHY IDs to
the MDIO module device table.

Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
---
Changes in v3:
- Drop standalone driver drivers/net/phy/jlsemi.c and extend the Realtek
  PHY driver directly as suggested by Andrew Lunn.
- Add jlsemi_read_status() to read PHYSR (0x1a) via phy_read_paged()
  from page 0xa43, avoiding false downshift to 10Mbps half duplex (verified
  on physical ALINX AX7Z020B board).

Changes in v2:
- Drop redundant phy_interface_is_rgmii() check in jlsemi_config_init()
  (Andrew Lunn)
- Change speed check in jlsemi_read_status() to '>= SPEED_1000' since
  JL21xx only supports up to 1000M and 100BASE-TX does not use Master/Slave
  clock resolution (Andrew Lunn)
- Check device_can_wakeup() and configure wakeup capability and wake IRQ
  in probe() when 'wakeup-source' is present (Andrew Lunn)
- Drop redundant .features = PHY_GBIT_FEATURES (Andrew Lunn)
- Use PHY_ID_MATCH_VENDOR() for generic driver and mdio table (Andrew Lunn)
 drivers/net/phy/realtek/realtek_main.c | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 177b62a7b..36c8f2529 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -259,6 +259,10 @@
 #define RTL_8261C				0x001cc890
 #define RTL_8261C_CG				0x001cc898
 
+#define JLSEMI_JL2101_PHYID			0x937c4032
+#define JLSEMI_JL2121_PHYID			0x937c4030
+#define JLSEMI_STATUS_PAGE			0xa43
+
 #define RTL8261C_CE_MODEL		0x00
 #define RTL8261D_MODEL			0x81
 #define RTL8261X_INT_AUTONEG_ERROR	BIT(0)
@@ -1731,6 +1735,23 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int jlsemi_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0 || !phydev->link)
+		return ret;
+
+	val = phy_read_paged(phydev, JLSEMI_STATUS_PAGE, RTL_PHYSR);
+	if (val < 0)
+		return val;
+
+	rtlgen_decode_physr(phydev, val);
+
+	return 0;
+}
+
 static int rtlgen_read_vend2(struct phy_device *phydev, int regnum)
 {
 	return __mdiobus_c45_read(phydev->mdio.bus, 0, MDIO_MMD_VEND2, regnum);
@@ -3192,6 +3213,44 @@ static struct phy_driver realtek_drvs[] = {
 		.led_hw_control_get = rtl8211f_led_hw_control_get,
 		.led_hw_control_set = rtl8211f_led_hw_control_set,
 		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
+	}, {
+		PHY_ID_MATCH_EXACT(JLSEMI_JL2101_PHYID),
+		.name		= "JLSemi JL2101 Gigabit Ethernet",
+		.probe		= rtl8211f_probe,
+		.config_init	= &rtl8211f_config_init,
+		.read_status	= jlsemi_read_status,
+		.config_intr	= &rtl8211f_config_intr,
+		.handle_interrupt = rtl8211f_handle_interrupt,
+		.set_wol	= rtl8211f_set_wol,
+		.get_wol	= rtl8211f_get_wol,
+		.suspend	= rtl8211f_suspend,
+		.resume		= rtl8211f_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211f_led_hw_control_get,
+		.led_hw_control_set = rtl8211f_led_hw_control_set,
+		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
+	}, {
+		PHY_ID_MATCH_MODEL(JLSEMI_JL2121_PHYID),
+		.name		= "JLSemi JL2121 Gigabit Ethernet",
+		.probe		= rtl8211f_probe,
+		.config_init	= &rtl8211f_config_init,
+		.read_status	= jlsemi_read_status,
+		.config_intr	= &rtl8211f_config_intr,
+		.handle_interrupt = rtl8211f_handle_interrupt,
+		.set_wol	= rtl8211f_set_wol,
+		.get_wol	= rtl8211f_get_wol,
+		.suspend	= rtl8211f_suspend,
+		.resume		= rtl8211f_resume,
+		.read_page	= rtl821x_read_page,
+		.write_page	= rtl821x_write_page,
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
+		.led_hw_is_supported = rtl8211x_led_hw_is_supported,
+		.led_hw_control_get = rtl8211f_led_hw_control_get,
+		.led_hw_control_set = rtl8211f_led_hw_control_set,
+		.disable_autonomous_eee = rtl8211f_disable_autonomous_eee,
 	}, {
 		.name		= "Generic FE-GE Realtek PHY",
 		.match_phy_device = rtlgen_match_phy_device,
@@ -3420,6 +3479,8 @@ module_phy_driver(realtek_drvs);
 
 static const struct mdio_device_id __maybe_unused realtek_tbl[] = {
 	{ PHY_ID_MATCH_VENDOR(0x001cc800) },
+	{ PHY_ID_MATCH_EXACT(JLSEMI_JL2101_PHYID) },
+	{ PHY_ID_MATCH_MODEL(JLSEMI_JL2121_PHYID) },
 	{ }
 };
 
-- 
2.56.0

