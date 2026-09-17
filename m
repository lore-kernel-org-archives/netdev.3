Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FC4AEBC0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682058; cv=none; b=leIy1qG4PZDmyb5+1fAOwWEIcfYYffcgz2JV3CA4/4xZT5Ajhc2Z5FP7Jx/EiIcOWjNVlojjuFU3qD4wjvuf8z1oyapHOwdpA0kyOXB+0qw4JckCFY4sbUMCW0owICq7q+/3P4CCRmdLFI8Ihp5sVO3FSk83iQvvWfDbPlaPn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682058; c=relaxed/simple;
	bh=ww88GYu5nGoin++YN5FI3xzUwRyGfSi1cZypY6xt1HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6uKcuvZPXyi7Ax2IAU71bW3Gdl5zjZlFRYMAPzvRZg3o9ilExylBsxdUhKxpel83kGpVDKaxRm04qkz7wQjhAfFnfcvQ+XwzlaHsgazskTO+ZrACOxwMO9HW8EHGTh7fxzRuf2VCU0z+hkk8vlx9XD1zKVrJngocGjKJczfWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ncDGFZns; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ncDGFZns"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AABD14E407BD;
	Thu, 17 Sep 2026 21:54:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 778515FF03;
	Thu, 17 Sep 2026 21:54:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D93411C7B08A;
	Thu, 17 Sep 2026 23:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789682052; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3ws2khTiEkVn3RET/TZ4kJ8Lw2HegLOZvwO/z1SoMCE=;
	b=ncDGFZnsLJDpsaGWXJ0s8QdmyE0cEWrdkVJUCGJWZqrX1bXEht0TiSrtohZJ67QH6u71dU
	zAcEkpdJUXvi9gkVwcIlsH2IOziraqWBa01kF5x6hn3fYNOY+ZoX9g1Z/tWq3xojV1dfdC
	7B1L4oakZDNyW5iEYp0QVaeMKUb+hiCSGxsJpTHfLjnujCmoUxbrtNYH8pI7wA01IM9aVA
	OOjfmFN0G1r6BHQnRVheB4o6HI5B3OYNrez+1tp+536w82S5aO8l2DUhkCCl3+RVME/kAY
	tFxN8VR3UMY0w5Lo9dv04iy8+1jErwIQ6J+sIO7V0yFADtZQDca/epSDZ1qMaA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net v4 4/7] net: stmmac: selftests: Capture all packets for vlan checks
Date: Thu, 17 Sep 2026 23:53:35 +0200
Message-ID: <20260917215339.2022523-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While we use vlan_vid_add to trigger the tag filtering machinery
in the driver, there's no netdev associated to the VLAN. This causes the
skb to arrive with empty skb->vlan_tci fields, as the packet is marked
OTHERHOST in __netif_receive_skb_core(), and we fail our validation.

Let's use the proxy mechanism introduced for DSA, that registers a
ETH_P_ALL packet handler that runs earlier, before the vlan netdev
lookup, then filters for the correct ethertype before passing an skb
clone to our validation function.

As we may receive external frames with the right tag from the outside,
let's move the address check in the vlan validation function earlier.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index de02c0da56dc..43b8411c5112 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -242,6 +242,7 @@ struct stmmac_test_priv {
 	__be16 packet_type;
 	int (*func)(struct sk_buff *skb, struct net_device *ndev,
 		    struct packet_type *pt, struct net_device *orig_ndev);
+	bool capture_all;
 	int double_vlan;
 	int vlan_id;
 	int ok;
@@ -344,13 +345,15 @@ static void stmmac_sft_add_pack(struct packet_type *pt)
 {
 	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
 
-	if (netdev_uses_dsa(tpriv->pt.dev)) {
+	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
 		tpriv->packet_type = tpriv->pt.type;
 		tpriv->func = tpriv->pt.func;
 
 		/* DSA conduit will report ETH_P_XDSA, so our packet handler
 		 * won't match. Let's register a ETH_P_ALL match and filter
-		 * manually in stmmac_sft_filter.
+		 * manually in stmmac_sft_filter. This is also useful for
+		 * VLAN tests, to capture packets otherwise marked as
+		 * OTHERHOST.
 		 */
 		tpriv->pt.type = htons(ETH_P_ALL);
 		tpriv->pt.func = stmmac_sft_filter;
@@ -943,6 +946,11 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 		goto out;
 	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
 		goto out;
+
+	ehdr = (struct ethhdr *)skb_mac_header(skb);
+	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
+		goto out;
+
 	if (tpriv->vlan_id) {
 		if (skb->vlan_proto != htons(proto))
 			goto out;
@@ -954,10 +962,6 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 		}
 	}
 
-	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
-		goto out;
-
 	ihdr = ip_hdr(skb);
 	if (tpriv->double_vlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
@@ -999,6 +1003,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1095,6 +1100,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1375,6 +1381,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
+	tpriv->capture_all = true;
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
 	if (ret)
-- 
2.55.0

