Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346163A8746;
	Tue, 28 Jul 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254272; cv=none; b=C7XDyqTciI/gGCyD9SwvqUpqKgLwqRRs9D6DeM3NV0SjRAAHcM06XATEcThWweSisPk+mUvZGi6qQ8MzQpTuY2VISiCxXERe0zG3IyQM9rN/JYQaxWuzCwwWov/qorDeCKGpCIfyuoOJgm6Nh4enCL2byXinEbINvrGaeZZFni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254272; c=relaxed/simple;
	bh=sF3GCzlwrd9KjC8q7of2ENNL6ssZXLmFMEsn45AiO4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9gCUhAXJuJtXt7FHf3hS3XhIYYQvbrAsckGo7dKO23Oaq2WS7gKWmliCiiVy46X0zmLNMsN8YWj5V3zYSofAxZWTpuaHzeX5HNLKM2LG24+uZaeUw/ThcMiY4hsF/vO0IZyHUCGpQGDXi55xFJPlWQaKBSYd5DUYvJLELoFjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JRmADhCC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JRmADhCC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7F0664E40FB1;
	Tue, 28 Jul 2026 15:57:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50C8E601BF;
	Tue, 28 Jul 2026 15:57:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BC6F11C142E2;
	Tue, 28 Jul 2026 17:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785254263; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CmOuU+to4qS4pPEFBvxuVdBGP9rNjI/sZHRB1EUJnAw=;
	b=JRmADhCCdaVi1NcGO73S29ltHZqIRAhnV9pjV7vt80ALbU4tFK8/+cVLzSdzmWf1leFpzr
	nVNBLblNFVqNJB5MMqO4c0FlQ/nUWQCyuA+vmyDBHmq6XFuClm3Wirdw+hmF9Php/Fg9lH
	JNB7uqUI/jtzd7/0grJCpba3j8qZeczU1aNx1QznpDIkpEqwqOwWq4+8e8IIYBpHdYIA/y
	J7O7LMkCuWvO/Gtndj0fIo4JY/jdnry2wQ55269jqBBhIkKogmF7KJlLEA4NBTOKur1r3N
	cfHYcqh+wMgtZN+BwCEtZCN7CQA5RaicQN0JR/wS/nje6rTQasRkcgOM8nzFbQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Zxyan Zhu <zxyan0222@gmail.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 1/2] net: stmmac: Don't use PHY loopback for selftests
Date: Tue, 28 Jul 2026 17:57:26 +0200
Message-ID: <20260728155728.1193169-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
References: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Stmmac selftests validate the internal behaviour of the various IPs,
using local loopback. The current logic is relies on PHY-side local
loopback if a PHY is attached, with a fallback to MAC loopback
otherwise.

However, PHY loopback is currently fragile especially for stmmac that
may require RXC to be provided from the PHY. Some PHYs shutdown RXC
while in loopback, while others will report carrier off when in local
loopback. This also fails when using SFP setup with a module that embeds
a PHY, that may also fail to enter loopback.

MAC loopback is done at the GMII level on dwmac, allowing the internal
to be just as meaningful as PHY-loopback testing.

Let's simplify stmmac selftests by only relying on MAC-side local
loopback, which makes the selftests runnable on a wider HW variety.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 112 ++----------------
 1 file changed, 9 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 29e824bd90ca..c0e5dee86451 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -374,25 +374,6 @@ static int stmmac_test_mac_loopback(struct stmmac_priv *priv)
 	return __stmmac_test_loopback(priv, &attr);
 }
 
-static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
-{
-	struct stmmac_packet_attrs attr = { };
-	int ret;
-
-	if (!priv->dev->phydev)
-		return -EOPNOTSUPP;
-
-	ret = phy_loopback(priv->dev->phydev, true, 0);
-	if (ret)
-		return ret;
-
-	attr.dst = priv->dev->dev_addr;
-	ret = __stmmac_test_loopback(priv, &attr);
-
-	phy_loopback(priv->dev->phydev, false, 0);
-	return ret;
-}
-
 static int stmmac_test_mmc(struct stmmac_priv *priv)
 {
 	struct stmmac_counters initial, final;
@@ -1815,10 +1796,6 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
 	return ret;
 }
 
-#define STMMAC_LOOPBACK_NONE	0
-#define STMMAC_LOOPBACK_MAC	1
-#define STMMAC_LOOPBACK_PHY	2
-
 static const struct stmmac_test {
 	char name[ETH_GSTRING_LEN];
 	int lb;
@@ -1826,131 +1803,96 @@ static const struct stmmac_test {
 } stmmac_selftests[] = {
 	{
 		.name = "MAC Loopback               ",
-		.lb = STMMAC_LOOPBACK_MAC,
 		.fn = stmmac_test_mac_loopback,
-	}, {
-		.name = "PHY Loopback               ",
-		.lb = STMMAC_LOOPBACK_NONE, /* Test will handle it */
-		.fn = stmmac_test_phy_loopback,
 	}, {
 		.name = "MMC Counters               ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_mmc,
 	}, {
 		.name = "EEE                        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_eee,
 	}, {
 		.name = "Hash Filter MC             ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_hfilt,
 	}, {
 		.name = "Perfect Filter UC          ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_pfilt,
 	}, {
 		.name = "MC Filter                  ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_mcfilt,
 	}, {
 		.name = "UC Filter                  ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_ucfilt,
 	}, {
 		.name = "Flow Control               ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_flowctrl,
 	}, {
 		.name = "RSS                        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_rss,
 	}, {
 		.name = "VLAN Filtering             ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_vlanfilt,
 	}, {
 		.name = "VLAN Filtering (perf)      ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_vlanfilt_perfect,
 	}, {
 		.name = "Double VLAN Filter         ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_dvlanfilt,
 	}, {
 		.name = "Double VLAN Filter (perf)  ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_dvlanfilt_perfect,
 	}, {
 		.name = "Flexible RX Parser         ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_rxp,
 	}, {
 		.name = "SA Insertion (desc)        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_desc_sai,
 	}, {
 		.name = "SA Replacement (desc)      ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_desc_sar,
 	}, {
 		.name = "SA Insertion (reg)         ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_reg_sai,
 	}, {
 		.name = "SA Replacement (reg)       ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_reg_sar,
 	}, {
 		.name = "VLAN TX Insertion          ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_vlanoff,
 	}, {
 		.name = "SVLAN TX Insertion         ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_svlanoff,
 	}, {
 		.name = "L3 DA Filtering            ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l3filt_da,
 	}, {
 		.name = "L3 SA Filtering            ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l3filt_sa,
 	}, {
 		.name = "L4 DA TCP Filtering        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l4filt_da_tcp,
 	}, {
 		.name = "L4 SA TCP Filtering        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l4filt_sa_tcp,
 	}, {
 		.name = "L4 DA UDP Filtering        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l4filt_da_udp,
 	}, {
 		.name = "L4 SA UDP Filtering        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_l4filt_sa_udp,
 	}, {
 		.name = "ARP Offload                ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_arpoffload,
 	}, {
 		.name = "Jumbo Frame                ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_jumbo,
 	}, {
 		.name = "Multichannel Jumbo         ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_mjumbo,
 	}, {
 		.name = "Split Header               ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_sph,
 	}, {
 		.name = "TBS (ETF Scheduler)        ",
-		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_tbs,
 	},
 };
@@ -1978,57 +1920,21 @@ void stmmac_selftest_run(struct net_device *dev,
 	/* Wait for queues drain */
 	msleep(200);
 
-	for (i = 0; i < count; i++) {
-		ret = 0;
-
-		switch (stmmac_selftests[i].lb) {
-		case STMMAC_LOOPBACK_PHY:
-			ret = -EOPNOTSUPP;
-			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, true, 0);
-			if (!ret)
-				break;
-			fallthrough;
-		case STMMAC_LOOPBACK_MAC:
-			ret = stmmac_set_mac_loopback(priv, priv->ioaddr, true);
-			break;
-		case STMMAC_LOOPBACK_NONE:
-			break;
-		default:
-			ret = -EOPNOTSUPP;
-			break;
-		}
-
-		/*
-		 * First tests will always be MAC / PHY loopback. If any of
-		 * them is not supported we abort earlier.
-		 */
-		if (ret) {
-			netdev_err(priv->dev, "Loopback is not supported\n");
-			etest->flags |= ETH_TEST_FL_FAILED;
-			break;
-		}
+	ret = stmmac_set_mac_loopback(priv, priv->ioaddr, true);
+	if (ret) {
+		netdev_err(priv->dev, "Loopback is not supported\n");
+		etest->flags |= ETH_TEST_FL_FAILED;
+		return;
+	}
 
+	for (i = 0; i < count; i++) {
 		ret = stmmac_selftests[i].fn(priv);
 		if (ret && (ret != -EOPNOTSUPP))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		buf[i] = ret;
-
-		switch (stmmac_selftests[i].lb) {
-		case STMMAC_LOOPBACK_PHY:
-			ret = -EOPNOTSUPP;
-			if (dev->phydev)
-				ret = phy_loopback(dev->phydev, false, 0);
-			if (!ret)
-				break;
-			fallthrough;
-		case STMMAC_LOOPBACK_MAC:
-			stmmac_set_mac_loopback(priv, priv->ioaddr, false);
-			break;
-		default:
-			break;
-		}
 	}
+
+	stmmac_set_mac_loopback(priv, priv->ioaddr, false);
 }
 
 void stmmac_selftest_get_strings(struct stmmac_priv *priv, u8 *data)
-- 
2.55.0

