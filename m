Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676A3B4EA9
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336329; cv=none; b=ivaEXC7uSUJxub6Sn5ZPZbkKhirIXxu0mjJc3spdezJ+cUEAchVGf1dg0JhcFX+mE1lW0UE2WKF0tAHGSCSESogduPdpA8HaHDqhFTQu0CLF2f36Ns8votNuw6GhCP1XxR8NzRxE1WmYKYpMfsWZx+vazhU1nF46uflikShAJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336329; c=relaxed/simple;
	bh=NsouuWMnY+pVMsdrIFxuVF7Di+LKkieEiK7zTUjJdqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLsgzt72XjX5Cp5mVsPWeZa95sqX+eUvjqx4mn3E93/0tKCAtCanKmRmV2SqyhdooaPILG9N7W0d46mZFD1tl+wQUHAxOZHWK7H9baSC4ptpLIqVAyippI8VQaiHi70JqmiTK+gkFuSVbWKXzTuBjYvIHFhnimvHxmb7y1Ojuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ccsmm+8U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ccsmm+8U"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so11917005e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788336326; x=1788941126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWL1kkTYSShipF3wkJ7JupP0b7TLAg9zfV2HGt6qDKw=;
        b=ccsmm+8UJqb/Yf8ueRmVThISG2Ugn8zhF7BDJsg9ZgfdbAILNivl8Q4Vmcg14y75SB
         rDJap5gjlffzanFcwJs+lLCCosuVxOD+oIJ1Y/xigiMdlVGd/G9lmUwvSHtLoB7emIZj
         jxzAiOvvGikhBY2YQxZxE5Og319Zqi+Ap8f1X5b3TO3X9Hvx4zn/ddmSIR7aV3z3tx6j
         NdgiwoSHe/Z2iOAQGBrCXTPB0xTVuXOq5mljLshqkqYueHZqzdTGtRbmEmJksSwI0sjf
         Xx/0nw3S7TPxYYb+owuL7MUCW2xX8s7UWzdjdxPLXcmHuDQ5VmK7BgNucdfTHOq/rMhV
         EIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336326; x=1788941126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWL1kkTYSShipF3wkJ7JupP0b7TLAg9zfV2HGt6qDKw=;
        b=KLYRkR4jW1QvkweRgTKjvivQ6cSApOvLC6AylefeFSfOKjmFRc7BElNyt2DRCgNCaT
         HUrqRHsfzMcN7l/WcnsKedq5yRjvyYJOWR1iMPY0DZc5HGoXNIIKWG/dRp0NyUasvsLq
         qm8jSln8xxXoFj4gD6HOT3R5/U+7MSWbdiOIxdSYsxg9CGMOngSwBLFAfJMK3ip4jgqg
         NdtXb08UKqL6ejgQSKSzUVgkaWbF5soUXFRF+3IqNBPAMbdw+HYCATJcqoJ9e8bfXqG0
         maIZnqdYioZ+R7Ehrtu76SsN4Jfu8CIgso4yJvnt7pxfRzDTdhrRu5deNG6c9SawKQl9
         iENw==
X-Forwarded-Encrypted: i=1; AHgh+RpiULlxHApZPxdsD4dMsgjbLfBzBj7Lqm8f6sSXrFw2krzLXd7igTpNGr9kmM7L7uEl6hsr0s8=@vger.kernel.org
X-Gm-Message-State: AFuF++l547XnwpVIfv0As0Z2iL9E1zJAJ3PhqdlBP0EydB2qzJvWzBKi
	RukE/73ZevAiEx4v+M3/vARVIJk58MZv280jwnqnb9M6PPaLvvJfXFhhuL+6TYX0D1M=
X-Gm-Gg: AR+sD11GOy94wT2crr3qh0EOS86I2aeK4z0lmteMdxqywvmiSEC1nLRU6ReL0HGL9Dg
	XxbaXl1L1g9er831SLwJ4LvjrZM+32GjTTtVmZzblD7a7s/lR+mUmNhPemEkjkaBrMF4eYlIafh
	UWr2BT40DcIgQNgZrEpx0fVRlLvrA0jTJJGHXErM1fbGdietq58pAypHY9Tyof0M+2bpVQwWl+K
	t+rdKS1Z+3OZzJJ9J/kO6qkGH13f3rBs+NMmTAqdU8BHxhaDPOjXsshJZqh8UhdQDIWgXBk8Qql
	c3hdL6rEH9+QJxRo1bFimFvskiasrRkf+cGlu7HlpIUKgiTpMdsMm9odSz9Diwk3EXLp19bD2hH
	S1BdyG1ayzQfwbe3wrc6f4oc3gBmLa70wbSJPoaTDe2aJmnkgZGsc8OCbsZVFyhXghA9mjbINvB
	eVfsmyKlWtu5pWRQqs2cZeB/w98gWC0J0t2Rasc/4=
X-Received: by 2002:a05:600c:3485:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49ce7c26ecemr20592395e9.5.1788336325567;
        Wed, 02 Sep 2026 01:05:25 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm72781715e9.13.2026.09.02.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:05:25 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	dqfext@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v4 2/2] net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support
Date: Wed,  2 Sep 2026 08:05:19 +0000
Message-ID: <20260902080519.2211373-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902080519.2211373-1-f@lex.la>
References: <20260902080519.2211373-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_create() decides once and for all that a MAC supports managed
EEE, and it requires the tx_lpi ops plus non-empty lpi_capabilities and
lpi_interfaces. mtk_add_mac() leaves lpi_interfaces empty.

So ever since EEE support was added, ethtool has answered "Not
supported" on every MAC that uses mtk_phylink_ops, and
phy_disable_eee() has locked userspace out of turning EEE on. MT7628
is unaffected, as rt5350_phylink_ops has no tx_lpi methods.

Leave 2.5 Gbps out of both bitmaps. MAC_MCR folds SPEED_2500 onto
MAC_MCR_SPEED_1000, so MAC_MCR_EEE1G would govern LPI on such a link,
and that is unvalidated rather than known unsupported: MediaTek's SDK
driver sets the EEE force bits for 100 Mbps and 1 Gbps only, and the
unit of the wakeup timers is undocumented with the port clock at
2.5 times the rate.

mtk_mac_enable_tx_lpi() programs wake-up times taken from MT7531's
reset values, and the SoC's own field has no reset value to fall
back on. Only MT7981 has been seen to exit LPI cleanly with them, so
the LPI interfaces sit behind a new MTK_GMAC_EEE capability that only
MT7981 sets; every other SoC keeps the current behaviour until it has
been confirmed.

LPI stays off until userspace enables it, but the EEE advertisement of
a PHY that advertises it out of reset comes back, since phylink stops
force-clearing it.

Fixes: 952d7325362f ("net: ethernet: mediatek: add EEE support")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
On the netsys v3 switch MAC the xGMII filter would empty lpi_interfaces
outright, as PHY_INTERFACE_MODE_INTERNAL is the only interface it
supports. MT7988 does not carry MTK_GMAC_EEE, so this is moot for now.

mtk_mac_enable_tx_lpi() programs MT7531's reset wakeup times (17 for
1 Gbps, 36 for 100 Mbps) whenever it runs, as its own comment says. The
capability gate exists because of that: MT7981 has been measured with
them (see the cover), the other SoCs have not, so they keep EEE
unreachable from userspace as before.

v2, with the full argument for leaving 2.5 Gbps out:
https://lore.kernel.org/netdev/20260824024117.46154-3-f@lex.la/

v4: the MTK_GMAC_EEE gate (Paolo Abeni).

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 30 ++++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..09f53875d100 100644
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
@@ -4966,6 +4969,27 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  mac->phylink_config.supported_interfaces);
 
+	/* mtk_mac_enable_tx_lpi() programs wake-up times borrowed from
+	 * MT7531; only SoCs where those have been seen to exit LPI cleanly
+	 * get LPI interfaces.
+	 */
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_GMAC_EEE)) {
+		phy_interface_copy(mac->phylink_config.lpi_interfaces,
+				   mac->phylink_config.supported_interfaces);
+
+		/* The MAC side of 2500BASE-X is never below 2.5 Gbps, not
+		 * even when a rate matching PHY drops the media to 1 Gbps,
+		 * and mtk_mac_enable_tx_lpi() refuses the xGMII modes
+		 * outright.
+		 */
+		__clear_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    mac->phylink_config.lpi_interfaces);
+		for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++)
+			if (mtk_interface_mode_is_xgmii(eth, i))
+				__clear_bit(i,
+					    mac->phylink_config.lpi_interfaces);
+	}
+
 	phylink = phylink_create(&mac->phylink_config,
 				 of_fwnode_handle(mac->of_node),
 				 phy_mode, mac_ops);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0168e2fbc619..88a9b3b23bea 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -994,6 +994,7 @@ enum mkt_eth_capabilities {
 	MTK_U3_COPHY_V2_BIT,
 	MTK_SRAM_BIT,
 	MTK_36BIT_DMA_BIT,
+	MTK_GMAC_EEE_BIT,
 
 	/* MUX BITS*/
 	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
@@ -1034,6 +1035,7 @@ enum mkt_eth_capabilities {
 #define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
 #define MTK_SRAM		BIT_ULL(MTK_SRAM_BIT)
 #define MTK_36BIT_DMA	BIT_ULL(MTK_36BIT_DMA_BIT)
+#define MTK_GMAC_EEE		BIT_ULL(MTK_GMAC_EEE_BIT)
 
 #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
 	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
@@ -1117,7 +1119,7 @@ enum mkt_eth_capabilities {
 #define MT7981_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPHY | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_MUX_U3_GMAC2_TO_QPHY | MTK_U3_COPHY_V2 | \
-		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
+		      MTK_RSTCTRL_PPE1 | MTK_SRAM | MTK_GMAC_EEE)
 
 #define MT7986_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
-- 
2.53.0

