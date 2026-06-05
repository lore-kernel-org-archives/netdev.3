Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F72C08CF
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621256; cv=none; b=GEN30Qp/aIElnro1IxFN4vEgq8ny5995ov5lzxUuvr2MQL/56C6wWMpkxxreuX7Xr0Nu1FL4AH0qzWadouRbt4PFx1IaqoCjsSVj/Yot4KEsjuW42x85wiS5iUyTUWGWIGHPbJUpkupsqjCeNDsjc5uvmLNmq5uKB/1XW1frQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621256; c=relaxed/simple;
	bh=Fl2vvfFimqS4GlpOM20DZtsfCLCrtWoZalqmHnKTKCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GocloFGQe2sHBTzS5SqzMfLM63V6KhctmJqTdr49DyUL8JxfZ3nMEU3cvptkFio8XKGUeBVlbaHjL2AcTguJkQ16pT7pHqeWC6cOyMLQAGkS8sFGIcGuBKQ37RUi1qKlE562D5aESQK2ptxccdkXPGiyxYX4dI80Wn9ruzN6yEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hnPP2LhC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hnPP2LhC"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4862ed6ab36so811671b6e.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780621241; x=1781226041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZkK5iRkM+bFu8r36hoA1oZzT41u9/qmzwRkx8FhOsM=;
        b=hnPP2LhCrmphc0LS/cRwIZU/py9l8iqMlf/5s76G55Vbm22SCgKVelKwBEkfF4qIZO
         NtHYL02toKdC1nI87qUMsmfD1yplesNL04PK7gmMP+7FPrlLHUwP7vx1KGzcLT7w+UjO
         od15QFIpPyVrVlCbHpUppdWGsiZfGqOKKOPzPtsR3con7QeX2QmIG0wI+hDkWGNRH/k+
         0Z/Rikks1UulXIN9VvXGldIawMTkALO+12U/8NWaFwTwfljOVJNAu/SffsPJOYtQa7LE
         TFYGw/qDgWbPhJ0Qjr3bSbf3C+D+z1CuU98jyXVDDbGgp95VMcf4tqUOa/gNbJCUIkrB
         qp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621241; x=1781226041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZkK5iRkM+bFu8r36hoA1oZzT41u9/qmzwRkx8FhOsM=;
        b=JK3ASW3U+wfiSTiePxGkhoyiP2dYrPBHMhbW0wv7QgxCgh8VJ7NMuby2ou8V9WMIO/
         vGLUTvIjP6MZybTja73IBowLqsEgiEUvoj49lYP9NEFaKXfjswiL6nUsr4tOPYzO3H4w
         hjc2g3L6AZMG3I6kKc17I1RW5tYNai4gFtyA1sJBRi6JyUPxQypqJtgdU5HoMpMV0CWz
         fdiF1mT1WpGKEPrLiuSbRXQ9lBi4DoALudxUUySHVdBQIUbuo2Kw1TMOZJuLwgyqb7wK
         Y5M+F6NrxWTlHDGUHfgvKPCM+4kPyqMMYNN/NFtYvNIzr+3fn3EySqAKa1fyO48V1nWK
         a9hg==
X-Forwarded-Encrypted: i=1; AFNElJ/N+39yob51oHSwl62s92f4JAxLbMQJn+yk6rc9Ws+92POmoishmSHhLKYFYbubFhUnuG4D8uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbC97oH7HGbQrgKhVX2C8xQ90hyNbrFPNXGJBk4IyvyY0vCS17
	4m18OR6jqkyCNQoKpOhYiXU7yCIQo4KEBqbk31PMqG4Tcpg9/7eFnuifzOsZDKUiphE=
X-Gm-Gg: Acq92OGYQC9ZDhNHn5YP1O60ka1N6juhpzbYiKQ3UbvxoX1+0Qzec7VEWDf1Ouc2fLA
	oahyddvVHo62okfdy80y5k7sRU9l00Rr4EdrADIl/BOfs7M3nNA2ybzahDE2gsodIGR90NX46XK
	4jF5nmvHRkMbUacJ3HXbJvNNeGuKxt181M8DWdq4SIDtcYHRbwk2/Sbpo8VdE9lGe3O/Jw564Mg
	0VhGopO+mIrQPTwJlf86FiLzjwiJbyznTwvXg3nhX/kWwYllfd0GBzgs8agFyLOxZmaz1O2bfYc
	5FSd8hFfgdt4/B1n0CcwPrFWpriApX6KHoAJ2j1z1bj52PZJRCTuuIdhMoR9S29JUgum+EwPnFj
	0SgNSbJ/2dfh6IJxxCv11O8HsYaNDHzO5gZmgFjytRgebkwwxIOTVt7Ig6CPzXbTBFfpFVn1FMN
	6UBRpNc4IAE8nLDGkE+ChmHTVPczsf4EthlXvAeg==
X-Received: by 2002:a05:6808:1b0e:b0:467:5f1:fc93 with SMTP id 5614622812f47-4868dbe795amr869921b6e.9.1780621240655;
        Thu, 04 Jun 2026 18:00:40 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm5544631b6e.5.2026.06.04.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:00:40 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 04/14] net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset
Date: Thu,  4 Jun 2026 20:00:11 -0500
Message-ID: <20260605010022.968612-5-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently, on Wangxun platforms, the XPCS is configured during the call
to xpcs_switch_interface_mode() and, if the need_reset flag is set, the
XPCS is reset and the configuration will be lost. This is harmless at
present because need_reset will never actually be set on these platforms.

Nevertheless having xpcs_switch_interface_mode() on the wrong side of
the reset is an obstacle for future changes where wiping out programmed
configuration with a reset could be harmful.

Reorder xpcs_pre_config() to allow the reset can happen before we
switch interface mode. To make this work we have to hoist the special
case logic for SGMII into the parent function.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..76c04372b5b50 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -705,46 +705,50 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
 				      phy_interface_t interface)
 {
-	int ret = 0;
+	/* Wangxun provides a full alternative implementation to handle quirks */
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+		return txgbe_xpcs_switch_mode(xpcs, interface);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-	} else if (xpcs->interface != interface) {
-		if (interface == PHY_INTERFACE_MODE_SGMII)
-			xpcs->need_reset = true;
-		xpcs->interface = interface;
-	}
+	xpcs->interface = interface;
 
-	return ret;
+	return 0;
 }
 
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 	const struct dw_xpcs_compat *compat;
+	bool force_reset;
 	int ret;
 
+	/*
+	 * According to the XPCS datasheet, a soft reset is required to initiate
+	 * Clause 37 auto-negotiation when the XPCS switches interface modes.
+	 */
+	force_reset = interface == PHY_INTERFACE_MODE_SGMII;
+
+	if (force_reset || xpcs->need_reset) {
+		compat = xpcs_find_compat(xpcs, interface);
+		if (!compat) {
+			dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+				phy_modes(interface));
+			return;
+		}
+
+		ret = xpcs_soft_reset(xpcs, compat);
+		if (ret) {
+			dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+				ERR_PTR(ret));
+			return;
+		}
+
+		xpcs->need_reset = false;
+	}
+
 	ret = xpcs_switch_interface_mode(xpcs, interface);
 	if (ret)
 		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
 			ERR_PTR(ret));
-
-	if (!xpcs->need_reset)
-		return;
-
-	compat = xpcs_find_compat(xpcs, interface);
-	if (!compat) {
-		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
-			phy_modes(interface));
-		return;
-	}
-
-	ret = xpcs_soft_reset(xpcs, compat);
-	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
-			ERR_PTR(ret));
-
-	xpcs->need_reset = false;
 }
 
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
-- 
2.51.0

