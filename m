Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF13659FB
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687715; cv=none; b=oQob3lYlYs4LEIEYL+/mfFfuDnHRILlRFvcLwuX8TruRC2hBsAoUvfTNbulO1DG38gXDHZ5UMEV8YrLp3oaejSUpcRSIFHAPMRUR3Y9l1uYIIcWdyfAm5FLMckYmocuBh5pDRqEAoNghckVIuHyOq1etpqXlWWj7trFJGjpUpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687715; c=relaxed/simple;
	bh=+DFF/LlKrj++mSfnje5JBkkLPuLJ0Z7cXJdpEeYpMoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsnAg4XSuGyjOiehzHrBJnLPwWvgV/oUCyyOLeJlcIZGCQn6XjhPYiBk4JlGPtUwJklaw3lupoBdonHQasprFm7+df1DH/k9OAoME3P11J7d0ckJ2K6VOPvjGhLCihYHCljG/Kt/mXDZfGw0o3Xh7Z83dwdy/UVg3J5cqMmvqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6SGzuOX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6SGzuOX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so5784025e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786687712; x=1787292512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9g+mH3cDkuaANlwOg+CZREKs6e+pObXwzyUt9cFT9pY=;
        b=P6SGzuOXhQPDRozcP/T9MOD8AlF+a8oefeWs+01Vf0pnAOskdcUE8Eod02fePST43U
         4TE06kOSKyU3yQBmyVGkfgObfwdauyfJce8RGCU071Hbfrgw5VpJxYxkueuILxJfidww
         ohow2SHsQlIMZXpcBMvkqwwKSWXYMWMk1bpZgWoYY/xpRta+UyAb7/trWzbhtix3S3B5
         ctzN7dM5+fbAwIUniUuE86WkG9dkM60b81B4BseCg+jmmIaVCSCBRDHEVNA6NM2S1+rY
         vrswBZU7Kp0iG+ihR9eyd96xIp6z1JLtaBB0Yjtg3Zu8frrMUPkj8uMt8JEV59trh52u
         jdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687712; x=1787292512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9g+mH3cDkuaANlwOg+CZREKs6e+pObXwzyUt9cFT9pY=;
        b=nM1rtc1MyqcFnT673ydNtwznGqaiXehLtBFUgcDeZBovv4vKLxDd+OqqaguL7+R0q1
         /NfHw0i2zsELxgsJcbuNKgH8jI6DfWO+oJf2n9VQHZS1Whoi04zgC3Msc6SuVOUrg953
         ZFAXR9Xm9jOMpl/yLmzOetgVryD90RtBca4j5Q4b2NoVSp60V+QRXBVuH6MLG+pAxGx+
         FTReWJsvCiIFkZXt6aPK4ISmvM+46y9jVahTn2+NFj7ICgujaMWLH84N/O69Nz172R4N
         O2Mdx2CXyzC03PbKCc2wf9j+JxWwt9iNoGPVIiODAowMBQuEk2SrUPJIb9lvUtEKQYbd
         ozhQ==
X-Gm-Message-State: AOJu0YzdlShwamfLDpda06NUjUiiGa/W22RQuZuVo5gkRiKwluAtdoHf
	x8QEY97To0479cQBn8HzRQVJrRNtXDQmXTntO6vg/eBbqmB0Mua4sGhh
X-Gm-Gg: AR+sD11sDJExc9ftyjh8P1M6q3dCQ6IgufaDOxU02ck3FDTKU13M1gs5BaomAHotyaM
	hG2EsnQxb17bKx8BlDVgrnDInBXp93hgPcjvJI4ocm3oN8p8PPWEC8Y3OYPZPHBxgvd+yLNxMuG
	E9rWI6oMdf21sVqaC+jc0opeYdJe8hVsvT/0eEpZyaTbGxspQAf/oRQV1+5SRAoxNUN5id2t3WV
	KXC0ODOS2/ffg33hZC251O1gJvkBd2y8WePqykRUr8S1U1ak9O9nhqMaMI+F+genXtNN4PZL9Yl
	7A0+P232PfV7j8I/X6+qh+ifhLpbPDknfFv4xgc81BQNOH5D+X1dTSqPHlSYIDOPsxtk+Pv9dhf
	1ioULixmUJQ80uDL2fi18FfsXi72pMd1COj2bQx+Umih/0SE4hhI+kh9iPROOt4zBb54o4RZX3h
	iQ1MjWJoIOOc25+kdwRAV1xNavRQl+yJsnpDhkrds9cQGB7nq8287zFwJ5VJbHmacw0iJWjCi/0
	eFyNycHuzvpMUq6yDjEQsjHSce3VJNC+JeMFV0y
X-Received: by 2002:a05:600c:b99:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-49987929903mr43542515e9.2.1786687711854;
        Thu, 13 Aug 2026 23:08:31 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae9618sm1475095e9.13.2026.08.13.23.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:08:31 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Fri, 14 Aug 2026 06:07:53 +0000
Subject: [PATCH net-next v4 1/3] net: stmmac: enable MAC rx/tx after DMA
 start
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-stmmac-rx-fifo-block-v4-1-1951fd3d33b7@gmail.com>
References: <20260814-stmmac-rx-fifo-block-v4-0-1951fd3d33b7@gmail.com>
In-Reply-To: <20260814-stmmac-rx-fifo-block-v4-0-1951fd3d33b7@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786687705; l=2204;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=+DFF/LlKrj++mSfnje5JBkkLPuLJ0Z7cXJdpEeYpMoI=;
 b=7dmhLiBOgS0G/4/VZZyzW/fGUA2YSWzXKrxly684D4wqxf4gGB4SxH9/fcczyumvvs0b213FX
 M51iz7my+rAD0uK9HgHPV0/GD4hJngQzMHpTB7Ew9B6G62L5EMXOxHY
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
index b2b7d0242dd3..b9d5d4aabf42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3685,9 +3685,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
@@ -3743,6 +3740,9 @@ static int stmmac_hw_setup(struct net_device *dev)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
+	/* Enable the MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, true);
+
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
@@ -7184,12 +7184,12 @@ int stmmac_xdp_open(struct net_device *dev)
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

