Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCB531B03;
	Tue, 22 Sep 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119496; cv=none; b=OPPpYea+bqmsC49m4ERrL5d5qN1mfGUJ/yXOU1XAeCVjBOsZVYOXp+7X5+d1GuT8Jxf1puDr2zi2VtgimhEEKuHRPvFH2gDWdbd9ERpJZmcXsO9PJSfTvG805c8w6vF573NJdwKoueODbwGYvFsj5o1JyRS6ZpX9uMfILsODwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119496; c=relaxed/simple;
	bh=g7xNGG6f6KDhEMF0no2WkSnny9t+AeRAFzePXWpQZ4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXkYCozl/Uc/8l2Ise0hi++py9+DcFfBd0ahlhdd1fvM8+BZyCaqzlaSKo9byRfuhqY3k72UHm/3YiV+vnk+WUrknIsvD0JXMuvpZrE9Dl+nfkOHkzwzajiU0R8BMBm0p+cUBiv9O9BiqfTEOxMiUm3ecdgH7Acxn2wY3CPGmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GTCWYsnM; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GTCWYsnM"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D335FC0000FA;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D335FC0000FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119485;
	bh=g7xNGG6f6KDhEMF0no2WkSnny9t+AeRAFzePXWpQZ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTCWYsnMbOf5U8F7+WDaMlhx9xZ8qqTz2oslhb5Yx1u/p9iMCZMZlXSxfClobjq/y
	 ux6NpkcATX/pSfafcUrXWETaN08K7Gt33pVw2SsN89CpIQlcDlzq53fXdQkmQSNv70
	 DnXPp++P+JuU7JT6sD4QuFPWt3Sraf9Mxvyxqdiw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 741C9ACC;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 02/10] net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()
Date: Tue, 22 Sep 2026 16:24:32 -0700
Message-Id: <20260922232440.598918-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both bcm_sysport_rx_isr() and bcm_sysport_tx_isr() expect their second
argument (dev_id) to be a 'struct net_device *dev', as they call
netdev_priv(dev) to retrieve the private data structure.

bcm_sysport_poll_controller() was passing 'priv' instead of 'dev',
causing netdev_priv() inside the ISRs to treat 'priv' as a net_device,
leading to out-of-bounds pointer calculations and crashes when netconsole
or netpoll is triggered.

Fix this by passing 'dev' instead of 'priv' to the ISRs.

Fixes: 6cec4f5e00a3 ("net: systemport: Add netconsole support")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index db627cd15fb7..8328fe824d15 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1198,12 +1198,12 @@ static void bcm_sysport_poll_controller(struct net_device *dev)
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 
 	disable_irq(priv->irq0);
-	bcm_sysport_rx_isr(priv->irq0, priv);
+	bcm_sysport_rx_isr(priv->irq0, dev);
 	enable_irq(priv->irq0);
 
 	if (!priv->is_lite) {
 		disable_irq(priv->irq1);
-		bcm_sysport_tx_isr(priv->irq1, priv);
+		bcm_sysport_tx_isr(priv->irq1, dev);
 		enable_irq(priv->irq1);
 	}
 }
-- 
2.34.1

