Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9E48593F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053274; cv=none; b=oHlrrbbiDNQ9TMqzImT3pAeqSQj9s2f2UmcW8lrF0yKnx5yQ7a+GCDSG7eQ4V0NkXmrr0Es8C6oelu0FehzSDaFI6X4mXWK0CD8YtXxBiSD9/VX2Dqnc3kbHTf+CvgidXqSPs8FIEgB9DxIsSDEVfQ6rJ7ijvBNnmQ0OcTOTScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053274; c=relaxed/simple;
	bh=2fppCEk3a5ehRChhFmz0Q32VBY8fKX8kCPjVTxZ+Bcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6anNKKENuzZRkbMoGcm1Xkv3XVUnM6gqQVymCGme3VkNlh3FIQsSkcHKiqfLUnrzq5gQDlxBRa+Wsf52c1cjnb5D8NL1FA5bzPcsUgRkk3LQdzscRPzyRxdq7GFW9Xjan3diGbkph34KMM4/Rt9IcqdR4N8ZVAp3NQn5gA7UI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RHbtafzH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RHbtafzH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5985CC653EB;
	Thu, 10 Sep 2026 15:15:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F09035FA2F;
	Thu, 10 Sep 2026 15:14:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 445CF11C79E5A;
	Thu, 10 Sep 2026 17:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789053265; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DNPAM9nDsQc4xWLjYUEEe56W4814wcdUv3lS7rYFjR0=;
	b=RHbtafzH3Ec0enGh5IsBUxWsI/AG0EySCN9HiXsqJtmZ/telJ/1mTPua726VLAwilDARq0
	aJ/G9BIf061vOwkR7ywRhqs7NHOUqqCVjSf44wtI7eKva5tlfxTxpodO/cE1Sb1iWfr6uY
	ODlRirq5Br9qNyW7JwyJodnm8kKUP2CObDIZuMU04LV0U5f+uwCBgyQYzbbg82SCfH7MSK
	LWNowoJWZ6bgbjjnTSswmIcaCX7mMEyt+kXgRJYJn8uLNjNyBJmh8Bje6i/Mb+F5D9HPzm
	hCgVR9KMHUHansZlU6PU5vZqmXtJ3OL5geLkqOK2UgWteyz/zDTSqhE8g2xpgg==
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
Subject: [PATCH net v2 2/6] net: stmmac: selftests: Validate EEE based on the actual LPI timer value
Date: Thu, 10 Sep 2026 17:13:59 +0200
Message-ID: <20260910151404.976753-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EEE selftest is a 2-step test :
 - It validates that we enter in LPI mode with the
   irq_tx_path_in_lpi_mode_n counter
 - It then validates that we exit LPI when sending a frame, with the
   irq_tx_path_exit_lpi_mode_n counter.

The current state of the test lacks 2 main things :

 - We don't know exactly when was the previous frame sent (it's from the
   previous selftest)

 - The timeout is hardcoded, while the LPI is entered after a
   user-configurable delay. On top of that, the timeout loop uses a
   pre-decrement iterator (--retries) that actually only iterate nine
   times, so 900ms while the default LPI value is 1 second.

Let's therefore make it more deterministic :

 - Send a frame at the beginning of the test
 - Wait for more than the lpi timer value, we timeout after about twice
   the value,
 - Then send another frame, and verify that we do go out of LPI, also
   with a timeout.

Note that the test's goal isn't to validate the LPI timer value itself,
only that we enter/leave LPI mode.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6503678b646e..a8280834185c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -462,7 +462,7 @@ static int stmmac_test_mmc(struct stmmac_priv *priv)
 static int stmmac_test_eee(struct stmmac_priv *priv)
 {
 	struct stmmac_extra_stats *initial, *final;
-	int retries = 10;
+	unsigned long timeout, max_duration;
 	int ret;
 
 	if (!priv->dma_cap.eee || !priv->eee_active)
@@ -478,14 +478,21 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
 		goto out_free_initial;
 	}
 
+	/* Snapshot stats, we want to count the in_lpi events. We may enter
+	 * LPI just after the packet was sent.
+	 */
 	memcpy(initial, &priv->xstats, sizeof(*initial));
 
+	/* Send a frame, then wait to enter LPI */
 	ret = stmmac_test_mac_loopback(priv);
 	if (ret)
 		goto out_free_final;
 
+	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
+
 	/* We have no traffic in the line so, sooner or later it will go LPI */
-	while (--retries) {
+	timeout = jiffies + max_duration;
+	while (!time_after(jiffies, timeout)) {
 		memcpy(final, &priv->xstats, sizeof(*final));
 
 		if (final->irq_tx_path_in_lpi_mode_n >
@@ -494,20 +501,38 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
 		msleep(100);
 	}
 
-	if (!retries) {
+	memcpy(final, &priv->xstats, sizeof(*final));
+	if (final->irq_tx_path_in_lpi_mode_n <=
+	    initial->irq_tx_path_in_lpi_mode_n) {
 		ret = -ETIMEDOUT;
 		goto out_free_final;
 	}
 
-	if (final->irq_tx_path_in_lpi_mode_n <=
-	    initial->irq_tx_path_in_lpi_mode_n) {
-		ret = -EINVAL;
+	/* Re-snapshot, as we want to measure exit_lpi events. We should be
+	 * in LPI right now.
+	 */
+	memcpy(initial, &priv->xstats, sizeof(*initial));
+
+	/* TX something so we go out of LPI */
+	ret = stmmac_test_mac_loopback(priv);
+	if (ret)
 		goto out_free_final;
+
+	/* Wait for the exit LPI interrupt */
+	timeout = jiffies + max_duration;
+	while (!time_after(jiffies, timeout)) {
+		memcpy(final, &priv->xstats, sizeof(*final));
+
+		if (final->irq_tx_path_exit_lpi_mode_n >
+		    initial->irq_tx_path_exit_lpi_mode_n)
+			break;
+		msleep(100);
 	}
 
+	memcpy(final, &priv->xstats, sizeof(*final));
 	if (final->irq_tx_path_exit_lpi_mode_n <=
 	    initial->irq_tx_path_exit_lpi_mode_n) {
-		ret = -EINVAL;
+		ret = -ETIMEDOUT;
 		goto out_free_final;
 	}
 
-- 
2.55.0

