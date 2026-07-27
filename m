Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C72931D8
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132930; cv=none; b=sPo1dFOk+ys5xnxV2IJJd3l1BHyapYkWcRFihc7/ltnrG4nkOWyKRTr9S6IzUqgQTVc4jEG0J08+LHn2NUzIExtwmiQoI+RlGZInvTdHPhSEfmrnCD870g5js2hxcrLSyLMvOM8BqFcYj7Y+GevQ2C+1kbu+WL1RfmYMnPVYtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132930; c=relaxed/simple;
	bh=fLe9G039vQ6hRWQL5QYu0XMthfFe2VADtTrit1z6nOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gIEYfIFKg+WhuOGG9aVkWWmXn88maMD55mnzf3KYj2DndNpodv4FdEicsrL6+iV2upYz9rPJAWzMFpjHdhW4bxlqiTrhc0yOsNBTV04qjdQjSYUXEyp/O9jqI/f3mV3CZOYdTIGX2kOgBTuYBYgA+HAOR0xLrh2dcTCnTVdfuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLcvpDcG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLcvpDcG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47df43bfb07so362338f8f.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 23:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785132927; x=1785737727; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZTsSQ/Qdqv/aRMjcPYSTqUT2GFSJ11xQmUiZl5tGlPA=;
        b=cLcvpDcG4cPkcMrNYCLq3sqCHJ7oJyZ5kE4K7fYqJs1X3BFokgpzuhtAPNS+NPRiUT
         wvkGz0955dpqlIB+uazj7vtSGJdEZ5mpFk7yjJ6/SeiF0NgOxuHzSlKXp9ai1Z6PV60U
         FBbzmCbVI4zFbo9mMa2XCQtktQ3chsHf09QoHlPqpU8FNc+q+TwBUXD+rDT+ISFxa/Kd
         DwpdMKUlJf2yCB3iX8mKqCtgbIAPjCCF7ry1U1ZOWHtgDk/GdUG7c5CQZLAl0A1+9gvR
         1hn6Xv0y3uLlobcqSOoda5GUUpMyJjSQNGHlUpz9SyRuys7O1NTofgmUdwe+KXIB6kGq
         EXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785132927; x=1785737727;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZTsSQ/Qdqv/aRMjcPYSTqUT2GFSJ11xQmUiZl5tGlPA=;
        b=lV3ttpGDDefmCMSFTQjjJnwuwH5S4Fsd4MERqCob7GpjwQh2/V1zEbfZ42P5t3uSKL
         hWIZpcTtxN8oFMpu88ioP3S3RZNpxx0suEolJv45SVbgkoq0y37ryzlpOX9fBymVOSdf
         79kOI0F6hCargVq65qc5E2QaPIjFyFAh6o/c4DChZ5aSsTSXRYMjdTA0yxHsmkr+O2AJ
         re/ZGcXIcHd4BvJHPV2/ANyL+h1ZZkX8Zd4o5dOEphx0hP/xw78jxzLxhYF8VQ7VUroV
         wwzNV+6INUywWUydwRJ/HMcH7aeJhgLfyWfb8iWVgcYuDhfqphKl7kPylJaYYLJsjuMR
         nZoQ==
X-Gm-Message-State: AOJu0Yz3tXcsXNfRUpHkb+hlBSSDHSbpW/GI6bcMafYIbeBLjXGl7lUR
	G785eySUSBqeetYHIRX7yTeTjXn5KFAh3aNKs9V9lCBCxIeMwvS5DeR/
X-Gm-Gg: AR+sD13ClpMu/MH5mDvoen3lAHk7LdC/pGxTRxCXn8lbi3G68alNVce8BzVfK93FXZc
	DTr3rd5qgKjAuM0AukQW7oCmeRUVIg24/AFdKQi2Vd1ulU4TprvQAV9wtlN8myJctIhFf0BbuWB
	qDgUl5gTz8O9hi7geDrxXuJk9nctYlWDsJfOOS0PiCDEhEwggiCWakbceiftXbhcqQGuIW3CyHx
	HwrW/UFwEWtIuS928n4oFg+jiYzcxhf8KZPf+Miw8bEz/YyX2SWJbZ8iJtQMqsiZDrkh9e7NfPk
	kU6siZZS4WPSmm/Fei8jrI/u+mMhlnMT28G0cUFqg4nRKPF2Gx3voRaqpHt+rxt+YVpd0GH/MIW
	vGwreDNApUrFFOXshRvNhQdkJ6/LwZkp91o+dNSFiYJMJ9kNmECzcmlxLqHu9oQHotwDdmU2a6r
	9uRXQSE/+JuVTnXLkZXwClt6JXaSeMCuhC3Hn69nByV3OUt427NjiCnQ==
X-Received: by 2002:a05:6000:41de:b0:47f:87f5:ed32 with SMTP id ffacd0b85a97d-47f9fe9ffbemr9378789f8f.46.1785132927044;
        Sun, 26 Jul 2026 23:15:27 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm47003657f8f.11.2026.07.26.23.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 23:15:26 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Mon, 27 Jul 2026 06:14:52 +0000
Subject: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFv3ZmoC/4WNQQ6DIBBFr2Jm3WmAKpWueo/GBVDQSUUaMMbGe
 PdSL9Dle8l/f4PsErkMt2qD5BbKFKcC4lSBHfTUO6RnYRBMSHYVEvMcgraYVvTkI5ox2hc637T
 KXlqvpIEyfSfnaT2yj67wQHmO6XO8LPxn/wQXjhzrRhumaiMtE/c+aBrPNgbo9n3/AkYT7Tq4A
 AAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785132924; l=3209;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=fLe9G039vQ6hRWQL5QYu0XMthfFe2VADtTrit1z6nOM=;
 b=DcSjAoQAD9vywawezrGp7qHePtKZQSTza2D9e2SpMA+jhDf9Xl0+KFq73N4F/KHdY3sU6xL9X
 0szs6JBtPjJDtn1GUU9CavqAR482V5sLC1Zv8eT6dNjbovap4EFouwS
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
Similarly, the teardown should ensure the MAC rx/tx is stopped before
DMA engine is stopped.

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
Changes in v2:
- Corrected the ordering in teardown for xdp at stmmac_xdp_release().
- Link to v1: https://lore.kernel.org/r/20260726-stmmac-rx-fifo-block-v1-1-45ab094b6c02@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea..92864d7df 100644
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
@@ -7109,15 +7109,15 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
+	/* Disable the MAC Rx/Tx */
+	stmmac_mac_set(priv, priv->ioaddr, false);
+
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* set trans_start so we don't get spurious
 	 * watchdogs during reset
 	 */
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

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260726-stmmac-rx-fifo-block-ef589c38f96b

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>

