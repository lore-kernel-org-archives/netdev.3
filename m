Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D055AEC41
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161669; cv=none; b=qeaZvHZzOyN/Epfthvke4tzHtX377eyi1PBDkjuxsf4ixC4zYuHQ9BQTde7qtRIo+S76XPG5qOuQj4IznwTkUHC68tRyuC20TwILm9F3XgYw2py3oeZ5JL3O+0O7abfzHVIBUIxtaHjMoWZt/K2ZJAjQtwYfjld3Ga0wZQDJrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161669; c=relaxed/simple;
	bh=RK38IZFLPu4ZNdz36EQmVTuMw3HAUKeLk91jdfgK/Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxrk62N7iynA/JXU/m+UpGJ3lX+UH9nqzkA2DVzl8ivo2K0GGzmZSjabjVxU7UKF+MUsN4xkH/J1bFtU5PUZgkcJc23GzAM3Z419gs2+mHNKMhbAoNoDKpimQHKF5z1Y1BIaCnF5oDbLPJGm8L1Zj/RJ2Ba+Ioc/VoRVHHb2aOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k7okRelX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k7okRelX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 50CFE1A022A;
	Fri, 11 Sep 2026 21:21:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BBCA601A3;
	Fri, 11 Sep 2026 21:21:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BABE11C7A23F;
	Fri, 11 Sep 2026 23:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789161660; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=E53E+laYN2V9OrwunsngYOX3sgSFNZRroU2RxbAo3+g=;
	b=k7okRelX+F97+CgvB8hxPWdgZCN4Jcuo8AECXrt0Gz9P09JJEpFqGrDueFYp4y62XEU12r
	YV2Zh3+Tf0znV3ECJOUDxnSsveZrcchnwQc8EadD98uWcm4Eu1UgMS5sf9g5wfSNQ8kAsO
	WYmkOBn0BiayzPy7EdgP6DPYtp++/4y+xYGkEAghxrqMMRlu83AKtP+z1bKFMdLV3ie8lA
	w+ZmXL200BZXHZJ42lW3M/aIo/MS0yAbE0DLJ2nzjz0TMpxkfpFJSvT+RBNzG0a782p0Mi
	e/Oc6YwjZsCLYGLP4vZIs0EYLuHGvmR148t7tRPqdC0FbWxZL6gLCaRTJPgyEQ==
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
Subject: [PATCH net v3 2/6] net: stmmac: selftests: Validate EEE based on the actual LPI timer value
Date: Fri, 11 Sep 2026 23:20:22 +0200
Message-ID: <20260911212028.1497613-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
References: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
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
index 6503678b646e..df28741abf2b 100644
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

