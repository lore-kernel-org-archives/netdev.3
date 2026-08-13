Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5D35C693
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607408; cv=none; b=ayYgwKMuy7/MW1tF5iVVyOTZZcWEJx3mTLARqI4bFBMFR2x2HAkl2157lHdLi1RLRG1lqPbyCuXFoZN/iMNXb1bzZUIl89CGoB1GStjWMPEGEHNRYti0SANYWaVA3rSs11qNjOMGDHuIV3TR5PnCzHzLYEvKBSnCDy34LoZABuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607408; c=relaxed/simple;
	bh=oLJsS8Rav70RicuKxT5K0qmNv7lDA+PehXT5PqdKKNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIN+5aZLHCYCHZhbb9zwuJFpZUe4UubhUJbWfKhc/SZTDlkFgMQ40L/0CpOGLtzBRSVTzm/4Al+BQt3fdVw5n0K902Qo6LVXh97QVoUspgooWjPu3VdDUr6P6R2NOcUGl9Vj/cdzx/QaOHvA9VgSMxCqijTVcwG6ekHMuFtRHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyuUfrzW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyuUfrzW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so2618755e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786607401; x=1787212201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sht1wpc2JaD5RBgXpQ5clgBvN8Zd0QFzMWE/NcW/TSg=;
        b=ZyuUfrzWw2qWZWMLQgobHgt0UObTJE26q6cWWylhT8mMSQjvgIDLz6bcPoEomUMA89
         bpjxDlxyNOPVr3HuVJKgln5WHSFzWPbtPY0blSKNB5nF29OcHjIZFJu/T6goBe7VPgRP
         0uxGptv3Ny/lYyY8iruMUONx9NiHm+Kp29SnBLoXfP4yT3HSEZtJlJO6qHHMk8oli2P3
         S+pU1H/clx0UKRBRLQaMwb04wO/GwJYHyt37RsTjKwt++T13avn9mW/eJp+ec8kiNHEg
         5/BbRuVheCd1+XbQXlDslsckiHzYTAS6Dm5P2+9jcKAooUJcMKBwt2IRc1DoNmElCIrw
         R3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607401; x=1787212201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sht1wpc2JaD5RBgXpQ5clgBvN8Zd0QFzMWE/NcW/TSg=;
        b=CCNAzkWe5VoVbpdzuB9UPDG099Wfv8Zjw+ihK+ggWYSbH4329RUE5+X1OlXN/O6lyq
         eCIkhVZYAgS++gCui3uhHbV1o9TrTOZZ7AT2rfPQEEPbVkshJLcs8NC9hSThlLOfUGwz
         TWLwMvXjHQ+CvbuQTGHtsiA+3oAmXJQanlRktaO4ZmVgO4Ep9/YPdB/RSOqwQJkzNs/9
         AIvj134AX4zYe9TDbRZ/jztbgHhc2EOhEgLdBBEmgjJxWBXC6PuEhqZK8+uZc39ju+xO
         d/renpa/S7ScKUg0L3qcDmmB1sGYOzmtuo6/8mZcxU6dcrgIfd58sVaNKUPHfYWtyDL8
         zCzQ==
X-Gm-Message-State: AOJu0YxWe4JwOp8rcqrMptdMpeJXMANjS49U4o2lbfq9kQTk5uiY3coA
	v1Ksey16Gb7NxAs0zXQ7lglZXaXhbC1fsdsGb9PlPjS/A9ymtEQapODU
X-Gm-Gg: AR+sD13a4pK0elTQq1ZtItnZQpH+GZvP7uV1lD+EGO8w26V6MhdTPLtMmvNhn5YNAoF
	gaZcz3wH8sUIaXMwGZ3GDwsV6XjIlRHtAOc5KsgwIBylIzPqIOXwJnOjNEPZlUoNc9Y0YJGwl3+
	ICxTWPXAZkxqSbI2mb9T0ost3gji/QnOv9OVAmyJ306TaUjSq7OS5V3iiWWZEs+RfC/IKt9ZIHi
	SNGEN/I2/RQCr7GaVsnaLNETn2YXCNza1qpGLzRl67qPTdRL4eRiQvhNCRAQywu6nP/hRz3W+Me
	tAviAkGql2ypxyxp+4w02RAyQOEgPfsyipsfgttUYJSV/bAHYywW4IAeH+GMEng0hkL1eMa4hJW
	FeQ6n9Gn4qF2++VcGFWZdStHX1t22sreQ9yR3NT6E1V28U0h5tXqjd25XiTEC05rO4itKH2yGnP
	lxCyX6cBP3BljWINwUJ78Xj9FdQnPzBdTaYWUierJ2gINj64DpPzdIQ2npvNKHLkRHkbcK0pMpW
	ybo93xui0Ct6PrUq4vKIfb3Lty28Zr1mQu0ww5QELm8ZLHVCzk=
X-Received: by 2002:a05:600c:8209:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-499821f1273mr49179195e9.11.1786607400830;
        Thu, 13 Aug 2026 00:50:00 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm41936365e9.13.2026.08.13.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:50:00 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Thu, 13 Aug 2026 07:49:27 +0000
Subject: [PATCH v3 1/3] net: stmmac: enable MAC rx/tx after DMA start
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-stmmac-rx-fifo-block-v3-1-738acbee55d9@gmail.com>
References: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
In-Reply-To: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786607395; l=2198;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=oLJsS8Rav70RicuKxT5K0qmNv7lDA+PehXT5PqdKKNQ=;
 b=hJo3R0HUUrrbix8X3VwmEqUsVK8fR1LNfIWebwZ0c3IPfe14IWCevuyQu7bdSHoIuNgdeoAdz
 /kxuNoZ6eCFCtBKcosxxy1Ff0Od+wPN6JCggYGfYdAnse5WAN1dZBUD
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=

When the MAC receiver is enabled before the DMA channels are started,
incoming frames fill the MTL FIFO with no DMA engine to drain it.
If the PHY/Switch is already up at this point, and there is inflow
of packets towards EMAC, the per-queue FIFO overflows within this window.

Once the FIFO is full, the MTL read controller goes idle and never
retries delivery even if the DMA comes alive later on.
This behaviour happens due to enabling the MAC RX path before
the DMA setup is ready, and any delay between these events increases
the chances of blocking the rx path permanently.

The EMAC should only accept packets after the DMAs are enabled.

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea..1213cb216 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3692,9 +3692,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
@@ -3750,6 +3747,9 @@ static int stmmac_hw_setup(struct net_device *dev)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
+	/* Enable the MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, true);
+
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
@@ -7189,12 +7189,12 @@ int stmmac_xdp_open(struct net_device *dev)
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
+	/* Enable the MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, true);
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;

-- 
2.43.0

