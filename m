Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E673A4535
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790415244; cv=none; b=liMVuvk+cBrAeVOroickbmjNShRogzEhtX2zpx8bDSKQk8Pv8tj6hcQBTerVQGz7aSAmONqKsprAydmjQcgnTNdLwUVjqCqkPXdPji8ikljXXx9RS5t12KebddXkK+Kp40tKvNQ7cfaO/nLZkbzdD5wl2GdakrIk8z4BTthDSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790415244; c=relaxed/simple;
	bh=CfXughzgrdv8ww1ri9Ceb4wr0FfkkEdog82MnjbMhqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlVaraL/z9hOAo8+S0NRzcarXGVmNqnXO33qVWw8Xh9WgZPJQb8+DRjB+noITFJ+VF3bqAycACiGH1KHsseSvVzq+l9XzFFEio0gA+phJMwToHHIt9GJzPh/kbJWdyPIaX8KTl2qxZ+/AqW/sKS65lQZeB2h6CWh7DgHBsNYCSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I76U5edA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I76U5edA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9499D1A102E;
	Sat, 26 Sep 2026 09:33:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6037F60749;
	Sat, 26 Sep 2026 09:33:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 590B1102F1E39;
	Sat, 26 Sep 2026 11:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790415232; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3ImgzvPCPqF/pLzMmEdPt+sptLiEtWyXUVBfTOmQMrw=;
	b=I76U5edAiNk+tI0IhQ05Cc52pq6tuflYYxmk1SZmxC+bS1xPTDF3ANb7wcjQO45rXuUYkh
	QLdT41nwmwoAY+f3i0Ilm+gb1r7DOOv4OjntzDfitSJJ4yDLMt0FN9AZu7cV+6M5NFjRDk
	LifbniLduUQFsBdI9+GK8Mw1Pdmr5k5b4TSkbuz8UoHmZSpu6GrWNHYnqJyWcsioeVw7nE
	1oF30/5A07q4wdM/P3ehdyplfFnMCloa5DABjEVwKuy0C7M2jmmCKNQPy9e1ZffmWqWn7R
	tRQbvNGe4LHgjajZfXEws1gYmOZSHqYAn2q1BNDlVTh2kGJWPHXyGrdA2isLUA==
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
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net] net: stmmac: Don't set or get RSS parameters when not supported
Date: Sat, 26 Sep 2026 11:33:41 +0200
Message-ID: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RSS kselftests fail on stmmac, and this is partly due to the driver
reporting bogus data for the RSS ops :

 - ethtool -x reports an indirection table and a key while the hardware
   doesn't have any of that
 - ethtool -X fails with -EINVAL.

Let's return early in the rss ops if we know the hardware and platform
don't support RSS.

Note that RSS is currently not supported on any devices upstream, so
code that was already useless is now effectively dead. It has been the
case since 2019 when the code was added, as platforms need to set rss_en
in their plat data, and no glue ever did that.

Russell King ran a poll in february 2026 [1] asking if the code should
be dropped, without any reply going in either direction.

Jitendra Vegiraju from Broadcom sent 9 iterations of a Broadcom PCIe glue
driver [2] that actually sets rss_en = 1, so there's some hope that this
may be used in the future.

[1] : https://lore.kernel.org/netdev/aYd4BkAeNW6d0iIC@shell.armlinux.org.uk/
[2] : https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju@broadcom.com/

Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Jitendra, do you have plans to continue iterating on the BCM8958x glue ?

Thanks,

Maxime

 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1be5310ca766..4e917a448271 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
+		return 0;
+
 	return sizeof(priv->rss.key);
 }
 
@@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
+		return 0;
+
 	return ARRAY_SIZE(priv->rss.table);
 }
 
@@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int i;
 
+	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
+		return -EOPNOTSUPP;
+
 	if (rxfh->indir) {
 		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 			rxfh->indir[i] = priv->rss.table[i];
@@ -962,6 +971,9 @@ static int stmmac_set_rxfh(struct net_device *dev,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int i;
 
+	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-- 
2.55.0

