Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA94D6C3F
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607062; cv=none; b=UyTl9S5dOUXOmro/N4vrLt+fvQAYXg5jN2EOv1Ux8tXrPOHEHMtYavWRgWoZdSUGrduJvn7ZZOfH+HZ6Z6R2TZAApNqRfSU4m//hVIkkWYaoI6hKqipq+D/piOaywiTBAv7ASg75Ru5GR8qocNXYWIFhvvl0/NuNpzSDRDv3fOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607062; c=relaxed/simple;
	bh=RSMXLle6IeDMYBW5/Ujco3LlAzF/DLousyHeQV0wswA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjCXT90rA+zcrpCihK6jOc1eFp1BcDADxRrKCpT4XRMOgFiHamrqnaQFNo0SayLNO2DH+iot8RIJqL3CNp9loelTgG+BQw2tcdpsi5fciKn3khCryrcm4wGDw0cL9JH+DWkVsa4hVS58CxWy0L+1M9dE+RPNpRoZmsY0j2Gf3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vkqOSCIZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vkqOSCIZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 06B281A1038;
	Mon, 28 Sep 2026 14:50:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE6D7601BD;
	Mon, 28 Sep 2026 14:50:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC44103294FE;
	Mon, 28 Sep 2026 16:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790607057; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=A8fu8QWqXpe2Gyvs1H5hAyun/lTjh9IKFR/yCOmv8rI=;
	b=vkqOSCIZmsSpcNDP7cjdZzfM5O/CDP/k33daOqxfqivgMuJXVPRAsS6D+JO7EjZES0Xhqp
	gUPV+2NfXNLktFSaeBzAIp0sVJ7velx+4zAcB03tYsqPiai2Gu9wSi72WalfVlMe9/OZzO
	KTDrethn4QQYloWqEGLyKx9V+KNJ2mrSpyIWRCSrwksI2v2Qvx1jS/HbBEqRafI94UuwGi
	o63ryg1pdWCkRmOM7yFZjc+VX7N/KFKMt6NUr3MeM5uB0NUUUIgcvFTnmWB32rLNNjwdSP
	2heIvm0s0ZjZlKUTHlGfrbntDzuNXiSUMftPUoBe070ky99Hk8YoVuClI7+Bsw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH net-next v2 1/2] net: stmmac: Introduce a helper to check RSS support
Date: Mon, 28 Sep 2026 16:50:41 +0200
Message-ID: <20260928145043.1228968-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
References: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RSS feature is only available in stmmac if the hardware reports it
through the DMA caps and if the platform glue sets rss_en.

Introduce a helper that checks both.

For now, no platform sets rss_en, but there's interest in the topic so
leave the door open instead of dropping the feature altogether.

No functional changes intended.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..e2873d46e049 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -433,6 +433,11 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 					   ktime_t current_time,
 					   u64 cycle_time);
 
+static inline bool stmmac_rss_is_supported(const struct stmmac_priv *priv)
+{
+	return priv->dma_cap.rssen && priv->plat->rss_en;
+}
+
 #if IS_ENABLED(CONFIG_STMMAC_SELFTESTS)
 void stmmac_selftest_run(struct net_device *dev,
 			 struct ethtool_test *etest, u64 *buf);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4dee3542df3b..08feb18d62ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3538,7 +3538,7 @@ static void stmmac_mac_config_rx_queues_routing(struct stmmac_priv *priv)
 
 static void stmmac_mac_config_rss(struct stmmac_priv *priv)
 {
-	if (!priv->dma_cap.rssen || !priv->plat->rss_en) {
+	if (!stmmac_rss_is_supported(priv)) {
 		priv->rss.enable = false;
 		return;
 	}
@@ -8037,7 +8037,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 		priv->rss.table[i] = ethtool_rxfh_indir_default(i, rxq);
 
-	if (priv->dma_cap.rssen && priv->plat->rss_en)
+	if (stmmac_rss_is_supported(priv))
 		ndev->features |= NETIF_F_RXHASH;
 
 	ndev->vlan_features |= ndev->features;
-- 
2.55.0

