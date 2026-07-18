Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653E38F24B
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784385543; cv=none; b=BE2i/K25oI1ID/RPFfU5Cb+Kt2+3nrZhkiJCYAoerUcKczTtR4u//eWn4/O3Kyl/KdFqYn6SNVZdPXRxSt8XbSiiuKeUgimh4aW2emCjlSkzK1ZmfoTjkuf/H45D07DZuHDnrDOb/r3g4mqExegcJD6iTWSPCfyC6q52b1My+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784385543; c=relaxed/simple;
	bh=I6CzJ+JDKjRxZu3r96ktIWuesBGUDKfrC8qrCqZn4Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxTONsBVK1VHAcBuZie7JRLDmnIy5WPP1fG7iq9NhouEu2lIvlFIz5PQeshVJNLQbyiewKb+2sKAjY5jw4Cw8pBiOopGyzfm11eXlKnEBDsD6BtEUlzpCgSwIFRfA2s9qZWu7ClEfkdNyOpHW+nNS4+SzBuFSNfHgBdAQubvYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O2PCNXAz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O2PCNXAz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4B90F4E40E42;
	Sat, 18 Jul 2026 14:38:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 07D3960363;
	Sat, 18 Jul 2026 14:38:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1D8211BD0158;
	Sat, 18 Jul 2026 16:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784385535; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=x9V6cBq+TtwXJYqhnu6T1q5wgsLXdHrhThBITkOay1U=;
	b=O2PCNXAzjDUrE5AmaW/q2eCL+nLSBYwFFKEWvlyvm+Y+GElh/6Y+NNsT1xBrUUMgFOAO9l
	sowywpbcNketelv260cm8YiILm5yo+rjCmXvNQi1MdB9p7b2KhMbz2IzRahNTQxKUp7VdE
	qZ1Iiu31ZZzwffSLcUaxraJX7ngXNYC54lNClCHis/OQH/ebGYxxYV2+ZBdseMsIcv8pB2
	WbTtSOTST/T8lT1of7CTBQ90w/vq3Rmz4N+BZHukMAJoH/DI9SkM291BSfJtqlLLOm4R0n
	wtyR76iPOdtTIwuBb1Z+Po0Ee2xZgswjDwrTt+e8Tjc0RJDUPMm6wBUQQpXUvw==
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
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next] net: stmmac: Simplify ioctl handling
Date: Sat, 18 Jul 2026 16:38:47 +0200
Message-ID: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Now that timestamping is controlled through an NDO, we can simply
call phylink_mii_ioctl() to handle ioctls.

The only functional difference is that phylink_mii_ioctl() ->
phy_mii_ioctl() can handle SIOCSHWTSTAMP, but this no longer happens
as this ioctl is not longer dispatched to the ndo_eth_ioctl().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
handling in phy_mii_ioctl(). Looks like we can ?

 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..562d20830b94 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6371,28 +6371,17 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
  *  @rq: An IOCTL specific structure, that can contain a pointer to
  *  a proprietary structure used to pass information to the driver.
  *  @cmd: IOCTL command
- *  Description:
- *  Currently it supports the phy_mii_ioctl(...) and HW time stamping.
+ *  Description: Forward the PHY ioctls to phylink
+ *  Return: Zero on success or negative error code.
  */
 static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct stmmac_priv *priv = netdev_priv (dev);
-	int ret = -EOPNOTSUPP;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	switch (cmd) {
-	case SIOCGMIIPHY:
-	case SIOCGMIIREG:
-	case SIOCSMIIREG:
-		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
+	return phylink_mii_ioctl(priv->phylink, rq, cmd);
 }
 
 static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
-- 
2.55.0

