Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15E374A11
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539297; cv=none; b=IA6qzjm4nWIpjX6hNblXkE4VIPFGfuEKQ+n/z5pJWsPehocKqYEW3IlOIXSAyLc5zVxXodWQnZF3DkeD8Ov5JAjmFpFtSDP1Tf4MN0gUd2IYYB1/b5iJbmQdwa7UhaBZMLyBGMXjewpck9OOz2XONBmPuk6eZ7l+ifFdaH/XFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539297; c=relaxed/simple;
	bh=AD9+/6KWGvFpcCoDcfBCRac/d4Y11iTlGJwO4GZJrJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7VOF3M/EROKFcXtx7bxrvykB6juVJ8aUxtpdd/1GnWs5A87a/O/cXQzRHEZTervezfKFENivh8J5VdS8BEhFEfT4Oz5lSo18exT6XrxHxf1yUDAr3bdXG8FzBCAOqPrNoT+2DQstEbo+i8XRgXRM2N0I2R8cqM7/KV4jYuOFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=DOjypVL6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="DOjypVL6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c26d7e951so429866566b.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787539291; x=1788144091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eff4/RO9BXDKGgT0WoHgozDOguCB0zRc8wyBEOOYuWg=;
        b=DOjypVL60KufgUoQRHYpdjd5DCPA2xrcHtVE/FYbZ2kAKprmVTX1i+Rd56A33Nhg3l
         IJTgDk7AdtQYmHIP69sVxDIP7o9hJk3SajxDe9gE7m5GPKPTf244tQRV9T0A5CS96iWb
         RfhBbgEYAWkoK5wcMU/IjzJMJ6R19AZv5s5MlFnIup6HqM3mJNDZPWkX+ogWoXu3MlOP
         4E0PT3hKz2nvX3jvRA0gm8zjpI9Sby4SDGcpeTV/nq3x1NebhLbgfZoyJ/MiJTPnNQIN
         zGwGZ6pIhhVMfGuL6TT0gtm/LebFwk+pBe5qMdoPoL9TOZJGHwl6mgYkvGUCSl/gU7lv
         QNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539291; x=1788144091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eff4/RO9BXDKGgT0WoHgozDOguCB0zRc8wyBEOOYuWg=;
        b=FY6uKsnQsnbgalOxuqyDcNOFQVuWZZ7n9hXCGE0yaP/buP1yMdssZxTpvScg+Qk2Pc
         M0FHDnI2T4Dnl2pF6yI67W6I4l6iCGKumongOYF5ypSBJ/aQGDqm+ZhnjMLnKDZK0HIv
         u/LleBoeQVe1QACcWdkH5AYFDWVrsfFRueUvoCjZCO6OuUZklXjgDV/XXFQxgI8436Fx
         KDnfBiPbgoxBf8mVraENUbJQdIjMriGXiQzbaMKAqd4lZ1HeibwCkUqGl02yJRMKB+AN
         tZCcANxhpoOQLzLb6+VCSfNpiefN4PVoJ2GoX6Ebvgn5xIWImaoUOH0/Nr/GnrJp2ONE
         RP/w==
X-Forwarded-Encrypted: i=1; AHgh+RpXDw3/6YPHDXvdbh0o+0ztQjTjj5VossgkLrskNdnyyQFbC0TH/yeWBBUNpa6x0Co6Ywm0lUY=@vger.kernel.org
X-Gm-Message-State: AFuF++kN7tPFuyTQh8/C2lUnaTGP3CtB7xMrJf15hcYG2GJFWFk77sc4
	zXdVO5bWkJs+jD1gn3pOolYM0NIqe5KHoIXTkUA1jQStVERpoX5Yz3c0y9Z3ljYFQzY=
X-Gm-Gg: AR+sD12TLRqqyTmnE2AnSUrfjfHZeOaCKS4MD3xxPB+V3S1DbrtYla6/0rHYNuCW8vg
	VoB1cncAXG2nCldY/C/wOPoYv/4P4LZWquDnfbQzU2LEykJACjQXXf1aoxhXYlmwPEH4/nQ0k8r
	FxAYjhps5PO73TRPbEGtQDMbE8y7V9dSm0IHZhihf5GMIK6zqs4xbyL/nWfYwLPEo8DQ96ZmOeU
	zrzfRuEd2Pjgyens+zbeJzh92eqb4+suJnHUQaeMKkDlon7GYfOfn2egP0zqXqScjUywBjzYkDn
	DLWgWljPvP9iTeMeRyICXiOnAb56I+jTMBew5idMH5v3L2/8r2EOi7GKRUhYrcYrsZapLUftYaH
	y+p0JTpRBvcMfGeq6hA1rSkcIq2NNZ2AfEKI/Wr6wHk8oXGs67XAed5Gs5BGGqnxQMVzSBEF2Wf
	qPMaa0qML2n8yyQTYiJCMl2v0v9/iBQ7cBoAFjn9E9w6MoXh9voTsJAYGV
X-Received: by 2002:a17:906:fd83:b0:c12:5a0e:3e0 with SMTP id a640c23a62f3a-c246a651b90mr2593036066b.19.1787539288568;
        Sun, 23 Aug 2026 19:41:28 -0700 (PDT)
Received: from ownbook ([195.181.160.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249686e37bsm949008466b.55.2026.08.23.19.41.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:41:28 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v2 2/2] net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support
Date: Mon, 24 Aug 2026 05:41:17 +0300
Message-ID: <20260824024117.46154-3-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824024117.46154-1-f@lex.la>
References: <20260824024117.46154-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_add_mac() fills in lpi_capabilities and lpi_timer_default but
never lpi_interfaces, so phylink treats every MAC that uses
mtk_phylink_ops as not supporting EEE: ethtool reports "Not
supported" and phy_disable_eee() keeps userspace locked out. MT7628
is unaffected, as rt5350_phylink_ops has no tx_lpi methods.

Copy the supported interfaces into lpi_interfaces once the SoC
specific fixups have finished changing them, and leave 2.5 Gbps out
for now: drop 2500BASE-X from the copy and MAC_2500FD from
lpi_capabilities. MAC_MCR folds SPEED_2500 onto MAC_MCR_SPEED_1000, so
MAC_MCR_EEE1G is what would govern LPI on such a link, and it is
unvalidated rather than unsupported: MediaTek's SDK driver sets the
EEE force bits for 100 Mbps and 1 Gbps link speed only, EEE signalling
on 2500BASE-X is outside 802.3, and the 1 us unit of the wakeup timers
is undocumented with the port clock at 2.5 times the rate. Narrowing
lpi_capabilities alone would not do it, since it gates on the media
speed a rate matching PHY reports rather than on the speed the MAC
runs at. Drop the xGMII modes too, which mtk_mac_enable_tx_lpi()
refuses outright and which on netsys v3 include the mode of MT7988's
built-in 2.5G PHY.

LPI stays off until userspace enables it. The EEE advertisement of a
PHY that advertises it out of reset does come back, since phylink
stops force-clearing it.

Fixes: 952d7325362f ("net: ethernet: mediatek: add EEE support")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

On leaving 2.5 Gbps out: the absence of 2.5 Gbps EEE force bits in
MAC_MCR is not the argument, since the same reasoning applied to the
speed field would say the MAC cannot do 2.5 Gbps at all - 2500BASE-X
here is 1000BASE-X at 2.5 times the clock, and the MAC does not know
the difference. MAC_2500FD was deliberate in the original EEE
submission [1], which set MAC_MCR_EEE1G for SPEED_2500 and SPEED_1000
alike. The masks say nobody has validated it, not that the hardware
refuses.

On the netsys v3 switch MAC the xGMII filter empties lpi_interfaces
outright, as PHY_INTERFACE_MODE_INTERNAL is the only interface it
supports. It is a fixed link port with no PHY, so phylink had no EEE to
manage there before this patch either.

Pre-existing, made live by this patch and not addressed here:
mtk_mac_enable_tx_lpi() programs MT7531's reset wakeup times (17 for
1 Gbps, 36 for 100 Mbps) whenever it runs, as its own comment says, so
they now apply to every SoC driven by mtk_phylink_ops once a user
enables EEE on an eligible interface. Those values do not appear to
have been confirmed for MT7981, MT7986 or MT7988.

[1] https://lore.kernel.org/all/20250210125246.1950142-1-dqfext@gmail.com/
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..37a831f73da6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4828,7 +4828,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	phy_interface_t phy_mode;
 	struct phylink *phylink;
 	struct mtk_mac *mac;
-	int id, err;
+	int id, err, i;
 	int txqs = 1;
 	u32 val;
 
@@ -4907,8 +4907,11 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->phylink_config.type = PHYLINK_NETDEV;
 	mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
-	mac->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD |
-		MAC_2500FD;
+	/* MAC_MCR folds SPEED_2500 onto MAC_MCR_SPEED_1000, so LPI above
+	 * 1 Gbps would be governed by MAC_MCR_EEE1G and is unvalidated
+	 * rather than unsupported.
+	 */
+	mac->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
 	mac->phylink_config.lpi_timer_default = 1000;
 
 	/* MT7623 gmac0 is now missing its speed-specific PLL configuration
@@ -4966,6 +4969,19 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  mac->phylink_config.supported_interfaces);
 
+	phy_interface_copy(mac->phylink_config.lpi_interfaces,
+			   mac->phylink_config.supported_interfaces);
+
+	/* The MAC side of 2500BASE-X is never below 2.5 Gbps, not even when
+	 * a rate matching PHY drops the media to 1 Gbps, and
+	 * mtk_mac_enable_tx_lpi() refuses the xGMII modes outright.
+	 */
+	__clear_bit(PHY_INTERFACE_MODE_2500BASEX,
+		    mac->phylink_config.lpi_interfaces);
+	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++)
+		if (mtk_interface_mode_is_xgmii(eth, i))
+			__clear_bit(i, mac->phylink_config.lpi_interfaces);
+
 	phylink = phylink_create(&mac->phylink_config,
 				 of_fwnode_handle(mac->of_node),
 				 phy_mode, mac_ops);
-- 
2.55.0

