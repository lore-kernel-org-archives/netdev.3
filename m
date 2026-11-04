Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773988;
	b=aU6bN60NiUdzugpUzKnOd/Tzj4Wve+1YAL1RS2qdV/0bCvCNPUWwKkCQ96sREf6QRlsV
	 eOlpAhcz4SUnrfUBWyZfFMNtfbrAME662a9NVRdnNKljW0oio/KDOPWBWVFzEsOHeoJWR
	 vzMMbMZMAY4TB+PMykV7DjaXg/BTlAXg47Q/1vav7q4Hr7tuU4tzC4H7G1aTb+o66Ig0b
	 Cg2sBWar/8KA2/B83xJ4cIeieMhrYT65608mnzSZsT8+fL+IBiPRR0BKm7fUDvWXUsKJ2
	 ilkb07vnRforG53af85OzYRxadG2Is9Avp8U0yF02s0j+tsT3A+6KR7MsewduRT46dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
	b=f/FVOSUt9IFZVbcL8FbT9DFduKxo2lQqVFOOIMNNCfjhMT+1dUD8mesPfniBIOftUIZB
	 Edh8R7zl0uIHCiLjSNgKloHyKpxV03emGc5YvTs9A2rmsS/u+gWD6uKWYKSzEITH9neoB
	 yg4yycHz8zYSU9tdjt/GM2VX/6gnd4ozeJVfj+VRxPNB2LPIjWY+huL/iwIHMw6srzlS5
	 KdOdo8rYKJZ7SB1MUGB+roqc4PhRE9LdyC8t4ToR5rPrRxC1zVfg4o9QLbntIdcwi+iyO
	 OCn3ucICS9rYBWfuk0xopRGAUl5zjfCmf/dOyr3VHvJMfeLgwNRCWX5hCy11s01tC0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKKXxiTS;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DD606A330
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1DD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKKXxiTS
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e942864693so1853285ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773987; x=1794378787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
        b=WKKXxiTSTsxPOabagD3SlBgkZ9yigOTxXysn70pKQCdJDv4dO9lyAoyuNmUvzL3YXy
         3RVxTZb+zbkZywHGYo/nt12vEY+pOuzrcFZB9kOvQLiJa4l5dmVZ7ACgy/zXhB/duzvd
         7XlwCx/d/apJzLpgy24jRqUv29j9HdIcY+S9YOe2oAzQv/SZncCKdGVuPtq9bbA7MdKJ
         AEJ1keBLhJq25r6bvhzpTh9zuzHte3bgZGdeH1YtqO+Eu9AxNxvmOLblV+1T6HRp0T6y
         VwghtZ01S6dCksufcuangbp5kmMQ9GUbF8ijXXxR6aZ9SavK7prk+4zpZjnpC90Uq7Ny
         bi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773987; x=1794378787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxxQShbp8FZG7pXPyIlcAhi3RD1LSwiwzG+8Ik25uV4=;
        b=hytZ8dTSjs3egeF2FUGMMYJAIgeFEWADoKsf2rtQsGsIsW8/O2fq0owy3FezhmlE5k
         +n5TKM3gdU8C4kOqv/5BBqtEEoLPSJKdEGzSm3QfcKsGO+LitKL4Q8tI976DBUrOCXYM
         cWhg1dkpWc24j8ftH0i+lpxrGcMnIgXR5QKGwljMN5V9UO5rsh0Oqj2QmIS5nm6JKUep
         6t9mNTF68Ddr6h8O9ohy6ZflSdbqiICfI6wBLCZkjS4r3KiimgVHZS5MmvaHnVeJ55Yv
         GfkTD40jUL3y4yJHnwoyWqLMsFha8IIYczgf/DcsM6vlhLA01/vrbBgakuDt9YzFM/LJ
         l7NQ==
X-Gm-Message-State: APuU4Z8AEz3rrNGasowpFTijdMJpKg+gyl9sHfxFEk7alNlS+Lb/fGpr
	9LzSE2nsBGC/xBoixtcE2tXU6bSPFZ6xhO41vRB3yNjtV3WSSDcrm6Sq
X-Gm-Gg: AYBFou3pNWuilYp8+D+EdxGTyAuZFbQFLFKr5c0HZmxi9L4wWxBIb4yoF2nemz5+KMK
	AIqS67kd/yFFdXhJtl3lUFqhxAkwKHoz73KtgtPYWYYj7KyGyl3sYaLVGCVFTsS+QhyZUBBYjos
	jjAzvuIJ+FOBPTBUoHRImO2YfpYyQNXfNXGpgNaxwHpNBARm+F3PHUWLd1zPu2JRywubvCRIrTE
	AyLut6CnlsVl/p5Ah0rUqb+DMbOXvcJoQRCWI0Y4qzKFwNcHj5njPtANoxiR6ty8idtBC03zPgm
	JCyuUTP3JqJWkS5X1ivVigckLmUGutCpwGgd2/Nf5g6NNdgA+vB17I5fEuizk7Yk2Z2EpaCpsjq
	XUOsUBG/5po+tlutz3umOJ+5eFSZJD84UIIO0IyY5mZ5SV7ZUgzPaoi5G4FQZlwd6sMUQDXOD6t
	IHZ+oKcQ9a3ZxVVHK0bY4OdCmscrhwBDO48/hY+AhIpBhR8+r1hhYKyAV3BxxekSunu0iwHJF7e
	msfTsT1Wvn9vq5sMOniArEx5/ClmIOwp9WVv6j/t+Ts3K4lQvHS9nGOoi1HKTFHIEKqpcJJvPIJ
	uwgX3+6Mddky3bQ9h1KrbfbwPhmJRGf1goghuPAwnDs0MF6fnroH+4mF
X-Received: by 2002:a17:90b:51c7:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3ae89819925mr13498598a91.42.1793773987414;
        Tue, 03 Nov 2026 22:33:07 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:33:07 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] net: xgmac: disable timeout work before teardown
Date: Wed,  4 Nov 2026 14:32:45 +0800
Message-ID: <20261104063245.23402-4-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xgmac_remove() frees the IRQ lines and unmaps the registers before
freeing the netdev, but tx_timeout_work can still be pending or running.
The work is queued from ndo_tx_timeout() and from the DMA error
interrupt path, and its handler disables NAPI, programs the DMA
registers and walks the TX ring.

xgmac_stop() has the same lifetime problem: it frees the DMA descriptor
rings while a queued timeout work can still run.

Disable the work in probe after INIT_WORK() so open/resume can enable it,
disable it synchronously in xgmac_stop() before the rings are freed and
in xgmac_suspend() before NAPI/interrupts are torn down, enable it in
xgmac_open() and xgmac_resume(), and disable it in xgmac_remove() before
the IRQs and MMIO are released.  The enable/disable pairing avoids the
underflow warning that enable_work() emits when the work was never
disabled.  disable_work_sync() also rejects queue_work() from a late
interrupt, which cancellation alone would not.

The patch does not change the existing free_irq()/unregister_netdev()
ordering in xgmac_remove(); it only prevents the timeout work from
outliving the netdev.

Fixes: 8746f671ef04 ("net: calxedaxgmac: fix race between xgmac_tx_complete and xgmac_tx_err")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/calxeda/xgmac.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a2410fba6b..9b7aee56f2 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1023,6 +1023,9 @@ static int xgmac_open(struct net_device *dev)
 	if (ret < 0)
 		return ret;
 
+	/* xgmac_stop() disables this work before freeing the rings. */
+	enable_work(&priv->tx_timeout_work);
+
 	/* Enable the MAC Rx/Tx */
 	xgmac_mac_enable(ioaddr);
 
@@ -1046,6 +1049,13 @@ static int xgmac_stop(struct net_device *dev)
 {
 	struct xgmac_priv *priv = netdev_priv(dev);
 
+	/*
+	 * The timeout work programs the DMA rings that are freed below, and
+	 * it toggles NAPI.  Disable it synchronously before touching either;
+	 * xgmac_open() and xgmac_resume() enable it again.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
+
 	if (readl(priv->base + XGMAC_DMA_INTR_ENA))
 		napi_disable(&priv->napi);
 
@@ -1713,6 +1723,12 @@ static int xgmac_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &xgmac_ethtool_ops;
 	spin_lock_init(&priv->stats_lock);
 	INIT_WORK(&priv->tx_timeout_work, xgmac_tx_timeout_work);
+	/*
+	 * The work is enabled while the interface is up.  Start it disabled
+	 * so the enable_work() in xgmac_open()/xgmac_resume() has a matching
+	 * disable and never underflows.
+	 */
+	disable_work(&priv->tx_timeout_work);
 
 	priv->device = &pdev->dev;
 	priv->dev = ndev;
@@ -1823,6 +1839,13 @@ static void xgmac_remove(struct platform_device *pdev)
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	struct resource *res;
 
+	/*
+	 * The timeout work can be queued from ndo_tx_timeout() and from the
+	 * DMA error interrupt.  Disable it before the IRQs are released and
+	 * the registers are unmapped.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
+
 	xgmac_mac_disable(priv->base);
 
 	/* Free the IRQ lines */
@@ -1862,6 +1885,12 @@ static int xgmac_suspend(struct device *dev)
 		return 0;
 
 	netif_device_detach(ndev);
+	/*
+	 * The timeout work touches the DMA registers and toggles NAPI.
+	 * Disable it before NAPI and the interrupts are torn down;
+	 * xgmac_resume() enables it again.
+	 */
+	disable_work_sync(&priv->tx_timeout_work);
 	napi_disable(&priv->napi);
 	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
 
@@ -1891,6 +1920,7 @@ static int xgmac_resume(struct device *dev)
 
 	/* Enable the MAC and DMA */
 	xgmac_mac_enable(ioaddr);
+	enable_work(&priv->tx_timeout_work);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_STATUS);
 	writel(DMA_INTR_DEFAULT_MASK, ioaddr + XGMAC_DMA_INTR_ENA);
 
-- 
2.43.0

