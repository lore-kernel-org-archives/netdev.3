Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B64265606;
	Wed, 26 Aug 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753132; cv=none; b=Afb7QmQRy1gnJgb1R0Vr19p28tL/3hW8RVpR3xMMzJYOM1O6RQAAL0nuL0+C/BdCrW0U8k6IzJAx3QZdTlxXUQizhzsJHDS5Lgm5zg9Mf3xiEEMefLZQZ8zA1Ji1ZEP3RqF/zE7NrJv3lPFGlg5M3eKLbagm2anXKBtyzE8IIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753132; c=relaxed/simple;
	bh=qlelEtOskWaj7RpLhhZxKBC3ijuhPSxI3GLSC6+HIkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly3JddsE/xs93Bn+gP5zj8DHCq4UCNvr/W6VqV5EYhaHGBvcwktoc92aznN8J4YPhij+MMmS5smbUsiXJhgETUEDfs3e3A3INLD+mwEu+Zxk1pWNyS74iXKRobotn8hb/QdyW1WT1zItxehtVuikcT7dLXGnw05xbgq49+ZgLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hAxFsAcc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hAxFsAcc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F9894E413AA;
	Wed, 26 Aug 2026 14:05:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 03299604EC;
	Wed, 26 Aug 2026 14:05:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 637E111C78258;
	Wed, 26 Aug 2026 16:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787753124; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VhEMOZBfPvbotP4mJSctwIV46O5jNxmqqQ0vWmXGO/4=;
	b=hAxFsAcctP44imj+TPmS83tKVy954AaLdZ6ZOaamcFulcx2Dv+BfCTL0JFfMKXyhyxOs06
	RD3Q6d3DcjqmXUO8ZPVisXab+E1YuEG66+91F4AZvwCkr0Kl73teud7EfNc2V/7PKbtySC
	ZOVtmDanBzNt8nfIyRmfF/UbyeKGR/3gJXJxdrexq1fvIAInuXcl4NBmbI7kqrzI1jeFQT
	Hmc8WY344a5M7shEiur0U2TS147N3l9nRyByeKjt+wkTYS0JS7WbWcX4EEqCyvk1J/gU2Y
	7ASpstgnDMgvmGK8nqiqPsMZoT8PIvtLD823WSA8//sX9eYR8I+coDUG1EQWyA==
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
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net 1/6] net: stmmac: selftests: Check multiple MMC counters
Date: Wed, 26 Aug 2026 16:04:53 +0200
Message-ID: <20260826140500.616466-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The MMC counters report MAC statistics. Multiple counters can be
enabled when the IP is integrated, however there's no way to know
exactly which ones. Un-implemented counters seem to report 0.

It was found that on StarFive JH7110 and Amlogic SM1, the counter that's
used by the selftest (mmc_tx_framecount_g) isn't implemented, triggering
an MMC selftest failure.

Both the above SoCs seem to implement mmc_rx_framecount_gb, let's use
this counter as well for MMC counter validation.

Note that this doesn't guarantee that we won't encounter the same issue
again if another IP implements yet another set of counters that don't
include that new one.

If the game of whack-a-mole with implemented counters becomes too hard to
maintain, we may simply consider removing the MMC selftest entirely.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a2b917dd60e5..14db0c0e0ba9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -395,11 +395,17 @@ static int stmmac_test_mmc(struct stmmac_priv *priv)
 	stmmac_mmc_read(priv, priv->mmcaddr, &final);
 
 	/*
-	 * The number of MMC counters available depends on HW configuration
-	 * so we just use this one to validate the feature. I hope there is
-	 * not a version without this counter.
+	 * The number of MMC counters available depends on HW configuration,
+	 * and there doesn't seem to be a way to enumerate the implemented
+	 * counters.
+	 *
+	 * Let's check a hand-picked set of counters, knowing that :
+	 *  - Starfive JH7110 doesn't implement mmc_tx_framecount_g
+	 *  - Amlogic SM1 doesn't implement any mmc_tx_*
+	 *
 	 */
-	if (final.mmc_tx_framecount_g <= initial.mmc_tx_framecount_g)
+	if (final.mmc_tx_framecount_g <= initial.mmc_tx_framecount_g &&
+	    final.mmc_rx_framecount_gb <= initial.mmc_rx_framecount_gb)
 		return -EINVAL;
 
 	return 0;
-- 
2.55.0

