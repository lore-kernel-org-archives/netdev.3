Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C66345741;
	Wed, 18 Feb 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444637; cv=none; b=cHuzNXP8+AdwO7yjgLL+6n+pMPTeVrROihmwu8Rj04urBKj35z2LTnUQvaFlOGQpRESpw0yf9SRPKLme5tKpEeVXpacE555M1BktGyCGkBKvIKUbDwx8MCsK4NcbnV0Jmjli2iCzRdH1AuzNY5Yn/TJZUCqG+R9o1RcrcoVtR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444637; c=relaxed/simple;
	bh=h2BiBz+DfieSHe3tI/Njgc7TA1kWLssBIRP/12PL2iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqUhDcDV+hdAi5QXUrw7fSebhTH3F9mEhHpzMGpZpLv7hs7z3X9cpNwzxhscxZMhPGc0CrA5PQbNmPHwZMa1DUn2oUaDUctyQm0xgeuRQT+jhWnpEB663dxuA1wh7JQ7FhF4g3FL2t7yvHC0B74GxKYSMfCjUDlYg4z8ChJxH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Kogft3yF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Kogft3yF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9810BA034E;
	Wed, 18 Feb 2026 20:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771444633; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pR6GVLXGqByomxqwQ5CVsKqzX3AIx0j3FQbyTqkfcRc=;
	b=Kogft3yFxdoI3G3kUVfJTZ7vQOv13v1oZkmAai548h2iHUJ2RiYgdTfRhNalh6Y41Bnl8V
	1b8KIZnCZlEXUpXrHP2etdXMqDN9pIPv44MHgINkeeRhQLSJK3jbMRCOOi1Sr3swRT7BZS
	ssf+AqjlukeaPJtP316EL3z5mOCuCT6npzjCiwnTfEhckGX8jM3TBb8IlxYfQkr1FDPyqL
	friaQBJ0n408F/bT3GqW2ESoPpqqcfbI3YszZFqc/HtrofCChNrO5mbbEu2ZiLawDg1SGi
	r6WSI4PZcxpmtkEb2dMaz/DLchs2FFJVGnhvoUBKH2OqFoTY2hRIC5p4vbZrqw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: cadence: macb: add ethtool nway_reset support
Date: Wed, 18 Feb 2026 20:57:04 +0100
Message-Id: <20260218195704.25769-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Wire phy_ethtool_nway_reset() as the .nway_reset ethtool operation,
allowing userspace to restart PHY autonegotiation via 'ethtool -r'.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..47fd85cd9613 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3945,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.nway_reset		= phy_ethtool_nway_reset,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.39.5

