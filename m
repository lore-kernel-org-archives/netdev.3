Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346E38734D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011003; cv=none; b=R8MV0Fa/C80mMscCElcAuEg4p5hM5H/hg8S/n/4UoYJXArolAjgQBsYzjzvukp0pBEaE7SmoK4xtvE7HTiPsWsYpXur9J8syOY9X2S7EdKB7FePy9RSHpq0XTtnz37NFTWYaA2mmBQh9ot3sdb7kC8WFGkzhasChBOINgsNlJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011003; c=relaxed/simple;
	bh=hFLXOB8N+D9V98BpkdJM9FH8d5ovP9uBx4zJgl68nok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNY+cy8/hNUzeIMd3ucwY/vbM+HcHeEvgkd+G6ldyxcwtbDBYZPchDWf7gyN27kJ8G9mQZv9DBxmqiDw28twr/KkkqYCmXmwAJEHY4zTUm93lAYfbM2apOT0Qc5YL6IdncG7oa5FF3L4iw4wX7bm8uBZwx1PivhelpoQyKQpafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=BsOzXc9J; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="BsOzXc9J"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65500A4463;
	Wed, 25 Feb 2026 10:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772010998; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rVYHCdw10D7YjJnBP8DmmR4pDQUvEzjz01boDXvRA2Y=;
	b=BsOzXc9JWXzGZP6+fSQ5xBPZsByXJcxLTLozlO2KAKf9SLgfuvvIAWekLORZ6Mrr1hoXln
	Cv/kf6LedsvWWnWCv+ASDbaToaCceEx1ZcNqXoMo75HOHMbgqBemLkF4JAEeTncBFFLIOt
	hVYf7LdBOAykibi3Q5thBTpMY2G9vgALe3DvsimjKkR6wgVkpNCYkZ9M9dIMhOyAO3rb1E
	ZzvXObByH0NjjPKYgXTCNWx3cMSwzgKS5IAZFBHoEN9v5sf5CcTdwmsgU+40F8kCQ/0uXL
	ingnZMWtTCdBk+z9N/wIFwXaLJA1V1NmJSdPv6TK1D9h6iS4SBSVyZvmMIEiww==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 4/5] net: cadence: macb: add ethtool EEE support
Date: Wed, 25 Feb 2026 10:15:57 +0100
Message-Id: <20260225091558.51157-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225091558.51157-1-nb@tipi-net.de>
References: <20260225091558.51157-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Implement ethtool get_eee and set_eee operations for the Cadence GEM
MAC, delegating to phylink for PHY-level EEE negotiation state.

The MAC-level LPI control (TXLPIEN) is not manipulated directly in the
ethtool ops - phylink manages the full EEE lifecycle through the
mac_enable_tx_lpi / mac_disable_tx_lpi callbacks.

Both ops are gated on MACB_CAPS_EEE; platforms without the capability
flag return -EOPNOTSUPP.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a9ae7ecf9fe9..37a5b866e3a5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4033,6 +4033,26 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_ringparam		= macb_set_ringparam,
 };
 
+static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_get_eee(bp->phylink, eee);
+}
+
+static int macb_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_set_eee(bp->phylink, eee);
+}
+
 static const struct ethtool_ops gem_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4054,6 +4074,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.51.0

