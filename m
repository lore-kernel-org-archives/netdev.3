Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2513BCD13
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682050; cv=none; b=nvQ8XS7XdKItZjytkD8Lc4zeL8HGPDwM2Gh6DVsWMpDYe4QeDQQKLtTg1zeUhaJ83GvTSxJtw6a6cHXATflQaGyztghIpmPu3FPV2hN3+nxN41MfrcjRTrWF42zWuMsduCtKgRxNREfUxtJhyr9dM8j+tzgd4+Vq7A/Bv581+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682050; c=relaxed/simple;
	bh=gyBDOeV6ybo8r/Smyu55opwn8QbP81D/fA+gHFGb38w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC5D5LlVLH7Wi8aq1/cS3xqrDEHiUhvXRMLpG+ReRCI6DGrYbG/k69YS2NLh2hTewy6r+uNhFnCY2auzSYuB2KSmrVAEPLzKgQqF/55uhPHuz08Z8ZAVFbeQgvzSHO4ZT46Pl5mdbEGb4sDDaOc/GntGwbUJKLncXRvOwcyIyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=czj1k2vk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="czj1k2vk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BB3C6C58468;
	Thu, 17 Sep 2026 21:54:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3517F5FF03;
	Thu, 17 Sep 2026 21:54:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C2BD11C7B078;
	Thu, 17 Sep 2026 23:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789682044; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=db9kiRUqojTT6icRWrq9tkilEuRiipOUqaP3av78n68=;
	b=czj1k2vkY9pYJFQe8+ympcPKTYmLGy8XBl1PJrwbWoGxJxaMev1/JoX1LzRAl89+jAkrFh
	gfjKMLaBO1Meoj0HJqZNpYVvVCxJgTDHFVQ052PGzuU1jYgeLxnKhBSk0KJqU8FKOEjwFS
	BMBaZciaGHfykuH/8vRyoUpKf3J7ZvkAHjQz/211yRKt1gb5B+wiOaXMzWKCiqiPjOjQ7H
	etwHJ161PRuVd+MQcNfTzlI+SIikW5aIRi8GLpNVoyEy0RIik2M+Q+CqwIzF/yJp1mSXZ3
	18LL0L5x7Yuh7yv0T4eqhOJ3OBzwbfYe55jBer3ak+O0ezR3eRDomfEJUKwb7w==
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
Subject: [PATCH net v4 2/7] net: stmmac: selftests: Validate EEE based on the actual LPI timer value
Date: Thu, 17 Sep 2026 23:53:33 +0200
Message-ID: <20260917215339.2022523-3-maxime.chevallier@bootlin.com>
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

As LPI timer can get pretty high, bail out if LPI timer is over 5
seconds.

Note that the test's goal isn't to validate the LPI timer value itself,
only that we enter/leave LPI mode.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 44 ++++++++++++++++---
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 614b5995dec5..2f9f7746c40a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -30,6 +30,7 @@ struct stmmachdr {
 			      sizeof(struct stmmachdr))
 #define STMMAC_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
 #define STMMAC_LB_TIMEOUT	msecs_to_jiffies(200)
+#define STMMAC_SFT_MAX_LPI	(5 * USEC_PER_SEC)
 
 struct stmmac_packet_attrs {
 	int vlan;
@@ -462,12 +463,16 @@ static int stmmac_test_mmc(struct stmmac_priv *priv)
 static int stmmac_test_eee(struct stmmac_priv *priv)
 {
 	struct stmmac_extra_stats *initial, *final;
-	int retries = 10;
+	unsigned long timeout, max_duration;
 	int ret;
 
 	if (!priv->dma_cap.eee || !priv->eee_active)
 		return -EOPNOTSUPP;
 
+	/* Bail out if the configured LPI timer is too long */
+	if (priv->tx_lpi_timer > STMMAC_SFT_MAX_LPI)
+		return -EOPNOTSUPP;
+
 	initial = kzalloc_obj(*initial);
 	if (!initial)
 		return -ENOMEM;
@@ -478,14 +483,21 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
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
@@ -494,20 +506,38 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
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

