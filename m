Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460B47C110;
	Mon, 21 Sep 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032481; cv=none; b=AyKcNJHFx/3yPaMYe0KtMe2tQjBqqkXOn/lYB2P1ByWKu8jfUGd9adprbFCCYbvj1/eRSocgpjwcEP1PiwCOSqGOMTPVT9ctcFCscpNKzweYpovnmH5yaVKUgxHbxr1jTzMPVJAs7GlI0XRQTw9HWxx/vdyatAIhCe6w5TTl3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032481; c=relaxed/simple;
	bh=v3TAneIUXNK6RM+jO/O4VsMmQ5viuhNfs/4VJDoEAUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAIiIhjNFT3fSRRU+XYVyrnRtii09yeCPGdXwqy3jD+5TFGiLzXWELxIP0MrXQPQnwOsgakc+pNLbI8jdM7/htNeSdIttlcyfk4/M+kcJSGoHTZ9gkAtjCydOfqa7dx+7+yt6STJVBbADEw0p3YXlu6jUx1mnELYcMIMkajwiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=mjQIvBcU; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="mjQIvBcU"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9BB11C000D83;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9BB11C000D83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032472;
	bh=v3TAneIUXNK6RM+jO/O4VsMmQ5viuhNfs/4VJDoEAUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjQIvBcUo6ZzzcAA1ZVoBrSVPZeV4q/w4JVdh08mk4qIlFvN7//cq3iTK+ex7kwKq
	 HI/AlWO+t0LENQIUjU/BcxoSFPdxGTCn0EKMxWAULj/FzBMNLOGJ8T3UPlGnZsl3Lw
	 Sz4XSavF6jH+BBQfXwF/f5T+I1CONDRv/YUoHCpo=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 72D3BAE0;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 02/12] net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()
Date: Mon, 21 Sep 2026 16:12:55 -0700
Message-Id: <20260921231305.394773-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
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

