Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628593D5C05
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076301; cv=none; b=G1LuLyNJ/Ooe9pltxFS52BlambCwxCieEcdVJCL2V3qNphXW9cqXO6ou1grBiZVAD8qEuq1lzRiLZpBsR5eOslCDMfvPiwbr5b657/dr3Sh6CsRmx26k092/k3p5XQ8vkxuBGcOQUy68HM8fpXDL9HfiMS2vAv7Qzpd2rd7BBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076301; c=relaxed/simple;
	bh=Xmsh8vLkxa+urAg9ZzBey5HhQUknHpXB+xWvp5JB6io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoUbimfTN8mxjKYaNOC7VndCFvrT7tBuuXb/A+zvSTTa0XeAp1ocI9AttgEJfY0GsSO3jdanRdYUao4qMljolgbZpiICy1iXbabey0UOfmvMNzhO5MM7iM0Z2qC442yTiMBPFlnA13SLzRPJgaPeD9gLgbmq0fLJivoJkVMgk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=h/PRzly6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="h/PRzly6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48af27fe287so504886f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792076295; x=1792681095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HM+R+mbJK8RLBqpDdx1wr25PKa74we7OacPAq9nMC0I=;
        b=h/PRzly6hhi90KP0RzL8HrpZfRgF2sERzu2tPpwVXy/XAttTznW/cyqvTtYWNsaWVK
         gDPBerOsOknGvgDALJJsL8ezVNDtNBxSwG6arIr4Nsd+4fw8xiiTUSTYL9NXN1+L8Uy+
         fHfRtb4Kmjqj/FYidsTSPVK6KDgbOj0XN73dUQgrWcM+cs+2RHDq2MnPXqp1QEM7pEPZ
         y0EKUnteHqB2y2bisI1FeLaA1BrPPhVgx4wdugI492doXJJxZ35Awk+K857YUy6+Oxg/
         sf9XJNrjvu8hIlaq88jMwJvAMYujU7dIeYkJmPpr5/a/+p0qwuQVBFR7888bqDMAxjXz
         AlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792076295; x=1792681095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HM+R+mbJK8RLBqpDdx1wr25PKa74we7OacPAq9nMC0I=;
        b=2DSttyxEq54QTNksuBLF+oO1aAzbWeTzEdUwa7xhBwuTBBrMTi4L4R9ha98sqQXjQO
         laXZnPbAiUyp1b+DqOSkNm9Utmn6Z7qLYiLF3trwSEBeVb7yFV2Kew0Fkl6M0d9Sn57s
         9EGnV/XsThOlzbDLh5Bxu/0nsenRuC84kpsGjwe4tjmj6PBRfBRqJ117eWvddD9qJLzf
         S3INh/9V0NDmR1CMP07d09P83qLq2vOxdFLOJ7CiuDm1BiNQSShANkhQFYHnOPVLQViP
         mwBxb+16DxGdGWreMZ0wlNQ8Y23gBCf0SwdaQkdzkp8Ii4g8QcHcq44Ta5qN8PJB4cqs
         NIhw==
X-Forwarded-Encrypted: i=1; AKwUvBxhAds8QLNlxcrZ11meYe7Wuz4ydXnB7OU3QnjvFksT/4t+ZaEtZreoEwxpOlVQ9q3iY28tjGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmQGD63aa0nNMp/jopLyVhXtlxzGML32jJ6Mcz4JFS1Hj0/6Bd
	VkfwpS4bdVd5dtmgXSspVumm+yAS1xEOKyS+xn3ieVIYIlwDUG5JFVhilZTnY68t460=
X-Gm-Gg: AYBFou2hut1b0gn7MZ0ffGnxPmr9gA0BGHJg6blILKT+YIcR279tUUYAIUSiWV5aSwA
	t0L2hbJPABVd2WpQUbvcZ5AEOP6/E3+bRDUbrcsQi7qoThUqxTYjMeTO+ge77AWwcUertgtmCbZ
	HaTWXeTyD/k7YgPHYOg1ff6fPLo2hVyufyeD1gPSVO/kmEaujTJ0OvJPo+npuzqFf1cH8g4cVKu
	3fifi+s7ITkUfqyBwwiG4n8XLWNjhFHw/WF+so47hrYaRdrwK89pq0VISXLHghT6/SbvNfTszF1
	SEPnRd3LNzqzLzJH/LjQ8WP5puzCJvuZpGzcap3VixUua+0H0xA3NgKwP4ZUK6fDZRHFqEfkOPu
	/ds6zb/Y90bzqWFFI+HGGhgnRrT61gkHBzFt2g/xH0aEmYbweDFS5FpoKMfrOOXUNpJyAKJWbQO
	IBZPxmukwk8lhozAxM3caDl/C32NAE2EgNMkKqu4+xuE7M63yHT37ax6AXYJpXW1vLhxNSZd2Ie
	7ekfiHcwFR1HI7fzHNzY3oul6orgt08iBLJnn5uLYYH1dtMzaFSQDx0oOK1fetBZMB6tRUE9nZi
	yNsF+Q4lLD1IkLqDk3B5CWTBG0SsOqPKemR0/2SC5LmR3o4qJ92gneZrSPjNeFO0w7ww2A==
X-Received: by 2002:a5d:43c4:0:b0:48d:ba3b:af36 with SMTP id ffacd0b85a97d-48dbaae8e33mr30543201f8f.37.1792076295196;
        Thu, 15 Oct 2026 07:58:15 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac4fd7sm19738293f8f.40.2026.10.15.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:58:14 -0700 (PDT)
From: Daniel Thompson <daniel@riscstar.com>
Date: Thu, 15 Oct 2026 15:55:02 +0100
Subject: [PATCH net-next v3 2/2] net: stmmac: Avoid freeing and
 re-requesting IRQ during XDP set prog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc956x-stmmac-no_irq_teardown-v3-2-8189870be545@riscstar.com>
References: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
In-Reply-To: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Eric Dumazet <edumazet@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5397; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=Xmsh8vLkxa+urAg9ZzBey5HhQUknHpXB+xWvp5JB6io=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBq0On0886l08HHREvWrJqdn0hcWlbVy9OPSK05v
 3jBqmxmICCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCatDp9AAKCRB84yVdOfeI
 oVUJD/9PRRiCUW/mNpgCqony21Y+ly09GrfxL7uqhj8q7gbv3J7MfZzTgMES0M6JKRyOUTAWMbW
 mdRzY0OHRDgRt01w5WKjbMjHKriUKKfk40tc7BLkyYmI2DRz3uAYVE5e5Nh7GLXylUtF9z/QtF9
 YjFgKjuhdfSknG+uoXjgTwASLwOAjFHoHdkgOE3Q+8akX0b99GZb+WRvbNxXVEnTrgBjd65cMvK
 U49YCfVG3Y4LkLOhZHNWRjs+NzvBvU0DqHF93X9cMQzzaFG47gaWbzwIcUEgsvTm5U0U+wbwLKS
 zFccajtkdEBVDGQdvdtLre3N+JRcuyEM///kbv4u/PgqFeTrcnpjiwuQXOaFHz4dX5fgRVGXSGM
 RxRl/xUENymJW+9VIdG4SDmIsKVrZ+K9K4smCGuki9lHJm2ev5j5ruLxN8ePCOZx+hhzi3ODiX7
 sPkd0pIyACcYwhdR264p7xgILqRgTjje1USdjq+0TiVtd9hTSbIsW+/8BtC0JDxOBI1lfZwOtzW
 lPy/dGg/KH02/QaJYKzf0KIxxiVIk62+9KMYdt7JH9IIMY4HjVrq67ocMu09Fs+hB9V4u1+jusd
 TOBMZnXTwmhsWV+nTxj6CloIkRFtCsiUncePB8XlUuKBOBuFiF4iOzGL2Ip6bmD25BIV+jdKDSN
 +q/Y6jCTmK2tnHg==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently stmmac will run a full cycle of IRQ tear down and setup when
setting up a new XDP program. This makes tuning TSN systems difficult
because whenever a new XDP program is installed then the irq threads will
be stopped and restarted which will undo any thread tuning.

The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
from stmmac_xdp_release()/stmmac_xdp_open().

stmmac_free_irq() implicitly synchronizes interrupts and, with that
removed, nothing else disables interrupts or makes later actions by
stmmac_xdp_release() safe when there are concurrent interrupts. Thus we
must replace the code to free the IRQ with code to disable (and sync) DMA
interrupts. We also need to avoid re-initializing the DMA channel. Happily
the reinit is redundant, it is sufficient to rely on the re-enabling
of interrupts at the end of stmmac_xdp_open().

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 65 +++++++++++++++++------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b80fe66cf199adbd31b79a484b2970aef211b51..f1359637007e211b505dd74577232cdc079baf46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -144,6 +144,7 @@ static const char *stmmac_dwxgmac_phyif[4] = {
 	[PHY_INTF_RGMII]	= "RGMII",
 };
 
+static void stmmac_synchronize_irq(struct net_device *dev);
 static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
 /* For MSI interrupts handling */
 static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
@@ -2520,6 +2521,23 @@ static void stmmac_enable_all_dma_irq(struct stmmac_priv *priv)
 	}
 }
 
+static void stmmac_disable_all_dma_irq(struct stmmac_priv *priv)
+{
+	u8 rx_channels_count = priv->plat->rx_queues_to_use;
+	u8 tx_channels_count = priv->plat->tx_queues_to_use;
+	u8 dma_csr_ch = max(rx_channels_count, tx_channels_count);
+	u8 chan;
+
+	for (chan = 0; chan < dma_csr_ch; chan++) {
+		struct stmmac_channel *ch = &priv->channel[chan];
+		unsigned long flags;
+
+		spin_lock_irqsave(&ch->lock, flags);
+		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, STMMAC_DMA_IRQ_ALL);
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+}
+
 /**
  * stmmac_start_all_dma - start all RX and TX DMA channels
  * @priv: driver private structure
@@ -3816,6 +3834,33 @@ static void stmmac_free_irq(struct net_device *dev,
 	}
 }
 
+static void stmmac_synchronize_irq(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_msi *msi = priv->msi;
+	int j;
+
+	for (j = priv->plat->tx_queues_to_use - 1; msi && j >= 0; j--) {
+		if (msi->tx_irq[j] > 0)
+			synchronize_irq(msi->tx_irq[j]);
+	}
+
+	for (j = priv->plat->rx_queues_to_use - 1; msi && j >= 0; j--) {
+		if (msi->rx_irq[j] > 0)
+			synchronize_irq(msi->rx_irq[j]);
+	}
+
+	if (msi && msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq)
+		synchronize_irq(msi->sfty_ue_irq);
+	if (msi && msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq)
+		synchronize_irq(msi->sfty_ce_irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
+		synchronize_irq(priv->wol_irq);
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
+		synchronize_irq(priv->sfty_irq);
+	synchronize_irq(dev->irq);
+}
+
 static int stmmac_msi_init(struct stmmac_priv *priv,
 			   struct stmmac_resources *res)
 {
@@ -7141,8 +7186,9 @@ void stmmac_xdp_release(struct net_device *dev)
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	/* Free the IRQ lines */
-	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	/* Silence DMA interrupts */
+	stmmac_disable_all_dma_irq(priv);
+	stmmac_synchronize_irq(dev);
 
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
@@ -7165,7 +7211,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 rx_cnt = priv->plat->rx_queues_to_use;
 	u8 tx_cnt = priv->plat->tx_queues_to_use;
-	u8 dma_csr_ch = max(rx_cnt, tx_cnt);
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
 	bool sph_en;
@@ -7188,12 +7233,6 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	stmmac_reset_queues_param(priv);
 
-	/* DMA CSR Channel configuration */
-	for (chan = 0; chan < dma_csr_ch; chan++) {
-		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
-		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, STMMAC_DMA_IRQ_TXRX);
-	}
-
 	/* Adjust Split header */
 	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
 
@@ -7230,10 +7269,6 @@ int stmmac_xdp_open(struct net_device *dev)
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
-	ret = stmmac_request_irq(dev);
-	if (ret)
-		goto irq_error;
-
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
 	netif_carrier_on(dev);
@@ -7242,10 +7277,6 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	return 0;
 
-irq_error:
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
-
 init_error:
 	free_dma_desc_resources(priv, &priv->dma_conf);
 dma_desc_error:

-- 
2.47.3

