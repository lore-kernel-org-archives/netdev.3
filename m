Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509C2E62A9;
	Mon, 28 Sep 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607068; cv=none; b=NIaiMYud0xjxygpBCYOSBRFKHkjK8aXPOZjvFWMpDe3n95y88sYYMe0TqrE8zCWwYFvj/PLNf825Ze3IJLrXbp/6qactWmndTXevfeP2t/jc0j48xVSExq38Js8BXBfyj1zEkJpXCp6OhpnerCWEHbOaIh8Edx3vY1zuszE+YpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607068; c=relaxed/simple;
	bh=BnLlv+4McXetMJgoXug89KG8SYwblZXjQPSRppt1o5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ8YahEnlmEJKugSzbKNrS4YI+aQVhTS7KhA3npK5N9ewBniK8Sz8bikHty7nLbsHsnB22+VgiW01YR5V9k9oRSNqYUQ2lJQKWkAqqG9swJO3ISrhQm2tdcgKcWDeBdpQLz+wJPNCNxxrx+iUNe3Bnaqx25/tM8qbUkVIIb7qV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SptTGbpv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SptTGbpv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4E0541A103C;
	Mon, 28 Sep 2026 14:51:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2171D601BD;
	Mon, 28 Sep 2026 14:51:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A18BF1032968D;
	Mon, 28 Sep 2026 16:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790607059; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=O3fJrMQL1fKhE5DPCwlRr2e8oi3phq7U6oB8w73Ea0I=;
	b=SptTGbpvyTZxZi3oNTAkUvACSYop2iGc2oUfB9BB9vIXQkYHE7anqVr+Na61W/DR7beoFX
	eTsdG7ylS8dDLuk9yTkikpuweq7tmvYmMeJvO2Bdu6aTwWZDvtKDCpZx7WwcCxxV7SmtoQ
	+FYh/jVNHTv3EgrRZF+HJxfs2Zevg1hVQOTItaAFonV3q4xrsjC7l1njodRDDqOZKDCejd
	ahYsMnAeZGuqjCeAr3jgCbqiHssmMZQGrKFXLlsWraIGHBSdAb9LVR4s6Ixns7Ru5gxunN
	JMXBWSSgMFqxOc0awxWUghMSjR9mxQ6qPkVE/uzBUx4xqPekWSUVLtyl87mqPw==
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
Subject: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS parameters when not supported
Date: Mon, 28 Sep 2026 16:50:42 +0200
Message-ID: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
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

The RSS kselftests fail on stmmac, and this is partly due to the driver
reporting bogus data for the RSS ops :

 - ethtool -x reports an indirection table and a key while the hardware
   doesn't have any of that
 - ethtool -X fails with -EINVAL.

Let's return early in the rss ops if we know the hardware and platform
don't support RSS.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..b78dc301d70d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!stmmac_rss_is_supported(priv))
+		return 0;
+
 	return sizeof(priv->rss.key);
 }
 
@@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (!stmmac_rss_is_supported(priv))
+		return 0;
+
 	return ARRAY_SIZE(priv->rss.table);
 }
 
@@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int i;
 
+	if (!stmmac_rss_is_supported(priv))
+		return -EOPNOTSUPP;
+
 	if (rxfh->indir) {
 		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 			rxfh->indir[i] = priv->rss.table[i];
@@ -962,6 +971,9 @@ static int stmmac_set_rxfh(struct net_device *dev,
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int i;
 
+	if (!stmmac_rss_is_supported(priv))
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-- 
2.55.0

