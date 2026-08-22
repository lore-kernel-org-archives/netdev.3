Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07936826B
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428390; cv=none; b=QPpQIpMxR/+E2CGTJnrrCcIfR2aO1/jvVTXQOjZ0Gu2baMrIW+EulkFDsXENCN2F4jfmfdtEdqNvcslJA69R7fkHS99yQY5mfXZ8OsBePWDQeW0Hh5N7Yk7SNizH9NeO6mpNpFkD5J/Kiz6Zs58dhci/airoWSq0aaYPD54jBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428390; c=relaxed/simple;
	bh=rYDFwLmw4rqtLoCuHgoPh3rMzXjmfiowCEUJa3nZGcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICtEW56zisvycfLi4UJ7n/PRPqp/fmaSjp1v5iZ+MbzFXyayDYbv/5LaQ2EWWgM+Afe1Q3Zp1UaKe/olrT98G7YtG2QsucZ2TQV0hOa+Tz5JU1T23m3tXD8xyZC12jmTjmtGqPiqj7d3yxoBXzNsHDZRccNR75jDMbO7Iv0inU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Qu580He+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Qu580He+"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c160420289bso321621566b.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787428379; x=1788033179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uy0OKeVpCAmhbj0eyrSB4RHofJlj5Ul/6v78/RLpNA=;
        b=Qu580He+uEEIL3Dh+cu3R6tAxCK57MEYM7jRPG4147jv28KQUuH61s6w47b/3S5i8A
         3TYQD5lLsaoqV5ctbfuZfT+t6LM5YBOXLrlk9wOQTQYVlIkGJKbCorPJnr5X0Wa0fOY2
         zc8yH/UHBhv+iz3vVsNlNo1PP2HECYyKiKdGozNKC4GFZ2/LWoaED/8/YA+Lm66Km3FT
         JbF6E6IC4c5A6fdafUnQyCTjnUpRSMQCZbL/oLnUKfurcCr8g+D2/jDCypkyoD4GJup1
         ojjbCDTn4YV3zeWPDtiUUjzh3iNdHj+iIkTdESTKQDRcdj33oPtQTRCQILNBgQd4xRM7
         KHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428379; x=1788033179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0uy0OKeVpCAmhbj0eyrSB4RHofJlj5Ul/6v78/RLpNA=;
        b=gSqN67popDa4ZohVf8kZvbPTMVrhlE++qdNn7o67+OJ33FOfhbqlqFhFALrtDIMkfo
         UwrqSR2GbB4kFTMmXlEMv+q4N5gaSchF+J2UFqzIgMmhqUfX9yiNd02a8BmX6TvU/vtC
         4LEN6DVmQ+kKhHCErHarZIreRnvnxPEDHJdA+8XT+gv8Jp02G1Jn68fx06t0+jVlmodG
         /RQRVVszo84DIOj30ysNyCjpTFaWDHW4nxcDaFtY4petPgLKyEJKUI+0U4YUfY8aIfK2
         1mRESOod1MXO17pMFadhmq0uDk6OYbwtRcOryBF/pGgFCXIb1n7cQ9J6eCct9tpIdFOI
         VPrw==
X-Forwarded-Encrypted: i=1; AHgh+RpxHHIhd4frNYyRNku0cU5EaYiIgtL9JTh92/zlF94Ri77f094h0S2xRajw0pkF3hzLAQMqPgA=@vger.kernel.org
X-Gm-Message-State: AFuF++k8+jg/cFvU8a9YiqdXKyCgnaL4e7Xq01O5NRp9fEfJzSFdARGu
	s1SKX+Itp5Na+0Dts2sQVBEklYR20jPnPceCJUbX14yYyLnYbln7U+6bSuJRGSM2msA=
X-Gm-Gg: AR+sD12eXljJksUHiUSWcKhvRKMR+LprjK3GZa02177uSfqBCYWtcbNTsSpxthmCwsq
	MLka/tR+NUG9K+xM7D2/Md8g1bQJYabJx3p7JH0i2oHm9W6m65mqdGPCnBIWxIJchQ3Z+sVD/o2
	eSLiToFhW/F3qSsZrtHKuDAGxpVitUzhUurrtaTpRdmfZS+cF1IF14jnaSHs4iur9kT76dDKKch
	9EyDUuBgt4LabB974GFf/mVyy6db9QO9IfK6XQ0fM3xneK4cRCR+nrJU5caMjAAEFW7MulSrQAd
	7dR/ahBipkgvzY1GOYjhn1mt98ZGM48gxSLfrmLQKmTz5oxMYosEy0Q/G+GO1j9qJpR+VzLaXyF
	EnwJBPzHcrqOjUYoD5cr+R6t7ywQrb22sy1kKTz0Vw5Z0+De1BUUddEu+rYWEERHoMc0KoTAWD1
	h947WuXI6X5kyev75vUoljX6MWP71Uy2FHJImC12gjD/3YCZvq5A/zapr9T+LCgA4xSVH3XUyku
	Lfg/n+a
X-Received: by 2002:a17:907:ea8b:b0:c21:2c32:e2da with SMTP id a640c23a62f3a-c246a5f4515mr1912226866b.8.1787428378632;
        Sat, 22 Aug 2026 12:52:58 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2495ee5295sm475032666b.0.2026.08.22.12.52.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 12:52:58 -0700 (PDT)
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
Subject: [PATCH net 2/2] net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support
Date: Sat, 22 Aug 2026 22:52:52 +0300
Message-ID: <20260822195252.2934-3-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822195252.2934-1-f@lex.la>
References: <20260822195252.2934-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_add_mac() fills in phylink_config.lpi_capabilities and
phylink_config.lpi_timer_default, but never populates
phylink_config.lpi_interfaces. phylink only treats a MAC as supporting
phylink managed EEE when the tx_lpi methods are implemented and both
the LPI capabilities and the LPI interfaces are non-empty, so EEE is
unavailable on every MAC that uses mtk_phylink_ops:

  # ethtool --show-eee wan
  Cannot get EEE settings: Not supported

even though those ops implement mac_enable_tx_lpi() and
mac_disable_tx_lpi(). Since the methods are implemented, phylink takes
the other branch and calls phy_disable_eee(), which fills
eee_disabled_modes, so userspace cannot enable EEE either. MT7628 is
unaffected, as rt5350_phylink_ops has no tx_lpi methods at all.

Copy the supported interfaces into lpi_interfaces once they are
complete, that is after the SoC specific fixups have added and removed
modes. In particular the netsys v3 switch path clears the bitmap
before setting PHY_INTERFACE_MODE_INTERNAL, so copying it any earlier
would leave stale modes behind.

The MAC does not start using LPI on its own: the driver does not set
eee_enabled_default, so phylink leaves tx_lpi_enabled false, and
phy_check_link_status() computes enable_tx_lpi as tx_lpi_enabled &&
eee_active. One thing does change, and it is worth being explicit
about: phylink no longer takes the phy_disable_eee() branch, so a PHY
that advertises EEE out of reset advertises it again instead of being
forced quiet, and the link may negotiate EEE where it previously could
not. Nothing on this side asserts LPI until userspace enables it with
ethtool --set-eee.

This also makes lpi_capabilities take effect for the first time, so
correct its value in the same change. MAC_MCR only has EEE force bits
for 100 Mbps (MAC_MCR_EEE100M) and 1 Gbps (MAC_MCR_EEE1G), and
MAC_EEECR only carries wakeup times for those two speeds
(MAC_EEE_WAKEUP_TIME_100, MAC_EEE_WAKEUP_TIME_1000), so the MAC cannot
signal LPI at 2.5 Gbps: drop MAC_2500FD. Correcting the value here
rather than in a separate patch changes nothing observable: while
lpi_interfaces was empty, lpi_capabilities never reached
phy->advertising_eee, so no state ever claimed 2.5 Gbps LPI.

Two sets of interfaces have to come out of lpi_interfaces as well.
lpi_capabilities cannot express either: it masks the PHY's EEE
advertisement, a media side property, and never gates LPI activation on
the MAC side speed, while phylink raises the MAC speed to the interface
maximum when the PHY rate matches (RATE_MATCH_PAUSE in
phylink_link_up()), so 2500BASE-X would arm LPI on a 2.5 Gbps MAC even
for a 1 Gbps media link. Separately, mtk_mac_enable_tx_lpi() refuses
the xGMII modes outright, which on netsys v3 includes
PHY_INTERFACE_MODE_INTERNAL, the mode MT7988's built-in 2.5G PHY runs
in; offering those to phylink would log an error on link up once EEE is
enabled. What that costs is limited to setups that keep the MAC on
2500BASE-X or on an xGMII mode, neither of which the MAC has LPI bits
for; a PHY that switches the interface down to SGMII or 1000BASE-X
keeps LPI, as those stay in the mask.

On the netsys v3 switch MAC, that empties lpi_interfaces outright,
since PHY_INTERFACE_MODE_INTERNAL is the only interface it supports.
Nothing changes there: it is a fixed link port with no PHY, so phylink
had no EEE to manage on it before this patch either.

Fixes: 952d7325362f ("net: ethernet: mediatek: add EEE support")
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Pre-existing, made live by this patch and not addressed here:
mtk_mac_enable_tx_lpi() programs MT7531's reset wakeup times (17 for
1 Gbps, 36 for 100 Mbps) whenever it runs, as its own comment says, so
they now apply to every SoC driven by mtk_phylink_ops once a user
enables EEE on an eligible interface. Those values do not appear to
have been confirmed for MT7981, MT7986 or MT7988.
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..5412c89685f2 100644
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
+	/* MAC_MCR only has EEE force bits for 100 Mbps and 1 Gbps, and
+	 * MAC_EEECR only has wakeup times for those two speeds, so the MAC
+	 * cannot signal LPI at 2.5 Gbps.
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

