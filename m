Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CE39A056;
	Wed,  9 Sep 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940086; cv=none; b=NCl5cUABNezmux4SnNG1zAYd9yVMi4iku1IECW10n2PvE7uDNWy0bEU5UKxAHG1ZZPhJmRVLpMrwZRx3A8+u2YFbgE/NURxvCS9xaSgFpcXhmaqbK8mUEe9ZZH2A7VmJqvzpxxNEVHP7RQeQuMXq+px6Qusqb734t7JOhLnw3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940086; c=relaxed/simple;
	bh=YwruzpVomfozQZLhxg9EnmVDG16ojJZrrjSrRnUMIYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrI7DVAjJAjGBjGaZN0qLhN3ZtKMcWN0+PBF4DNZ7DuAvtbZWRhk07aJh5wukFgS32jz89x3Yq2GdjdoeQDF0bxWKQ/DorzNEaMfE0blOw35QFp9XylVvjmmo7feKzMiRm2H/R3MIU9bZxPV8Vdf3dQXCg1a2nlAFz9Y2Xbbe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LuPaEWon; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LuPaEWon"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6E2314E415AF;
	Wed,  9 Sep 2026 07:48:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40D2960448;
	Wed,  9 Sep 2026 07:48:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDC5711C7AF62;
	Wed,  9 Sep 2026 09:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940080; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5CsIfRyzFe2btViu+CIi4c6ueRMBh9o52Hwe0iHRbww=;
	b=LuPaEWonx1X7Qhk2sJJSwHPzdHvV93Dn/2wSNByZ3tNAiiFqnWUnC19dPVri7yn7EnSQbm
	FQj3x85JlagKj/TQLWaX5EfErJP+pzhkLXcWSFgCxeiQokcYeIOu9Ht6IHgD+Ei/Zz52/Z
	L1n4nICYbtU+tY7Ek5b+5pFAp8poo8PUxYAW1Bj/63XzHrpx0w5BmYWppw8rh0QLWCFCN5
	GdlpwAEldqBCWiw639aRMW3vYpr95pQ4WafDVz/vW3mvVE7LaYGd5ycp2uutPWmmYMOVIg
	gQQcwenx8DaymhKbFOXtt0CU8io1z6ueGYdyIjH3jGuOEf/RQLh4XFih9G0mgA==
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
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net 2/6] net: stmmac: selftests: Validate EEE based on the actual LPI timer value
Date: Wed,  9 Sep 2026 09:47:35 +0200
Message-ID: <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
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
 .../stmicro/stmmac/stmmac_selftests.c         | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6503678b646e..4564b9f29194 100644
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
@@ -478,14 +478,18 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
 		goto out_free_initial;
 	}
 
-	memcpy(initial, &priv->xstats, sizeof(*initial));
-
+	/* Send a frame, then wait to enter LPI */
 	ret = stmmac_test_mac_loopback(priv);
 	if (ret)
 		goto out_free_final;
 
+	max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
+
+	memcpy(initial, &priv->xstats, sizeof(*initial));
+
 	/* We have no traffic in the line so, sooner or later it will go LPI */
-	while (--retries) {
+	timeout = jiffies + max_duration;
+	while (!time_after(jiffies, timeout)) {
 		memcpy(final, &priv->xstats, sizeof(*final));
 
 		if (final->irq_tx_path_in_lpi_mode_n >
@@ -494,17 +498,30 @@ static int stmmac_test_eee(struct stmmac_priv *priv)
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
 		ret = -EINVAL;
-- 
2.55.0

